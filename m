Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA84C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E852722B48
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752732;
	bh=pqw5UfEYGYT8ol4RNywBnTNu1KP+OoGQYk4BTsvHyYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2A2wU3TrsSmBiuycaomujvNmHXXrzG0nmyrldslo6iQpy3bbkX3eeFbJkUnhHXGWN
	 uy1uNlC4jaepsqFfkWKqEvZCbkonVO7SrU+YAw5Lg0/M+sbda74TIoTOUA37NrHL3F
	 rHiCFjNAfT6/ttk8Ttxe6mhH4bGXYncW3ivjBZg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgGNSwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgGNSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CF122B48;
        Tue, 14 Jul 2020 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752726;
        bh=pqw5UfEYGYT8ol4RNywBnTNu1KP+OoGQYk4BTsvHyYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBUJUNV5UMzefvehC/cW7s6dF+qatrRhF64/+MxaQWviF1UBMH5+qNbeGYuJwJrJB
         ZTsLD9YTC33TrKPQUZ0B61l2bY+yWDo5ldOTyEQfY2OWqJ9An4AAq4P8onP+0UAIfO
         zeMfviOkrZY/n9HFKypsbjnuzRCz7MajPM4f63YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 087/109] kallsyms: Refactor kallsyms_show_value() to take cred
Date:   Tue, 14 Jul 2020 20:44:30 +0200
Message-Id: <20200714184109.715957926@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 160251842cd35a75edfb0a1d76afa3eb674ff40a upstream.

In order to perform future tests against the cred saved during open(),
switch kallsyms_show_value() to operate on a cred, and have all current
callers pass current_cred(). This makes it very obvious where callers
are checking the wrong credential in their "read" contexts. These will
be fixed in the coming patches.

Additionally switch return value to bool, since it is always used as a
direct permission check, not a 0-on-success, negative-on-error style
function return.

Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/filter.h   |    2 +-
 include/linux/kallsyms.h |    5 +++--
 kernel/kallsyms.c        |   17 +++++++++++------
 kernel/kprobes.c         |    4 ++--
 kernel/module.c          |    2 +-
 5 files changed, 18 insertions(+), 12 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -858,7 +858,7 @@ static inline bool bpf_dump_raw_ok(void)
 	/* Reconstruction of call-sites is dependent on kallsyms,
 	 * thus make dump the same restriction.
 	 */
-	return kallsyms_show_value() == 1;
+	return kallsyms_show_value(current_cred());
 }
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -18,6 +18,7 @@
 #define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s]") + (KSYM_NAME_LEN - 1) + \
 			 2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + 1)
 
+struct cred;
 struct module;
 
 static inline int is_kernel_inittext(unsigned long addr)
@@ -98,7 +99,7 @@ int lookup_symbol_name(unsigned long add
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
-extern int kallsyms_show_value(void);
+extern bool kallsyms_show_value(const struct cred *cred);
 
 #else /* !CONFIG_KALLSYMS */
 
@@ -158,7 +159,7 @@ static inline int lookup_symbol_attrs(un
 	return -ERANGE;
 }
 
-static inline int kallsyms_show_value(void)
+static inline bool kallsyms_show_value(const struct cred *cred)
 {
 	return false;
 }
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -645,19 +645,20 @@ static inline int kallsyms_for_perf(void
  * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
  * block even that).
  */
-int kallsyms_show_value(void)
+bool kallsyms_show_value(const struct cred *cred)
 {
 	switch (kptr_restrict) {
 	case 0:
 		if (kallsyms_for_perf())
-			return 1;
+			return true;
 	/* fallthrough */
 	case 1:
-		if (has_capability_noaudit(current, CAP_SYSLOG))
-			return 1;
+		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
+				     CAP_OPT_NOAUDIT) == 0)
+			return true;
 	/* fallthrough */
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -674,7 +675,11 @@ static int kallsyms_open(struct inode *i
 		return -ENOMEM;
 	reset_iter(iter, 0);
 
-	iter->show_value = kallsyms_show_value();
+	/*
+	 * Instead of checking this on every s_show() call, cache
+	 * the result here at open time.
+	 */
+	iter->show_value = kallsyms_show_value(file->f_cred);
 	return 0;
 }
 
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2362,7 +2362,7 @@ static void report_probe(struct seq_file
 	else
 		kprobe_type = "k";
 
-	if (!kallsyms_show_value())
+	if (!kallsyms_show_value(current_cred()))
 		addr = NULL;
 
 	if (sym)
@@ -2463,7 +2463,7 @@ static int kprobe_blacklist_seq_show(str
 	 * If /proc/kallsyms is not showing kernel address, we won't
 	 * show them here either.
 	 */
-	if (!kallsyms_show_value())
+	if (!kallsyms_show_value(current_cred()))
 		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
 			   (void *)ent->start_addr);
 	else
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4391,7 +4391,7 @@ static int modules_open(struct inode *in
 
 	if (!err) {
 		struct seq_file *m = file->private_data;
-		m->private = kallsyms_show_value() ? NULL : (void *)8ul;
+		m->private = kallsyms_show_value(current_cred()) ? NULL : (void *)8ul;
 	}
 
 	return err;



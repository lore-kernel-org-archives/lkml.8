Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A122068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgEEOXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729372AbgEEONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEADAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKF-0000Vo-Gm; Tue, 05 May 2020 16:13:35 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id F3A7FFFC8D;
        Tue,  5 May 2020 16:13:34 +0200 (CEST)
Message-Id: <20200505134059.771170126@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 17/36] kprobes: Support NOKPROBE_SYMBOL() in modules
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support NOKPROBE_SYMBOL() in modules. NOKPROBE_SYMBOL() records only symbol
address in "_kprobe_blacklist" section in the module.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/158523419989.24735.6665260504057165207.stgit@devnote2

---
 include/linux/module.h |    2 ++
 kernel/kprobes.c       |   17 +++++++++++++++++
 kernel/module.c        |    3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 369c354f9207..1192097c9a69 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -492,6 +492,8 @@ struct module {
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
+	unsigned long *kprobe_blacklist;
+	unsigned int num_kprobe_blacklist;
 #endif
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b7549992b9bd..9eb5acf0a9f3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2192,6 +2192,11 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	}
 }
 
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2231,6 +2236,12 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_add_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
@@ -2242,6 +2253,12 @@ static void add_module_kprobe_blacklist(struct module *mod)
 static void remove_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_remove_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
diff --git a/kernel/module.c b/kernel/module.c
index f7712a923d63..7be011dacd8a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3197,6 +3197,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #ifdef CONFIG_KPROBES
 	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
 						&mod->kprobes_text_size);
+	mod->kprobe_blacklist = section_objs(info, "_kprobe_blacklist",
+						sizeof(unsigned long),
+						&mod->num_kprobe_blacklist);
 #endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);



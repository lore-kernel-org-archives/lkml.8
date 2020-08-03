Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1E1206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596459443;
	bh=0Nnr52XMSJnMBpdN4Zi3KaJuzM8KsrD/MyR3/JGEUf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nHkPdA+5BKgSJot9pDEuQttq6eb3pLp8AmSTTdBWolxzaWt+TY6cAi8M/bgODEnZ2
	 Tu9XzwYU84G1TI0V/raZAkl0GXQg5Qt1Ev4B5b3a9DUTc3yXEGBtlaoIOJ82OQsFpY
	 Y14jGonxgyiUU9R4UyaTZexQwdB7m3b474Ifam0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgHCM5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgHCMVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:21:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1453A204EC;
        Mon,  3 Aug 2020 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457288;
        bh=0Nnr52XMSJnMBpdN4Zi3KaJuzM8KsrD/MyR3/JGEUf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANd28LFAZGRDbqIwbfypFbU056FeWBysV2mxPgnZFIFnKduKinPg/PUQiiV+wowp3
         JLVQWj2NhbvU/1Sr51B7staXcF9OxwykiMafC1s03O0VPvpLAIthNYp0j9b3ggO7UP
         aKhf1xaFyfPEdqjQBE+AiyASLOuvkMOp0yP1zksU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, j2468h@googlemail.com,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.7 014/120] revert: 1320a4052ea1 ("audit: trigger accompanying records when no rules present")
Date:   Mon,  3 Aug 2020 14:17:52 +0200
Message-Id: <20200803121903.554565390@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

commit 8ac68dc455d9d18241d44b96800d73229029ed34 upstream.

Unfortunately the commit listed in the subject line above failed
to ensure that the task's audit_context was properly initialized/set
before enabling the "accompanying records".  Depending on the
situation, the resulting audit_context could have invalid values in
some of it's fields which could cause a kernel panic/oops when the
task/syscall exists and the audit records are generated.

We will revisit the original patch, with the necessary fixes, in a
future kernel but right now we just want to fix the kernel panic
with the least amount of added risk.

Cc: stable@vger.kernel.org
Fixes: 1320a4052ea1 ("audit: trigger accompanying records when no rules present")
Reported-by: j2468h@googlemail.com
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/audit.c   |    1 -
 kernel/audit.h   |    8 --------
 kernel/auditsc.c |    3 +++
 3 files changed, 3 insertions(+), 9 deletions(-)

--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1811,7 +1811,6 @@ struct audit_buffer *audit_log_start(str
 	}
 
 	audit_get_stamp(ab->ctx, &t, &serial);
-	audit_clear_dummy(ab->ctx);
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
 			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
 
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -290,13 +290,6 @@ extern int audit_signal_info_syscall(str
 extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
-
-static inline void audit_clear_dummy(struct audit_context *ctx)
-{
-	if (ctx)
-		ctx->dummy = 0;
-}
-
 #else /* CONFIG_AUDITSYSCALL */
 #define auditsc_get_stamp(c, t, s) 0
 #define audit_put_watch(w) {}
@@ -330,7 +323,6 @@ static inline int audit_signal_info_sysc
 }
 
 #define audit_filter_inodes(t, c) AUDIT_DISABLED
-#define audit_clear_dummy(c) {}
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1406,6 +1406,9 @@ static void audit_log_proctitle(void)
 	struct audit_context *context = audit_context();
 	struct audit_buffer *ab;
 
+	if (!context || context->dummy)
+		return;
+
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PROCTITLE);
 	if (!ab)
 		return;	/* audit_panic or being filtered */



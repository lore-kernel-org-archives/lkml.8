Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C87C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D0C20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCWSi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:38:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46762 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCWSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxu-00136W-9F; Mon, 23 Mar 2020 18:38:22 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 15/22] x86: ia32_setup_rt_frame(): consolidate uaccess areas
Date:   Mon, 23 Mar 2020 18:38:12 +0000
Message-Id: <20200323183819.250124-15-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

__copy_siginfo_to_user32() call reordered a bit.  The rest folds
nicely.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 4dae24f42e1a..b97087812d26 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -296,10 +296,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 {
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fpstate = NULL;
 
-	/* __copy_to_user optimizes that into a single 8 byte store */
+	/* unsafe_put_user optimizes that into a single 8 byte store */
 	static const struct {
 		u8 movl;
 		u32 val;
@@ -341,17 +340,13 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	 * versions need it.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
+	if (ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
+				     regs, set->sig[0]))
+		goto Efault;
+	unsafe_put_user(*(__u64 *)set, (__u64 *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
 
-	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
-	if (!user_access_begin(&frame->uc.uc_mcontext, sizeof(struct sigcontext_32)))
-		return -EFAULT;
-	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				     regs, set->sig[0]);
-	user_access_end();
-	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
-
-	if (err)
+	if (__copy_siginfo_to_user32(&frame->info, &ksig->info, false))
 		return -EFAULT;
 
 	/* Set up registers for signal handler */
-- 
2.11.0


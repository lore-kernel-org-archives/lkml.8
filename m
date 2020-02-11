Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3320870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgBKN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:56:18 -0500
Received: from 8bytes.org ([81.169.241.247]:52390 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgBKNxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 35481E84; Tue, 11 Feb 2020 14:53:14 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 39/62] x86/sev-es: Harden runtime #VC handler for exceptions from user-space
Date:   Tue, 11 Feb 2020 14:52:33 +0100
Message-Id: <20200211135256.24617-40-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Send SIGBUS to the user-space process that caused the #VC exception
instead of killing the machine. Also ratelimit the error messages so
that user-space can't flood the kernel log.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index f5bff4219f6f..d128a9397639 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -254,16 +254,16 @@ dotraplinkage void do_vmm_communication(struct pt_regs *regs, unsigned long exit
 		finish_insn(&ctxt);
 		break;
 	case ES_UNSUPPORTED:
-		pr_emerg("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_VMM_ERROR:
-		pr_emerg("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_DECODE_FAILED:
-		pr_emerg("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_EXCEPTION:
 		forward_exception(&ctxt);
@@ -278,10 +278,24 @@ dotraplinkage void do_vmm_communication(struct pt_regs *regs, unsigned long exit
 	return;
 
 fail:
-	show_regs(regs);
+	if (user_mode(regs)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal with
+		 * it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	} else {
+		/* Show some debug info */
+		show_regs(regs);
 
-	while (true)
-		halt();
+		/* Ask hypervisor to terminate */
+		terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+		/* If that fails and we get here - just halt the machine */
+		while (true)
+			halt();
+	}
 }
 
 int __init boot_vc_exception(struct pt_regs *regs)
-- 
2.17.1


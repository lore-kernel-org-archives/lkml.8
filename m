Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90624C35E17
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724C620578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgB0OQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389402AbgB0OQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7JxF-0005B5-Vk; Thu, 27 Feb 2020 15:15:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D3DA1C216C;
        Thu, 27 Feb 2020 15:15:57 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:15:57 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Remove redundant declaration of do_double_fault()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225220216.720335354@linutronix.de>
References: <20200225220216.720335354@linutronix.de>
MIME-Version: 1.0
Message-ID: <158281295739.28353.15003553494431699964.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3ba4f0a633ca4bfeadb24eba19cb53ebe246eabf
Gitweb:        https://git.kernel.org/tip/3ba4f0a633ca4bfeadb24eba19cb53ebe246eabf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 22:36:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Feb 2020 14:48:40 +01:00

x86/traps: Remove redundant declaration of do_double_fault()



Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200225220216.720335354@linutronix.de

---
 arch/x86/include/asm/traps.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index e1c660b..c26a7e1 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -76,13 +76,6 @@ dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long err
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
-#ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
-asmlinkage __visible notrace
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
-void __init trap_init(void);
-#endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
@@ -94,6 +87,13 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
+#ifdef CONFIG_X86_64
+asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
+asmlinkage __visible notrace
+struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
+void __init trap_init(void);
+#endif
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)

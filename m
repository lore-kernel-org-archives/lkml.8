Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgEST7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgEST6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7AC08C5C1;
        Tue, 19 May 2020 12:58:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O1-0008V7-Jx; Tue, 19 May 2020 21:58:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 021951C047E;
        Tue, 19 May 2020 21:58:38 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:37 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Reorder idtentries
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.841853522@linutronix.de>
References: <20200505134903.841853522@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831789.17951.4143955942714459133.tip-bot2@tip-bot2>
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

Commit-ID:     8996fcd630d11ff3fe6f3fbaee7b39b4a9dde4d0
Gitweb:        https://git.kernel.org/tip/8996fcd630d11ff3fe6f3fbaee7b39b4a9dde4d0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:55 +02:00

x86/entry/64: Reorder idtentries

Move them all together so verifying the cleanup patches for binary
equivalence will be easier.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134903.841853522@linutronix.de



---
 arch/x86/entry/entry_64.S | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9747b42..e62061e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1020,20 +1020,36 @@ _ASM_NOKPROBE(\sym)
 SYM_CODE_END(\sym)
 .endm
 
+
 idtentry divide_error			do_divide_error			has_error_code=0
 idtentry overflow			do_overflow			has_error_code=0
+idtentry int3				do_int3				has_error_code=0	create_gap=1
 idtentry bounds				do_bounds			has_error_code=0
 idtentry invalid_op			do_invalid_op			has_error_code=0
 idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2 read_cr2=1
 idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
 idtentry segment_not_present		do_segment_not_present		has_error_code=1
+idtentry stack_segment			do_stack_segment		has_error_code=1
+idtentry general_protection		do_general_protection		has_error_code=1
 idtentry spurious_interrupt_bug		do_spurious_interrupt_bug	has_error_code=0
 idtentry coprocessor_error		do_coprocessor_error		has_error_code=0
 idtentry alignment_check		do_alignment_check		has_error_code=1
 idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
 
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
+
+#ifdef CONFIG_X86_MCE
+idtentry machine_check		do_mce			has_error_code=0 paranoid=1
+#endif
+idtentry debug			do_debug		has_error_code=0 paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
+idtentry double_fault		do_double_fault		has_error_code=1 paranoid=2 read_cr2=1
+
+#ifdef CONFIG_XEN_PV
+idtentry hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
+idtentry xennmi			do_nmi				has_error_code=0
+idtentry xendebug		do_debug			has_error_code=0
+#endif
 
 /*
  * Reload gs selector with exception handling
@@ -1084,8 +1100,6 @@ SYM_FUNC_END(do_softirq_own_stack)
 .popsection
 
 #ifdef CONFIG_XEN_PV
-idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
-
 /*
  * A note on the "critical region" in our callback handler.
  * We want to avoid stacking callback handlers due to events occurring
@@ -1188,22 +1202,6 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	acrn_hv_callback_vector acrn_hv_vector_handler
 #endif
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
-idtentry int3			do_int3			has_error_code=0	create_gap=1
-idtentry stack_segment		do_stack_segment	has_error_code=1
-
-#ifdef CONFIG_XEN_PV
-idtentry xennmi			do_nmi			has_error_code=0
-idtentry xendebug		do_debug		has_error_code=0
-#endif
-
-idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
-
-#ifdef CONFIG_X86_MCE
-idtentry machine_check		do_mce			has_error_code=0	paranoid=1
-#endif
-
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.

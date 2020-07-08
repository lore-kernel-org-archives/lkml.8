Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE0420775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dzgr6QCK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44JN/bKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGHJwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgGHJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:54 -0400
Date:   Wed, 08 Jul 2020 09:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SNQKgtYeN3ILXa5tMtzSYLdxzXoALKzjaJMGXnrzvk=;
        b=Dzgr6QCKfboMWagin7pXkhNJy42ZPWpW+T2fAKKVLsqUqDrGSJ40rVWOMJvP465nF4PjWx
        gdk3NZuwdSyq8aY6+W4Q2V8nr2aC2mmeL+J/jFzGqldVCws0Vosz92U0wNtwU+t8TZk+FI
        N0OJfMRVs9X1jui369pqnQWJ0wL2BRPbDjkwlmeR0hffwQehhSMKV4uAmZ85GYG/E7Cuss
        KOoxJk7I/2z5NsmBgSMyK0eQ95NfP8gWKE12xjGevueVPsuqoW1WSwPwOy9mzXuGCo+6bV
        S3zUCKAtBBBGqFrbGnqpPS7Z+e5Ilwyxip/33my0Su0DEYKe7PvMTO1Kvm4YWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SNQKgtYeN3ILXa5tMtzSYLdxzXoALKzjaJMGXnrzvk=;
        b=44JN/bKCXQG9KcrLC4rvGbBeMe0B4JOaHB+5kI1AmuC4pB9w/HB56gOD73iwxyOoCLRo4N
        8yO2b6mb6zkTDJAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Support LBR_CTL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-10-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-10-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191116.4006.12606247942831487185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     49d8184f2036ff5b8d1eea3d61bac8b23420eca7
Gitweb:        https://git.kernel.org/tip/49d8184f2036ff5b8d1eea3d61bac8b23420eca7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:53 +02:00

perf/x86/intel/lbr: Support LBR_CTL

An IA32_LBR_CTL is introduced for Architecture LBR to enable and config
LBR registers to replace the previous LBR_SELECT.

All the related members in struct cpu_hw_events and struct x86_pmu
have to be renamed.

Some new macros are added to reflect the layout of LBR_CTL.

The mapping from PERF_SAMPLE_BRANCH_* to the corresponding bits in
LBR_CTL MSR is saved in lbr_ctl_map now, which is not a const value.
The value relies on the CPUID enumeration.

For the previous model-specific LBR, most of the bits in LBR_SELECT
operate in the suppressed mode. For the bits in LBR_CTL, the polarity is
inverted.

For the previous model-specific LBR format 5 (LBR_FORMAT_INFO), if the
NO_CYCLES and NO_FLAGS type are set, the flag LBR_NO_INFO will be set to
avoid the unnecessary LBR_INFO MSR read. Although Architecture LBR also
has a dedicated LBR_INFO MSR, perf doesn't need to check and set the
flag LBR_NO_INFO. For Architecture LBR, XSAVES instruction will be used
as the default way to read the LBR MSRs all together. The overhead which
the flag tries to avoid doesn't exist anymore. Dropping the flag can
save the extra check for the flag in the lbr_read() later, and make the
code cleaner.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-10-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c  | 43 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h | 15 +++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e62baa9..7742562 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -132,6 +132,44 @@ enum {
 	 X86_BR_IRQ		|\
 	 X86_BR_INT)
 
+/*
+ * Intel LBR_CTL bits
+ *
+ * Hardware branch filter for Arch LBR
+ */
+#define ARCH_LBR_KERNEL_BIT		1  /* capture at ring0 */
+#define ARCH_LBR_USER_BIT		2  /* capture at ring > 0 */
+#define ARCH_LBR_CALL_STACK_BIT		3  /* enable call stack */
+#define ARCH_LBR_JCC_BIT		16 /* capture conditional branches */
+#define ARCH_LBR_REL_JMP_BIT		17 /* capture relative jumps */
+#define ARCH_LBR_IND_JMP_BIT		18 /* capture indirect jumps */
+#define ARCH_LBR_REL_CALL_BIT		19 /* capture relative calls */
+#define ARCH_LBR_IND_CALL_BIT		20 /* capture indirect calls */
+#define ARCH_LBR_RETURN_BIT		21 /* capture near returns */
+#define ARCH_LBR_OTHER_BRANCH_BIT	22 /* capture other branches */
+
+#define ARCH_LBR_KERNEL			(1ULL << ARCH_LBR_KERNEL_BIT)
+#define ARCH_LBR_USER			(1ULL << ARCH_LBR_USER_BIT)
+#define ARCH_LBR_CALL_STACK		(1ULL << ARCH_LBR_CALL_STACK_BIT)
+#define ARCH_LBR_JCC			(1ULL << ARCH_LBR_JCC_BIT)
+#define ARCH_LBR_REL_JMP		(1ULL << ARCH_LBR_REL_JMP_BIT)
+#define ARCH_LBR_IND_JMP		(1ULL << ARCH_LBR_IND_JMP_BIT)
+#define ARCH_LBR_REL_CALL		(1ULL << ARCH_LBR_REL_CALL_BIT)
+#define ARCH_LBR_IND_CALL		(1ULL << ARCH_LBR_IND_CALL_BIT)
+#define ARCH_LBR_RETURN			(1ULL << ARCH_LBR_RETURN_BIT)
+#define ARCH_LBR_OTHER_BRANCH		(1ULL << ARCH_LBR_OTHER_BRANCH_BIT)
+
+#define ARCH_LBR_ANY			 \
+	(ARCH_LBR_JCC			|\
+	 ARCH_LBR_REL_JMP		|\
+	 ARCH_LBR_IND_JMP		|\
+	 ARCH_LBR_REL_CALL		|\
+	 ARCH_LBR_IND_CALL		|\
+	 ARCH_LBR_RETURN		|\
+	 ARCH_LBR_OTHER_BRANCH)
+
+#define ARCH_LBR_CTL_MASK			0x7f000e
+
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
 /*
@@ -820,6 +858,11 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 	reg = &event->hw.branch_reg;
 	reg->idx = EXTRA_REG_LBR;
 
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
+		reg->config = mask;
+		return 0;
+	}
+
 	/*
 	 * The first 9 bits (LBR_SEL_MASK) in LBR_SELECT operate
 	 * in suppress mode. So LBR_SELECT should be set to
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cc81177..ba89e56 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -245,7 +245,10 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
-	struct er_account		*lbr_sel;
+	union {
+		struct er_account		*lbr_sel;
+		struct er_account		*lbr_ctl;
+	};
 	u64				br_sel;
 	void				*last_task_ctx;
 	int				last_log_id;
@@ -688,8 +691,14 @@ struct x86_pmu {
 	 */
 	unsigned int	lbr_tos, lbr_from, lbr_to,
 			lbr_nr;			   /* LBR base regs and size */
-	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
-	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	union {
+		u64	lbr_sel_mask;		   /* LBR_SELECT valid bits */
+		u64	lbr_ctl_mask;		   /* LBR_CTL valid bits */
+	};
+	union {
+		const int	*lbr_sel_map;	   /* lbr_select mappings */
+		int		*lbr_ctl_map;	   /* LBR_CTL mappings */
+	};
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 

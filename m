Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA12720760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j61VgqC1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKw0ldVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgGHJw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGHJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:57 -0400
Date:   Wed, 08 Jul 2020 09:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aF/AF34mjCS32BEMGCVK4lJkJkMPkPWeBjbxXiQNrH0=;
        b=j61VgqC1HToZQzRH7vahF0oQYyhpC+Tw6fRT6LfAz9f5hZAA2sgEj7LGPz9HhtkDpInsTd
        ZVrT7yWkJ5KKubN7icxb5KjJ1NjHqx1v9cElykxeZpeaJfGB76/bi/MgFKNla5v98q1Qts
        dK+AYLUk1s2EMc1AoJH+6lQuI6oFqi4Xer5WxaFurh5zUYkLiHJp24yfVtFLf3mFg52ZzZ
        oAkymH2KRea26NW2I7iAn52VZ7KyMr916E/yfSLIOAfZD1lLwFdH6KXZHhwcSqzt00xlr8
        TIbx60iT7fxm7M6f0aEOn7JrdJG2gvUqWGEqox7dfRmMhtc2bgWsbYoS8MzxSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aF/AF34mjCS32BEMGCVK4lJkJkMPkPWeBjbxXiQNrH0=;
        b=rKw0ldVLzBTPZfOEjvmRuT0BVZZVndESjF+k3sylxuik+C5z8/SA3axwuxbFe7eSw9gyls
        4ue/5LOO12s5cFBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Add a function pointer for LBR reset
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-3-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191526.4006.6298094884310452122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9f354a726cb1d4eb00a0784a27eaa0a3283cff71
Gitweb:        https://git.kernel.org/tip/9f354a726cb1d4eb00a0784a27eaa0a3283cff71
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:51 +02:00

perf/x86/intel/lbr: Add a function pointer for LBR reset

The method to reset Architectural LBRs is different from previous
model-specific LBR. Perf has to implement a different function.

A function pointer is introduced for LBR reset. The enum of
LBR_FORMAT_* is also moved to perf_event.h. Perf should initialize the
corresponding functions at boot time, and avoid checking lbr_format at
run time.

The current 64-bit LBR reset function is set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  7 +++++++
 arch/x86/events/intel/lbr.c  | 20 +++-----------------
 arch/x86/events/perf_event.h | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 582ddff..fe49e99 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3978,6 +3978,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dead		= intel_pmu_cpu_dead,
 
 	.check_period		= intel_pmu_check_period,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4023,6 +4025,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.aux_output_match	= intel_pmu_aux_output_match,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4649,6 +4653,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index d03de75..7af27a7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -8,17 +8,6 @@
 
 #include "../perf_event.h"
 
-enum {
-	LBR_FORMAT_32		= 0x00,
-	LBR_FORMAT_LIP		= 0x01,
-	LBR_FORMAT_EIP		= 0x02,
-	LBR_FORMAT_EIP_FLAGS	= 0x03,
-	LBR_FORMAT_EIP_FLAGS2	= 0x04,
-	LBR_FORMAT_INFO		= 0x05,
-	LBR_FORMAT_TIME		= 0x06,
-	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
-};
-
 static const enum {
 	LBR_EIP_FLAGS		= 1,
 	LBR_TSX			= 2,
@@ -194,7 +183,7 @@ static void __intel_pmu_lbr_disable(void)
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
-static void intel_pmu_lbr_reset_32(void)
+void intel_pmu_lbr_reset_32(void)
 {
 	int i;
 
@@ -202,7 +191,7 @@ static void intel_pmu_lbr_reset_32(void)
 		wrmsrl(x86_pmu.lbr_from + i, 0);
 }
 
-static void intel_pmu_lbr_reset_64(void)
+void intel_pmu_lbr_reset_64(void)
 {
 	int i;
 
@@ -221,10 +210,7 @@ void intel_pmu_lbr_reset(void)
 	if (!x86_pmu.lbr_nr)
 		return;
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
-		intel_pmu_lbr_reset_32();
-	else
-		intel_pmu_lbr_reset_64();
+	x86_pmu.lbr_reset();
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8147596..5c1ad43 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -180,6 +180,17 @@ struct x86_perf_task_context;
 #define MAX_LBR_ENTRIES		32
 
 enum {
+	LBR_FORMAT_32		= 0x00,
+	LBR_FORMAT_LIP		= 0x01,
+	LBR_FORMAT_EIP		= 0x02,
+	LBR_FORMAT_EIP_FLAGS	= 0x03,
+	LBR_FORMAT_EIP_FLAGS2	= 0x04,
+	LBR_FORMAT_INFO		= 0x05,
+	LBR_FORMAT_TIME		= 0x06,
+	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
+};
+
+enum {
 	X86_PERF_KFREE_SHARED = 0,
 	X86_PERF_KFREE_EXCL   = 1,
 	X86_PERF_KFREE_MAX
@@ -682,6 +693,8 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	void		(*lbr_reset)(void);
+
 	/*
 	 * Intel PT/LBR/BTS are exclusive
 	 */
@@ -1058,6 +1071,10 @@ u64 lbr_from_signext_quirk_wr(u64 val);
 
 void intel_pmu_lbr_reset(void);
 
+void intel_pmu_lbr_reset_32(void);
+
+void intel_pmu_lbr_reset_64(void);
+
 void intel_pmu_lbr_add(struct perf_event *event);
 
 void intel_pmu_lbr_del(struct perf_event *event);

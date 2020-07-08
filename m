Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0217C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967CA20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W20NA49z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HK2NMn+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGHJwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgGHJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:58 -0400
Date:   Wed, 08 Jul 2020 09:51:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLobp6FPNCcI0EzlsDcxTy1biul8k9Xn+iJZsXQzRQc=;
        b=W20NA49zst64juLg8LzuH7p3bzDCi8GKjeLh4TJ4D64QSgbx/NRhIPgSzTrEQ8al3QZdv9
        QFq0rDsZsOAShgibQWVvzWCASGIoX3WxBw/tYDb1Mhte4+EVymyKSCZ+vIPjoCrqg7CwEG
        GbTTwwYGNFDKHKppptquSR/b3NiXCxfyzF0ptS768bHDgKOc6LxmP+Y1Zpauguzq+fLUSK
        98h8fulHNFaXYV0uMNjPIhBWBkW8m8zfLMvqmuSLKl4Ei665huIHBFX5/98xnF7SpTLwcF
        wd5XQ4O7uBTvzdmTK8u1AgFepvC1WVs14b9X8uU+do3NIwiiySsAswPAvFGD7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLobp6FPNCcI0EzlsDcxTy1biul8k9Xn+iJZsXQzRQc=;
        b=HK2NMn+yinOTSF+zT6gdgLnJOE6eiGInyN9//eqiPJGVJM+v+70nSHWHfjd2xdt5ZneMPa
        CKShH59aKWNrVtBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Add a function pointer for LBR read
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-4-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191468.4006.1899821467540433834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c301b1d80ed5b806834fe0f739f028f65fb4fb16
Gitweb:        https://git.kernel.org/tip/c301b1d80ed5b806834fe0f739f028f65fb4fb16
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:51 +02:00

perf/x86/intel/lbr: Add a function pointer for LBR read

The method to read Architectural LBRs is different from previous
model-specific LBR. Perf has to implement a different function.

A function pointer for LBR read is introduced. Perf should initialize
the corresponding function at boot time, and avoid checking lbr_format
at run time.

The current 64-bit LBR read function is set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  6 +++++-
 arch/x86/events/intel/lbr.c  |  9 +++------
 arch/x86/events/perf_event.h |  5 +++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe49e99..6414b47 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3980,6 +3980,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4027,6 +4028,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.aux_output_match	= intel_pmu_aux_output_match,
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4653,8 +4655,10 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32) {
 		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
+	}
 
 	intel_ds_init();
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7af27a7..b8943f4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -562,7 +562,7 @@ void intel_pmu_lbr_disable_all(void)
 		__intel_pmu_lbr_disable();
 }
 
-static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	u64 tos = intel_pmu_lbr_tos();
@@ -599,7 +599,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -704,10 +704,7 @@ void intel_pmu_lbr_read(void)
 	    cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
-		intel_pmu_lbr_read_32(cpuc);
-	else
-		intel_pmu_lbr_read_64(cpuc);
+	x86_pmu.lbr_read(cpuc);
 
 	intel_pmu_lbr_filter(cpuc);
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5c1ad43..312d27f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -694,6 +694,7 @@ struct x86_pmu {
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
 	void		(*lbr_reset)(void);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1085,6 +1086,10 @@ void intel_pmu_lbr_disable_all(void);
 
 void intel_pmu_lbr_read(void);
 
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);

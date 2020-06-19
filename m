Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B75C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D121924
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbgFSOHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:07:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:54724 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbgFSOHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:46 -0400
IronPort-SDR: boBhcLovMiLxW9vHXHOPkLozUZu4hrqZYKC21AASWw1dWBiy2KqhjSMUb180DOdupTZmFtwiBK
 ANtjeuIkbV5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452805"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:44 -0700
IronPort-SDR: s86JjjODGBw5FSxVGNkT7ydcQmvzPgubnYbPOqB59VbJKI9GHbFHN9+RjlfyBJ7kG0fkPbmfKo
 2ulUVKkRSkzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837410"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/21] perf/x86/intel/lbr: Add pointers for LBR enable and disable
Date:   Fri, 19 Jun 2020 07:03:50 -0700
Message-Id: <1592575449-64278-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The method to enable and disable Architectural LBR is different from
the previous model-specific LBR. Perf has to implement different
functions.

The function pointers for LBR enable and disable are introduced. Perf
should initialize the corresponding functions at boot time.

The current model-specific LBR functions are set as default.

The __intel_pmu_lbr_disable() and __intel_pmu_lbr_enable() are not
static functions anymore. The prefix "__" is removed from the name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 6 ++++++
 arch/x86/events/intel/lbr.c  | 8 ++++----
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 332954c..56966fc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3951,6 +3951,9 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dead		= intel_pmu_cpu_dead,
 
 	.check_period		= intel_pmu_check_period,
+
+	.lbr_enable		= intel_pmu_lbr_enable,
+	.lbr_disable		= intel_pmu_lbr_disable,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -3996,6 +3999,9 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.aux_output_match	= intel_pmu_aux_output_match,
+
+	.lbr_enable		= intel_pmu_lbr_enable,
+	.lbr_disable		= intel_pmu_lbr_disable,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 65113b1..bdd38b6 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -150,7 +150,7 @@ static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
  * otherwise it becomes near impossible to get a reliable stack.
  */
 
-static void __intel_pmu_lbr_enable(bool pmi)
+void intel_pmu_lbr_enable(bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 debugctl, lbr_select = 0, orig_debugctl;
@@ -185,7 +185,7 @@ static void __intel_pmu_lbr_enable(bool pmi)
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
-static void __intel_pmu_lbr_disable(void)
+void intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
@@ -545,7 +545,7 @@ void intel_pmu_lbr_enable_all(bool pmi)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (cpuc->lbr_users)
-		__intel_pmu_lbr_enable(pmi);
+		x86_pmu.lbr_enable(pmi);
 }
 
 void intel_pmu_lbr_disable_all(void)
@@ -553,7 +553,7 @@ void intel_pmu_lbr_disable_all(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (cpuc->lbr_users)
-		__intel_pmu_lbr_disable();
+		x86_pmu.lbr_disable();
 }
 
 static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f1cd1ca..a61a076 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -679,6 +679,9 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	void		(*lbr_enable)(bool pmi);
+	void		(*lbr_disable)(void);
+
 	/*
 	 * Intel PT/LBR/BTS are exclusive
 	 */
@@ -1059,8 +1062,12 @@ void intel_pmu_lbr_del(struct perf_event *event);
 
 void intel_pmu_lbr_enable_all(bool pmi);
 
+void intel_pmu_lbr_enable(bool pmi);
+
 void intel_pmu_lbr_disable_all(void);
 
+void intel_pmu_lbr_disable(void);
+
 void intel_pmu_lbr_read(void);
 
 void intel_pmu_lbr_init_core(void);
-- 
2.7.4


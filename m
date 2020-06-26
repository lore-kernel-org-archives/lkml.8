Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B71FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E096B20836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgFZSYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgFZSXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:37 -0400
IronPort-SDR: VWFLVfMWd2WefIjOyeLoLVFyIO0ABDposL9uyeMQa/ePPLduHXmhDvdWLj5b+ClnbsLtiEYUa2
 UTqYd/dKYbpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512905"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512905"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:35 -0700
IronPort-SDR: PXyJYqpJBJB2wXjrRakNfOSag4n7G7mQO31+mV05o1fGBWGIIaFvQIucIveJhebc4toI7QCWmC
 5BXEE+8R0X6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153857"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:35 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 08/23] perf/x86: Expose CPUID enumeration bits for arch LBR
Date:   Fri, 26 Jun 2020 11:20:05 -0700
Message-Id: <1593195620-116988-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR capabilities of Architecture LBR are retrieved from the CPUID
enumeration once at boot time. The capabilities have to be saved for
future usage.

Several new fields are added into structure x86_pmu to indicate the
capabilities. The fields will be used in the following patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/perf_event.h      |  5 +++++
 arch/x86/include/asm/perf_event.h | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d04818b..9b0e533 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -690,6 +690,11 @@ struct x86_pmu {
 	const int	*lbr_sel_map;		   /* lbr_select mappings */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
+	bool		arch_lbr;		   /* Arch LBR supported */
+
+	union cpuid28_eax	lbr_eax;
+	union cpuid28_ebx	lbr_ebx;
+	union cpuid28_ecx	lbr_ecx;
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index e855e9c..d33cc82 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -142,6 +142,46 @@ union cpuid10_edx {
 	unsigned int full;
 };
 
+/*
+ * Intel Architectural LBR CPUID detection/enumeration details:
+ */
+union cpuid28_eax {
+	struct {
+		/* Supported LBR depth values */
+		unsigned int	lbr_depth_mask:8;
+		unsigned int	reserved:22;
+		/* Deep C-state Reset */
+		unsigned int	lbr_deep_c_reset:1;
+		/* IP values contain LIP */
+		unsigned int	lbr_lip:1;
+	} split;
+	unsigned int		full;
+};
+
+union cpuid28_ebx {
+	struct {
+		/* CPL Filtering Supported */
+		unsigned int    lbr_cpl:1;
+		/* Branch Filtering Supported */
+		unsigned int    lbr_filter:1;
+		/* Call-stack Mode Supported */
+		unsigned int    lbr_call_stack:1;
+	} split;
+	unsigned int            full;
+};
+
+union cpuid28_ecx {
+	struct {
+		/* Mispredict Bit Supported */
+		unsigned int    lbr_mispred:1;
+		/* Timed LBRs Supported */
+		unsigned int    lbr_timed_lbr:1;
+		/* Branch Type Field Supported */
+		unsigned int    lbr_br_type:1;
+	} split;
+	unsigned int            full;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
-- 
2.7.4


Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A343C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6B21527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFSOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:54739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732664AbgFSOHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:54 -0400
IronPort-SDR: mnuigAQd5XBKWDgjHDFZFKAoKtggpqlh+akmK3UhwXwJIP2qsvNG2W33vHDuDsr/dhTFDaq7uW
 5IRZ+FCWW6Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452843"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:53 -0700
IronPort-SDR: LqYann7WDlB2GvizOXdNPBviE3qSrsXJMkKOfberSurLeBf7OzGHTMhKWNKa/Kj79NCXJ2RA2e
 NQmMMsSDg50g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837455"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:52 -0700
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
Subject: [PATCH 09/21] perf/x86: Expose CPUID enumeration bits for arch LBR
Date:   Fri, 19 Jun 2020 07:03:57 -0700
Message-Id: <1592575449-64278-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR capabilities of Architecture LBR are retrieved from the CPUID
enumeration once at boot time. The capabilities have to be saved for
future usage.

Several new fields in x86_pmu are added to indicate the capabilities.
The fields will be used in the following patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/perf_event.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e33d348..cbfc55b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -689,6 +689,50 @@ struct x86_pmu {
 	const int	*lbr_sel_map;		   /* lbr_select mappings */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
+	bool		arch_lbr;		   /* Arch LBR supported */
+
+	/* Arch LBR Capabilities */
+	union {
+		struct {
+			/* Supported LBR depth values */
+			unsigned int	arch_lbr_depth_mask:8;
+
+			unsigned int	reserved:22;
+
+			/* Deep C-state Reset */
+			unsigned int	arch_lbr_deep_c_reset:1;
+
+			/* IP values contain LIP */
+			unsigned int	arch_lbr_lip:1;
+		};
+		unsigned int		arch_lbr_eax;
+	};
+	union {
+		struct {
+			/* CPL Filtering Supported */
+			unsigned int    arch_lbr_cpl:1;
+
+			/* Branch Filtering Supported */
+			unsigned int    arch_lbr_filter:1;
+
+			/* Call-stack Mode Supported */
+			unsigned int    arch_lbr_call_stack:1;
+		};
+		unsigned int            arch_lbr_ebx;
+	};
+	union {
+		struct {
+			/* Mispredict Bit Supported */
+			unsigned int    arch_lbr_mispred:1;
+
+			/* Timed LBRs Supported */
+			unsigned int    arch_lbr_timed_lbr:1;
+
+			/* Branch Type Field Supported */
+			unsigned int    arch_lbr_br_type:1;
+		};
+		unsigned int            arch_lbr_ecx;
+	};
 
 	void		(*lbr_enable)(bool pmi);
 	void		(*lbr_disable)(void);
-- 
2.7.4


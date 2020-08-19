Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462CDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA420882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHSVTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:19:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:15408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHSVTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:19:14 -0400
IronPort-SDR: Ut/Ju7w31/pBEIlpALGbJi19/EqFTZPVPpW3sXbexAaKPOBgieIu2//cCt+m7vbIX8fH34rDI7
 1Jw/MDzPzmDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142830421"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142830421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:19:13 -0700
IronPort-SDR: YEB6o1oAEgFLHBCLQJOL+ziGzsZm1I6zOpmQinj63gVXn6ATkXCzPmByI17NpQETKS0QXMx0UE
 Yw5SaucES8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="278433817"
Received: from pnp1.jf.intel.com ([10.23.15.21])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2020 14:19:12 -0700
From:   vaibhav.shankar@intel.com
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     vaibhav.shankar@intel.com
Subject: [PATCH v2] perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown
Date:   Wed, 19 Aug 2020 14:19:01 -0700
Message-Id: <20200819211901.27287-1-vaibhav.shankar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Shankar <vaibhav.shankar@intel.com>

Linux only has support to read total DDR reads and writes. Here we
add support to enable bandwidth breakdown-GT, IA and IO. Breakdown
of BW is important to debug and optimize memory access. This can also
be used for telemetry and improving the system software. The offsets for
GT, IA and IO are added and these free running counters can be accessed
via MMIO space.

The BW breakdown can be meaured using the following cmd:-
perf stat -e uncore_imc/gt_requests/,uncore_imc/ia_requests/,
             uncore_imc/io_requests/

             30.57 MiB  uncore_imc/gt_requests/
           1346.13 MiB  uncore_imc/ia_requests/
            190.97 MiB  uncore_imc/io_requests/

       5.984572733 seconds time elapsed

     BW/s = <gt,ia,io>_requests/time elapsed

Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
---
Changes in v2:
	-Fix lkp warnings.
	 >> arch/x86/events/intel/uncore_snb.c:441:37: warning: initialized field 
	 >> overwritten [-Woverride-init]
	-Fix commit message

 arch/x86/events/intel/uncore_snb.c | 52 ++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index cb94ba86efd2..eb6b9feb2d97 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -390,6 +390,18 @@ static struct uncore_event_desc snb_uncore_imc_events[] = {
 	INTEL_UNCORE_EVENT_DESC(data_writes.scale, "6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(data_writes.unit, "MiB"),
 
+	INTEL_UNCORE_EVENT_DESC(gt_requests, "event=0x03"),
+	INTEL_UNCORE_EVENT_DESC(gt_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(gt_requests.unit, "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(ia_requests, "event=0x04"),
+	INTEL_UNCORE_EVENT_DESC(ia_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(ia_requests.unit, "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(io_requests, "event=0x05"),
+	INTEL_UNCORE_EVENT_DESC(io_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(io_requests.unit, "MiB"),
+
 	{ /* end: all zeroes */ },
 };
 
@@ -405,13 +417,35 @@ static struct uncore_event_desc snb_uncore_imc_events[] = {
 #define SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE	0x5054
 #define SNB_UNCORE_PCI_IMC_CTR_BASE		SNB_UNCORE_PCI_IMC_DATA_READS_BASE
 
+/* BW break down- legacy counters */
+#define SNB_UNCORE_PCI_IMC_GT_REQUESTS		0x3
+#define SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE	0x5040
+#define SNB_UNCORE_PCI_IMC_IA_REQUESTS		0x4
+#define SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE	0x5044
+#define SNB_UNCORE_PCI_IMC_IO_REQUESTS		0x5
+#define SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE	0x5048
+
 enum perf_snb_uncore_imc_freerunning_types {
-	SNB_PCI_UNCORE_IMC_DATA		= 0,
+	SNB_PCI_UNCORE_IMC_DATA_READS		= 0,
+	SNB_PCI_UNCORE_IMC_DATA_WRITES,
+	SNB_PCI_UNCORE_IMC_GT_REQUESTS,
+	SNB_PCI_UNCORE_IMC_IA_REQUESTS,
+	SNB_PCI_UNCORE_IMC_IO_REQUESTS,
+
 	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 };
 
 static struct freerunning_counters snb_uncore_imc_freerunning[] = {
-	[SNB_PCI_UNCORE_IMC_DATA]     = { SNB_UNCORE_PCI_IMC_DATA_READS_BASE, 0x4, 0x0, 2, 32 },
+	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_GT_REQUESTS]	= { SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_IA_REQUESTS]	= { SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_IO_REQUESTS]	= { SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
 };
 
 static struct attribute *snb_uncore_imc_formats_attr[] = {
@@ -525,6 +559,18 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 		base = SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE;
 		idx = UNCORE_PMC_IDX_FREERUNNING;
 		break;
+	case SNB_UNCORE_PCI_IMC_GT_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
+	case SNB_UNCORE_PCI_IMC_IA_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
+	case SNB_UNCORE_PCI_IMC_IO_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -598,7 +644,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
 
 static struct intel_uncore_type snb_uncore_imc = {
 	.name		= "imc",
-	.num_counters   = 2,
+	.num_counters   = 5,
 	.num_boxes	= 1,
 	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 	.mmio_map_size	= SNB_UNCORE_PCI_IMC_MAP_SIZE,
-- 
2.17.1


Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71B720719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgDBToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:44:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:56632 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgDBToq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:44:46 -0400
IronPort-SDR: lqUpGZctDPZ6rKOI32vNGDn5Bnf76UPU4klzAUhYM+8OfsKxO66tWvfDtqW5bVgIr8M2DU530C
 iMLSyfWMfmDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:44:46 -0700
IronPort-SDR: Hj3oSl4e4vjJS1ETUS8m8QYg41SNIyJS8YOcYs0GBIRj7ik8g3bcVHSOrteIScL/Fw89AWmCAf
 Huf7E5WKQb4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="328933544"
Received: from ssp-cmls-cdi352.jf.intel.com ([10.54.55.41])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2020 12:44:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add Comet Lake support
Date:   Thu,  2 Apr 2020 12:44:03 -0700
Message-Id: <20200402194403.19339-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore subsystem on Comet Lake is similar to Sky Lake.
The only difference is the new PCI IDs for IMC.

Share the perf code with Sky Lake.
Add new PCI IDs in the table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  2 +
 arch/x86/events/intel/uncore_snb.c | 66 ++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 63922e3a34f5..ef4ff854ff80 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1512,6 +1512,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_COMETLAKE_L,	  skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_COMETLAKE,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3de1065eefc4..5c4036710b7a 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -42,6 +42,17 @@
 #define PCI_DEVICE_ID_INTEL_WHL_UQ_IMC		0x3ed0
 #define PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC	0x3e34
 #define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
+#define PCI_DEVICE_ID_INTEL_CML_H1_IMC		0x9b44
+#define PCI_DEVICE_ID_INTEL_CML_H2_IMC		0x9b54
+#define PCI_DEVICE_ID_INTEL_CML_H3_IMC		0x9b64
+#define PCI_DEVICE_ID_INTEL_CML_U1_IMC		0x9b51
+#define PCI_DEVICE_ID_INTEL_CML_U2_IMC		0x9b61
+#define PCI_DEVICE_ID_INTEL_CML_U3_IMC		0x9b71
+#define PCI_DEVICE_ID_INTEL_CML_S1_IMC		0x9b33
+#define PCI_DEVICE_ID_INTEL_CML_S2_IMC		0x9b43
+#define PCI_DEVICE_ID_INTEL_CML_S3_IMC		0x9b53
+#define PCI_DEVICE_ID_INTEL_CML_S4_IMC		0x9b63
+#define PCI_DEVICE_ID_INTEL_CML_S5_IMC		0x9b73
 #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
 #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
 #define PCI_DEVICE_ID_INTEL_TGL_U1_IMC		0x9a02
@@ -771,6 +782,50 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S5_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -863,6 +918,17 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(WHL_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_4_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_UD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Dual Core */
+	IMC_DEV(CML_H1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S4_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	{  /* end marker */ }
-- 
2.20.1


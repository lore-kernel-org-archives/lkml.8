Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B56C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D092064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgAPUCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:02:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:36832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgAPUCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:02:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 12:02:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="424177757"
Received: from ssp-jcv-cdi286.jf.intel.com ([10.54.39.33])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2020 12:02:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     like.xu@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/uncore: Remove PCIe3 unit for SNR
Date:   Thu, 16 Jan 2020 12:02:10 -0800
Message-Id: <20200116200210.18937-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116200210.18937-1-kan.liang@linux.intel.com>
References: <20200116200210.18937-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PCIe Root Port driver for CPU Complex PCIe Root Ports are not
loaded on SNR.

The device ID for SNR PCIe3 unit is used by both uncore driver and the
PCIe Root Port driver. If uncore driver is loaded, the PCIe Root Port
driver never be probed.

Remove the PCIe3 unit for SNR for now. The support for PCIe3 unit will
be added later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 011644802ce7..ad20220af303 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -369,11 +369,6 @@
 #define SNR_M2M_PCI_PMON_BOX_CTL		0x438
 #define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
 
-/* SNR PCIE3 */
-#define SNR_PCIE3_PCI_PMON_CTL0			0x508
-#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
-#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e4
-
 /* SNR IMC */
 #define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
 #define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
@@ -4328,27 +4323,12 @@ static struct intel_uncore_type snr_uncore_m2m = {
 	.format_group	= &snr_m2m_uncore_format_group,
 };
 
-static struct intel_uncore_type snr_uncore_pcie3 = {
-	.name		= "pcie3",
-	.num_counters	= 4,
-	.num_boxes	= 1,
-	.perf_ctr_bits	= 48,
-	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
-	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
-	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
-	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
-	.ops		= &ivbep_uncore_pci_ops,
-	.format_group	= &ivbep_uncore_format_group,
-};
-
 enum {
 	SNR_PCI_UNCORE_M2M,
-	SNR_PCI_UNCORE_PCIE3,
 };
 
 static struct intel_uncore_type *snr_pci_uncores[] = {
 	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
-	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
 	NULL,
 };
 
@@ -4357,10 +4337,6 @@ static const struct pci_device_id snr_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(12, 0, SNR_PCI_UNCORE_M2M, 0),
 	},
-	{ /* PCIe3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
-	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.21.1


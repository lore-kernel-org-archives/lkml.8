Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E7CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E5E22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHEUZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:32773 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgHEUZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:17 -0400
IronPort-SDR: +jc5eSvx9IzaTLfiWlwOtDaWltYXBJAWP9yEF/5lR8ydijy3KMuAHL4ICsDGEQQCDj0leNcRUc
 3ZOA3C2bRPlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214171518"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="214171518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:14 -0700
IronPort-SDR: MtIgX8SoHgondyZMI8wne+KgfuLoVcV7HGR5U6y9r4Cd2Z9HZz1Nq5X6Jdw6DK8kDzbI9vZrK/
 LiPFoOF6GbWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958451"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:14 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 6/6] perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge
Date:   Wed,  5 Aug 2020 13:24:11 -0700
Message-Id: <1596659051-95759-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Snow Ridge integrated PCIe3 uncore unit can be used to collect
performance data, e.g. utilization, between PCIe devices, plugged into
the PCIe port, and the components (in M2IOSF) responsible for
translating and managing requests to/from the device. The performance
data is very useful for analyzing the performance of PCIe devices.

The device with the PCIe3 uncore PMON units is owned by the portdrv_pci
driver. Create a PCI sub driver for the PCIe3 uncore PMON units.

Here are some difference between PCIe3 uncore unit and other uncore
pci units.
- There may be several Root Ports on a system. But the uncore counters
  only exist in the Root Port A. A user can configure the channel mask
  to collect the data from other Root Ports.
- The event format of the PCIe3 uncore unit is the same as IIO unit of
  SKX.
- The Control Register of PCIe3 uncore unit is 64 bits.
- The offset of each counters is 8, which is the same as M2M unit of
  SNR.
- New MSR addresses for unit control, counter and counter config.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 62e88ad..495056f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -393,6 +393,11 @@
 #define SNR_M2M_PCI_PMON_BOX_CTL		0x438
 #define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
 
+/* SNR PCIE3 */
+#define SNR_PCIE3_PCI_PMON_CTL0			0x508
+#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
+#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e0
+
 /* SNR IMC */
 #define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
 #define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
@@ -4551,12 +4556,46 @@ static struct intel_uncore_type snr_uncore_m2m = {
 	.format_group	= &snr_m2m_uncore_format_group,
 };
 
+static void snr_uncore_pci_enable_event(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, (u32)(hwc->config | SNBEP_PMON_CTL_EN));
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+}
+
+static struct intel_uncore_ops snr_pcie3_uncore_pci_ops = {
+	.init_box	= snr_m2m_uncore_pci_init_box,
+	.disable_box	= snbep_uncore_pci_disable_box,
+	.enable_box	= snbep_uncore_pci_enable_box,
+	.disable_event	= snbep_uncore_pci_disable_event,
+	.enable_event	= snr_uncore_pci_enable_event,
+	.read_counter	= snbep_uncore_pci_read_counter,
+};
+
+static struct intel_uncore_type snr_uncore_pcie3 = {
+	.name		= "pcie3",
+	.num_counters	= 4,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
+	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
+	.event_mask	= SKX_IIO_PMON_RAW_EVENT_MASK,
+	.event_mask_ext	= SKX_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
+	.ops		= &snr_pcie3_uncore_pci_ops,
+	.format_group	= &skx_uncore_iio_format_group,
+};
+
 enum {
 	SNR_PCI_UNCORE_M2M,
+	SNR_PCI_UNCORE_PCIE3,
 };
 
 static struct intel_uncore_type *snr_pci_uncores[] = {
 	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
+	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
 	NULL,
 };
 
@@ -4573,6 +4612,19 @@ static struct pci_driver snr_uncore_pci_driver = {
 	.id_table	= snr_uncore_pci_ids,
 };
 
+static const struct pci_device_id snr_uncore_pci_sub_ids[] = {
+	{ /* PCIe3 RP */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_driver snr_uncore_pci_sub_driver = {
+	.name		= "snr_uncore_sub",
+	.id_table	= snr_uncore_pci_sub_ids,
+};
+
 int snr_uncore_pci_init(void)
 {
 	/* SNR UBOX DID */
@@ -4584,6 +4636,7 @@ int snr_uncore_pci_init(void)
 
 	uncore_pci_uncores = snr_pci_uncores;
 	uncore_pci_driver = &snr_uncore_pci_driver;
+	uncore_pci_sub_driver = &snr_uncore_pci_sub_driver;
 	return 0;
 }
 
-- 
2.7.4


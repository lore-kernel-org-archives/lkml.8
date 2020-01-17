Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC5C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833B2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAQKh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:37:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55540 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:37:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isP0A-0006Hj-2v; Fri, 17 Jan 2020 11:37:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AC0651C19DA;
        Fri, 17 Jan 2020 11:37:17 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:37:17 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Remove PCIe3 unit for SNR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200116200210.18937-2-kan.liang@linux.intel.com>
References: <20200116200210.18937-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157925743741.396.664173780038702154.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2167f1625c2f04a33145f325db0de285630f7bd1
Gitweb:        https://git.kernel.org/tip/2167f1625c2f04a33145f325db0de285630f7bd1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Jan 2020 12:02:10 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 Jan 2020 11:33:38 +01:00

perf/x86/intel/uncore: Remove PCIe3 unit for SNR

The PCIe Root Port driver for CPU Complex PCIe Root Ports are not
loaded on SNR.

The device ID for SNR PCIe3 unit is used by both uncore driver and the
PCIe Root Port driver. If uncore driver is loaded, the PCIe Root Port
driver never be probed.

Remove the PCIe3 unit for SNR for now. The support for PCIe3 unit will
be added later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200116200210.18937-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 0116448..ad20220 100644
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
 

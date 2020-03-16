Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB7CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90462051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbgCPOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:32:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:43228 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731465AbgCPOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:32:29 -0400
IronPort-SDR: 4D2uMYzM8nmuI8rBDYjMT5yecU2h9BXNT2UcI7D4BqgxAbpW3RydRbZ9dPO+yyWYf9yk9+FhFe
 t/87Vh3GkJOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 07:32:28 -0700
IronPort-SDR: CN9to3jq/4ZxD3XYzeg27v4u37TrxQpSX4BMaSP8df9UUzdYmr8MrP8Vira8Tb5aMX1nXcCiPg
 kw3fstlFotdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="443361048"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2020 07:32:27 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] mfd: intel-lpss: Fix Intel Elkhart Lake LPSS I2C input clock
Date:   Mon, 16 Mar 2020 16:32:24 +0200
Message-Id: <20200316143224.234432-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Elkhart Lake LPSS I2C has 100 MHz input clock instead of 133 MHz
that was our preliminary information. This will result slower I2C bus
clock when driver calculates its timing parameters in case ACPI tables
don't provide them.

Slower I2C bus clock is allowed but let's fix this to match with
reality.

While at it, keep the same default I2C device properties as Intel
Broxton since it is not known do they need any update.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For normal development cycle.
---
 drivers/mfd/intel-lpss-pci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c40a6c7d0cf8..e48f00448551 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -139,6 +139,11 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
 	.properties = spt_i2c_properties,
 };
 
+static const struct intel_lpss_platform_info ehl_i2c_info = {
+	.clk_rate = 100000000,
+	.properties = bxt_i2c_properties,
+};
+
 static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* CML-LP */
 	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
@@ -231,15 +236,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b2a), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x4b2b), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x4b37), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x4b44), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b45), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b4b), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b4c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b44), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b45), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b4b), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b4c), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b4d), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x4b78), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b78), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&ehl_i2c_info },
 	/* JSL */
 	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
-- 
2.25.1


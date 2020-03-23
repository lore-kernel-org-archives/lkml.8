Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE99C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE620719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWUCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:02:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:11382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCWUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:02:40 -0400
IronPort-SDR: VcZzATigG9WaE5Kg2wf4qKNxzM08de78ei3alqfmtzvuqGsnIJIsgN6boqIrKOEF5N8yZIYwYH
 cp32GgJM4qKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 13:02:39 -0700
IronPort-SDR: 2eRAf0i91RWMolVNSNGG4GUxlFzYhJvLNJDMSAcPp4XSgLAAJ0A6T8zMgP/i6UwKSxLoaXSggT
 orOVPCXNFHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="292682625"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2020 13:02:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 298DD14B; Mon, 23 Mar 2020 22:02:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: dln2: Allow to be enumerated via ACPI
Date:   Mon, 23 Mar 2020 22:02:37 +0200
Message-Id: <20200323200237.51416-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms user may want to enumerate DLN2 device, its children,
to be enumerated via ACPI. In order to achieve this, let's distinguish
children by _ADR value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/dln2.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 64196b06bfec..3a729b196b1f 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -640,35 +640,56 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
 	return 0;
 }
 
+enum {
+	DLN2_ACPI_MATCH_GPIO	= 0,
+	DLN2_ACPI_MATCH_I2C	= 1,
+	DLN2_ACPI_MATCH_SPI	= 2,
+};
+
 static struct dln2_platform_data dln2_pdata_gpio = {
 	.handle = DLN2_HANDLE_GPIO,
 };
 
+static struct mfd_cell_acpi_match dln2_acpi_match_gpio = {
+	.adr = DLN2_ACPI_MATCH_GPIO,
+};
+
 /* Only one I2C port seems to be supported on current hardware */
 static struct dln2_platform_data dln2_pdata_i2c = {
 	.handle = DLN2_HANDLE_I2C,
 	.port = 0,
 };
 
+static struct mfd_cell_acpi_match dln2_acpi_match_i2c = {
+	.adr = DLN2_ACPI_MATCH_I2C,
+};
+
 /* Only one SPI port supported */
 static struct dln2_platform_data dln2_pdata_spi = {
 	.handle = DLN2_HANDLE_SPI,
 	.port = 0,
 };
 
+static struct mfd_cell_acpi_match dln2_acpi_match_spi = {
+	.adr = DLN2_ACPI_MATCH_SPI,
+};
+
 static const struct mfd_cell dln2_devs[] = {
 	{
 		.name = "dln2-gpio",
+		.acpi_match = &dln2_acpi_match_gpio,
 		.platform_data = &dln2_pdata_gpio,
 		.pdata_size = sizeof(struct dln2_platform_data),
 	},
 	{
 		.name = "dln2-i2c",
+		.acpi_match = &dln2_acpi_match_i2c,
 		.platform_data = &dln2_pdata_i2c,
 		.pdata_size = sizeof(struct dln2_platform_data),
 	},
 	{
 		.name = "dln2-spi",
+		.acpi_match = &dln2_acpi_match_spi,
 		.platform_data = &dln2_pdata_spi,
 		.pdata_size = sizeof(struct dln2_platform_data),
 	},
-- 
2.25.1


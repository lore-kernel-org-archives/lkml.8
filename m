Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79A204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbgFYNKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:10:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:35371 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405050AbgFYNKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:10:40 -0400
IronPort-SDR: LJKlswmNps43eaL6y3ByfdAWSKx+I6hLOqugHCO+tbw1eifecZbmzSakdrWi+2l5DcFUfJGmtr
 hro/lezCRhbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133304104"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="133304104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 06:10:39 -0700
IronPort-SDR: QYnii4KgMoIfkw+TJ/Zs5W/mR1Ia3g4vT6FDdX4HFXpn5ZH+k7wwEHTuWW+mO+1wtY2mZc/BeU
 /vyPuBEYxFug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="385458847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2020 06:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83E2B13B; Thu, 25 Jun 2020 16:10:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Tiger Lake PCH-H PCI IDs
Date:   Thu, 25 Jun 2020 16:10:36 +0300
Message-Id: <20200625131036.43953-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Tiger Lake PCH-H has the same LPSS than Intel Broxton.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 046222684b8b..cc64cdda41c1 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -230,6 +230,22 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
+	/* TGL-H */
+	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x43a9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x43aa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x43ab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x43ad), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43ae), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43d8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43da), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x43e8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43e9), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43ea), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43eb), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x43fb), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x43fd), (kernel_ulong_t)&bxt_info },
 	/* EHL */
 	{ PCI_VDEVICE(INTEL, 0x4b28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4b29), (kernel_ulong_t)&bxt_uart_info },
-- 
2.27.0


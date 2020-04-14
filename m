Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07DC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B909B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438018AbgDNJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:52:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:41781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437981AbgDNJvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:51:37 -0400
IronPort-SDR: PHVtJUS8L+I3joD8ticl7n3GjYCUcKS9MpHyUtNxeZ6w6s9aIJkt4LZ5tQSPG6zssLRtWzCo0m
 u0la3fAzWi6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 02:51:36 -0700
IronPort-SDR: AglxUp8RCWKBm6bm1/qX1Owm6f1GQSAX+ZIuKxOJWSYJXk5uAA0o/gDDTUld+4xo8gYBhyReJ+
 kfPio+Vh0RRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="288167616"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 02:51:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DDF6CE1; Tue, 14 Apr 2020 12:51:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Update LPSS UART #2 PCI ID for Jasper Lake
Date:   Tue, 14 Apr 2020 12:51:34 +0300
Message-Id: <20200414095134.80135-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that preliminary documentation has a typo in the ID list,
i.e. LPSS UART #2 had been advertised wrongly.

Fix the driver according to the EDS v0.9.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 7fc0c5d4edff..046222684b8b 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -250,9 +250,9 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4daa), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x4dab), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x4daf), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4dc5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dc6), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4dc7), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4de8), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4de9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dea), (kernel_ulong_t)&bxt_i2c_info },
-- 
2.25.1


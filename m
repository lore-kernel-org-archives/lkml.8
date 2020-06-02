Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B23206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFBJVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:21:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:48071 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgFBJVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:21:11 -0400
IronPort-SDR: RspO2SjK2L1ic8JI+YU+GDtH7HED+Y8+hMOwse9eXFN/rmscxWNc9gnneQhXH0utlDdSuhMWKh
 9Sv2bQw/2GeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:21:11 -0700
IronPort-SDR: fkBHbWKlEHPCj7K0tvumVPuxdD4Bo7ZtHrsjQRmHTs9zq7mw6r9HXMboKjIUD+0MI9EzOGGSAU
 xponlJj3JdDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="304175793"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2020 02:21:09 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 12/15] amd-xgbe: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:21:05 +0200
Message-Id: <20200602092105.32190-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 7b86240ecd5f..903bc5ef2518 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -133,7 +133,7 @@ static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 			    pdata->tx_ring_count);
 
 	ret = pci_alloc_irq_vectors(pdata->pcidev, XGBE_MSI_MIN_COUNT,
-				    vector_count, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+				    vector_count, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		dev_info(pdata->dev, "multi MSI/MSI-X enablement failed\n");
 		return ret;
-- 
2.17.2


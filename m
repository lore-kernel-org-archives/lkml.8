Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54961C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2612C2077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBJVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:21:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:48081 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgFBJVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:21:18 -0400
IronPort-SDR: i2dfDPdEMkTO5+VdePIoIEDzkD2LIBlazVDZQzkuWx+IL5SeZ3gs3+iuLkXSzGM/k3WiTfhj47
 6xsOvejRvbQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:21:17 -0700
IronPort-SDR: lOw+HoekDgjAS33T7/+WaJ0cyBkO//grmGrHAqJ8B+6e7h6dplj5IBD021ZIm8trsy5I8swa4J
 Ft/UIfbXvi3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="470654364"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2020 02:21:15 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 13/15] aquantia: atlantic: use PCI_IRQ_ALL_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:21:11 +0200
Message-Id: <20200602092111.32235-1-piotr.stankiewicz@intel.com>
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
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 8a70ffe1d326..2a0ebf296478 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -277,9 +277,7 @@ static int aq_pci_probe(struct pci_dev *pdev,
 	numvecs += AQ_HW_SERVICE_IRQS;
 	/*enable interrupts */
 #if !AQ_CFG_FORCE_LEGACY_INT
-	err = pci_alloc_irq_vectors(self->pdev, 1, numvecs,
-				    PCI_IRQ_MSIX | PCI_IRQ_MSI |
-				    PCI_IRQ_LEGACY);
+	err = pci_alloc_irq_vectors(self->pdev, 1, numvecs, PCI_IRQ_ALL_TYPES);
 
 	if (err < 0)
 		goto err_hwinit;
-- 
2.17.2


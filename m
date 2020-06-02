Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C2206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFBJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:20:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:59641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFBJUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:54 -0400
IronPort-SDR: r7yWF7tffePp3vb9GFM/hZAeGEdJj2tOYu33KN/e+ykV6CGR9J9QzGcdHugtGKkLEXxu9hD89+
 orqMGdbAAglA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:54 -0700
IronPort-SDR: gWZBZdSTl1j0WmrkvM1gn3thc21IfaUqI+5qNxbXFQbSKIdvcT7YcOgyYm8xKsvUsbqYWZyOi2
 eWONDwHw+k4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="257058355"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 02:20:52 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 09/15] media: ddbridge: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:48 +0200
Message-Id: <20200602092048.32058-1-piotr.stankiewicz@intel.com>
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
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..ff5c33d7a736 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -106,7 +106,7 @@ static void ddb_irq_msi(struct ddb *dev, int nr)
 
 	if (msi && pci_msi_enabled()) {
 		stat = pci_alloc_irq_vectors(dev->pdev, 1, nr,
-					     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+					     PCI_IRQ_MSI_TYPES);
 		if (stat >= 1) {
 			dev->msi = stat;
 			dev_info(dev->dev, "using %d MSI interrupt(s)\n",
-- 
2.17.2


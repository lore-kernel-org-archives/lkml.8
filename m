Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A692C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E752077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PSsWlQDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbgDCOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:19:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42988 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgDCOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:19:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033EJcjW064402;
        Fri, 3 Apr 2020 09:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585923578;
        bh=Qx+iAMwdWP0VkygxXbbv0T3XL5ZlN3V0BBEuiiFMFH0=;
        h=From:To:CC:Subject:Date;
        b=PSsWlQDiAC2SDtA4NKcu6ffbwfyMtrh4bS0DPFaBawr4M4idYai2KENryGe7xPeNt
         dJM9ptHQkRdhIXt6WUnudjxn5RIBdphApKGetPG5uDMQckHCBTZroWg4g32qTB6IJ7
         OSspylyU1sUz9xVIUz1G1GLtiBk/RF8NMybMHtOA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 033EJcQP064141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Apr 2020 09:19:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 09:19:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 09:19:38 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033EJaPO092261;
        Fri, 3 Apr 2020 09:19:36 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <torvalds@linux-foundation.org>
Subject: [PATCH] dmaengine: ti: k3-udma: Drop COMPILE_TEST for the drivers for now
Date:   Fri, 3 Apr 2020 17:19:50 +0300
Message-ID: <20200403141950.9359-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to compile test the UDMA stack right now due to
dependencies to T_SCI_PROTOCOL and TI_SCI_INTA_IRQCHIP and their
dependencies.

Remove the COMPILE_TEST until it is actually possible to compile test the
drivers.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index f76e06651f80..79618fac119a 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -36,7 +36,7 @@ config DMA_OMAP
 
 config TI_K3_UDMA
 	bool "Texas Instruments UDMA support"
-	depends on ARCH_K3 || COMPILE_TEST
+	depends on ARCH_K3
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
 	select DMA_ENGINE
@@ -49,7 +49,7 @@ config TI_K3_UDMA
 
 config TI_K3_UDMA_GLUE_LAYER
 	bool "Texas Instruments UDMA Glue layer for non DMAengine users"
-	depends on ARCH_K3 || COMPILE_TEST
+	depends on ARCH_K3
 	depends on TI_K3_UDMA
 	help
 	  Say y here to support the K3 NAVSS DMA glue interface
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


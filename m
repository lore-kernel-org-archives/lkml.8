Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAEC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EC924698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QjZeglP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgB0Mi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:38:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35860 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgB0MiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:25 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbrEZ089743;
        Thu, 27 Feb 2020 06:37:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582807073;
        bh=N0ZTnsWAGol2AuTpDnmtxbZq6ogLFkSohABUVzcd+sE=;
        h=From:To:CC:Subject:Date;
        b=QjZeglP3AIt+Vfhur4e95S7ux4fT6vGQuuR59x4CU4MDfozKzCGK7gX6k01I/FJo/
         3B/CfbHDM8esY4J4EqdSOh0tSnxweSOHKtl/x15h1+3Q70VvdK4FV2gbbtoS0swBfq
         DZndI5YUx/MGSer6tbBQ1yeUzNCaEC1TmDZ1EQEg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbrsE130414;
        Thu, 27 Feb 2020 06:37:53 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 06:37:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 06:37:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RCbnvN100207;
        Thu, 27 Feb 2020 06:37:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <han.xu@nxp.com>,
        <richard@nod.at>, <mripard@kernel.org>, <wens@csie.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vkoul@kernel.org>
Subject: [PATCH 0/7] mtd: rawnand: Convert drivers to use dma_request_chan()
Date:   Thu, 27 Feb 2020 14:37:42 +0200
Message-ID: <20200227123749.24064-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With dma_request_chan() drivers can know why the channel request failed and
depending on how they are implemented can handle the failure in a best effort,
either deferring or falling back to PIO mode.

Regards,
Peter
---
Peter Ujfalusi (7):
  mtd: rawnand: gpmi: Use dma_request_chan() instead
    dma_request_slave_channel()
  mtd: rawnand: marvell: Release DMA channel on error
  mtd: rawnand: marvell: Use dma_request_chan() instead
    dma_request_slave_channel()
  mtd: rawnand: sunxi: Use dma_request_chan() instead
    dma_request_slave_channel()
  mtd: rawnand: qcom: Release resources on failure within
    qcom_nandc_alloc()
  mtd: rawnand: qcom: Use dma_request_chan() instead
    dma_request_slave_channel()
  mtd: rawnand: stm32_fmc2: Use dma_request_chan() instead
    dma_request_slave_channel()

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  21 +++--
 drivers/mtd/nand/raw/marvell_nand.c        |  38 +++++---
 drivers/mtd/nand/raw/qcom_nandc.c          | 105 +++++++++++++--------
 drivers/mtd/nand/raw/stm32_fmc2_nand.c     |  44 +++++++--
 drivers/mtd/nand/raw/sunxi_nand.c          |  15 ++-
 5 files changed, 149 insertions(+), 74 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


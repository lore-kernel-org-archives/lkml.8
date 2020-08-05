Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB96CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA122068F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rWRwla7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgHETPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:15:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56882 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHESGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:06:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075BQODj042353;
        Wed, 5 Aug 2020 06:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596626784;
        bh=ptD3hGzWwT8Vq2gSquJN4k9oJHMA8CvoI0Kiq0So7lw=;
        h=From:To:CC:Subject:Date;
        b=rWRwla7T/new3KgGWmbnNQqJZngYGytA2IVU4/3oUmp0CNNi6zALaUaoK+GEEBGSH
         x3lyNisfVC4liC0+qf/jb4j14wFX8WYk4NxXicaL0YvVy0sz9ItDBRWKd/q1TP5WGG
         GAOx6UqOG3Q0NOkJV5aWqDRAjLDe6RhEU55fQ6vI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075BQOJE114460;
        Wed, 5 Aug 2020 06:26:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 06:26:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 06:26:23 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075BQL5i053178;
        Wed, 5 Aug 2020 06:26:22 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: Fix parameters for rx ring pair request
Date:   Wed, 5 Aug 2020 14:27:46 +0300
Message-ID: <20200805112746.15475-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200805112746.uiXM5idddyF3rCd4LcnnnKl-1I8Kh76_XlKwkm2VDBc@z>

The original commit mixed up the forward and completion ring IDs for the
rx flow configuration.

Fixes: 4927b1ab2047 ("dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Santosh, Vinod,

the offending patch was queued via ti SoC tree.
Santosh, can you pick up this fix also?

Regards,
Peter

 drivers/dma/ti/k3-udma-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 3a5d33ea5ebe..12da38a92218 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -579,8 +579,8 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 
 	/* request and cfg rings */
 	ret =  k3_ringacc_request_rings_pair(rx_chn->common.ringacc,
-					     flow_cfg->ring_rxq_id,
 					     flow_cfg->ring_rxfdq0_id,
+					     flow_cfg->ring_rxq_id,
 					     &flow->ringrxfdq,
 					     &flow->ringrx);
 	if (ret) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


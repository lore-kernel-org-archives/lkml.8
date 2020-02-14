Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6E9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020A62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fj2/m+vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgBNJO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:14:58 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53920 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgBNJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:14:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E9EoiG111864;
        Fri, 14 Feb 2020 03:14:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581671691;
        bh=OzHgH5nWkKfcQlJ+YZ/ZYmveXJLzjgDJI2DOc610CdM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fj2/m+vqeHwlobG7670Ae3pCfFkNWkBoySACbhTOCs+CRmd/t3odMB4UaGqOYXSru
         /fn0llcgHkb4mR2820vf+8d7cumlOo9A5VALwPDlinOaNrWUJNktHyWk5eXz+myB3H
         w8MgMX9dC2VnWiRh+h+vnoNCMUHuv782jFyphrLA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01E9EoYD076831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 03:14:50 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 03:14:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 03:14:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Ea42043021;
        Fri, 14 Feb 2020 03:14:48 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH v2 6/6] dmaengine: ti: k3-udma: Fix terminated transfer handling
Date:   Fri, 14 Feb 2020 11:14:41 +0200
Message-ID: <20200214091441.27535-7-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214091441.27535-1-peter.ujfalusi@ti.com>
References: <20200214091441.27535-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we receive back the descriptor of the terminated transfer the cookie
must be marked as completed to make sure that the accounting is correct.

In udma_tx_status() the status should be marked as completed if the channel
is no longer running (it can only happen if the channel is not yet started
for the first time, or after a channel termination).

Fixes: 25dcb5dd7b7ce ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9b4e1e5fa849..0536866a58ce 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1097,29 +1097,27 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 			goto out;
 		}
 
-		if (uc->cyclic) {
-			/* push the descriptor back to the ring */
-			if (d == uc->desc) {
+		if (d == uc->desc) {
+			/* active descriptor */
+			if (uc->cyclic) {
 				udma_cyclic_packet_elapsed(uc);
 				vchan_cyclic_callback(&d->vd);
-			}
-		} else {
-			bool desc_done = false;
-
-			if (d == uc->desc) {
-				desc_done = udma_is_desc_really_done(uc, d);
-
-				if (desc_done) {
+			} else {
+				if (udma_is_desc_really_done(uc, d)) {
 					uc->bcnt += d->residue;
 					udma_start(uc);
+					vchan_cookie_complete(&d->vd);
 				} else {
 					schedule_delayed_work(&uc->tx_drain.work,
 							      0);
 				}
 			}
-
-			if (desc_done)
-				vchan_cookie_complete(&d->vd);
+		} else {
+			/*
+			 * terminated descriptor, mark the descriptor as
+			 * completed to update the channel's cookie marker
+			 */
+			dma_cookie_complete(&d->vd.tx);
 		}
 	}
 out:
@@ -2769,6 +2767,9 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 
+	if (!udma_is_chan_running(uc))
+		ret = DMA_COMPLETE;
+
 	if (ret == DMA_IN_PROGRESS && udma_is_chan_paused(uc))
 		ret = DMA_PAUSED;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


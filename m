Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3BA20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846942;
	bh=z/WV8EeiNvfcjX/k2GwivHrgnCgeVcM9x9Mjv+VytKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPAAzFIM72CqQ8KcjjEOq8BkL9ktZuHVF2O/hpfoHO2CyB0LjwAaZpuvBidzZR5kH
	 jTheCDvISqnSjB5g2JLZyFO43i3Hn9Jet4aOcGRxVoio8et0zCqLIHWasRmmeDEgf8
	 fwFYM21Ci0KfzSIB1jBWJjitjVpMS/gEbwzeO7cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgCJMwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgCJMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57ED42253D;
        Tue, 10 Mar 2020 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844741;
        bh=z/WV8EeiNvfcjX/k2GwivHrgnCgeVcM9x9Mjv+VytKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye6TQB+ix/zJmt4ZMdpZg7r6Q767zcU1CNkVctQ+/0vhSoxZp4FvWoUf+AfA0lqPA
         fg+SIFTqP2+QQ6QmokmnUM1Do1N24ng/Y2qz5Oe98ZTNPAG9PQvc3/7sXLLVg1GGrD
         tWH/vbW2+a+sOKvod8VpGtAwmFfJiUpUfus4RGOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.4 101/168] dmaengine: imx-sdma: Fix the event id check to include RX event for UART6
Date:   Tue, 10 Mar 2020 13:39:07 +0100
Message-Id: <20200310123645.607285006@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit 25962e1a7f1d522f1b57ead2f266fab570042a70 upstream.

On i.MX6UL/ULL and i.MX6SX the DMA event id for the RX channel of
UART6 is '0'. To fix the broken DMA support for UART6, we change
the check for event_id0 to include '0' as a valid id.

Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200225082139.7646-1-frieder.schrempf@kontron.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1328,7 +1328,7 @@ static void sdma_free_chan_resources(str
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0)
+	if (sdmac->event_id0 >= 0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
 	if (sdmac->event_id1)
 		sdma_event_disable(sdmac, sdmac->event_id1);
@@ -1629,7 +1629,7 @@ static int sdma_config(struct dma_chan *
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0) {
+	if (sdmac->event_id0 >= 0) {
 		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
 			return -EINVAL;
 		sdma_event_enable(sdmac, sdmac->event_id0);



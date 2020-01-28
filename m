Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7857C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4392468F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221167;
	bh=geLJ6xUNHRdt4519rEsGUtaXAzzPN2bxD+6kvmxJIBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Do89toP3ZxFuFh/hEialKhOI0LAk9CR7apYWObRQKM79yeWRVxwh+PSvvUMIsOYyW
	 eUG61LAI4BBNBrTVHwL/RovW6qmDFZ8fJD+Ssc7HvlScaDFEY60Pd2iul95Mj+riQw
	 5La9vIcEULJLozLIXzUNmDV+9FaJPivflgY/rxxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgA1OTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbgA1OTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD742468F;
        Tue, 28 Jan 2020 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221161;
        bh=geLJ6xUNHRdt4519rEsGUtaXAzzPN2bxD+6kvmxJIBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ci7ox8tPP5axpMQjPX/gdRqtcDZ3eBVTgZZmq1D6qvH9FHX3zQD364tS+flzSRpr4
         E5JR+YI8Fr2EYJZmVhRM7glg9qNdOQ4YArX+8mma7C/05uc3Eq0B0xTljapUhz4mXC
         lQvFpbAciaGwat5ODFGYd/7bhY8I5c0KUtQ4+olo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 076/271] dmaengine: mv_xor: Use correct device for DMA API
Date:   Tue, 28 Jan 2020 15:03:45 +0100
Message-Id: <20200128135858.222551906@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 3e5daee5ecf314da33a890fabaa2404244cd2a36 ]

Using dma_dev->dev for mappings before it's assigned with the correct
device is unlikely to work as expected, and with future dma-direct
changes, passing a NULL device may end up crashing entirely. I don't
know enough about this hardware or the mv_xor_prep_dma_interrupt()
operation to implement the appropriate error-handling logic that would
have revealed those dma_map_single() calls failing on arm64 for as long
as the driver has been enabled there, but moving the assignment earlier
will at least make the current code operate as intended.

Fixes: 22843545b200 ("dma: mv_xor: Add support for DMA_INTERRUPT")
Reported-by: John David Anglin <dave.anglin@bell.net>
Tested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23f75285a4d9c..5d524f29c5f11 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1044,6 +1044,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		mv_chan->op_in_desc = XOR_MODE_IN_DESC;
 
 	dma_dev = &mv_chan->dmadev;
+	dma_dev->dev = &pdev->dev;
 	mv_chan->xordev = xordev;
 
 	/*
@@ -1076,7 +1077,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
-	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
 	if (dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask))
-- 
2.20.1




Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8150206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHNOSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgHNOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:18:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6797C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 07:18:19 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <has@pengutronix.de>)
        id 1k6aX6-0000CU-Ft; Fri, 14 Aug 2020 16:18:12 +0200
Received: from has by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <has@pengutronix.de>)
        id 1k6aX4-0005WZ-5U; Fri, 14 Aug 2020 16:18:10 +0200
From:   Holger Assmann <h.assmann@pengutronix.de>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Wolfram Sang <wsa@kernel.org>,
        Alain Volmat <alain.volmat@st.com>,
        Etienne Carriere <etienne.carriere@st.com>
Cc:     kernel@pengutronix.de, Holger Assmann <h.assmann@pengutronix.de>,
        linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: stm32: remove unnecessary DMA kernel error log
Date:   Fri, 14 Aug 2020 16:13:55 +0200
Message-Id: <20200814141355.3816-1-h.assmann@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: has@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently print errors twice when there is an actual error
when requesting a DMA channel, once in stm32f7_i2c_probe()
when stm32_i2c_dma_request() fails and once more in
stm32_i2c_dma_request() itself. stm32_i2c_dma_request() is only
called from stm32f7_i2c_probe(), so we could drop the duplicate
error message.

This has the effect that we no longer warn about absence of a
DMA channel. This is intended as it is not mandatory for the
i2c-stm32 devices to have DMA enabled.  Also, the overall number
of DMA channels on the STM32 is limited and has to be shared
with other peripherals. This may lead to DMA being intentionally
off for specific devices.

This patch removes the unnecessary error message.

Fixes: e07a89775c71 ("i2c: stm32: don't print an error on probe deferral")
Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
---
 drivers/i2c/busses/i2c-stm32.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
index 3f69a3bb6119..cc05a4202559 100644
--- a/drivers/i2c/busses/i2c-stm32.c
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -26,8 +26,6 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
 		ret = PTR_ERR(dma->chan_tx);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "can't request DMA tx channel\n");
 		goto fail_al;
 	}
 
@@ -46,9 +44,6 @@ struct stm32_i2c_dma *stm32_i2c_dma_request(struct device *dev,
 	dma->chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->chan_rx)) {
 		ret = PTR_ERR(dma->chan_rx);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "can't request DMA rx channel\n");
-
 		goto fail_tx;
 	}
 
-- 
2.20.1


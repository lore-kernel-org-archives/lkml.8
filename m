Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6D2C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EDD22208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQ/hVm91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGNLTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgGNLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021BC08C5FC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so20906778wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnI1Hr8cN1xgbEvUxkhLUJ4OsaPQfVlLvMmqI8pCO3s=;
        b=NQ/hVm91tDxmABEPbH0rNFSS8NGb/3PLnnApSOyHhscglrmoLOMyFWz5wtrlv5WEAc
         w7NAY2gdTBxkp94u7rS0Tgl3QOcWWldpWa1sZatsmBy4bkojuQ84zuqlGEmm43TZlNhe
         7e3tzwADI4qKPfm21AmneVuYTXCGvYdl6nXLIBiAbNSxYm48Go5/XJhJbknaO85600l/
         TzbhOUwbnb14+TgiQxeYmoqM4xnXjKW+V62qGrdsT14LaW6eknTWW9U8wx+FLbneGpIQ
         tr/AyMKX9X+pZ6WHkzUes84iQtVh7eyenP5X+cqfAeZa6IUYaorMUth/P/mYblGq+9S0
         DidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnI1Hr8cN1xgbEvUxkhLUJ4OsaPQfVlLvMmqI8pCO3s=;
        b=d722fVY6N40qDTyw3cVjAzTJGF0x9ib3Zg3U6DRd1AV3D10N/IgcV6ix0LvPVTaptP
         CF0maNd6qH0ZSzXxWDQPTQX6TudNQuddsQwBUUmq7pcqouY4wBl8CDmerVaCdaeYE/79
         i+1y6OaUSPhMaZ3xo2kt+B6Du0X6maE6BDq04EvWYplIYSIIzJ9ADb0XSB6Vreu47spH
         IwT4p/Grhai1qhkmwqdVUGv8bLcKdjpRDRw7RlHTqp/EnwXCrg/FT+r3MnhV5gFUCjWW
         znLk5Z2N/PXXQl+93UPQc14yAbtOKygaBImp2fB8xwZP7m04rR5NBHmRyfH8pS50Nxgr
         XANQ==
X-Gm-Message-State: AOAM530soj7mMXPEO4yoSxJIckVrREhzB24puSvVNI1f/sCFeY4Y8gJq
        yXcgX4u4dmb0uYYG7YhtYp9W+A==
X-Google-Smtp-Source: ABdhPJzYlJ+XLLzRSmvIFCs1WJ2WYX+Cwdno9y3SVmnqqB4jRMVHTnl+GSY47lUzMwCDxwwOni3Ziw==
X-Received: by 2002:adf:db86:: with SMTP id u6mr4773505wri.27.1594725362227;
        Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 11/17] dma: imx-sdma: Correct formatting issue and provide 2 new descriptions
Date:   Tue, 14 Jul 2020 12:15:40 +0100
Message-Id: <20200714111546.1755231-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'slave_config' not described in 'sdma_channel'
 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'context_loaded' not described in 'sdma_channel'
 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'terminate_worker' not described in 'sdma_channel'

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 270992c4fe475..4f8d8f5e11329 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -335,7 +335,7 @@ struct sdma_desc {
  * @sdma:		pointer to the SDMA engine for this channel
  * @channel:		the channel number, matches dmaengine chan_id + 1
  * @direction:		transfer type. Needed for setting SDMA script
- * @slave_config	Slave configuration
+ * @slave_config:	Slave configuration
  * @peripheral_type:	Peripheral type. Needed for setting SDMA script
  * @event_id0:		aka dma request line
  * @event_id1:		for channels that use 2 events
@@ -354,8 +354,10 @@ struct sdma_desc {
  * @shp_addr:		value for gReg[6]
  * @per_addr:		value for gReg[2]
  * @status:		status of dma channel
+ * @context_loaded:	ensure context is only loaded once
  * @data:		specific sdma interface structure
  * @bd_pool:		dma_pool for bd
+ * @terminate_worker:	used to call back into terminate work function
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
-- 
2.25.1


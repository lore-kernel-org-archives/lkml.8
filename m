Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170AC3815B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89207206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648572;
	bh=BuT+U3bSnltRoLUw4bLKl1iPe6gDp2CGnADnaOvLaGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Viike5Kq8ay4KhtVXjnofLpQpGyNa0anVqVb0oXAb7amv0PmBOAY80EypmBkdSsi
	 Tu8shpltj6kcyZhP9ruymMT97kJoFOr/MIGuAF8t0SuztF09bHr9vUdIa0UrOimp+i
	 5fbph+Rrdc2FkZDrs/uL2pL5pCVHrjFjrCw//7cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgDKXGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgDKXGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBED21744;
        Sat, 11 Apr 2020 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646385;
        bh=BuT+U3bSnltRoLUw4bLKl1iPe6gDp2CGnADnaOvLaGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dj+MXXl3tEVDbBM9atZ+l4MXuS1bs6JQXof0uUsgsPMFbxqsDJh8FevQ/cP62ia0y
         pw78lT6C8gZDv0O1wn7Sv2dJJWLjGrIH/aXcRbxIjgbdTULL7rIC5h+MDqTSG/2eoA
         9/LZvlw2XifzxVjYJ01wqwBNIjtUD321sGnT5/vI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Etienne Carriere <etienne.carriere@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 125/149] dmaengine: stm32-dma: use reset controller only at probe time
Date:   Sat, 11 Apr 2020 19:03:22 -0400
Message-Id: <20200411230347.22371-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

[ Upstream commit 8cf1e0fc50fcc25021567bb2755580504c57c83a ]

Remove reset controller reference from device instance since it is
used only at probe time.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Link: https://lore.kernel.org/r/20200129153628.29329-3-amelie.delaunay@st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/stm32-dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5989b08935211..ff34a10fc8d89 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -207,7 +207,6 @@ struct stm32_dma_device {
 	struct dma_device ddev;
 	void __iomem *base;
 	struct clk *clk;
-	struct reset_control *rst;
 	bool mem2mem;
 	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
 };
@@ -1275,6 +1274,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	struct dma_device *dd;
 	const struct of_device_id *match;
 	struct resource *res;
+	struct reset_control *rst;
 	int i, ret;
 
 	match = of_match_device(stm32_dma_of_match, &pdev->dev);
@@ -1309,11 +1309,11 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
 						"st,mem2mem");
 
-	dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
-	if (!IS_ERR(dmadev->rst)) {
-		reset_control_assert(dmadev->rst);
+	rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
 		udelay(2);
-		reset_control_deassert(dmadev->rst);
+		reset_control_deassert(rst);
 	}
 
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
-- 
2.20.1


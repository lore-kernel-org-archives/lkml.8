Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5850FC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733C21924
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646852;
	bh=Gs9gV0T5JmCcdrBT2Z6oU0AYlf9e1hsG3yby/+UBH3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLgDG124t6tJ/kL68UKvGnG/ryMVrNTPDbL9B7+FWJSSFJEmBtbqRz4YHKeFFFWdm
	 DRdy/cAmcQj+yH3D+xMgcVIakfM902Cbd+RZrwfrTN322Ly3Pb5dckNT2Ixf/xSsBN
	 k7JCDteWyj7wC6i9JvavK/42UibkgFZjMxgtY/ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgDKXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgDKXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:14:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB98820708;
        Sat, 11 Apr 2020 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646846;
        bh=Gs9gV0T5JmCcdrBT2Z6oU0AYlf9e1hsG3yby/+UBH3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xm1zUjridEKkLLjq8i11HHMGdkZKfGWC/qAoU7ICnCiZf4/yYNGudzJleCFfBnE6t
         EMPM87qD7z/qcqToOdiS29dGNpNiGceX2USgGskXL3O2lzOsc61Y5Axe8oEWFiOV5k
         Gi2LX6swPA8rfNAEnOo8beHwJopjYG84l+Jjz7xA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Etienne Carriere <etienne.carriere@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 33/37] dmaengine: stm32-dma: use reset controller only at probe time
Date:   Sat, 11 Apr 2020 19:13:22 -0400
Message-Id: <20200411231327.26550-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231327.26550-1-sashal@kernel.org>
References: <20200411231327.26550-1-sashal@kernel.org>
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
index 32192e98159b2..02172997a184d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -177,7 +177,6 @@ struct stm32_dma_device {
 	struct dma_device ddev;
 	void __iomem *base;
 	struct clk *clk;
-	struct reset_control *rst;
 	bool mem2mem;
 	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
 };
@@ -1034,6 +1033,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	struct dma_device *dd;
 	const struct of_device_id *match;
 	struct resource *res;
+	struct reset_control *rst;
 	int i, ret;
 
 	match = of_match_device(stm32_dma_of_match, &pdev->dev);
@@ -1062,11 +1062,11 @@ static int stm32_dma_probe(struct platform_device *pdev)
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


Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08449C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7D9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281549;
	bh=eejwkf5aLP13LBU3eN1eFu50Bc9f75o89K27gI+G6Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WTlL6yBjiwBLkv8OmVxKwq/hHtwwcNWLV0eeX+sfX1pEAQbeWmmdGQHETj71vCii2
	 99cyFkCocVd9Ksq73cJTyEFQk3svMW2MVlI3Z6ZIk9QiRE6S169kY0ruqE00Cagk0a
	 PhvEJg9wWUcq3e8KBEofYNa+a69HAmSq2PZS0fSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgGTVps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGTVh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE7022D08;
        Mon, 20 Jul 2020 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281047;
        bh=eejwkf5aLP13LBU3eN1eFu50Bc9f75o89K27gI+G6Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0D8U8EmxGuO40Qy0mZaiknZcdlAUCXro8BwQrn8XpUm8wJVB4fHptzm8L2p3rrhKS
         WGp7oNIAdopMurE5Z+Jsoz23/YCVCNUrlh01ehpUP6FOX1VP6o0VEg9LXxNdUBVX9z
         gbz+joY22vR6JavgSZUa3U+mZ4ZJ/uBRlVWNOjwA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 09/40] dmaengine: tegra210-adma: Fix runtime PM imbalance on error
Date:   Mon, 20 Jul 2020 17:36:44 -0400
Message-Id: <20200720213715.406997-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 5b78fac4b1ba731cf4177fdbc1e3a4661521bcd0 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20200624064626.19855-1-dinghao.liu@zju.edu.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/tegra210-adma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index db58d7e4f9fec..c5fa2ef74abc7 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
 
 	ret = pm_runtime_get_sync(tdc2dev(tdc));
 	if (ret < 0) {
+		pm_runtime_put_noidle(tdc2dev(tdc));
 		free_irq(tdc->irq, tdc);
 		return ret;
 	}
@@ -869,8 +870,10 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto rpm_disable;
+	}
 
 	ret = tegra_adma_init(tdma);
 	if (ret)
-- 
2.25.1


Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63941C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363D220838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096629;
	bh=9JKDfUhdeddyJ9Fqh2SV91QEs3A3JERW2Zy48paEr1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h6iYQphTEde0e+P27gFDXEk5USjjhxnjjDJ3lWGKPXtRohzo4dU/G+31GV3yXvcIC
	 3WlV3sV/IN1IgFrQuR9SCaJft6ck0S4MD8lRkn4/c29KWldiPJCAjdcn9k73g7jjgH
	 NR18M+AnjDtDDYNInp5yRLFffCQZtEtkYAHQBhfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgG3IKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgG3IKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:10:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE672070B;
        Thu, 30 Jul 2020 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096610;
        bh=9JKDfUhdeddyJ9Fqh2SV91QEs3A3JERW2Zy48paEr1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaM8pySjZFkS9En7pOVVbVDgLp0ErW5ocQw9Ck0Frlm+JT1WfaxpnUoapHFQruLL1
         9u9hwbKHfJRB6WmHEfdXtusbxILZeZDZjcB1GSAM5yw0R06otp27VhuJg7RV5rQ8Am
         MMeRM0p2lQNw16+0gupymWIBgW3MJQ2EuZSgaSRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 23/61] dmaengine: tegra210-adma: Fix runtime PM imbalance on error
Date:   Thu, 30 Jul 2020 10:04:41 +0200
Message-Id: <20200730074421.968538532@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c16c06b3dd2f4..54296e262deab 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -583,6 +583,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
 
 	ret = pm_runtime_get_sync(tdc2dev(tdc));
 	if (ret < 0) {
+		pm_runtime_put_noidle(tdc2dev(tdc));
 		free_irq(tdc->irq, tdc);
 		return ret;
 	}
@@ -764,8 +765,10 @@ static int tegra_adma_probe(struct platform_device *pdev)
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




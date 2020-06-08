Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA93C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E504A20C56
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658623;
	bh=xfgbRMaYu1U4oFDf4gWpQzShktC0BgPWQW1Ys9OQYtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aIvfirr/7aEtVuy6s4MPO7uvAVihV1lMF43BnuUQgr8vnI/6MICepNB1BKp92nrK8
	 IeV8z6yYvN41w1sQ56hi6jcfNEcSgw6rlFVsNd9S3r8trpoRAIqrSOKjjmfK7PBVHN
	 CmfMtTry7kTEeQFK68ZtVckQqVc1g4jLymV0wngE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgFHXXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730656AbgFHXSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422DE20842;
        Mon,  8 Jun 2020 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658316;
        bh=xfgbRMaYu1U4oFDf4gWpQzShktC0BgPWQW1Ys9OQYtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO0SGEFffzgh8rP0vI+FoSaKfMMYo2jj2V7WmX2CzWr3peSFAnOjGqeLNFovLj/Ik
         7iUvHhZMZ+L1Sxwd40LPIusnToAlNsK9wBWaEAgcB4UcPS0dagk27gkxlbjtF7+Wbo
         pHYKFaBoxSUwYwlGXsLkN9f+L+fye0XcTlx8nI0M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 316/606] gpio: bcm-kona: Fix return value of bcm_kona_gpio_probe()
Date:   Mon,  8 Jun 2020 19:07:21 -0400
Message-Id: <20200608231211.3363633-316-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 98f7d1b15e87c84488b30ecc4ec753b0690b9dbf ]

Propagate the error code returned by devm_platform_ioremap_resource()
out of probe() instead of overwriting it.

Fixes: 72d8cb715477 ("drivers: gpio: bcm-kona: use devm_platform_ioremap_resource()")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[Bartosz: tweaked the commit message]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index baee8c3f06ad..cf3687a7925f 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -625,7 +625,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 
 	kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kona_gpio->reg_base)) {
-		ret = -ENXIO;
+		ret = PTR_ERR(kona_gpio->reg_base);
 		goto err_irq_domain;
 	}
 
-- 
2.25.1


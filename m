Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9451C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44221582
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034952;
	bh=fbp5eN4Hnuv3+bR/hO5F+wm3gfMFLymjiWDBZD1oZEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IzryWQuFCLbrGF2lF09/Tz97hHGvFV0XalhqWnaOmmj2khyw1z91roDHsJfdTbTXi
	 t0z0t7aZ6K4UwjlDTw4b7qtgzay22ljT4Hso+S3g0KONCWKVvqz++TIK6FgeOS7b1K
	 OUvZ3XlDxsVjpQkTe7HOEo2x0yzYc/pegk0fuxLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgFASJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgFASJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:09:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3184E206E2;
        Mon,  1 Jun 2020 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034948;
        bh=fbp5eN4Hnuv3+bR/hO5F+wm3gfMFLymjiWDBZD1oZEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2ESWlGWhEl3PFf0bWyCp8f618knM9Dse3VG/XP6rAkGdrwG6BuYNCAYKZrjZUS/N
         qjoIj3IdnAIsy1vQScgpTgK+Hb2dgSJKmRpnKWyU33xZ/cpv/snHQUqf8Ym3Ub74Si
         Rj9gzDaZOg5DqU/wrhLYMI40/263TbXriy7s/HnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 084/142] gpio: pxa: Fix return value of pxa_gpio_probe()
Date:   Mon,  1 Jun 2020 19:54:02 +0200
Message-Id: <20200601174046.636051642@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 558ab2e8155e5f42ca0a6407957cd4173dc166cc ]

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 542c25b7a209 ("drivers: gpio: pxa: use devm_platform_ioremap_resource()")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 9888b62f37af..432c487f77b4 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -663,8 +663,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	pchip->irq1 = irq1;
 
 	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!gpio_reg_base)
-		return -EINVAL;
+	if (IS_ERR(gpio_reg_base))
+		return PTR_ERR(gpio_reg_base);
 
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-- 
2.25.1




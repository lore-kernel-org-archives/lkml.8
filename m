Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECC02065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692301;
	bh=5jBy9Sbw6TZGfmZD9NAK0ySdYA0L+padKW5xd+QSurk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xp8TvXrRkeK2r2Avt6ln+Z0CDvOLk4v/PzY+/irI2mIWp0oqjIc5/uK21XahyRjA6
	 PUMsa2Wdx4tFvMcG2AotkxoKfx09S0eutsu+s4zweXMTA5CD0lfiIsrR5/H0yC4fdC
	 +xam+LLbdoNTgZehjVNaFYlz6KCifb/4BitBNWJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgHQTZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbgHQPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:34:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A8B23441;
        Mon, 17 Aug 2020 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678474;
        bh=5jBy9Sbw6TZGfmZD9NAK0ySdYA0L+padKW5xd+QSurk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvBYrEbmK1jX4RCnf3gQlK2hrWqIkniVLixx64JT4rj9lnpuutmnrDB61wQ8Lxu24
         y6lyXBIof5ElUX01jSLcXBqhrJE3vZ+L/pZevgsgcibFRudyIcsav+KOJMIKm5kKqO
         JiH4g9os75kiCeczGOkA7r/WkEixbsFSde9EnSfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 319/464] nvmem: sprd: Fix return value of sprd_efuse_probe()
Date:   Mon, 17 Aug 2020 17:14:32 +0200
Message-Id: <20200817143849.077200748@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit bcd14bb7a68520bf88e45e91d354e43535624f82 ]

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200722100705.7772-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/sprd-efuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 925feb21d5adf..59523245db8a5 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -378,8 +378,8 @@ static int sprd_efuse_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	efuse->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!efuse->base)
-		return -ENOMEM;
+	if (IS_ERR(efuse->base))
+		return PTR_ERR(efuse->base);
 
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret < 0) {
-- 
2.25.1




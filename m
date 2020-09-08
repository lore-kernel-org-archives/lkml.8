Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CD92087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599591681;
	bh=y+zrUYeyGIEDIzii/wZZiVN5+0rnA8OlhzATkZVQEdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrKgbIPCasN4QiDU8bvkp5OMTT8BNzm3DNGAyBSMQXz4HyeNdbHhrZR7iuFdNFXJb
	 Ze9riq6m9k0cm3ldMkdlphRT50EVNG5zx02Up8EpY7t+PcCLVQS5Wq8+iEyQ7B7ynN
	 UQzGfqX3fMM4ZetZ+++qzQrh8M4iAgu/7eYgazss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbgIHTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbgIHQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F36F23F2C;
        Tue,  8 Sep 2020 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580086;
        bh=y+zrUYeyGIEDIzii/wZZiVN5+0rnA8OlhzATkZVQEdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7oxB6aJDGKFNQiZrVoFFOHSG1OnXSZY4D7DfQy5iSAwkosEhdrqK+9yQ+P9g4QCC
         qFCfT6N5I6qlZPAVcNUNEQICuJzAeiCsgyKjV38QPaU0NwWSGJYpKHNG+SKJkg5U1H
         i3opgvgNf5b2HMwEuAZaO+WSElBUEogpQTZTi0Ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/88] net: systemport: Fix memleak in bcm_sysport_probe
Date:   Tue,  8 Sep 2020 17:25:27 +0200
Message-Id: <20200908152222.372361279@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 7ef1fc57301f3cef7201497aa27e89ccb91737fe ]

When devm_kcalloc() fails, dev should be freed just
like what we've done in the subsequent error paths.

Fixes: 7b78be48a8eb6 ("net: systemport: Dynamically allocate number of TX rings")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 6b761f6b8fd56..9a614c5cdfa22 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2441,8 +2441,10 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	priv->tx_rings = devm_kcalloc(&pdev->dev, txq,
 				      sizeof(struct bcm_sysport_tx_ring),
 				      GFP_KERNEL);
-	if (!priv->tx_rings)
-		return -ENOMEM;
+	if (!priv->tx_rings) {
+		ret = -ENOMEM;
+		goto err_free_netdev;
+	}
 
 	priv->is_lite = params->is_lite;
 	priv->num_rx_desc_words = params->num_rx_desc_words;
-- 
2.25.1




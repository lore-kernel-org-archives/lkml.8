Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7887C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F38B20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WCoxlxcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgEWN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbgEWN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:27:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB6C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so12950229wrc.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64kvwBG1/A4ZIpIpQ81Lq/ynCrPXhKaGjAzI5WzwgPE=;
        b=WCoxlxcAreaFf6FWNGwNvYKxgyg/0gU+HbaYFg23bXDv4PSZYQHZlcxTOz7FCYoubj
         5e5E0jUoENWF/3lKC2kOeluwhMEcroHJYd4LLhnNzHEnkUXIYnNGkbayPKVmcdBOa4Ct
         Zd7GHa3AvzA8wj3qLAFTjfju/dvJxGVk6M8DDJ+ik4ZotMuSwK1r56f3O59Uk50PFPVn
         R0DaSsNzfIUyeO9IWOXdsNRiOpScHj5lcBRivA9lt7wATE958fMmZQ8bNr/E3zw9Lp+a
         lRCGiGC2Qe4t821qu5XEVbdXbkQ+sQS32lFBOC3K6B9MwNUMYCIjE+kQk5GoDFnQ/755
         JQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64kvwBG1/A4ZIpIpQ81Lq/ynCrPXhKaGjAzI5WzwgPE=;
        b=rhUz8inuFB4QlYlWqkv8wKP9A66xWmqy3pSkbI5HjTcoXfHYDA1WPEwF1SC7dGdr5g
         h5npnaNIzKg85u+Lsck0fKe4LrQtq466PpWkLsICL7tjjeEzhWoNK/VW0syCtgKXeVE1
         Dv9HgvNamVreELVsVJPSSv8jvDj2mZjkYwG82DNxQ60wSoCP7GjTHOh7rYyj9VGvM8aM
         ifLGfG7uFkjrr+RxAwgAFWlLtC6OAQb1OQOP6Pw7PNNrT5x0NrKzd7cPsS8NpL8DNoQk
         DPUA5a4H+vmL7ODhJhc88q4gJQ9AtLHx+eYVL4SDmaIMZ38MKBt37yeDiL6HUeHrxuK0
         gKxQ==
X-Gm-Message-State: AOAM532x9jQIMNPxhtTWfRc8FxcJrEA5Q6WbRsNsXOv2IZqtWIOegZ+1
        PUGjgwr4XJ7yR1qOmMQ85wta0g==
X-Google-Smtp-Source: ABdhPJzIGyb5J01y0YxEKH5gekjElLjvEzQP6NEzA1GtaboJVo5CQutHS2WF+ceWndsriO45lbSBPQ==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr3797110wrm.33.1590240446683;
        Sat, 23 May 2020 06:27:26 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id g69sm8098703wmg.15.2020.05.23.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 06:27:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/5] net: ethernet: mtk_star_emac: use devm_register_netdev()
Date:   Sat, 23 May 2020 15:27:11 +0200
Message-Id: <20200523132711.30617-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200523132711.30617-1-brgl@bgdev.pl>
References: <20200523132711.30617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new devres variant of register_netdev() in the mtk-star-emac
driver and shrink the code by a couple lines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 789c77af501f..b74349cede28 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1519,13 +1519,6 @@ static void mtk_star_mdiobus_unregister(void *data)
 	mdiobus_unregister(priv->mii);
 }
 
-static void mtk_star_unregister_netdev(void *data)
-{
-	struct net_device *ndev = data;
-
-	unregister_netdev(ndev);
-}
-
 static int mtk_star_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node;
@@ -1641,15 +1634,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 
 	netif_napi_add(ndev, &priv->napi, mtk_star_poll, MTK_STAR_NAPI_WEIGHT);
 
-	ret = register_netdev(ndev);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, mtk_star_unregister_netdev, ndev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_register_netdev(dev, ndev);
 }
 
 static const struct of_device_id mtk_star_of_match[] = {
-- 
2.25.0


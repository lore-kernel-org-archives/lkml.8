Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16522207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R7zN8JmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgETLoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgETLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:44:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF639C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:44:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so2795469wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDvXJX4yV3p/HLngOBi/jKhO6RPUbYJQuBEN6OKUGtQ=;
        b=R7zN8JmITYNRLCw9ivuWeVAv4mugM84KU9YtOgLMG84n9N+ErPDlDOUXwmnnn6qAK0
         viPGPNbxdWUJXG4FO2NefKDnqLl+ENkQThQY7F7pVJLW7vTVZ1SfT47impUX3qDOd2VQ
         uEkDA/gG3TYp0MSKvb6EO3pf49EGvtOXQXJigVQlnn4NsSR4ny5rZcBkqy8g6uUU53O5
         M1yNyMEx4zclKGqRO8yeeGHcEX3Vt5PjHhwmyW0CwImOXcw/fAUlzgLkGY4MThV+pK2K
         h27XQSVc0pcPLN7VXSi/HBl9isXiwjvQ9x9/UtiIEgN+mxIitT8el5sMSp02Se1SEvP+
         QHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDvXJX4yV3p/HLngOBi/jKhO6RPUbYJQuBEN6OKUGtQ=;
        b=S2inX7RrumS8EpN2CUs7OhOHyVVSgRqZvyYq48AdEI04jTEux1zekTAJ3B6rmmlIQh
         yhAnf2dtUK8btPXO9Zazr3XvlAV9ExJExtOjNHXde2igWPGi2ngoLIOLYklRp0SUQzqG
         FKsKAAD5VCv3+JGUiyfJhyER1JjOUFivYysoCvFDFpRl0McvQ5Cign0LCr2YrqrHv3Jg
         m9kN7QO6vfAvyQKR+a3yEhI9ltNdeIyCLlz/95UtfFRBTzzcrM2JbrxyBdc+3qFKw8Ss
         8gyVMgi17qHCVQpSPmVLQ8+PkNthkMziWIbvRSl7bWar+qbYwGeckhUp/P83YTrev8I8
         Xj6w==
X-Gm-Message-State: AOAM53199F/ERZC9uQtOA46fUabZeWq5DSVTnHVq+v8gz0lpimwyvo8C
        we/JyGeocVfHG9XerWqBj0P6Bg==
X-Google-Smtp-Source: ABdhPJxix/P9D3Mn5oh6fiWDRRTUhSOcXRz8XE3qxCx4RCTw666U9OaDVlR73p1lgKqZTh/IlvPteQ==
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr3697173wrt.48.1589975069582;
        Wed, 20 May 2020 04:44:29 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id q2sm2530782wrx.60.2020.05.20.04.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:44:29 -0700 (PDT)
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
Subject: [PATCH 5/5] net: ethernet: mtk_eth_mac: use devm_register_netdev()
Date:   Wed, 20 May 2020 13:44:15 +0200
Message-Id: <20200520114415.13041-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520114415.13041-1-brgl@bgdev.pl>
References: <20200520114415.13041-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new devres variant of register_netdev() in the mtk-eth-mac
driver and shrink the code by a couple lines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_mac.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_mac.c b/drivers/net/ethernet/mediatek/mtk_eth_mac.c
index 4dfe7c2c4e3d..2919ce27efeb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_mac.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_mac.c
@@ -1513,13 +1513,6 @@ static void mtk_mac_clk_disable_unprepare(void *data)
 	clk_bulk_disable_unprepare(MTK_MAC_NCLKS, priv->clks);
 }
 
-static void mtk_mac_unregister_netdev(void *data)
-{
-	struct net_device *ndev = data;
-
-	unregister_netdev(ndev);
-}
-
 static int mtk_mac_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node;
@@ -1631,15 +1624,7 @@ static int mtk_mac_probe(struct platform_device *pdev)
 
 	netif_napi_add(ndev, &priv->napi, mtk_mac_poll, MTK_MAC_NAPI_WEIGHT);
 
-	ret = register_netdev(ndev);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, mtk_mac_unregister_netdev, ndev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_register_netdev(dev, ndev);
 }
 
 static const struct of_device_id mtk_mac_of_match[] = {
-- 
2.25.0


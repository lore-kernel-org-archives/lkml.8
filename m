Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39623C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6872084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KmRbdjqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbgE1OXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391112AbgE1OW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:22:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A2C08C5C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:22:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so3366394wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jw+8SfYlfUDAgIF9spfjdhK61J/Bd95zBvBrsjSxAUU=;
        b=KmRbdjqFJMDgM7zZgdmnW7RkEEYSCnk8RqnqZH9e536aJiiYoonWkmpmwhcQXZ9cVu
         ntU2cadu6Gw5uLX58u1UPfBqbZy5jSdgu2SrqgU+bLKYJu2Mgd/+/HxpCAtWbmsQYC8t
         lXFVV59WmDC3VU7VT/n0he1AmfcMRaEJNQV6V8Rv9Bl3Y3x3ECHFSLzgQD35qCHxIe97
         QkbeFcByw573bt4VJJCpoMkvpcQ2RK2z72BF4HHhlpb1YGCZtNjlwri6mN24fjjbQXqq
         FPw/SXEOfb+PVVO/uKrTO+ObuUP1jvcrl6354btOH6QeX5FDDfbRHZQlq5+wJkeCkwyj
         WBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jw+8SfYlfUDAgIF9spfjdhK61J/Bd95zBvBrsjSxAUU=;
        b=sZwE3SVKqoeJdyL7RB9VT3C6ksXZa6DfzmtOK4El8KoL9cJg1p42SSSsSj8mgFrpTM
         7ARXu1LRJPsYy/wA4cmFkTAhKOK5H0PWI/ju6S0j0ShG7nmMbXy2DlTp696qq4PkSi2z
         5UG5nPlOdwj+WnVhzklMgeCjaW/Ph15+Neo+YnwvOayflc6O8G7dA0bCwkY4hgVcWf6M
         gEqN3W9wBUEm030XuwzlBVlxuJZk2WrYawSPUOBbVdiZ9TXMvARKO9251WCAk3mxxAmh
         XkXIQHHE4JmMwaEcbcyvGld2i7vz/QX7Nsvhn5HP6Nk/JUKAizWuX+iQpzswq/+gpQsA
         UHUQ==
X-Gm-Message-State: AOAM530j8Qnd5m6UPbrACxy1G+beHXzFe0RRuHXpYaxEp6ThytIPudMi
        xflDbkxqmHp9Kmcy9RAhTQHKBA==
X-Google-Smtp-Source: ABdhPJzQFiE8t6RKpsfwffFg3syXfwNajeDQoVonEqPDskIMt1HelrgucHFaJkjQw0uAe+nlCydZ2w==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr3532655wmh.113.1590675775296;
        Thu, 28 May 2020 07:22:55 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h74sm6258162wrh.76.2020.05.28.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:22:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/2] net: ethernet: mtk-star-emac: use regmap bitops
Date:   Thu, 28 May 2020 16:22:41 +0200
Message-Id: <20200528142241.20466-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528142241.20466-1-brgl@bgdev.pl>
References: <20200528142241.20466-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink the code visually by replacing regmap_update_bits() with
appropriate regmap bit operations where applicable.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 80 ++++++++-----------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 8596ca0e60eb..326ac792a4a0 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -413,8 +413,8 @@ static void mtk_star_dma_unmap_tx(struct mtk_star_priv *priv,
 
 static void mtk_star_nic_disable_pd(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_MAC_CFG,
-			   MTK_STAR_BIT_MAC_CFG_NIC_PD, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_MAC_CFG,
+			  MTK_STAR_BIT_MAC_CFG_NIC_PD);
 }
 
 /* Unmask the three interrupts we care about, mask all others. */
@@ -434,41 +434,38 @@ static void mtk_star_intr_disable(struct mtk_star_priv *priv)
 
 static void mtk_star_intr_enable_tx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_BIT_INT_STS_TNTC, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			  MTK_STAR_BIT_INT_STS_TNTC);
 }
 
 static void mtk_star_intr_enable_rx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_BIT_INT_STS_FNRC, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			  MTK_STAR_BIT_INT_STS_FNRC);
 }
 
 static void mtk_star_intr_enable_stats(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_REG_INT_STS_MIB_CNT_TH, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			  MTK_STAR_REG_INT_STS_MIB_CNT_TH);
 }
 
 static void mtk_star_intr_disable_tx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_BIT_INT_STS_TNTC,
-			   MTK_STAR_BIT_INT_STS_TNTC);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			MTK_STAR_BIT_INT_STS_TNTC);
 }
 
 static void mtk_star_intr_disable_rx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_BIT_INT_STS_FNRC,
-			   MTK_STAR_BIT_INT_STS_FNRC);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			MTK_STAR_BIT_INT_STS_FNRC);
 }
 
 static void mtk_star_intr_disable_stats(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_INT_MASK,
-			   MTK_STAR_REG_INT_STS_MIB_CNT_TH,
-			   MTK_STAR_REG_INT_STS_MIB_CNT_TH);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_INT_MASK,
+			MTK_STAR_REG_INT_STS_MIB_CNT_TH);
 }
 
 static unsigned int mtk_star_intr_read(struct mtk_star_priv *priv)
@@ -524,12 +521,10 @@ static void mtk_star_dma_init(struct mtk_star_priv *priv)
 
 static void mtk_star_dma_start(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_TX_DMA_CTRL,
-			   MTK_STAR_BIT_TX_DMA_CTRL_START,
-			   MTK_STAR_BIT_TX_DMA_CTRL_START);
-	regmap_update_bits(priv->regs, MTK_STAR_REG_RX_DMA_CTRL,
-			   MTK_STAR_BIT_RX_DMA_CTRL_START,
-			   MTK_STAR_BIT_RX_DMA_CTRL_START);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_TX_DMA_CTRL,
+			MTK_STAR_BIT_TX_DMA_CTRL_START);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_RX_DMA_CTRL,
+			MTK_STAR_BIT_RX_DMA_CTRL_START);
 }
 
 static void mtk_star_dma_stop(struct mtk_star_priv *priv)
@@ -553,16 +548,14 @@ static void mtk_star_dma_disable(struct mtk_star_priv *priv)
 
 static void mtk_star_dma_resume_rx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_RX_DMA_CTRL,
-			   MTK_STAR_BIT_RX_DMA_CTRL_RESUME,
-			   MTK_STAR_BIT_RX_DMA_CTRL_RESUME);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_RX_DMA_CTRL,
+			MTK_STAR_BIT_RX_DMA_CTRL_RESUME);
 }
 
 static void mtk_star_dma_resume_tx(struct mtk_star_priv *priv)
 {
-	regmap_update_bits(priv->regs, MTK_STAR_REG_TX_DMA_CTRL,
-			   MTK_STAR_BIT_TX_DMA_CTRL_RESUME,
-			   MTK_STAR_BIT_TX_DMA_CTRL_RESUME);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_TX_DMA_CTRL,
+			MTK_STAR_BIT_TX_DMA_CTRL_RESUME);
 }
 
 static void mtk_star_set_mac_addr(struct net_device *ndev)
@@ -845,8 +838,8 @@ static int mtk_star_hash_wait_ok(struct mtk_star_priv *priv)
 		return ret;
 
 	/* Check the BIST_OK bit. */
-	regmap_read(priv->regs, MTK_STAR_REG_HASH_CTRL, &val);
-	if (!(val & MTK_STAR_BIT_HASH_CTRL_BIST_OK))
+	if (!regmap_test_bits(priv->regs, MTK_STAR_REG_HASH_CTRL,
+			      MTK_STAR_BIT_HASH_CTRL_BIST_OK))
 		return -EIO;
 
 	return 0;
@@ -880,12 +873,10 @@ static int mtk_star_reset_hash_table(struct mtk_star_priv *priv)
 	if (ret)
 		return ret;
 
-	regmap_update_bits(priv->regs, MTK_STAR_REG_HASH_CTRL,
-			   MTK_STAR_BIT_HASH_CTRL_BIST_EN,
-			   MTK_STAR_BIT_HASH_CTRL_BIST_EN);
-	regmap_update_bits(priv->regs, MTK_STAR_REG_TEST1,
-			   MTK_STAR_BIT_TEST1_RST_HASH_MBIST,
-			   MTK_STAR_BIT_TEST1_RST_HASH_MBIST);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_HASH_CTRL,
+			MTK_STAR_BIT_HASH_CTRL_BIST_EN);
+	regmap_set_bits(priv->regs, MTK_STAR_REG_TEST1,
+			MTK_STAR_BIT_TEST1_RST_HASH_MBIST);
 
 	return mtk_star_hash_wait_ok(priv);
 }
@@ -1016,13 +1007,13 @@ static int mtk_star_enable(struct net_device *ndev)
 		return ret;
 
 	/* Setup the hashing algorithm */
-	regmap_update_bits(priv->regs, MTK_STAR_REG_ARL_CFG,
-			   MTK_STAR_BIT_ARL_CFG_HASH_ALG |
-			   MTK_STAR_BIT_ARL_CFG_MISC_MODE, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_ARL_CFG,
+			  MTK_STAR_BIT_ARL_CFG_HASH_ALG |
+			  MTK_STAR_BIT_ARL_CFG_MISC_MODE);
 
 	/* Don't strip VLAN tags */
-	regmap_update_bits(priv->regs, MTK_STAR_REG_MAC_CFG,
-			   MTK_STAR_BIT_MAC_CFG_VLAN_STRIP, 0);
+	regmap_clear_bits(priv->regs, MTK_STAR_REG_MAC_CFG,
+			  MTK_STAR_BIT_MAC_CFG_VLAN_STRIP);
 
 	/* Setup DMA */
 	mtk_star_dma_init(priv);
@@ -1204,9 +1195,8 @@ static void mtk_star_set_rx_mode(struct net_device *ndev)
 	int ret;
 
 	if (ndev->flags & IFF_PROMISC) {
-		regmap_update_bits(priv->regs, MTK_STAR_REG_ARL_CFG,
-				   MTK_STAR_BIT_ARL_CFG_MISC_MODE,
-				   MTK_STAR_BIT_ARL_CFG_MISC_MODE);
+		regmap_set_bits(priv->regs, MTK_STAR_REG_ARL_CFG,
+				MTK_STAR_BIT_ARL_CFG_MISC_MODE);
 	} else if (netdev_mc_count(ndev) > MTK_STAR_HASHTABLE_MC_LIMIT ||
 		   ndev->flags & IFF_ALLMULTI) {
 		for (i = 0; i < MTK_STAR_HASHTABLE_SIZE_MAX; i++) {
-- 
2.26.1


Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D64120809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581721;
	bh=LyC5reHuKcgTb4gEK4bP1Zn7mJplEn+GKnZZgfiDpzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+KT89sFueFfxR1d4J5pIkw9+nkTVHzVxTFJFIC4r3cJDTPp2wvafm4zMpaFUFN9f
	 fdUlNhwRRa0q9mHZP3a/oEJuRj79jEIcAIHyovZEpTCyIlBMZzKMsACjM0dqXVdEt0
	 yYY0Qncp0eRB68zQoUydQL3EhlfK7t3lVKkubemc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393566AbgFSPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393423AbgFSPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:25:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5741B21556;
        Fri, 19 Jun 2020 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580327;
        bh=LyC5reHuKcgTb4gEK4bP1Zn7mJplEn+GKnZZgfiDpzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DL0vHHu4UQDhmN/rUbtpOhB1Er+3gCmaP9+/UV3+YrxBzc6JF7zagr9X0VKX+VxfC
         VxhsPSbFo0PVIuSfV8qZTH0K/xpCKWOoNgFJKiNEOmNNkQiIUrJCYyt0s6aUZDnrtF
         L1PnWtuXLwWEFXKenGWUvpwxUuzupVuwU9bzqrvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 180/376] mt76: mt7622: fix DMA unmap length
Date:   Fri, 19 Jun 2020 16:31:38 +0200
Message-Id: <20200619141718.877691046@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit c0f8055b3986f9c9f990268b578173259769ba1c ]

Fix DMA unmap length estimation in mt7615_txp_skb_unmap_hw for mt7622
chipset

Fixes: 6aa4ed7927f1 ("mt76: mt7615: implement DMA support for MT7622")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 656231786d55..b5249d08564c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -675,7 +675,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 
 		len = le16_to_cpu(ptr->len0);
 		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		len &= MT_TXD_LEN_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
 				 DMA_TO_DEVICE);
 		if (last)
@@ -683,7 +683,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 
 		len = le16_to_cpu(ptr->len1);
 		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		len &= MT_TXD_LEN_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
 				 DMA_TO_DEVICE);
 		if (last)
@@ -1107,8 +1107,8 @@ mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
 
 	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
 		u32 addr = tx_info->buf[i + 1].addr;
-		u16 len = tx_info->buf[i + 1].len;
 
 		if (i == nbuf - 1)
 			len |= MT_TXD_LEN_MSDU_LAST |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index e0b89257db90..53ac184ab2d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -252,6 +252,7 @@ enum tx_phy_bandwidth {
 
 #define MT_MSDU_ID_VALID		BIT(15)
 
+#define MT_TXD_LEN_MASK			GENMASK(11, 0)
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
 
-- 
2.25.1




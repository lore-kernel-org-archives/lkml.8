Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69803C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2695222C9F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678630;
	bh=qGB1eCeXyQTCRvPGHcsCiktvK5rer3VZ0aHNYF40RSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/bzbAGg5Hpk8gTNUvCmxqMBGc0h6asj+BS/HsyCwZ1OPwJewIPsroqpoiMztkByO
	 GB3DTP6CaBR1yN4DA9bUshOorc/6Ryw9uwbNEWJCIOh4aGC1qSVMgyS9FuGYZbtWlC
	 KkHw2ACJKundgh5tAoLa7qvfJcA0p4clY8ss54/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgHQPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbgHQPa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E066823BCF;
        Mon, 17 Aug 2020 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678259;
        bh=qGB1eCeXyQTCRvPGHcsCiktvK5rer3VZ0aHNYF40RSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVKpGAUDCbVwW8xrzhY3KPQQQlEyacHAE3jzGqx6TrqvuYI+lU5OIsbYMCpnJYm3a
         KpMcOgQZBOd2Kyi3vzK1l6SoRjdko00MUzrN7XHx5AU8DhSlqtdxVzlMke5K80HTry
         Vazas99ohUS0UY9WwPESVwnTD4ZjhIoxLuSiwLrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 272/464] mt76: mt7615: fix possible memory leak in mt7615_mcu_wtbl_sta_add
Date:   Mon, 17 Aug 2020 17:13:45 +0200
Message-Id: <20200817143846.810934762@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 2bccc8415883c1cd5ae8836548d9783dbbd84999 ]

Free the second mcu skb if __mt76_mcu_skb_send_msg() fails to transmit
the first one in mt7615_mcu_wtbl_sta_add().

Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d8c52ffcf0ecb..cb8c1d80ead92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1209,8 +1209,12 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	skb = enable ? wskb : sskb;
 
 	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
-	if (err < 0)
+	if (err < 0) {
+		skb = enable ? sskb : wskb;
+		dev_kfree_skb(skb);
+
 		return err;
+	}
 
 	cmd = enable ? MCU_EXT_CMD_STA_REC_UPDATE : MCU_EXT_CMD_WTBL_UPDATE;
 	skb = enable ? sskb : wskb;
-- 
2.25.1




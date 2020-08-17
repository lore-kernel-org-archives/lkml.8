Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCED52065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692831;
	bh=FAX54MrF/KkdadZT9jjc5WO27LGpp87mXu+a2s/+4Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OZN+FdUtczEw0B87CUaBLRdZjU/JC/Jc6KFjk8CwRlPZaGBEVNMJ18GdpxvXgXPEw
	 hw2DbGpTUwxJ0VXJA9HR0Zw1OoqsS8tzSOodc9NYjbup+Mrf7VJ1gXZO5Bn3k50x7n
	 h63581MO1svv3VmLH+CCcNn8LE04++E4IM60Jvng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbgHQTdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgHQPap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B02207D3;
        Mon, 17 Aug 2020 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678245;
        bh=FAX54MrF/KkdadZT9jjc5WO27LGpp87mXu+a2s/+4Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlBlz2SnGJVrtVEvXqVidVBv7aCc5tqKFC3Iu5Gjq33aWwtlWPA+/VOZ+T9ms50k4
         bPYInArBBERLsL5gACXntyFu93zNTVy6ouA42Qq27ZbVZX5DZwYNElkng6F2Ze5gtG
         i6+XvclEHWyymCqmQ1MD9mrBweXg4ydfLWiZoKf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 268/464] mt76: mt7663u: fix potential memory leak in mcu message handler
Date:   Mon, 17 Aug 2020 17:13:41 +0200
Message-Id: <20200817143846.623741414@linuxfoundation.org>
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

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit c876039e95559350ee101d4b6f6084d9803f2995 ]

Fix potential memory leak in mcu message handler on error condition.

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index cd709fd617db2..3e66ff98cab81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -34,7 +34,6 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	ret = mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
 			     1000, ep);
-	dev_kfree_skb(skb);
 	if (ret < 0)
 		goto out;
 
@@ -43,6 +42,7 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 out:
 	mutex_unlock(&mdev->mcu.mutex);
+	dev_kfree_skb(skb);
 
 	return ret;
 }
-- 
2.25.1




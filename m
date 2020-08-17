Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631DB20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690987;
	bh=IpghtgvCCTydbyTfuyyTr0dkXbxMWkuxdwG8nKbPTPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tadHURqohfV4mQjw0u6BJoaXbOW0fIrjMNUoPtecM6psHNBOhpIVfsdOG1AKAkfSY
	 0cWCk42Dmg7oU/sCGDzUenLTkno+Ff+7McSeq95PLxfIH/5F/Sj4BPwfNAn7FdeNtk
	 loecMxwjhTdvG26HVhXXTQrTe4h9MXoToIbM7l1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgHQTDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbgHQPrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:47:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F0F2075B;
        Mon, 17 Aug 2020 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679218;
        bh=IpghtgvCCTydbyTfuyyTr0dkXbxMWkuxdwG8nKbPTPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MENfXfBPU+pQ6Y7tY41CkONQYNMc5OlLp91ruttFzlw0bKk0MDWNkKQNGVr7h82mC
         92F/4DzSTKTJOej0liErU5tBerYjIvmBVzjGP0cwz53X53/q8ofZElcYBDyuP9S0ff
         YGpSWrOWd2yEIQKzuS5GFOqS6zK8HoziGxpOHBOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 137/393] ath10k: Acquire tx_lock in tx error paths
Date:   Mon, 17 Aug 2020 17:13:07 +0200
Message-Id: <20200817143826.256735715@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit a738e766e3ed92c4ee5ec967777276b5ce11dd2c ]

ath10k_htt_tx_free_msdu_id() has a lockdep assertion that htt->tx_lock
is held. Acquire the lock in a couple of error paths when calling that
function to ensure this condition is met.

Fixes: 6421969f248fd ("ath10k: refactor tx pending management")
Fixes: e62ee5c381c59 ("ath10k: Add support for htt_data_tx_desc_64 descriptor")
Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200604105901.1.I5b8b0c7ee0d3e51a73248975a9da61401b8f3900@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 517ee2af2231d..e76b71e9326f5 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1550,7 +1550,9 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 err_unmap_msdu:
 	dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 err_free_msdu_id:
+	spin_lock_bh(&htt->tx_lock);
 	ath10k_htt_tx_free_msdu_id(htt, msdu_id);
+	spin_unlock_bh(&htt->tx_lock);
 err:
 	return res;
 }
@@ -1757,7 +1759,9 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 err_unmap_msdu:
 	dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 err_free_msdu_id:
+	spin_lock_bh(&htt->tx_lock);
 	ath10k_htt_tx_free_msdu_id(htt, msdu_id);
+	spin_unlock_bh(&htt->tx_lock);
 err:
 	return res;
 }
-- 
2.25.1




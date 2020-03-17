Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C8C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E5320658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443543;
	bh=+1f4QnqDdzNN9syh0v86emb7uMUaesvWQ5RPlv5BFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q6YQSs8j7rpQe/HmFeQp6xcVauZMxqZR4M2bCOTlstm5p5xgq+3EOyh2K+1SKPCqQ
	 l8RVRkCspcL784NwiDohQ93AMvlzGRdaVVHP3tEfSE62wvrpjBSZmsw5liZAhetvwh
	 duBAcwhPchWxzpLpm5yFOkcBHBvSjySm9luiLtOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgCQLMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgCQLMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:12:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4E3205ED;
        Tue, 17 Mar 2020 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443540;
        bh=+1f4QnqDdzNN9syh0v86emb7uMUaesvWQ5RPlv5BFfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4w2VMu8Rj2dltmJxKzr3J22lPABtIuPbr6lIjHbtz1oavj8PrvRcRSgyJz3hzkPD
         8B8zLVhlvoB7NYv0bKrWaGuJXl5mIYY99PNJm5Uc3GG9PhakHNdvzk1ijeT/jtBjWV
         SGQvVbaHX9JuyTqXUyOiCfiUwl+9snOz6oUlUGjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 116/151] mt76: fix array overflow on receiving too many fragments for a packet
Date:   Tue, 17 Mar 2020 11:55:26 +0100
Message-Id: <20200317103334.714877109@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit b102f0c522cf668c8382c56a4f771b37d011cda2 upstream.

If the hardware receives an oversized packet with too many rx fragments,
skb_shinfo(skb)->frags can overflow and corrupt memory of adjacent pages.
This becomes especially visible if it corrupts the freelist pointer of
a slab page.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/dma.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -447,10 +447,13 @@ mt76_add_fragment(struct mt76_dev *dev,
 	struct page *page = virt_to_head_page(data);
 	int offset = data - page_address(page);
 	struct sk_buff *skb = q->rx_head;
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-	offset += q->buf_offset;
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset, len,
-			q->buf_size);
+	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
+		offset += q->buf_offset;
+		skb_add_rx_frag(skb, shinfo->nr_frags, page, offset, len,
+				q->buf_size);
+	}
 
 	if (more)
 		return;



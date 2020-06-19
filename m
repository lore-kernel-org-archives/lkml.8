Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E759421527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584521;
	bh=Hf2alprBNfiUHQqF8h/J6O23B9wGzLZKgGZYPXTiCo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UtEqIz0Cf1M6LM9QpF24z3XvMTE+iVtkt5P2zDZY6aLh9nAykhBqr/I5Y/6+3y5BI
	 hOtX6e6YOno5MBrYYJjVJhUo/9i6MChowsNX3Z+XUJE233ml2rV74pky704M5GUOnS
	 OWha1UyruacAI19KvKuhzzCorAlBXQob98ln/QBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgFSQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389273AbgFSOuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:50:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F6D217BA;
        Fri, 19 Jun 2020 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578201;
        bh=Hf2alprBNfiUHQqF8h/J6O23B9wGzLZKgGZYPXTiCo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8dL5rM3FUQOzIgr6nLHz9x3WHEcyGkjp1hTsn4lbBtwG+uxyP41ocrLwKQD0iUnS
         qzIvU29RSPlrTI9xczitHzUiCyztil45g45TznPExPRr0awgPP7vWY2qthuR9J1o87
         4Kak1SRiJDJT57herC+Mt3wQ4LOnsCZ585L2YTmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 121/190] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
Date:   Fri, 19 Jun 2020 16:32:46 +0200
Message-Id: <20200619141639.675062486@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit beb12813bc75d4a23de43b85ad1c7cb28d27631e ]

Seven years ago we tried to fix a leak but actually introduced a double
free instead.  It was an understandable mistake because the code was a
bit confusing and the free was done in the wrong place.  The "skb"
pointer is freed in both _rtl_usb_tx_urb_setup() and _rtl_usb_transmit().
The free belongs _rtl_usb_transmit() instead of _rtl_usb_tx_urb_setup()
and I've cleaned the code up a bit to hopefully make it more clear.

Fixes: 36ef0b473fbf ("rtlwifi: usb: add missing freeing of skbuff")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200513093951.GD347693@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 93eda23f0123..7a050a75bdcb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -910,10 +910,8 @@ static struct urb *_rtl_usb_tx_urb_setup(struct ieee80211_hw *hw,
 
 	WARN_ON(NULL == skb);
 	_urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!_urb) {
-		kfree_skb(skb);
+	if (!_urb)
 		return NULL;
-	}
 	_rtl_install_trx_info(rtlusb, skb, ep_num);
 	usb_fill_bulk_urb(_urb, rtlusb->udev, usb_sndbulkpipe(rtlusb->udev,
 			  ep_num), skb->data, skb->len, _rtl_tx_complete, skb);
@@ -927,7 +925,6 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, struct sk_buff *skb,
 	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
 	u32 ep_num;
 	struct urb *_urb = NULL;
-	struct sk_buff *_skb = NULL;
 
 	WARN_ON(NULL == rtlusb->usb_tx_aggregate_hdl);
 	if (unlikely(IS_USB_STOP(rtlusb))) {
@@ -936,8 +933,7 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, struct sk_buff *skb,
 		return;
 	}
 	ep_num = rtlusb->ep_map.ep_mapping[qnum];
-	_skb = skb;
-	_urb = _rtl_usb_tx_urb_setup(hw, _skb, ep_num);
+	_urb = _rtl_usb_tx_urb_setup(hw, skb, ep_num);
 	if (unlikely(!_urb)) {
 		pr_err("Can't allocate urb. Drop skb!\n");
 		kfree_skb(skb);
-- 
2.25.1




Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BEEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967F20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E64Y9ONs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgEQUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:40:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD76C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:40:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b7so8168499qkk.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bF8z93o47HlcJUHuxu+yzZBCELvhT+1hX5AP8cWzK7I=;
        b=E64Y9ONsVfkw//ihBt0DC9gxvYSa+BKgHcOUpyjkoPceQDRfsZkmqiZByuH8YYS2TY
         jyIyYzQdyDLQotkkm/fvH4TqOAkrabjm3I3DZNapKGQWkx/Z4I0cPtGqzFlLi3elqLdN
         3MxxYM6R0WXo7F4FRGCjyQZBHrJ1iCoynT/eR5BiGEyPPAkHrCUFlqBBexv4YSlxc47E
         O5iPTkgbnsna/k0PvnrSGH1jweGHtcwEsZxRpVOvGPM/gLxAxKswS0YwcVfIv+j7V6lj
         40IgIa+u7R9UasxmkcsJds+h10hPDApFDMLf3BBm/TGY/8angiQNHPh81tRPCR+je5io
         3VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bF8z93o47HlcJUHuxu+yzZBCELvhT+1hX5AP8cWzK7I=;
        b=Bw3NE4ekUFzBRfHNedWh6HNAdY4jToZcROY2a4pk490OroNw7Hy67hE8IUIpP7v4oO
         Ev8EGyaHo+SzYXI3xygOX6U1eh13/7mKml9NnVF5j9HAHfQyartHsuclz0642YurTTIh
         Vm5oMWqWTkjNdP6bRE7OswbLzKkFCa+eXQzdYQry+l/N1qR/oeib32ZYdatT1RLsgLDT
         r2Tnk5K6ZtdKlFON0Uzm7KN3SpUVBovcpkvUMzZeYytWDtMeVxXcuby3F9+tNy/B/4c5
         /Defs67XTwEJY2fjxa0pO5xI5xecR/RV3KNYBINe2EUEWe8lK4LB8ohjNguL2pQ/HPB5
         Ui4w==
X-Gm-Message-State: AOAM532RYxXS1maKeR1UTpNVhajXWUB43Wux63EeuJxcmQev6mmAzCiZ
        uiY9Fr3Fvj2iXEZsSrKP8WDpVmn6ZeqV
X-Google-Smtp-Source: ABdhPJxlVJJySVMnIedJ10ma6f1gnAgrsaqX8sLvSYKLVhCS3BSZwwQgI/KGbhgTYPV1NwOAcBxXXA1tth1u
X-Received: by 2002:a0c:b5c4:: with SMTP id o4mr12587567qvf.229.1589748055115;
 Sun, 17 May 2020 13:40:55 -0700 (PDT)
Date:   Sun, 17 May 2020 21:40:45 +0100
In-Reply-To: <202005180407.tRbGahKX%lkp@intel.com>
Message-Id: <20200517204045.183223-1-pterjan@google.com>
Mime-Version: 1.0
References: <202005180407.tRbGahKX%lkp@intel.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2] staging: rtl8192u: Merge almost duplicate code
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This causes a change in behaviour:
- stats also get updated when reordering, this seems like it should be
  the case but those lines were commented out.
- sub_skb NULL check now happens early in both cases, previously it
  happened only after dereferencing it 12 times, so it may not actually
  be needed.

Signed-off-by: Pascal Terjan <pterjan@google.com>

---

v2: Made the new function static

 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 127 +++++++-----------
 1 file changed, 50 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index e101f7b13c7e..60dbb584b22c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -520,55 +520,68 @@ static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_entry *p
 	return true;
 }
 
-void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb **prxbIndicateArray, u8  index)
+static void indicate_packets(struct ieee80211_device *ieee,
+			     struct ieee80211_rxb *rxb)
 {
-	u8 i = 0, j = 0;
+	struct net_device_stats *stats = &ieee->stats;
+	struct net_device *dev = ieee->dev;
 	u16 ethertype;
-//	if(index > 1)
-//		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): hahahahhhh, We indicate packet from reorder list, index is %u\n",__func__,index);
-	for (j = 0; j < index; j++) {
-//added by amy for reorder
-		struct ieee80211_rxb *prxb = prxbIndicateArray[j];
-		for (i = 0; i < prxb->nr_subframes; i++) {
-			struct sk_buff *sub_skb = prxb->subframes[i];
+	u8 i;
+
+	for (i = 0; i < rxb->nr_subframes; i++) {
+		struct sk_buff *sub_skb = rxb->subframes[i];
+
+		if (!sub_skb)
+			continue;
 
 		/* convert hdr + possible LLC headers into Ethernet header */
-			ethertype = (sub_skb->data[6] << 8) | sub_skb->data[7];
-			if (sub_skb->len >= 8 &&
-				((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) == 0 &&
-				  ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
-				 memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) == 0)) {
+		ethertype = (sub_skb->data[6] << 8) | sub_skb->data[7];
+		if (sub_skb->len >= 8 &&
+		    ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
+			ethertype != ETH_P_AARP &&
+			ethertype != ETH_P_IPX) ||
+		     !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
 			/* remove RFC1042 or Bridge-Tunnel encapsulation and
 			 * replace EtherType */
-				skb_pull(sub_skb, SNAP_SIZE);
-				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->src, ETH_ALEN);
-				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->dst, ETH_ALEN);
-			} else {
+			skb_pull(sub_skb, SNAP_SIZE);
+		} else {
 			/* Leave Ethernet header part of hdr and full payload */
-				put_unaligned_be16(sub_skb->len, skb_push(sub_skb, 2));
-				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->src, ETH_ALEN);
-				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->dst, ETH_ALEN);
-			}
-			//stats->rx_packets++;
-			//stats->rx_bytes += sub_skb->len;
+			put_unaligned_be16(sub_skb->len, skb_push(sub_skb, 2));
+		}
+		memcpy(skb_push(sub_skb, ETH_ALEN), rxb->src, ETH_ALEN);
+		memcpy(skb_push(sub_skb, ETH_ALEN), rxb->dst, ETH_ALEN);
+
+		stats->rx_packets++;
+		stats->rx_bytes += sub_skb->len;
+		if (is_multicast_ether_addr(rxb->dst))
+			stats->multicast++;
 
 		/* Indicate the packets to upper layer */
-			if (sub_skb) {
-				sub_skb->protocol = eth_type_trans(sub_skb, ieee->dev);
-				memset(sub_skb->cb, 0, sizeof(sub_skb->cb));
-				sub_skb->dev = ieee->dev;
-				sub_skb->ip_summed = CHECKSUM_NONE; /* 802.11 crc not sufficient */
-				//skb->ip_summed = CHECKSUM_UNNECESSARY; /* 802.11 crc not sufficient */
-				ieee->last_rx_ps_time = jiffies;
-				netif_rx(sub_skb);
-			}
-		}
+		sub_skb->protocol = eth_type_trans(sub_skb, dev);
+		memset(sub_skb->cb, 0, sizeof(sub_skb->cb));
+		sub_skb->dev = dev;
+		/* 802.11 crc not sufficient */
+		sub_skb->ip_summed = CHECKSUM_NONE;
+		ieee->last_rx_ps_time = jiffies;
+		netif_rx(sub_skb);
+	}
+}
+
+void ieee80211_indicate_packets(struct ieee80211_device *ieee,
+				struct ieee80211_rxb **prxbIndicateArray,
+				u8 index)
+{
+	u8 i;
+
+	for (i = 0; i < index; i++) {
+		struct ieee80211_rxb *prxb = prxbIndicateArray[i];
+
+		indicate_packets(ieee, prxb);
 		kfree(prxb);
 		prxb = NULL;
 	}
 }
 
-
 static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 				    struct ieee80211_rxb *prxb,
 				    struct rx_ts_record *pTS, u16 SeqNum)
@@ -721,6 +734,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 
 	/* Handling pending timer. Set this timer to prevent from long time Rx buffering.*/
 	if (index > 0) {
+		u8 i;
 		// Cancel previous pending timer.
 	//	del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq = 0xffff;
@@ -877,7 +891,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	u16 fc, type, stype, sc;
 	struct net_device_stats *stats;
 	unsigned int frag;
-	u16 ethertype;
 	//added by amy for reorder
 	u8	TID = 0;
 	u16	SeqNum = 0;
@@ -1260,47 +1273,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 //added by amy for reorder
 	if (!ieee->pHTInfo->bCurRxReorderEnable || !pTS) {
-//added by amy for reorder
-		for (i = 0; i < rxb->nr_subframes; i++) {
-			struct sk_buff *sub_skb = rxb->subframes[i];
-
-			if (sub_skb) {
-				/* convert hdr + possible LLC headers into Ethernet header */
-				ethertype = (sub_skb->data[6] << 8) | sub_skb->data[7];
-				if (sub_skb->len >= 8 &&
-						((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) == 0 &&
-						  ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
-						 memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) == 0)) {
-					/* remove RFC1042 or Bridge-Tunnel encapsulation and
-					 * replace EtherType */
-					skb_pull(sub_skb, SNAP_SIZE);
-					memcpy(skb_push(sub_skb, ETH_ALEN), src, ETH_ALEN);
-					memcpy(skb_push(sub_skb, ETH_ALEN), dst, ETH_ALEN);
-				} else {
-					u16 len;
-					/* Leave Ethernet header part of hdr and full payload */
-					len = be16_to_cpu(htons(sub_skb->len));
-					memcpy(skb_push(sub_skb, 2), &len, 2);
-					memcpy(skb_push(sub_skb, ETH_ALEN), src, ETH_ALEN);
-					memcpy(skb_push(sub_skb, ETH_ALEN), dst, ETH_ALEN);
-				}
-
-				stats->rx_packets++;
-				stats->rx_bytes += sub_skb->len;
-				if (is_multicast_ether_addr(dst)) {
-					stats->multicast++;
-				}
-
-				/* Indicate the packets to upper layer */
-				sub_skb->protocol = eth_type_trans(sub_skb, dev);
-				memset(sub_skb->cb, 0, sizeof(sub_skb->cb));
-				sub_skb->dev = dev;
-				sub_skb->ip_summed = CHECKSUM_NONE; /* 802.11 crc not sufficient */
-				//skb->ip_summed = CHECKSUM_UNNECESSARY; /* 802.11 crc not sufficient */
-				ieee->last_rx_ps_time = jiffies;
-				netif_rx(sub_skb);
-			}
-		}
+		indicate_packets(ieee, rxb);
 		kfree(rxb);
 		rxb = NULL;
 
-- 
2.26.2.761.g0e0b3e54be-goog


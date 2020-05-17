Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060420674
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2WNejfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEQQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEQQ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:58:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F2BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 09:58:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e139so5966992ybc.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dkKURodgy3jG25cttpEp0uozoRnJeq6PMT5tfOrDLMc=;
        b=c2WNejfzhlGZ3P7COgoKcgaGQmYN9GbCo3TZGtgDsctU+GOOILokXIIcEQEUP++4ni
         Akdz8ZwieN/0Sqo73N74yBxrnC3FvNyNH+P6Rp/39iCcqRUHDpF35dpFm3oN4xbudPy3
         am3Cx9OuOnyFj/wELyamEieULTj+eWQ8Df5/MIfj2NddB51OckvZtfyhppjiG85Xi7/X
         /x5w1CNwaLXWVmVVTUhtnfXMzR8ksP3Si5hijShMK9ynQaCB7cJzrvmj9g58/AV0rgYG
         8VKeBaqEtVoeFZj7WvQKX7s363Xk9xQqQooX+hyeJ5NXd+Bre/qxPrkyjKmmzNMs9nb+
         E6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dkKURodgy3jG25cttpEp0uozoRnJeq6PMT5tfOrDLMc=;
        b=BDEHGH4vSbjjhSK6Mj/15cqdBzjHS724KBQOLu7FLLEjt2EyFOHUn5QLy5FbTuiDnv
         VK8Y0t+IzEUb6vg5bhtXJc4FZMHf41Rp2ZZ4sV7aMBi6Q4WKXAgNZETgneoXqOlzxlHV
         ZoQqSLQ3HmfmFlAOgJcfwunRJuYel/VRi0Jc87+IrolNKkrS4syuJmq/StRWVk3uXmaw
         GDBsb8YdHtJWrgR5Butfr3xHcE2mQo58DvUhoB5buUqHE22Vr4NXHROxpiMyOO6nwoog
         FJLmX9rubMufiDT47UcAgb5pvf37EVKK7gAq7EN4EPz5N3EoG5L6+fFguXxJhEDjAzn/
         NvdQ==
X-Gm-Message-State: AOAM532tWkGs0pKq6UWjffYgsilnwZR9bAJRpf0A9Tv8mIFKy5VMZb0s
        nZ+VA9Pn1LzlHaCJcwhR/8vuB+73iE5q
X-Google-Smtp-Source: ABdhPJxDTquhIBmuESw8P1Fcsz3tWHgDQGUMMjXDzdziCYf6XSrBlqY2/KV3gLMesKKUSWGyK0NYJFyEEnR1
X-Received: by 2002:a25:7607:: with SMTP id r7mr20541261ybc.493.1589734704157;
 Sun, 17 May 2020 09:58:24 -0700 (PDT)
Date:   Sun, 17 May 2020 17:58:19 +0100
Message-Id: <20200517165819.136715-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] staging: rtl8192u: Merge almost duplicate code
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
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 126 +++++++-----------
 1 file changed, 49 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index e101f7b13c7e..3309f64be4c9 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -520,55 +520,67 @@ static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_entry *p
 	return true;
 }
 
-void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb **prxbIndicateArray, u8  index)
+void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
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
@@ -721,6 +733,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 
 	/* Handling pending timer. Set this timer to prevent from long time Rx buffering.*/
 	if (index > 0) {
+		u8 i;
 		// Cancel previous pending timer.
 	//	del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq = 0xffff;
@@ -877,7 +890,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	u16 fc, type, stype, sc;
 	struct net_device_stats *stats;
 	unsigned int frag;
-	u16 ethertype;
 	//added by amy for reorder
 	u8	TID = 0;
 	u16	SeqNum = 0;
@@ -1260,47 +1272,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 
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


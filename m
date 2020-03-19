Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87A21556
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623929;
	bh=/tnjJMgvLSGDranwiq8LtGIlbks4hqw1BrVjb+hbWMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POU5d20uFRsZspBsss1tIqUxQ1jKomYayzRF2vFky66zQGqz8uH4frml2C20/rkSe
	 +ybEPuBDh+IBIJbfk/lVUf1iWuHCYUlefhyOKDKqKgEcYKyJlWHOWL+vPqP6EkfXWO
	 r5BU5307+nr8wupXPq0miW+GXwjQyDTe1G1ukyGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCSNSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgCSNSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:18:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3ED8206D7;
        Thu, 19 Mar 2020 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623924;
        bh=/tnjJMgvLSGDranwiq8LtGIlbks4hqw1BrVjb+hbWMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRrEqI/KLvHuqxzfMyViKrQcHtT6zMbbChLhQCJYTxYqT0GqRhVwFxPbZDrypcxf5
         F+eQA52esb+GXpJUgbh0cZM+QsOXZs23ayTxDbWBtDftcmjVm3DCsTB6D/6MWUMtkC
         aU3r266xpPqRJnxDA49Rncyl/NXAFhDrtJ5N73EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.14 72/99] batman-adv: update data pointers after skb_cow()
Date:   Thu, 19 Mar 2020 14:03:50 +0100
Message-Id: <20200319124003.112213376@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <mschiffer@universe-factory.net>

commit bc44b78157f621ff2a2618fe287a827bcb094ac4 upstream.

batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
must be (re)set after calling it. The ethhdr variable is dropped
altogether.

Fixes: 7cdcf6dddc42 ("batman-adv: add UNICAST_4ADDR packet type")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/routing.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -950,14 +950,10 @@ int batadv_recv_unicast_packet(struct sk
 	struct batadv_orig_node *orig_node = NULL, *orig_node_gw = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
-	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
 	bool is4addr, is_gw;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
-	ethhdr = eth_hdr(skb);
-
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
 	if (is4addr)
@@ -977,12 +973,14 @@ int batadv_recv_unicast_packet(struct sk
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		goto free_skb;
 
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		/* If this is a unicast packet from another backgone gw,
 		 * drop it.
 		 */
-		orig_addr_gw = ethhdr->h_source;
+		orig_addr_gw = eth_hdr(skb)->h_source;
 		orig_node_gw = batadv_orig_hash_find(bat_priv, orig_addr_gw);
 		if (orig_node_gw) {
 			is_gw = batadv_bla_is_backbone_gw(skb, orig_node_gw,
@@ -997,6 +995,8 @@ int batadv_recv_unicast_packet(struct sk
 		}
 
 		if (is4addr) {
+			unicast_4addr_packet =
+				(struct batadv_unicast_4addr_packet *)skb->data;
 			subtype = unicast_4addr_packet->subtype;
 			batadv_dat_inc_counter(bat_priv, subtype);
 



Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B97C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C720772
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623233;
	bh=OAoPDyufF1nyTx0uJ1tbde3Pf+2/PBrKfHeyCb5SJZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZqjiXrToU+CiUbuH/D5YaRDuhszVDDFj+tMOn7Yi32CpM/GndC6AGo/GpUqt+eP6C
	 UlLi+anmeR2RSgxwUXKZuh+lBquLFJxOPBLS5jpI4GBBOl8XUDW4fvfnPfjGP9sjrS
	 DkfSB7acN8G25nk/U4one0U6s774wAtwfBwDJjus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgCSNHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgCSNHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:07:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9771020787;
        Thu, 19 Mar 2020 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623222;
        bh=OAoPDyufF1nyTx0uJ1tbde3Pf+2/PBrKfHeyCb5SJZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC0OJhdKytZEEk1OTmxjWzXeCgPqoYV3O9SqRY0IPbePM7PV6XZ8RbLZfhqjAAJVO
         LzSsCZSmreTT2IsQ34CqmLi3Y0hVAPiIoui/PaUjqnFZbK0G4e/rTHp7CaQ6bRrtt/
         fmF2DxAg70tP2I/IzxR7jy49Pl+YOhuOYV4jsyRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Westphal <fw@strlen.de>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Antonio Quartulli <a@unstable.cc>
Subject: [PATCH 4.4 49/93] batman-adv: fix skb deref after free
Date:   Thu, 19 Mar 2020 13:59:53 +0100
Message-Id: <20200319123940.571581873@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 63d443efe8be2c1d02b30d7e4edeb9aa085352b3 upstream.

batadv_send_skb_to_orig() calls dev_queue_xmit() so we can't use skb->len.

Fixes: 953324776d6d ("batman-adv: network coding - buffer unicast packets before forward")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/routing.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -585,6 +585,7 @@ static int batadv_route_unicast_packet(s
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
 	int res, hdr_len, ret = NET_RX_DROP;
+	unsigned int len;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
@@ -625,6 +626,7 @@ static int batadv_route_unicast_packet(s
 	if (hdr_len > 0)
 		batadv_skb_set_priority(skb, hdr_len);
 
+	len = skb->len;
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
 
 	/* translate transmit result into receive result */
@@ -632,7 +634,7 @@ static int batadv_route_unicast_packet(s
 		/* skb was transmitted and consumed */
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
-				   skb->len + ETH_HLEN);
+				   len + ETH_HLEN);
 
 		ret = NET_RX_SUCCESS;
 	} else if (res == NET_XMIT_POLICED) {



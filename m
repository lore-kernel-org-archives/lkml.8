Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3021DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CB920878
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034748;
	bh=cYxn46v7Fp+VUDknXWc2HELPE8i0Sn7JqZLgXwySOm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yxzst0dwpIKaZwTrq09wSaAYjbe+rWi9BJh9cEK91TOjQ9rrYLAuMnZBxiDxxEcua
	 B7mg+Gc+dWyrKcLvHEB0cwU2kKD1WoCg4eG1gk0Pg8YQ9BDYsI9xBCQ//c816KMVPV
	 ihjmz0uzWgaQ5KZh/HfVbd49pHWtStPcZkAZKTk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgFASFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbgFASF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DF62074B;
        Mon,  1 Jun 2020 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034727;
        bh=cYxn46v7Fp+VUDknXWc2HELPE8i0Sn7JqZLgXwySOm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0oYUNqP7s7rzZXHVjq92t/8Fp4YLpbtlQBomCfAQerTDASFTfBJ387lfT9R9Qfr1
         zN2Z40hkDb9NylUayH5gA8c6++6WE4lY0N8ARbV0lWzthWMNB/OSBZPZyXDFE0QLBt
         /42cJ2E6MFDGZTOibl+jFKyYbE0WiDS89ItnZIXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Braun <michael-dev@fami-braun.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 83/95] netfilter: nft_reject_bridge: enable reject with bridge vlan
Date:   Mon,  1 Jun 2020 19:54:23 +0200
Message-Id: <20200601174033.163558907@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Braun <michael-dev@fami-braun.de>

commit e9c284ec4b41c827f4369973d2792992849e4fa5 upstream.

Currently, using the bridge reject target with tagged packets
results in untagged packets being sent back.

Fix this by mirroring the vlan id as well.

Fixes: 85f5b3086a04 ("netfilter: bridge: add reject support")
Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/nft_reject_bridge.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -34,6 +34,12 @@ static void nft_reject_br_push_etherhdr(
 	ether_addr_copy(eth->h_dest, eth_hdr(oldskb)->h_source);
 	eth->h_proto = eth_hdr(oldskb)->h_proto;
 	skb_pull(nskb, ETH_HLEN);
+
+	if (skb_vlan_tag_present(oldskb)) {
+		u16 vid = skb_vlan_tag_get(oldskb);
+
+		__vlan_hwaccel_put_tag(nskb, oldskb->vlan_proto, vid);
+	}
 }
 
 static int nft_bridge_iphdr_validate(struct sk_buff *skb)



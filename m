Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9542073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035431;
	bh=Syz0oJeLENcBeZiJymoRK63ZsyGJDQbC94aTQ556b6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zc3wUx9/8FaAOJBX1yw5RTGUu/8SAXYxRbPdEwSjCFUqV/uEMvN4pcIH3vgyE7E82
	 uFMKcOJxmi3u1dOBnELV4RNZx5S+a5NLOdGPgQQrZ2Aj0ony01lwDr4hYnFccj4RV5
	 peqmNbsmawhX0h3mhYkqu7l41TMFf37HbhgpLHR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbgFASRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731785AbgFASRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2EC206E2;
        Mon,  1 Jun 2020 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035426;
        bh=Syz0oJeLENcBeZiJymoRK63ZsyGJDQbC94aTQ556b6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnlGPRaT4XZWzANDZYhxMplKeY6Jthz3XTPpewIt5npE82O/FmmgI9aNc2Ai3VsfO
         8lByhIL5iYdIS1UNHIe+vagim8dxFzK0zq4hGLWblJqvJyOG72oxiooxwZtl/xAm+W
         pdsgxm9PvBlmqZdjJYdxxJ1jj9KcUM6DbLbt3qd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Braun <michael-dev@fami-braun.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.6 154/177] netfilter: nft_reject_bridge: enable reject with bridge vlan
Date:   Mon,  1 Jun 2020 19:54:52 +0200
Message-Id: <20200601174101.212699341@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
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
@@ -31,6 +31,12 @@ static void nft_reject_br_push_etherhdr(
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



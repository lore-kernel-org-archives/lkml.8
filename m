Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A75C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0403124688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699502;
	bh=+nEocEXu79xcANSH/l4JyDJI85CzV1CQLsYWCtinu6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fsuoy0r0I7pvQ9nIdWiS7DKs/xY999z4dwKw195TjDXw8bojVewCT0mEMd/UnpxOc
	 Y3JwLUQ2aAqsy9ZAXxNIjlxtav54IOKAS7U5YSNd5MK8uFHcmjw0joXa3AdVoPyfCb
	 telatPG8Ht+HImd9Sp8KyzuJA91Ztz7nevWaBLy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgAVNZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbgAVNY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:24:57 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A8C24688;
        Wed, 22 Jan 2020 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699496;
        bh=+nEocEXu79xcANSH/l4JyDJI85CzV1CQLsYWCtinu6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw1Ev+we5tsOI+Ovfs5jz8FHN0hvHDBfSd+DLFPGHihtOUQ4F4iOUhCpKDqfu/3CB
         0uYWYcG6xRI5XyBsSIdvKCTCooFlqE4sJgAQHY3ZOIXJzbNcDiqfccn+tpvt/9gfB3
         KJbnLB+DBCVhI6quhpANPpbnR5Ik3a0SPd0vzrp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 164/222] net: stmmac: selftests: Make it work in Synopsys AXS101 boards
Date:   Wed, 22 Jan 2020 10:29:10 +0100
Message-Id: <20200122092845.456111419@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 0b9f932edc1a461933bfde08e620362e2190e0dd upstream.

Synopsys AXS101 boards do not support unaligned memory loads or stores.
Change the selftests mechanism to explicity:
- Not add extra alignment in TX SKB
- Use the unaligned version of ether_addr_equal()

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c |   20 +++++++++--------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -80,7 +80,7 @@ static struct sk_buff *stmmac_test_get_u
 	if (attr->max_size && (attr->max_size > size))
 		size = attr->max_size;
 
-	skb = netdev_alloc_skb_ip_align(priv->dev, size);
+	skb = netdev_alloc_skb(priv->dev, size);
 	if (!skb)
 		return NULL;
 
@@ -244,6 +244,8 @@ static int stmmac_test_loopback_validate
 					 struct net_device *orig_ndev)
 {
 	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+	unsigned char *src = tpriv->packet->src;
+	unsigned char *dst = tpriv->packet->dst;
 	struct stmmachdr *shdr;
 	struct ethhdr *ehdr;
 	struct udphdr *uhdr;
@@ -260,15 +262,15 @@ static int stmmac_test_loopback_validate
 		goto out;
 
 	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (tpriv->packet->dst) {
-		if (!ether_addr_equal(ehdr->h_dest, tpriv->packet->dst))
+	if (dst) {
+		if (!ether_addr_equal_unaligned(ehdr->h_dest, dst))
 			goto out;
 	}
 	if (tpriv->packet->sarc) {
-		if (!ether_addr_equal(ehdr->h_source, ehdr->h_dest))
+		if (!ether_addr_equal_unaligned(ehdr->h_source, ehdr->h_dest))
 			goto out;
-	} else if (tpriv->packet->src) {
-		if (!ether_addr_equal(ehdr->h_source, tpriv->packet->src))
+	} else if (src) {
+		if (!ether_addr_equal_unaligned(ehdr->h_source, src))
 			goto out;
 	}
 
@@ -714,7 +716,7 @@ static int stmmac_test_flowctrl_validate
 	struct ethhdr *ehdr;
 
 	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal(ehdr->h_source, orig_ndev->dev_addr))
+	if (!ether_addr_equal_unaligned(ehdr->h_source, orig_ndev->dev_addr))
 		goto out;
 	if (ehdr->h_proto != htons(ETH_P_PAUSE))
 		goto out;
@@ -856,7 +858,7 @@ static int stmmac_test_vlan_validate(str
 	}
 
 	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal(ehdr->h_dest, tpriv->packet->dst))
+	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
 		goto out;
 
 	ihdr = ip_hdr(skb);
@@ -1546,7 +1548,7 @@ static int stmmac_test_arp_validate(stru
 	struct arphdr *ahdr;
 
 	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal(ehdr->h_dest, tpriv->packet->src))
+	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->src))
 		goto out;
 
 	ahdr = arp_hdr(skb);



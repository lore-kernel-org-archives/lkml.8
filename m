Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6CC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465BB218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943700;
	bh=MwUPChA0e/U10VThUgPNOxKC2VYVYN9NvONqW6P7n1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vj4hw5p8LT8CZqGJFp3HEngWkeM9T2IjwlOUTtbtJQA4yGc83dZ+sE7Min13y6p8w
	 4LrSeudhOPokRFC+JkGBpRlGbskzOwhC/dBJUPEWrUNC9BX2uCJFE61zrkb8yyQx+3
	 tBXg/q4nFLSrTI7Z9ndLtf/x4mZ+MJCLSff/fPL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgEHNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEHMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571582145D;
        Fri,  8 May 2020 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941983;
        bh=MwUPChA0e/U10VThUgPNOxKC2VYVYN9NvONqW6P7n1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrzZFe3xRxKJkVpmc52cGiNOwIojlmXNn2s6VjqImTP0nH3AWR5t4ZCmrzFCPrPft
         fdWbaQCwnXz/Hu7ZjB6FK0V6XFHbDCmNJs8A71c6H5pGYRZEZDeLcLjjVrqhKRoDFK
         m2Oi9ukhWhN8pD5NqPH01GN/00GG9bjnKz+k4uCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hariprasad Shenai <hariprasad@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 250/312] cxgb4/cxgb4vf: Fixes regression in perf when tx vlan offload is disabled
Date:   Fri,  8 May 2020 14:34:01 +0200
Message-Id: <20200508123141.998643113@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Shenai <hariprasad@chelsio.com>

commit 8d09e6b8b9c9969ac59496dc21e10b67fe727e7e upstream.

The commit 637d3e997351 ("cxgb4: Discard the packet if the length is
greater than mtu") introduced a regression in the VLAN interface
performance when Tx VLAN offload is disabled.

Check if skb is tagged, regardless of whether it is hardware accelerated
or not. Presently we were checking only for hardware acclereated one,
which caused performance to drop to ~0.17Mbps on a 10GbE adapter for
VLAN interface, when tx vlan offload is turned off using ethtool.
The ethernet head length calculation was going wrong in this case, and
driver ended up dropping packets.

Fixes: 637d3e997351 ("cxgb4: Discard the packet if the length is greater than mtu")
Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/chelsio/cxgb4/sge.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1165,7 +1165,7 @@ out_free:	dev_kfree_skb_any(skb);
 
 	/* Discard the packet if the length is greater than mtu */
 	max_pkt_len = ETH_HLEN + dev->mtu;
-	if (skb_vlan_tag_present(skb))
+	if (skb_vlan_tagged(skb))
 		max_pkt_len += VLAN_HLEN;
 	if (!skb_shinfo(skb)->gso_size && (unlikely(skb->len > max_pkt_len)))
 		goto out_free;
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -1188,7 +1188,7 @@ int t4vf_eth_xmit(struct sk_buff *skb, s
 
 	/* Discard the packet if the length is greater than mtu */
 	max_pkt_len = ETH_HLEN + dev->mtu;
-	if (skb_vlan_tag_present(skb))
+	if (skb_vlan_tagged(skb))
 		max_pkt_len += VLAN_HLEN;
 	if (!skb_shinfo(skb)->gso_size && (unlikely(skb->len > max_pkt_len)))
 		goto out_free;



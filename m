Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36410C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021BE21556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860473;
	bh=ZZ2ok39DClazOG1Vvv+v9Dl7WVqcbmWAVxwNdxK7bw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FgdYegKPbFdzSPYveX7fx9WB+8LYZ0tw0ud8iRZkrXlTJ9141ay7jiKNDOp/oC/Lz
	 A2SEVKek+TNiGYtVZFm0SlHdMfVI5mv38e9VL1x2qaznoo5PwmT4TPd4eXVAqxbYPm
	 jK2Op4wi4hPvuR1F+nK7LT58IWGavg3AI3nM9vDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgAXKHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389036AbgAXKHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:07:48 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334A22087E;
        Fri, 24 Jan 2020 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860467;
        bh=ZZ2ok39DClazOG1Vvv+v9Dl7WVqcbmWAVxwNdxK7bw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcLiIxLzOyYNSekaTDZ0NG80YLSBCFjCwQdaukjSsmYuFqzo5lB1rXNQsJwhpaN+5
         utkn8T33qbYWXVtxlZPiret6SKSq1KEWgnz6H0TIzXPalu/26h85dHb/m/IDjxsc1s
         LJyNxRGou/ntHdYw7N5FpDOUJoBGPGDI+I18241k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 332/343] hv_netvsc: flag software created hash value
Date:   Fri, 24 Jan 2020 10:32:30 +0100
Message-Id: <20200124093003.454681626@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <sthemmin@microsoft.com>

[ Upstream commit df9f540ca74297a84bafacfa197e9347b20beea5 ]

When the driver needs to create a hash value because it
was not done at higher level, then the hash should be marked
as a software not hardware hash.

Fixes: f72860afa2e3 ("hv_netvsc: Exclude non-TCP port numbers from vRSS hashing")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9e48855f64074..14451e14d99dc 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -282,9 +282,9 @@ static inline u32 netvsc_get_hash(
 		else if (flow.basic.n_proto == htons(ETH_P_IPV6))
 			hash = jhash2((u32 *)&flow.addrs.v6addrs, 8, hashrnd);
 		else
-			hash = 0;
+			return 0;
 
-		skb_set_hash(skb, hash, PKT_HASH_TYPE_L3);
+		__skb_set_sw_hash(skb, hash, false);
 	}
 
 	return hash;
@@ -802,8 +802,7 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 	    skb->protocol == htons(ETH_P_IP))
 		netvsc_comp_ipcsum(skb);
 
-	/* Do L4 checksum offload if enabled and present.
-	 */
+	/* Do L4 checksum offload if enabled and present. */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
 		if (csum_info->receive.tcp_checksum_succeeded ||
 		    csum_info->receive.udp_checksum_succeeded)
-- 
2.20.1




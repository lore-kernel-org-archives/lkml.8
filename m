Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335EC222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865739;
	bh=//fvSBPtYBMF1Igvz8lJoRgoyfEGurWut2PLs1x0Z64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jGPOBQ2aZfZ/IxuFEpCit3UFtsE/McpZAQcYIc0cPBeo5SchfIRODevEkLVV+gkgs
	 FusvtMAWeMCsOkorSvpTHWF6ZaVg98jjJleQjAymLkUZSl9oCM7v9+4odAD9lp6cfV
	 V/ArHZUuBENrAjFiWIwLU5354bYm+6D0zcvWv/t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404846AbgAXLfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388387AbgAXLff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:35:35 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1572075D;
        Fri, 24 Jan 2020 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865735;
        bh=//fvSBPtYBMF1Igvz8lJoRgoyfEGurWut2PLs1x0Z64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlH6bIP9TKKd6ybmyPWZmAJVSN/h5CVnu6eny6NZyVh90F/QRdkiObLtHoc8lh+kF
         Y0Z56SS7p+0VZiRlPihAlNo/CfcwsjB9WERMepKZvQxqfrsPkSK/6aHywR9+4hjyJT
         fiXG1AArMyKZzOQCDmuKbkipiFi423DZK2eNJ0K4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 623/639] hv_netvsc: flag software created hash value
Date:   Fri, 24 Jan 2020 10:33:13 +0100
Message-Id: <20200124093207.654124652@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index 54670c9905c79..7ab576d8b6227 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -295,9 +295,9 @@ static inline u32 netvsc_get_hash(
 		else if (flow.basic.n_proto == htons(ETH_P_IPV6))
 			hash = jhash2((u32 *)&flow.addrs.v6addrs, 8, hashrnd);
 		else
-			hash = 0;
+			return 0;
 
-		skb_set_hash(skb, hash, PKT_HASH_TYPE_L3);
+		__skb_set_sw_hash(skb, hash, false);
 	}
 
 	return hash;
@@ -804,8 +804,7 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
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




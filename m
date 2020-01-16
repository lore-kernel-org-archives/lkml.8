Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD32C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D9C2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202250;
	bh=tLL5fviRXm3vOMtOlR4+W3b4zIYYTZ6aRnxayKQc6YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vy7E12Cc0H8MjgPxj8gcP0LZ/UX95QSlVzwJ2eqBbqTpLWkA8XBFg8Qn2dVvyKyj2
	 ciGzSbDIIg8El8NRStySm28W1qVl3BztyAQdjid6nNE+0+3kAvMTAKdbUoUqPOFJyQ
	 UOA7J7+EQRVYwUQyHJI52r84KTQsrYRYunaBI5DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437671AbgAPTR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbgAPQzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27CF22525;
        Thu, 16 Jan 2020 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193718;
        bh=tLL5fviRXm3vOMtOlR4+W3b4zIYYTZ6aRnxayKQc6YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcE7/LchsWqt5Bxvn/v2+9sc+Uz7v+N1E4gkrkgttTWqnRM8hj7q0dAtOMzpfFN+C
         chFF52cqA/74pEohJtUxITetl2GYKNwY6aJnSCpW0Mvj1MBOhC0MBS2E2OXTQcrRJx
         /Ktd+BDYUaEiZJ2uVM7kR4OwYUyfSEXODocgxRDI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 013/671] bridge: br_arp_nd_proxy: set icmp6_router if neigh has NTF_ROUTER
Date:   Thu, 16 Jan 2020 11:44:04 -0500
Message-Id: <20200116165502.8838-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 7aca011f88eb57be1b17b0216247f4e32ac54e29 ]

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 2cf7716254be..d42e3904b498 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -311,7 +311,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	/* Neighbor Advertisement */
 	memset(na, 0, sizeof(*na) + na_olen);
 	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
-	na->icmph.icmp6_router = 0; /* XXX: should be 1 ? */
+	na->icmph.icmp6_router = (n->flags & NTF_ROUTER) ? 1 : 0;
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = 1;
 	na->target = ns->target;
-- 
2.20.1


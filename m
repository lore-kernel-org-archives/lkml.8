Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CADC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4EB21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942063;
	bh=lAWvsf08nZvSQrfzMExadqGz3aL2prjAHcmVRlzYXZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cvfTZfgCXsvshRqXEKWKjpevyNmsHFLhWMdO6dh3D7y3DrLsNTMR7aduM3k00NSNm
	 xjvV8fEdnZcEYRQ8ZmhDD/nK3TSNkb+Yon+HHoXq6TrkeUPOBQonVU18YcB9TerEN5
	 tgBSXtMNyTLuVnvhcH2E1XR4NtrDIbxdhkbp3KPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgEHMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgEHMrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9ED221F7;
        Fri,  8 May 2020 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942059;
        bh=lAWvsf08nZvSQrfzMExadqGz3aL2prjAHcmVRlzYXZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGNdz8lZwZ3kZY97w3pSEMAvvhh7dn4Stde5hNe0kNCdKG7FNjmuBGtWkcJt4v8+K
         rMLwlOiuDGZH0tvB6/W9/cZz4C2Q0ShogXGUC2AR+We+GQwWrcF9SAf94gAxwSJRAy
         96BL/d5htW9ok+xfgeuasAKfTQ/DeFpJslUCpcR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyeyoon Park <kyeyoonp@codeaurora.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        bridge@lists.linux-foundation.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 281/312] net: bridge: dont increment tx_dropped in br_do_proxy_arp
Date:   Fri,  8 May 2020 14:34:32 +0200
Message-Id: <20200508123144.177646487@linuxfoundation.org>
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

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 85a3d4a9356b595d5440c3f1bf07ee7cecca1567 upstream.

pskb_may_pull may fail due to various reasons (e.g. alloc failure), but the
skb isn't changed/dropped and processing continues so we shouldn't
increment tx_dropped.

CC: Kyeyoon Park <kyeyoonp@codeaurora.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Fixes: 958501163ddd ("bridge: Add support for IEEE 802.11 Proxy ARP")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_input.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -78,13 +78,10 @@ static void br_do_proxy_arp(struct sk_bu
 
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = false;
 
-	if (dev->flags & IFF_NOARP)
+	if ((dev->flags & IFF_NOARP) ||
+	    !pskb_may_pull(skb, arp_hdr_len(dev)))
 		return;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
-		return;
-	}
 	parp = arp_hdr(skb);
 
 	if (parp->ar_pro != htons(ETH_P_IP) ||



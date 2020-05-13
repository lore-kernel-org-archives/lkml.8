Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E847CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4669F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364027;
	bh=1zvD0OnGxIN8keCRL0TYLwEP8jE3c9haru81x4zAZxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OayLG/SA9/wZZH1f9HL+G6GNy2ZLvOWeKWlKOV/j7Zh2m5WJiQAtbYC6dgbeYFHwu
	 VbntybCO3rtCO6udluFjaazFCNQr9HD+6s/aeb5ODD+aAYf5Rsr/sZ/ec2n3Xoaik5
	 0p6GCgiTmjTVhe1WY2DbioGl1w4doYIcdhvWV7a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgEMKAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387748AbgEMJwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2612D20575;
        Wed, 13 May 2020 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363528;
        bh=1zvD0OnGxIN8keCRL0TYLwEP8jE3c9haru81x4zAZxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7L6UtGqWXaoyF+KSfJuN8GP+YSYYp53Po/X0iqQNGqea86VmXRkw7+ynUXfg1Da1
         jY+70yri5d0NrdFmPSP/ncc4UcW+/YNEudi9KONGDb71Zv206W0zTZFQQuROoinMTt
         aMQuXlrNrYibyWLomu+ttkFRNSPItCW0pG2aLnK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Roman Mashak <mrv@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 020/118] neigh: send protocol value in neighbor create notification
Date:   Wed, 13 May 2020 11:43:59 +0200
Message-Id: <20200513094419.505709069@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Mashak <mrv@mojatatu.com>

[ Upstream commit 38212bb31fe923d0a2c6299bd2adfbb84cddef2a ]

When a new neighbor entry has been added, event is generated but it does not
include protocol, because its value is assigned after the event notification
routine has run, so move protocol assignment code earlier.

Fixes: df9b0e30d44c ("neighbor: Add protocol attribute")
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Roman Mashak <mrv@mojatatu.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1954,6 +1954,9 @@ static int neigh_add(struct sk_buff *skb
 				   NEIGH_UPDATE_F_OVERRIDE_ISROUTER);
 	}
 
+	if (protocol)
+		neigh->protocol = protocol;
+
 	if (ndm->ndm_flags & NTF_EXT_LEARNED)
 		flags |= NEIGH_UPDATE_F_EXT_LEARNED;
 
@@ -1967,9 +1970,6 @@ static int neigh_add(struct sk_buff *skb
 		err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
 				     NETLINK_CB(skb).portid, extack);
 
-	if (protocol)
-		neigh->protocol = protocol;
-
 	neigh_release(neigh);
 
 out:



Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE30C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD592063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758711;
	bh=lAmqBsu/wsjKubuOe6/NouZ1wxhMs0q8L+D/vXUHWWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPCvEgVdo3LavTZQHuJA7g65jdZ9CHKLQfZ+WtYUOXSb2DhzPk0y0XBhg5H16M8mZ
	 dijbT+PA8dk6fDJmQGSspB2ClVqUuuLcOnbywwoBQrb3KJbq6AjeSz9B9kv/mJbP/h
	 uXtPwOaZgnFpAw4qoxrcY3BnDTN2X7hohFHmY1Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgDAQbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbgDAQbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6317A2063A;
        Wed,  1 Apr 2020 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758705;
        bh=lAmqBsu/wsjKubuOe6/NouZ1wxhMs0q8L+D/vXUHWWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+q+WYlAs/V1gLYKjDEG+4rTR3ngi0eyx+BCF3QfF43I01aPBjyygk4ZAPpx+g4Bn
         FvyibC7briWIoGBVpAksTn6NQtCU21dDNQ88ZZG2rOtFhUkNBfajBE3h+63DHNCdRT
         XsiGWY9dhvrB65hCYJgAHKglcoE9w1nxyLCSEXVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 49/91] net: ipv4: dont let PMTU updates increase route MTU
Date:   Wed,  1 Apr 2020 18:17:45 +0200
Message-Id: <20200401161530.542598128@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 28d35bcdd3925e7293408cdb8aa5f2aac5f0d6e3 ]

When an MTU update with PMTU smaller than net.ipv4.route.min_pmtu is
received, we must clamp its value. However, we can receive a PMTU
exception with PMTU < old_mtu < ip_rt_min_pmtu, which would lead to an
increase in PMTU.

To fix this, take the smallest of the old MTU and ip_rt_min_pmtu.

Before this patch, in case of an update, the exception's MTU would
always change. Now, an exception can have only its lock flag updated,
but not the MTU, so we need to add a check on locking to the following
"is this exception getting updated, or close to expiring?" test.

Fixes: d52e5a7e7ca4 ("ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 42132ac2c497e..988c132319c48 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -985,21 +985,22 @@ out:	kfree_skb(skb);
 static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 {
 	struct dst_entry *dst = &rt->dst;
+	u32 old_mtu = ipv4_mtu(dst);
 	struct fib_result res;
 	bool lock = false;
 
 	if (ip_mtu_locked(dst))
 		return;
 
-	if (ipv4_mtu(dst) < mtu)
+	if (old_mtu < mtu)
 		return;
 
 	if (mtu < ip_rt_min_pmtu) {
 		lock = true;
-		mtu = ip_rt_min_pmtu;
+		mtu = min(old_mtu, ip_rt_min_pmtu);
 	}
 
-	if (rt->rt_pmtu == mtu &&
+	if (rt->rt_pmtu == mtu && !lock &&
 	    time_before(jiffies, dst->expires - ip_rt_mtu_expires / 2))
 		return;
 
-- 
2.20.1




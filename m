Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21992C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC592187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="Q+SjqO1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgAOI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:57:08 -0500
Received: from fd.dlink.ru ([178.170.168.18]:58070 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgAOI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:57:06 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 570701B20EA4; Wed, 15 Jan 2020 11:57:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 570701B20EA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1579078624; bh=kFoiqF0w3QZg3K17qOi1DHkbwUbvxnM+DJ7ecUc6PjI=;
        h=From:To:Cc:Subject:Date;
        b=Q+SjqO1TvUyFnPjxy2bWM5ZaM8vJ1JJIq2l7h9bOBiJrGQkhgMKwUblqMMR2FeU5p
         4BlEWBPpNk4hdM2+9+BlVwoIduATkEZXpCktTDvbJp2zitC8zu8T9fvhBq94WltRnw
         wwi0u1g3SHc+T8kahrYlRm8v9t/YXNq8BHwKW4YQ=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 3D0D91B2025C;
        Wed, 15 Jan 2020 11:56:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 3D0D91B2025C
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 862361B21422;
        Wed, 15 Jan 2020 11:56:57 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Wed, 15 Jan 2020 11:56:57 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Lobakin <alobakin@dlink.ru>
Subject: [PATCH net] net: dsa: tag_qca: fix doubled Tx statistics
Date:   Wed, 15 Jan 2020 11:56:52 +0300
Message-Id: <20200115085652.12586-1-alobakin@dlink.ru>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSA subsystem takes care of netdev statistics since commit 4ed70ce9f01c
("net: dsa: Refactor transmit path to eliminate duplication"), so
any accounting inside tagger callbacks is redundant and can lead to
messing up the stats.
This bug is present in Qualcomm tagger since day 0.

Fixes: cafdc45c949b ("net-next: dsa: add Qualcomm tag RX/TX handler")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/dsa/tag_qca.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index c95885215525..c8a128c9e5e0 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -33,9 +33,6 @@ static struct sk_buff *qca_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	u16 *phdr, hdr;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
 	if (skb_cow_head(skb, 0) < 0)
 		return NULL;
 
-- 
2.25.0


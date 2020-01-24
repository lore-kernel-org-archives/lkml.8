Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1978C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BF21556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858894;
	bh=whAYpwwCTNHlGSDWqFos4rG0RuxrsjdUqx3iFZYLB/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PE1uYaPS9wQjOzVtQc9X46D/7HPvgvzIEHiVt9Bl06YKR+YQcLV1JE4XEiV0sg3aO
	 MCkLMK9ATOLLwYgb08cSPHtLtzowKx5tmrrM9CgGTKoxwH4V/+7tql9vagRp3l2ob5
	 s+fXsO4F2L3ePTnarAobLnfDU6WaOm4q1D8jJrSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgAXJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbgAXJla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:41:30 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD976208C4;
        Fri, 24 Jan 2020 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858890;
        bh=whAYpwwCTNHlGSDWqFos4rG0RuxrsjdUqx3iFZYLB/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6+xc6D5JlN2Taj9haVOGElAbOdOSjY+ocLDCZjKGL0ZLVxitUMKThvP9r+RlOwT3
         3IJJazmEq2bc/YTklrQB5fieWN7JVDSMsyUMghnEtdAYXFYqbjfCodFGh+yvOGsLnP
         NtcS6621PI+zLAV4d/lh/aSytoefkko2Mpd90rTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/102] net: neigh: use long type to store jiffies delta
Date:   Fri, 24 Jan 2020 10:31:16 +0100
Message-Id: <20200124092817.980055771@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9d027e3a83f39b819e908e4e09084277a2e45e95 ]

A difference of two unsigned long needs long storage.

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f2452496ad9f8..920784a9b7ffa 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2049,8 +2049,8 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 		goto nla_put_failure;
 	{
 		unsigned long now = jiffies;
-		unsigned int flush_delta = now - tbl->last_flush;
-		unsigned int rand_delta = now - tbl->last_rand;
+		long flush_delta = now - tbl->last_flush;
+		long rand_delta = now - tbl->last_rand;
 		struct neigh_hash_table *nht;
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
-- 
2.20.1




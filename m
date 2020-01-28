Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BCAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8184220716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222079;
	bh=4db/nx/Z2/7s+zbDP2Dx7JKPtmOIeHK33hDUB5t1qtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRHs2p/8D0e8Z5WkQhdlwRj+us6/Y/rTlD0D4Xm2orELqW5+C4zEXJcs+vqnXzR8S
	 Cbk1aGD9bpX2HFfCa64UdP/e38DzS8OIbj7J41EBhopst6ETnP2MRzrNlHYSKcgSvN
	 JD2wkfOEDPmA6ErgPZaYByapgkodSh7quhAhxnw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgA1Oei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732459AbgA1OYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEDD2468A;
        Tue, 28 Jan 2020 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221443;
        bh=4db/nx/Z2/7s+zbDP2Dx7JKPtmOIeHK33hDUB5t1qtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaW3WWWW+f+eae0vF4VsnjS9gDMwqmBnzcqAXALJR5Gzq5quZBvXdzWLiLGw/dZP4
         DVfOksvLLbANtSM7ra/m//Odp5SSN5GajAoaNZLb1dEyApISFIOOGXzmtKcxPPvbAH
         WUczB8809uME/QGFO09b6hECdUDAqS5UcNng1S6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 225/271] net: neigh: use long type to store jiffies delta
Date:   Tue, 28 Jan 2020 15:06:14 +0100
Message-Id: <20200128135909.308445604@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index cd85cee14bd03..6578d1f8e6c4a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1834,8 +1834,8 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
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




Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80EC2468D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196885;
	bh=k1oj8Q3S+cyZjezjyGu4MQPFxKMfh/wg8Du3DKYi+BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2Uvjm48db7SLHkpGE7YKgkpvbRMKDfQV+I0I03772O0d1rtFFGSW3OkGwXMhEIPj
	 8EacrQVhrJhQ8eO6GXSPbpuSci90R0xRMSOUSQR+Wbb1earGckisCJ7LSTktue3xTa
	 E7T0Nyvq+mKlhsqwnKDd92rnzcxi5EDPRBxu7hOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394308AbgAPRsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406773AbgAPRqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:46:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B2A246D3;
        Thu, 16 Jan 2020 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196803;
        bh=k1oj8Q3S+cyZjezjyGu4MQPFxKMfh/wg8Du3DKYi+BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHV34b4sUeCUIg7SA0bD2c+gnPt+g8/C+aS4M1rw/BCCTlfMMflBKBlT4zSy0EJbC
         mf3ne/RB/F64yVFLjtJoaOYiPsLQzpGoh6Z0DARaOYxD5fmyi/0h7R8cCje3B90o4j
         ieTvSJi4gK23yiMfwhBYiMsSyPBPKc+H5c0We+Rg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 162/174] net: neigh: use long type to store jiffies delta
Date:   Thu, 16 Jan 2020 12:42:39 -0500
Message-Id: <20200116174251.24326-162-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index af1ecd0e7b07..9849f1f4cf4f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1837,8 +1837,8 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
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


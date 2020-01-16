Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61587C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B757246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196048;
	bh=4yi/VfKsIAwD+kVuskrVQiWDYeWK1KPjwiFrid/OIkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWsao7BnBEApalwgJDnOUX57rlwinnnOypz2VCgQ0aOLvKjrpfKfG4fZqZyXWxX8m
	 mmNPz23kB1Ae5pdhQp6h0dD1IacTUUPuXnJWbD4Fd6nTDGpsnX4GlhevG+Nx1TP65d
	 2h3g6Xi9zIbdKuujwxczFj2OjggvIONVdOiFoe34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404350AbgAPRaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392968AbgAPRaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2B724727;
        Thu, 16 Jan 2020 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195806;
        bh=4yi/VfKsIAwD+kVuskrVQiWDYeWK1KPjwiFrid/OIkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xyx+c/JkDpm2Yh2DH/GvP1NaNKZZ9B8MUK4/ZA7VMGj8Rbdf8LNmQFokpZstVi5/U
         1pf4C+tNR4w4YUwsPEg+PQs5m5cbX23e1+rV5qa+YGuMO8WSQQWgGVKd88inTeWCco
         RkdnN0QiNcF1TFugWV3gXpGCrGuUJh2KIFKD2Qww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 320/371] tcp: annotate lockless access to tcp_memory_pressure
Date:   Thu, 16 Jan 2020 12:23:12 -0500
Message-Id: <20200116172403.18149-263-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1f142c17d19a5618d5a633195a46f2c8be9bf232 ]

tcp_memory_pressure is read without holding any lock,
and its value could be changed on other cpus.

Use READ_ONCE() to annotate these lockless reads.

The write side is already using atomic ops.

Fixes: b8da51ebb1aa ("tcp: introduce tcp_under_memory_pressure()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 2 +-
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 00d10f0e1194..c96302310314 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -289,7 +289,7 @@ static inline bool tcp_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return tcp_memory_pressure;
+	return READ_ONCE(tcp_memory_pressure);
 }
 /*
  * The next routines deal with comparing 32 bit unsigned ints
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8f07655718f3..db1eceda2359 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -328,7 +328,7 @@ void tcp_enter_memory_pressure(struct sock *sk)
 {
 	unsigned long val;
 
-	if (tcp_memory_pressure)
+	if (READ_ONCE(tcp_memory_pressure))
 		return;
 	val = jiffies;
 
@@ -343,7 +343,7 @@ void tcp_leave_memory_pressure(struct sock *sk)
 {
 	unsigned long val;
 
-	if (!tcp_memory_pressure)
+	if (!READ_ONCE(tcp_memory_pressure))
 		return;
 	val = xchg(&tcp_memory_pressure, 0);
 	if (val)
-- 
2.20.1


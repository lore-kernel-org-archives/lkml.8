Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D4E20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461670;
	bh=mHTMAWW1raNFP2h5TTT6iMi2R378EA2fCHGDsRw1TvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jbt0BJoSEPlKw93hb/WsZ3illEQp5gF1juOBx1bCt6RYyXZ9jlCJI0OZ5rTl0UbDX
	 ky42LNyVHAnii3aujupdeiSnOCMuvq2jL+9c1BPQ7IXiB1OnYiGEFGqq025wc28V9e
	 EX0hmoggtmbkaw6eo3OsHzPvhfMj3P/+ck55tTUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbgF2UO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732844AbgF2TaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C8C252E4;
        Mon, 29 Jun 2020 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445115;
        bh=mHTMAWW1raNFP2h5TTT6iMi2R378EA2fCHGDsRw1TvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1PSwTOMpjxYANKD6gJ8/VFCnoyTP4L2OHn3x8GD9a2ZUYT/m3qdp/UQeqDU+bkM2c
         KBCLC1i0v7R+LWZ/++M5DtriP3EoI1oWl7NK2IQ0B76A1WVQNY7cMiKg1lO3FLwrIJ
         mh5GYcpP+d6vmTV4bZ4rBQ2urKeiriccJiAj/Cxs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 21/78] net: Do not clear the sock TX queue in sk_set_socket()
Date:   Mon, 29 Jun 2020 11:37:09 -0400
Message-Id: <20200629153806.2494953-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 41b14fb8724d5a4b382a63cb4a1a61880347ccb8 ]

Clearing the sock TX queue in sk_set_socket() might cause unexpected
out-of-order transmit when called from sock_orphan(), as outstanding
packets can pick a different TX queue and bypass the ones already queued.

This is undesired in general. More specifically, it breaks the in-order
scheduling property guarantee for device-offloaded TLS sockets.

Remove the call to sk_tx_queue_clear() in sk_set_socket(), and add it
explicitly only where needed.

Fixes: e022f0b4a03f ("net: Introduce sk_tx_queue_mapping")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sock.h | 1 -
 net/core/sock.c    | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c6a003bc4737c..a2e10d0b12804 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1687,7 +1687,6 @@ static inline int sk_tx_queue_get(const struct sock *sk)
 
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-	sk_tx_queue_clear(sk);
 	sk->sk_socket = sock;
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index d2cb2051d0453..08ca2ec0ce60a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1538,6 +1538,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		cgroup_sk_alloc(&sk->sk_cgrp_data);
 		sock_update_classid(&sk->sk_cgrp_data);
 		sock_update_netprioidx(&sk->sk_cgrp_data);
+		sk_tx_queue_clear(sk);
 	}
 
 	return sk;
@@ -1740,6 +1741,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		 */
 		sk_refcnt_debug_inc(newsk);
 		sk_set_socket(newsk, NULL);
+		sk_tx_queue_clear(newsk);
 		newsk->sk_wq = NULL;
 
 		if (newsk->sk_prot->sockets_allocated)
-- 
2.25.1


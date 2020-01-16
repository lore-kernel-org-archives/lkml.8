Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E563C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6570A2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202335;
	bh=LCMoKknboLCehwjorCQswSNB9lYK22aKOntpTcABnj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QKvIIB+Pfwdhx/43l4SnVA/VwX28sXSk81JQyBNoSi53OBSx+PmE1FXfFzAN/GIaX
	 UW7rl2UzEQ5D5lXKjp/TUbOXwsmDEGVEASP76dIRK70qIPFIaDODxn6KuGuLH8d3kQ
	 FQycRgf9iIfG5CdEHHB4CzSjP+mT55y2albUaRS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgAPQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731669AbgAPQyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454A520730;
        Thu, 16 Jan 2020 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193657;
        bh=LCMoKknboLCehwjorCQswSNB9lYK22aKOntpTcABnj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q03RBlRuDF76uFchsSVwXy5WIG4hE8uN+OtIuHknpHt7HKnFtZlyghblKUVKkAjxX
         LWf2whUulKr27u5obwT8S8EF44mnyktfdgcnBqvGhiv58ye6y1Ks6MqFFfJ3ouZM6B
         Xa5ArXMcnbEQnDnYfkUA9k2tjEpefjJKSuCT2ARs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 185/205] tipc: fix wrong timeout input for tipc_wait_for_cond()
Date:   Thu, 16 Jan 2020 11:42:40 -0500
Message-Id: <20200116164300.6705-185-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit 12db3c8083fcab4270866a88191933f2d9f24f89 ]

In function __tipc_shutdown(), the timeout value passed to
tipc_wait_for_cond() is not jiffies.

This commit fixes it by converting that value from milliseconds
to jiffies.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 05b5e5e3a0c4..90ace35dbf0f 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -504,7 +504,7 @@ static void __tipc_shutdown(struct socket *sock, int error)
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
 	struct net *net = sock_net(sk);
-	long timeout = CONN_TIMEOUT_DEFAULT;
+	long timeout = msecs_to_jiffies(CONN_TIMEOUT_DEFAULT);
 	u32 dnode = tsk_peer_node(tsk);
 	struct sk_buff *skb;
 
-- 
2.20.1


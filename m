Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2CC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7722CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261174;
	bh=SLoLVovrOUb1vCKl414bjyDTjJcTM3F4jl245dXgTSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvOy9MtvabiQOmGeMMZGsfyfk+AJuI0LE1jyQ6Hl5Yn78IewrhVv8K+09kNBUdAo0
	 KDbpoV0ablJY8aitQoJxWFs/XV1LWfKr57IsQ96Larf0eOW7lwQTukRWJAevkSLodp
	 5IvGDVR6mK/FnUCp/wE0M7X4ksEzAjVR5owIi9o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgGTQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733012AbgGTQGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:06:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E3F20672;
        Mon, 20 Jul 2020 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261162;
        bh=SLoLVovrOUb1vCKl414bjyDTjJcTM3F4jl245dXgTSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXCCmg3l4pX4mkpoaGilyPYzAkUaYkVly1yKpPZoWFTL4eAPoCo7zJhmN6etl+COy
         azczUcDPPWFTuUczyNCm3InYNbgmg5RIogUpab5CP5lKGqg93KBbJ7/LEHLxMTkE2i
         5qem3nwLPEL9OWB4V0z56hNNgsHd+N+maMTWn9uY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 016/244] tcp: md5: add missing memory barriers in tcp_md5_do_add()/tcp_md5_hash_key()
Date:   Mon, 20 Jul 2020 17:34:47 +0200
Message-Id: <20200720152826.652493190@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6a2febec338df7e7699a52d00b2e1207dcf65b28 ]

MD5 keys are read with RCU protection, and tcp_md5_do_add()
might update in-place a prior key.

Normally, typical RCU updates would allocate a new piece
of memory. In this case only key->key and key->keylen might
be updated, and we do not care if an incoming packet could
see the old key, the new one, or some intermediate value,
since changing the key on a live flow is known to be problematic
anyway.

We only want to make sure that in the case key->keylen
is changed, cpus in tcp_md5_hash_key() wont try to use
uninitialized data, or crash because key->keylen was
read twice to feed sg_init_one() and ahash_request_set_crypt()

Fixes: 9ea88a153001 ("tcp: md5: check md5 signature without socket lock")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c      |    7 +++++--
 net/ipv4/tcp_ipv4.c |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3880,10 +3880,13 @@ EXPORT_SYMBOL(tcp_md5_hash_skb_data);
 
 int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct tcp_md5sig_key *key)
 {
+	u8 keylen = key->keylen;
 	struct scatterlist sg;
 
-	sg_init_one(&sg, key->key, key->keylen);
-	ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
+	smp_rmb(); /* paired with smp_wmb() in tcp_md5_do_add() */
+
+	sg_init_one(&sg, key->key, keylen);
+	ahash_request_set_crypt(hp->md5_req, &sg, NULL, keylen);
 	return crypto_ahash_update(hp->md5_req);
 }
 EXPORT_SYMBOL(tcp_md5_hash_key);
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1105,6 +1105,9 @@ int tcp_md5_do_add(struct sock *sk, cons
 	if (key) {
 		/* Pre-existing entry - just update that one. */
 		memcpy(key->key, newkey, newkeylen);
+
+		smp_wmb(); /* pairs with smp_rmb() in tcp_md5_hash_key() */
+
 		key->keylen = newkeylen;
 		return 0;
 	}



Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34522C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F353D21741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DG1uYPSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgCDKNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:13:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43955 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgCDKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id s23so1005506lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQzxMqnkSVUd1PGurjRWf9he+aR/h2xv8xkMvWw9R2w=;
        b=DG1uYPSe689KGlwB5IYDAXUBHjcn4mGrpArmItsmqYg2rzEoIzw3wiRa2odDOOKmBC
         fVD51JPyx+bJcpzEhIJtXDKw/j14WCQqmVyNEPEfbvLUyG1WQF6oYEO2Q3TrqMuSfID1
         LMmyObbGrov4h/SLLB4OFVvJAHFFFRwI/VTgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQzxMqnkSVUd1PGurjRWf9he+aR/h2xv8xkMvWw9R2w=;
        b=aCUWFNWmyhkVLJwPm/oatGUEw9hTl+4SmIxt65GwXug07/vlfU0tQD4yGxXkQ+a+Jf
         5MbBPKBhwzuWtqkWGp14Ndapr4RsGfqGTw+7yZafRcihRB86b1rP8VNog1+dgAziWgnI
         EMnyqD3ZxmT6y2fjXANOTYrxXywMJBhvWP6aDxyFZm9jHdEtNrCQCv/BuX5H2DCuLEUd
         pHyzbBzkGKcs3/bFrKlKXxXirGoa7St+JEKBkXZqyw8OwzzdP4hw0ZGn82Mxj908pcyN
         29bZy3p7XltxfsQEre938iD1BeNFoJYuogkaRhSi+hGg96ia9wfd/7K6AlUwqNTrFJPR
         oXGg==
X-Gm-Message-State: ANhLgQ2bEOBe1LZkoeZQUWCZZJZsjn9rTW3iCS/PA7SYbOQt2F23dII7
        OgY67wbYfO8KwGeOCRkHH+p6Ww==
X-Google-Smtp-Source: ADFU+vtP0Wg67pFU1/jCRJqBdcLWQvzQyRrkm7e/FzcdEHLzf1Y98rCcWZjt6+vePUHOMtkkxR5NMQ==
X-Received: by 2002:ac2:54a3:: with SMTP id w3mr1562653lfk.61.1583316821236;
        Wed, 04 Mar 2020 02:13:41 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:40 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 03/12] bpf: tcp: move assertions into tcp_bpf_get_proto
Date:   Wed,  4 Mar 2020 11:13:08 +0100
Message-Id: <20200304101318.5225-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to ensure that sk->sk_prot uses certain callbacks, so that
code that directly calls e.g. tcp_sendmsg in certain corner cases
works. To avoid spurious asserts, we must to do this only if
sk_psock_update_proto has not yet been called. The same invariants
apply for tcp_bpf_check_v6_needs_rebuild, so move the call as well.

Doing so allows us to merge tcp_bpf_init and tcp_bpf_reinit.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/net/tcp.h   |  1 -
 net/core/sock_map.c | 21 +++++++--------------
 net/ipv4/tcp_bpf.c  | 42 ++++++++++++++++++++++--------------------
 3 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 07f947cc80e6..ccf39d80b695 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2196,7 +2196,6 @@ struct sk_msg;
 struct sk_psock;
 
 int tcp_bpf_init(struct sock *sk);
-void tcp_bpf_reinit(struct sock *sk);
 int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg, u32 bytes,
 			  int flags);
 int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cb8f740f7949..bca560a79b5b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -145,8 +145,8 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 			 struct sock *sk)
 {
 	struct bpf_prog *msg_parser, *skb_parser, *skb_verdict;
-	bool skb_progs, sk_psock_is_new = false;
 	struct sk_psock *psock;
+	bool skb_progs;
 	int ret;
 
 	skb_verdict = READ_ONCE(progs->skb_verdict);
@@ -191,18 +191,14 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 			ret = -ENOMEM;
 			goto out_progs;
 		}
-		sk_psock_is_new = true;
 	}
 
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
-	if (sk_psock_is_new) {
-		ret = tcp_bpf_init(sk);
-		if (ret < 0)
-			goto out_drop;
-	} else {
-		tcp_bpf_reinit(sk);
-	}
+
+	ret = tcp_bpf_init(sk);
+	if (ret < 0)
+		goto out_drop;
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (skb_progs && !psock->parser.enabled) {
@@ -239,12 +235,9 @@ static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
 	if (IS_ERR(psock))
 		return PTR_ERR(psock);
 
-	if (psock) {
-		tcp_bpf_reinit(sk);
-		return 0;
-	}
+	if (!psock)
+		psock = sk_psock_init(sk, map->numa_node);
 
-	psock = sk_psock_init(sk, map->numa_node);
 	if (!psock)
 		return -ENOMEM;
 
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 3327afa05c3d..ed8a8f3c9afe 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -629,14 +629,6 @@ static int __init tcp_bpf_v4_build_proto(void)
 }
 core_initcall(tcp_bpf_v4_build_proto);
 
-static void tcp_bpf_update_sk_prot(struct sock *sk, struct sk_psock *psock)
-{
-	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
-	int config = psock->progs.msg_parser   ? TCP_BPF_TX   : TCP_BPF_BASE;
-
-	sk_psock_update_proto(sk, psock, &tcp_bpf_prots[family][config]);
-}
-
 static int tcp_bpf_assert_proto_ops(struct proto *ops)
 {
 	/* In order to avoid retpoline, we make assumptions when we call
@@ -648,34 +640,44 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendpage == tcp_sendpage ? 0 : -ENOTSUPP;
 }
 
-void tcp_bpf_reinit(struct sock *sk)
+static struct proto *tcp_bpf_get_proto(struct sock *sk, struct sk_psock *psock)
 {
-	struct sk_psock *psock;
+	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
+	int config = psock->progs.msg_parser   ? TCP_BPF_TX   : TCP_BPF_BASE;
 
-	sock_owned_by_me(sk);
+	if (!psock->sk_proto) {
+		struct proto *ops = READ_ONCE(sk->sk_prot);
 
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	tcp_bpf_update_sk_prot(sk, psock);
-	rcu_read_unlock();
+		if (tcp_bpf_assert_proto_ops(ops))
+			return ERR_PTR(-EINVAL);
+
+		tcp_bpf_check_v6_needs_rebuild(sk, ops);
+	}
+
+	return &tcp_bpf_prots[family][config];
 }
 
 int tcp_bpf_init(struct sock *sk)
 {
-	struct proto *ops = READ_ONCE(sk->sk_prot);
 	struct sk_psock *psock;
+	struct proto *prot;
 
 	sock_owned_by_me(sk);
 
 	rcu_read_lock();
 	psock = sk_psock(sk);
-	if (unlikely(!psock || psock->sk_proto ||
-		     tcp_bpf_assert_proto_ops(ops))) {
+	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		return -EINVAL;
 	}
-	tcp_bpf_check_v6_needs_rebuild(sk, ops);
-	tcp_bpf_update_sk_prot(sk, psock);
+
+	prot = tcp_bpf_get_proto(sk, psock);
+	if (IS_ERR(prot)) {
+		rcu_read_unlock();
+		return PTR_ERR(prot);
+	}
+
+	sk_psock_update_proto(sk, psock, prot);
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.20.1


Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20044C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5622051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GClSFCOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCILN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:13:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46701 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCILNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so10493720wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCPLoXcP+lpHnWKxQvj+YI13qZvo01PQWJqE3eh/Ik4=;
        b=GClSFCOK/i7yD4ZQLIXnEWvmlsZPqbeOKuo0zI5fWUUn09VmLVjxF4GBSVX+YOfgom
         rz3fELsHAof9pkf615s9KWN/7iTehWLcklyUjFh3NeJc22XD1sJSK2oZ44DfG0dLFhZW
         Jrp6ysOu5yaJoeZVO+ssyMBUN+BtbcPSJxs3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCPLoXcP+lpHnWKxQvj+YI13qZvo01PQWJqE3eh/Ik4=;
        b=qOIWcurzdbvK1ygjCNBvvBAXkEsruX9xOnkZdWnH9POW1qpRrvbg4BZPm+pcc8OCtH
         lDEmI96Z1WejOt5eamCxrpCa90uha98M5eOvJJV0TqJsK4TQcLnPlVsgo9t9t7aScuCG
         3Iu7vYS60SD30/hzDNnp0VYSHU09A6/TiwLSbBo3uIC0pBvZIaQP2RJ2gh/puZNP098d
         gM/qk4kUKW2fvc1+rDV/utDrurdca7DltD+f/1fQzZ5t1E0D8d/SArmXU0zkXfdH6Gbc
         nvWhoBMbHJ1YPiB9LUaouW02eWCfKOEhmqFFTujinL559NzBNHMzKF90IOHzWXsDP5Li
         ondw==
X-Gm-Message-State: ANhLgQ0wa1ltM9odbO0pSpbx5fmVGSkwTwRlV7pQKmwPKycxcoHkN1LQ
        ae2I6AWWVXsg91c9uMS7O6QYRw==
X-Google-Smtp-Source: ADFU+vv08iVdGwkGLNH4/nhgz74hG4LCZtJBIYml6lPUnB0/kXp9/a3ESDCjiVyIpxamKHUlTIvVKg==
X-Received: by 2002:a5d:6141:: with SMTP id y1mr19541463wrt.146.1583752403214;
        Mon, 09 Mar 2020 04:13:23 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 08/12] bpf: sockmap: add UDP support
Date:   Mon,  9 Mar 2020 11:12:39 +0000
Message-Id: <20200309111243.6982-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow adding hashed UDP sockets to sockmaps.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/sock_map.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index edfdce17b951..a7075b3b4489 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/udp.h>
 
 struct bpf_stab {
 	struct bpf_map map;
@@ -147,7 +148,19 @@ static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 
 	sock_owned_by_me(sk);
 
-	prot = tcp_bpf_get_proto(sk, psock);
+	switch (sk->sk_type) {
+	case SOCK_STREAM:
+		prot = tcp_bpf_get_proto(sk, psock);
+		break;
+
+	case SOCK_DGRAM:
+		prot = udp_bpf_get_proto(sk, psock);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
 	if (IS_ERR(prot))
 		return PTR_ERR(prot);
 
@@ -162,7 +175,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
+		if (sk->sk_prot->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -474,15 +487,31 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB;
 }
 
-static bool sock_map_sk_is_suitable(const struct sock *sk)
+static bool sk_is_tcp(const struct sock *sk)
 {
 	return sk->sk_type == SOCK_STREAM &&
 	       sk->sk_protocol == IPPROTO_TCP;
 }
 
+static bool sk_is_udp(const struct sock *sk)
+{
+	return sk->sk_type == SOCK_DGRAM &&
+	       sk->sk_protocol == IPPROTO_UDP;
+}
+
+static bool sock_map_sk_is_suitable(const struct sock *sk)
+{
+	return sk_is_tcp(sk) || sk_is_udp(sk);
+}
+
 static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
-	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_tcp(sk))
+		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	else if (sk_is_udp(sk))
+		return sk_hashed(sk);
+
+	return false;
 }
 
 static int sock_map_update_elem(struct bpf_map *map, void *key,
-- 
2.20.1


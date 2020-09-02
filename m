Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C10C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D8220773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="szXIHXnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIBOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgIBOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:05:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A9C061249
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:05:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so1139858ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLpCQ3qI5KfHEBWeNBVXvI2wwhNyV/ewM21YvGAgnzw=;
        b=szXIHXnW/DfiXlKuuhJYXkvcvY4v9pEwZcjQ0p4LaEvQfCpa/LVenqQ9o0iSlR8jey
         d90zBEehr5Fg3KBLHtFy1EZxSqkGLHZ7E6aSVHeyJ0msF+QklNjeb6FvxQGZAVHOTOhk
         XbmaEZy9cjFVeuoQmVfx2Y94inCyXC0oo2bIle7C9o9EkSzyq4K/M6y3nMG6ERtxuona
         RpZ0PsNTHnEG6QahRQucJVV/9rSGdZX2Tji0aoyoB2/liTu2R6YMBwnNodYK4NKox6gm
         vQ/xYDDwLkyuzN7kHS9qs1XgcIIFfKuZiQL0efDJaoIp3kt4dAxZfhZJSF1wU9vw/tpv
         jC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLpCQ3qI5KfHEBWeNBVXvI2wwhNyV/ewM21YvGAgnzw=;
        b=fV+XrcVQTbTI4QvzA8AEEL/SsQKKOB5ckFHbEXJV4v1gxnkFO0GSRIyOHInR69rHSK
         1zKWLwef76Eh9MHrZQuOHOHMyD85sJ/cxi0n3yl6Z382RIYKDzTcOuWuMVSaWYQZWxbO
         diymRoV8xfWi+dvVIQywz2pbHpANEoDnpSZ7GOMmEHJsqZOCX8JAcB1ltxGoRu72kA25
         0kNCY5A+kWwlEdDtGd/n3R4moaBE0YWNQivy8M5ZsOTKCGC5eh6mpr6WPt6og7v4g0qg
         F7NFyZzyo0LnykeplWkrq+zUliIzYFrSac3L8sTotWTO1We7IzezP/SeKQbSORjvmQ7B
         e3AA==
X-Gm-Message-State: AOAM531MzldmazeyFvEw2q4L3LgFEmIQQgYm32di3wCclG+Iv3oTzF95
        PPJEQAaMnw5Jp/iK3hiZBjuqZHLeotUa9hBh
X-Google-Smtp-Source: ABdhPJwqSnB7z2vvto5AYOTdoYg5kh0MsgfWPFFpHnhvvrxZATt3nvpoXk9M7ZPJUTqsrdc4n9pUHw==
X-Received: by 2002:a17:906:480a:: with SMTP id w10mr179740ejq.372.1599055536596;
        Wed, 02 Sep 2020 07:05:36 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw14oqa3w7cibjsc.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:8cba:3abe:17e1:aaec])
        by smtp.gmail.com with ESMTPSA id os15sm4354775ejb.61.2020.09.02.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:05:35 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        matthieu.baerts@tessares.net, davem@davemloft.net,
        Tim Froidcoeur <tim.froidcoeur@tessares.net>
Subject: [PATCH 4.4 1/2] net: refactor bind_bucket fastreuse into helper
Date:   Wed,  2 Sep 2020 16:05:12 +0200
Message-Id: <20200902140513.866712-2-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902140513.866712-1-tim.froidcoeur@tessares.net>
References: <20200902140513.866712-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 62ffc589abb176821662efc4525ee4ac0b9c3894 ]

Refactor the fastreuse update code in inet_csk_get_port into a small
helper function that can be called from other places.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
---
 include/net/inet_connection_sock.h |  4 +++
 net/ipv4/inet_connection_sock.c    | 46 ++++++++++++++++++------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 72599bbc8255..a77a37c6349d 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -319,5 +319,9 @@ int inet_csk_compat_getsockopt(struct sock *sk, int level, int optname,
 int inet_csk_compat_setsockopt(struct sock *sk, int level, int optname,
 			       char __user *optval, unsigned int optlen);
 
+/* update the fast reuse flag when adding a socket */
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk);
+
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 #endif /* _INET_CONNECTION_SOCK_H */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6c9158805b57..9678dd8d70c3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -87,6 +87,31 @@ int inet_csk_bind_conflict(const struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(inet_csk_bind_conflict);
 
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk)
+{
+	kuid_t uid = sock_i_uid(sk);
+
+	if (hlist_empty(&tb->owners)) {
+		if (sk->sk_reuse && sk->sk_state != TCP_LISTEN)
+			tb->fastreuse = 1;
+		else
+			tb->fastreuse = 0;
+		if (sk->sk_reuseport) {
+			tb->fastreuseport = 1;
+			tb->fastuid = uid;
+		} else
+			tb->fastreuseport = 0;
+	} else {
+		if (tb->fastreuse &&
+		    (!sk->sk_reuse || sk->sk_state == TCP_LISTEN))
+			tb->fastreuse = 0;
+		if (tb->fastreuseport &&
+		    (!sk->sk_reuseport || !uid_eq(tb->fastuid, uid)))
+			tb->fastreuseport = 0;
+	}
+}
+
 /* Obtain a reference to a local port for the given sock,
  * if snum is zero it means select any available local port.
  */
@@ -216,24 +241,9 @@ tb_not_found:
 	if (!tb && (tb = inet_bind_bucket_create(hashinfo->bind_bucket_cachep,
 					net, head, snum)) == NULL)
 		goto fail_unlock;
-	if (hlist_empty(&tb->owners)) {
-		if (sk->sk_reuse && sk->sk_state != TCP_LISTEN)
-			tb->fastreuse = 1;
-		else
-			tb->fastreuse = 0;
-		if (sk->sk_reuseport) {
-			tb->fastreuseport = 1;
-			tb->fastuid = uid;
-		} else
-			tb->fastreuseport = 0;
-	} else {
-		if (tb->fastreuse &&
-		    (!sk->sk_reuse || sk->sk_state == TCP_LISTEN))
-			tb->fastreuse = 0;
-		if (tb->fastreuseport &&
-		    (!sk->sk_reuseport || !uid_eq(tb->fastuid, uid)))
-			tb->fastreuseport = 0;
-	}
+
+	inet_csk_update_fastreuse(tb, sk);
+
 success:
 	if (!inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, snum);
-- 
2.25.1


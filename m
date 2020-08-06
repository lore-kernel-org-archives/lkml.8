Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED276C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2F723119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="eNe+XCX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgHFRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgHFRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6FC034602
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:32:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so24316911ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ErNZRpF+8oSZq4thj+VkoA7Mzk+13pAiSMJt4dWjiw=;
        b=eNe+XCX78H+NRhHx+wAc7SWkSiqhHAtvd8+5u3ePNr+D20EEBg/xRfE0+Jcfe0NVo9
         gxs3GVSL/06sHgDhjxE/khDy9xtoxY3nFXT46+AxSU1haJE5My8R9ytCfQ09ichUWjv0
         zcQIuTQOqORLcPtfTRrADa4Eecio5gQtNB6Wabc4XHuksmK/DPWbI9yDNo2RceIVs3Wp
         KEjVEnJXcSCAcUFxXwZxd9VNdRo3+41pHyMp268QYSERI6JgHV22qFCjb7MoIK+oxjbI
         asRRgcYb5rey8md5HZmt2WOxQorSXPs7Jvd93VMso20CMevToRZjPe/fHrom9XY2T6oa
         UKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ErNZRpF+8oSZq4thj+VkoA7Mzk+13pAiSMJt4dWjiw=;
        b=jjgL5OWvhM9p/wBBw3tQt9N5pAnljHGcQW2JcS4gigfz2I0rMnejdQbHT8mg38v//a
         CXRoK3QbCtkgYgsU2GnuBY0jFdBaGhmH9+Bp7cNkZ1jcupWP7uyj+dxJ8vfGTu3TRfmK
         pOVqMTeVqvtF6/xBELhJ7fHrv/axUvUyapRhxMvwbs7Ha4zBa3u+FnKWxpWdoZYnIb2A
         uzNsVRulEn8ACF8uC3esQcka5TSF3UfgEYUkossc+oAd89KClVyL2g/uOJkf680o8EdO
         53c+LXTcf99rzuX5QAjoX+9hDf4eN0AnwmJMghq3wpQDfdF5fjLgh9L4yHU0WTY3gJLB
         A3pQ==
X-Gm-Message-State: AOAM532i4qCtFFa4i6i04T0tkvlPfc1DOti269Xvyfdh5+y5o21EA4NE
        xGpwNftqYw6ffQGvz9LTvUV46Q==
X-Google-Smtp-Source: ABdhPJyvgEaE+ueWwMVZG8YsIfh7s+1/NbPE8iYqP8jwxq8qK847GFAgR+j4ZMy1l9bb+5hAUBK+IA==
X-Received: by 2002:a17:906:32ce:: with SMTP id k14mr4303986ejk.412.1596717127478;
        Thu, 06 Aug 2020 05:32:07 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw15pracyli75x11.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:d05d:939:f42b:f575])
        by smtp.gmail.com with ESMTPSA id c5sm3695778ejb.103.2020.08.06.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 05:32:07 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Patrick McHardy <kaber@trash.net>,
        KOVACS Krisztian <hidden@balabit.hu>
Cc:     Tim Froidcoeur <tim.froidcoeur@tessares.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: refactor bind_bucket fastreuse into helper
Date:   Thu,  6 Aug 2020 14:30:22 +0200
Message-Id: <20200806123024.585212-2-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806123024.585212-1-tim.froidcoeur@tessares.net>
References: <20200806123024.585212-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the fastreuse update code in inet_csk_get_port into a small
helper function that can be called from other places.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
---

Notes:
    v2: - remove unnecessary cast (Matt)

 include/net/inet_connection_sock.h |  4 ++
 net/ipv4/inet_connection_sock.c    | 97 ++++++++++++++++--------------
 2 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index e5b388f5fa20..1d59bf55bb4d 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -316,6 +316,10 @@ int inet_csk_compat_getsockopt(struct sock *sk, int level, int optname,
 int inet_csk_compat_setsockopt(struct sock *sk, int level, int optname,
 			       char __user *optval, unsigned int optlen);
 
+/* update the fast reuse flag when adding a socket */
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk);
+
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 
 #define TCP_PINGPONG_THRESH	3
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index afaf582a5aa9..a1be020bde8e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -296,6 +296,57 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 				    ipv6_only_sock(sk), true, false);
 }
 
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk)
+{
+	kuid_t uid = sock_i_uid(sk);
+	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
+
+	if (hlist_empty(&tb->owners)) {
+		tb->fastreuse = reuse;
+		if (sk->sk_reuseport) {
+			tb->fastreuseport = FASTREUSEPORT_ANY;
+			tb->fastuid = uid;
+			tb->fast_rcv_saddr = sk->sk_rcv_saddr;
+			tb->fast_ipv6_only = ipv6_only_sock(sk);
+			tb->fast_sk_family = sk->sk_family;
+#if IS_ENABLED(CONFIG_IPV6)
+			tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
+#endif
+		} else {
+			tb->fastreuseport = 0;
+		}
+	} else {
+		if (!reuse)
+			tb->fastreuse = 0;
+		if (sk->sk_reuseport) {
+			/* We didn't match or we don't have fastreuseport set on
+			 * the tb, but we have sk_reuseport set on this socket
+			 * and we know that there are no bind conflicts with
+			 * this socket in this tb, so reset our tb's reuseport
+			 * settings so that any subsequent sockets that match
+			 * our current socket will be put on the fast path.
+			 *
+			 * If we reset we need to set FASTREUSEPORT_STRICT so we
+			 * do extra checking for all subsequent sk_reuseport
+			 * socks.
+			 */
+			if (!sk_reuseport_match(tb, sk)) {
+				tb->fastreuseport = FASTREUSEPORT_STRICT;
+				tb->fastuid = uid;
+				tb->fast_rcv_saddr = sk->sk_rcv_saddr;
+				tb->fast_ipv6_only = ipv6_only_sock(sk);
+				tb->fast_sk_family = sk->sk_family;
+#if IS_ENABLED(CONFIG_IPV6)
+				tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
+#endif
+			}
+		} else {
+			tb->fastreuseport = 0;
+		}
+	}
+}
+
 /* Obtain a reference to a local port for the given sock,
  * if snum is zero it means select any available local port.
  * We try to allocate an odd port (and leave even ports for connect())
@@ -308,7 +359,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	struct inet_bind_hashbucket *head;
 	struct net *net = sock_net(sk);
 	struct inet_bind_bucket *tb = NULL;
-	kuid_t uid = sock_i_uid(sk);
 	int l3mdev;
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
@@ -345,49 +395,8 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 			goto fail_unlock;
 	}
 success:
-	if (hlist_empty(&tb->owners)) {
-		tb->fastreuse = reuse;
-		if (sk->sk_reuseport) {
-			tb->fastreuseport = FASTREUSEPORT_ANY;
-			tb->fastuid = uid;
-			tb->fast_rcv_saddr = sk->sk_rcv_saddr;
-			tb->fast_ipv6_only = ipv6_only_sock(sk);
-			tb->fast_sk_family = sk->sk_family;
-#if IS_ENABLED(CONFIG_IPV6)
-			tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
-#endif
-		} else {
-			tb->fastreuseport = 0;
-		}
-	} else {
-		if (!reuse)
-			tb->fastreuse = 0;
-		if (sk->sk_reuseport) {
-			/* We didn't match or we don't have fastreuseport set on
-			 * the tb, but we have sk_reuseport set on this socket
-			 * and we know that there are no bind conflicts with
-			 * this socket in this tb, so reset our tb's reuseport
-			 * settings so that any subsequent sockets that match
-			 * our current socket will be put on the fast path.
-			 *
-			 * If we reset we need to set FASTREUSEPORT_STRICT so we
-			 * do extra checking for all subsequent sk_reuseport
-			 * socks.
-			 */
-			if (!sk_reuseport_match(tb, sk)) {
-				tb->fastreuseport = FASTREUSEPORT_STRICT;
-				tb->fastuid = uid;
-				tb->fast_rcv_saddr = sk->sk_rcv_saddr;
-				tb->fast_ipv6_only = ipv6_only_sock(sk);
-				tb->fast_sk_family = sk->sk_family;
-#if IS_ENABLED(CONFIG_IPV6)
-				tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
-#endif
-			}
-		} else {
-			tb->fastreuseport = 0;
-		}
-	}
+	inet_csk_update_fastreuse(tb, sk);
+
 	if (!inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, port);
 	WARN_ON(inet_csk(sk)->icsk_bind_hash != tb);
-- 
2.25.1


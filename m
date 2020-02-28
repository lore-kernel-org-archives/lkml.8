Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC41C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7B2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="nRHbeQgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgB1Lyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:54:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1Lyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:54:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so2679284wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkEx/G8eTytwDA2xVv10ojrFCAdFuXVuGczKEDlanmk=;
        b=nRHbeQgBoCC9FHlZT6ZsAN7GvP0j8s57g9+KlGBZwPDQqJZ3i5PoXvaA0GjY5CZpbS
         AioUXAB5a0PkTF6uS+TcLk0rI/fILna02Lp07mec29YR9laNBuKwaJ4KZpHnJ+ZY6bwu
         aF8i7C3vO5lTIACuzcScyyqfAF7VVNSeQ3cjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkEx/G8eTytwDA2xVv10ojrFCAdFuXVuGczKEDlanmk=;
        b=reAeBBdbAx6PTuEK2JTpvE5M3phQr4E2rNQbHul3swgXKbVpQBNUNcZBReu4bAdrIY
         I9jCBCcLiO8gFezZ9yFJSGxUHIshrMQ3SNJ9hKDqZ9DyPEsvTJ92hpE3SwCCkLuXwlaV
         cQlSwGYyewK/pwn8tEohCw2UCWx7f0OHca0yea5BZwBakvVEjTkTCWr//6tttPjFC4Di
         J0Qm/XwdqxJuNUbYuXaH3lSrh8OiyE3tpnsdFT+YmwCaneHuyP2CZdAAeT+rpFGt3gma
         0QbdYliNpjiAZrYPhKBO2Op3GUAXfJIDd6vR6q/pADpAqVBETfW/wWxweME6IaXkTNZU
         HOUQ==
X-Gm-Message-State: APjAAAXwKQtfbbDU2P3CxPZsdoow63qDVafcwcyOT/pe2gkPfrGFXJaH
        wsT5WetFfn4u1vEK5etdgfv9oQ==
X-Google-Smtp-Source: APXvYqxS15rS27QJPaHUorY/EiMzfq9bdMkp7hbe1foDlgNo69dHobfArrDcXbCCKQea3JYPjT7hlQ==
X-Received: by 2002:adf:ee85:: with SMTP id b5mr4566530wro.34.1582890874869;
        Fri, 28 Feb 2020 03:54:34 -0800 (PST)
Received: from antares.lan (b.2.d.a.1.b.1.b.2.c.5.e.0.3.d.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4d30:e5c2:b1b1:ad2b])
        by smtp.gmail.com with ESMTPSA id q125sm2044284wme.19.2020.02.28.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:54:34 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/9] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
Date:   Fri, 28 Feb 2020 11:53:37 +0000
Message-Id: <20200228115344.17742-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228115344.17742-1-lmb@cloudflare.com>
References: <20200228115344.17742-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
selected. The declaration should therefore be guarded as such.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 07f947cc80e6..a30022482dbc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2195,6 +2195,7 @@ void tcp_update_ulp(struct sock *sk, struct proto *p,
 struct sk_msg;
 struct sk_psock;
 
+#ifdef CONFIG_NET_SOCK_MSG
 int tcp_bpf_init(struct sock *sk);
 void tcp_bpf_reinit(struct sock *sk);
 int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg, u32 bytes,
@@ -2203,13 +2204,12 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		    int nonblock, int flags, int *addr_len);
 int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 		      struct msghdr *msg, int len, int flags);
-#ifdef CONFIG_NET_SOCK_MSG
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #else
 static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 {
 }
-#endif
+#endif /* CONFIG_NET_SOCK_MSG */
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
  * is < 0, then the BPF op failed (for example if the loaded BPF
-- 
2.20.1


Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F524C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129102187F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="pF4iF5TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgCDKNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:13:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45805 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgCDKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id b13so997854lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0wl1OJM6IH+sDqygSxTDk69keKKulf2E2ZitkodWc0=;
        b=pF4iF5TXR55/ShmYFyj64mtfIECTPwHUFTRMmBpG4v9K1a4oRko1LAc47oTrbPEZ7V
         ekTdV8Ugwvyah43WBZWKl1+avVwtF8AIuMjrRV6b2afdDIoZxSz1yBF9KJRkNnxbca6w
         kRb89JQ0VGHf6ttX+xKFebk61MJf1B0dFLtd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0wl1OJM6IH+sDqygSxTDk69keKKulf2E2ZitkodWc0=;
        b=XPVTZsyBz2rPrRWr3M2Py5nX/iLUm4WoHev9JRkMx2KLDWxZwicj+0R6CYtrWDq8/Z
         93chTjLcROO4i4ITOz9qcFHYsTGuSaAE6/MYW1ua8skdw/CvpQBMGH9VeeF1GtEuzn2p
         sf2J8ol80gT/bi7t+d/jiSl/93nLW0W8oVkpMc3nJLUmpyClIzwqrCUyWhih7UF5EvZB
         Zy/7Sx5CZAN9/t+f6SdrigUKTPRscXCq/XANiJdAFLMij7fcE8UT/EOI8HjSjPSbOp7s
         KwUUyjypHbTeVyH7lc1PPK6qYAv7qyK4nWHkqZI2YVu8ly2y8RHUqUeYbvehXLgzKbaQ
         m2lw==
X-Gm-Message-State: ANhLgQ0MfSsS+jztO1+ZmOQtBcbO+KWjDDdvAS5kg7byNeovisIL4M87
        7hMgC0pm5hv52RSOi9IZmg+n0w==
X-Google-Smtp-Source: ADFU+vuatKbNiLy7NuHZEEf/SpW/MBWvMF9amGOA+G+XIAlpSOS9i5x3LuuVPh8QK7qMDAuLd4pnbw==
X-Received: by 2002:ac2:4d41:: with SMTP id 1mr1553046lfp.171.1583316822741;
        Wed, 04 Mar 2020 02:13:42 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
Date:   Wed,  4 Mar 2020 11:13:09 +0100
Message-Id: <20200304101318.5225-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
selected. The declaration should therefore be guarded as such.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ccf39d80b695..ad3abeaa703e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2195,6 +2195,7 @@ void tcp_update_ulp(struct sock *sk, struct proto *p,
 struct sk_msg;
 struct sk_psock;
 
+#ifdef CONFIG_NET_SOCK_MSG
 int tcp_bpf_init(struct sock *sk);
 int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg, u32 bytes,
 			  int flags);
@@ -2202,13 +2203,12 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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


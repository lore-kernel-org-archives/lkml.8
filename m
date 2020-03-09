Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18743C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56D12051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OPuFONLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCILNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:13:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39961 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCILNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so9088552wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhnNh0FQpU0IXnemYuyXF82fe/AvYFMA5w4Rk3Zgjg8=;
        b=OPuFONLR+flmNj8q3OtmclC70Xv8ZSwnJ2b3unDxiP/H22qOrNB0U8O9evExpS2Pvh
         aANMarFYBxasC60dzb2/yI3+GoWDeoshz7mgTXsYd9GrRYkLoFPeUABNInnZ49oxNSrj
         Jd0ozRGwe7VkvtE/yTFobFyc9k1B4iEgb52uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhnNh0FQpU0IXnemYuyXF82fe/AvYFMA5w4Rk3Zgjg8=;
        b=LILPZt5RyZcBb6H/QbttwUey4ALWHEAMDHceBgh45v4mktVO3pV+cv7YECOqhDs+KQ
         ssu/488S6TjHcKKLg3KEEG50nI0xa0LQU36mZ7EctIGdnxzj8x1VbPEEIhuZd+kPKqI3
         M2/V5Tr9sMm149BFcZr7RklOmTsWkJpiXbrn0Q9dNkGIk67c7eemHhGt7kH8gQIIhxNA
         deky0IcVsY5kKjdrLw1QyqVfXyO5sl56KJdgOiLf3R6iV6gE15dkXOgf2qjE+NHHDbhk
         d0VuYlsiKrKQnkd7AznzEnCyC5CIUqISmPdeR2zdYNEzsrRbihbSE0EY8fjhnLwhvO8o
         neNA==
X-Gm-Message-State: ANhLgQ14OJQ1FxFdEjmXOIsE/IBg7d1tOGyfVQs+TFA8d3AVbf9uLggH
        dZsT28qBvULAaue+xCzHPorGiQ==
X-Google-Smtp-Source: ADFU+vvw76jpjuBquu29c/ImGlyugCxB+gF1RrtRq0128jT1ZEa3yp+jKznj7UEb3KCDKavSApSTJw==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr19143120wmr.72.1583752395887;
        Mon, 09 Mar 2020 04:13:15 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:15 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
Date:   Mon,  9 Mar 2020 11:12:35 +0000
Message-Id: <20200309111243.6982-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
selected. The declaration should therefore be guarded as such.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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


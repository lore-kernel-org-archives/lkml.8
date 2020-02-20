Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE97C11D41
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8024672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WzZKvPCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBTGXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBTGXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so1394623pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qayNiEk6Ez597Hfv2WXjhuGkwTEv6woGfUiEMCan8o=;
        b=WzZKvPCluiNn0EYIb2cJH7gk/Iwu48zGyL51qi6o50wqyXa0MHNh4UN34IwELQE+tL
         4Yf/ExFaaZn8+jAbh6sW6rHSPTd19fobn/13Icre1F6EvGp00V+hJxevsi2emcp19IVo
         QZCPxOy+/BZyRoUge1gQVhsmVL2dZWqhQh+Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qayNiEk6Ez597Hfv2WXjhuGkwTEv6woGfUiEMCan8o=;
        b=WanBcglLTngKGo2re2uSzqBSM6xx0qwwdYKeYA7M2XqnYPsPvdJtvqU49tdI3iw8kS
         BUQagsyy/6QUiJwXh+w2mSJabYt1k/DrDa6qyKM5j5jIVQu5gx5p1SSnpams91f4Fv+q
         wmrxAIE1xvXKZ/cvJZBXypyMaJ9TWhemcJVK27iZrFv4YJ1TWdZtV4KmpJFp5/GFKnB/
         aQIPkGa1Ey3aWvsFNJJSK7AVxalXcIJ9ilSUj3O4CIfd7lfW7WbZKQ+ly9ZqZOLEAy9X
         rwZUhK52t6PZTmsK3jKSzNKiO50PxXu9a6L/8Mn7f2N4wuG5ev3JhgQmtw7zyFn1XEVY
         jICw==
X-Gm-Message-State: APjAAAUygo7mhRy7AZUAzvJaEO9XExpcpUBFV2XN62VzzNq033sM984y
        pu6AH1C/VVjXPNcLs9m+uSgs5w==
X-Google-Smtp-Source: APXvYqxbFRQZq8cdLNzYWY9l0+FHpSJxlK3/FtLPNTsPI/zF7OARbBHjOSE/cwPT1SKoTZGUBiiXxg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr30850982pgh.96.1582179789982;
        Wed, 19 Feb 2020 22:23:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm1763457pjg.0.2020.02.19.22.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ip6_gre: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:07 -0800
Message-Id: <20200220062307.68986-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

net/ipv6/ip6_gre.c: In function ‘ip6gre_err’:
net/ipv6/ip6_gre.c:440:32: warning: statement will never be executed [-Wswitch-unreachable]
  440 |   struct ipv6_tlv_tnl_enc_lim *tel;
      |                                ^~~

net/ipv6/ip6_tunnel.c: In function ‘ip6_tnl_err’:
net/ipv6/ip6_tunnel.c:520:32: warning: statement will never be executed [-Wswitch-unreachable]
  520 |   struct ipv6_tlv_tnl_enc_lim *tel;
      |                                ^~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ipv6/ip6_gre.c    |    8 +++++---
 net/ipv6/ip6_tunnel.c |   13 +++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 55bfc5149d0c..781ca8c07a0d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -437,8 +437,6 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return -ENOENT;
 
 	switch (type) {
-		struct ipv6_tlv_tnl_enc_lim *tel;
-		__u32 teli;
 	case ICMPV6_DEST_UNREACH:
 		net_dbg_ratelimited("%s: Path to destination invalid or inactive!\n",
 				    t->parms.name);
@@ -452,7 +450,10 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			break;
 		}
 		return 0;
-	case ICMPV6_PARAMPROB:
+	case ICMPV6_PARAMPROB: {
+		struct ipv6_tlv_tnl_enc_lim *tel;
+		__u32 teli;
+
 		teli = 0;
 		if (code == ICMPV6_HDR_FIELD)
 			teli = ip6_tnl_parse_tlv_enc_lim(skb, skb->data);
@@ -468,6 +469,7 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 					    t->parms.name);
 		}
 		return 0;
+	}
 	case ICMPV6_PKT_TOOBIG:
 		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
 		return 0;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 5d65436ad5ad..4703b09808d0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -517,8 +517,6 @@ ip6_tnl_err(struct sk_buff *skb, __u8 ipproto, struct inet6_skb_parm *opt,
 	err = 0;
 
 	switch (*type) {
-		struct ipv6_tlv_tnl_enc_lim *tel;
-		__u32 mtu, teli;
 	case ICMPV6_DEST_UNREACH:
 		net_dbg_ratelimited("%s: Path to destination invalid or inactive!\n",
 				    t->parms.name);
@@ -531,7 +529,10 @@ ip6_tnl_err(struct sk_buff *skb, __u8 ipproto, struct inet6_skb_parm *opt,
 			rel_msg = 1;
 		}
 		break;
-	case ICMPV6_PARAMPROB:
+	case ICMPV6_PARAMPROB: {
+		struct ipv6_tlv_tnl_enc_lim *tel;
+		__u32 teli;
+
 		teli = 0;
 		if ((*code) == ICMPV6_HDR_FIELD)
 			teli = ip6_tnl_parse_tlv_enc_lim(skb, skb->data);
@@ -548,7 +549,10 @@ ip6_tnl_err(struct sk_buff *skb, __u8 ipproto, struct inet6_skb_parm *opt,
 					    t->parms.name);
 		}
 		break;
-	case ICMPV6_PKT_TOOBIG:
+	}
+	case ICMPV6_PKT_TOOBIG: {
+		__u32 mtu;
+
 		ip6_update_pmtu(skb, net, htonl(*info), 0, 0,
 				sock_net_uid(net, NULL));
 		mtu = *info - offset;
@@ -562,6 +566,7 @@ ip6_tnl_err(struct sk_buff *skb, __u8 ipproto, struct inet6_skb_parm *opt,
 			rel_msg = 1;
 		}
 		break;
+	}
 	case NDISC_REDIRECT:
 		ip6_redirect(skb, net, skb->dev->ifindex, 0,
 			     sock_net_uid(net, NULL));


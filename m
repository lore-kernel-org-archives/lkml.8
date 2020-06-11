Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E15206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CMzvm+im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFKRZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgFKRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:25:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBCC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:25:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so7014404wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmHmPvjIL/uoQZEqL49hjtjHKbcvKuEnA1LiIhhiiv4=;
        b=CMzvm+imQ9cB23Eiy1rEwYePeux7mfPlyD6M/FEjx5Hh6kdKtBGC6QkIrZj0C6FwWi
         OffW2wZLvIpgYLzJFod41sU26hINgE+Otu9+lSQ8mdn+YYNLSd8m6rYUn7Zy0wqDRIlR
         YrS2tofgEqd1VY32pehLP0/GCkbMu/RdT3GHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmHmPvjIL/uoQZEqL49hjtjHKbcvKuEnA1LiIhhiiv4=;
        b=OqW3xvNMlQ5fbtQSAjgUi2b7Au8ZizXDiAQ8uMVLjCy318AawtToNR9qn0SdMHDL0J
         6fI53jKmdrbuaBumEXi2mBblODYmjdFBPnEcpfQEmhHLj9GQVhXobBWg1/eQxfgPZmFt
         jZ8z5ELPfeJCyQ5oOXajsesXG7q9aeSwE32J8PbPvrZHQ03aPk/zpElTrQl4BGLprV5I
         2LEwHoL6nqLv/GW0mkNpkbUJ9KteD+EhR7krijRlST+u0O0z8zFPrlMhcp33menkjn7B
         TY2xNqRlqmoXyjEySkOfnH47dGUTSIDx6DUdESlJcPZvdODE+1y+VzIscBSWbH5oviy9
         J7RQ==
X-Gm-Message-State: AOAM531Dy9U/U0exm2afbHaAK4h3WvKi4jNuhieTDZGWO8MWXekyKz8C
        AVX8hfvXwTC/74k0t/2kmVEwGA==
X-Google-Smtp-Source: ABdhPJzfvbquWMv3SW72gKgtUedJACAfw0cuil7ok4HdoKUCgxg9YSjE0tpPciptHEDo7nJ9xggemw==
X-Received: by 2002:adf:d852:: with SMTP id k18mr10714394wrl.177.1591896345683;
        Thu, 11 Jun 2020 10:25:45 -0700 (PDT)
Received: from antares.lan (4.1.2.f.7.2.f.a.4.b.9.9.a.8.4.a.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:a48a:99b4:af27:f214])
        by smtp.gmail.com with ESMTPSA id v7sm5971907wro.76.2020.06.11.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:25:45 -0700 (PDT)
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
Subject: [PATCH bpf] bpf: sockmap: don't attach programs to UDP sockets
Date:   Thu, 11 Jun 2020 18:25:20 +0100
Message-Id: <20200611172520.327602-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream parser infrastructure isn't set up to deal with UDP
sockets, so we mustn't try to attach programs to them.

I remember making this change at some point, but I must have lost
it while rebasing or something similar.

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00a26cf2cfe9..35cea36f3892 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -424,10 +424,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
-static bool sock_map_redirect_allowed(const struct sock *sk)
-{
-	return sk->sk_state != TCP_LISTEN;
-}
+static bool sock_map_redirect_allowed(const struct sock *sk);
 
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
@@ -508,6 +505,11 @@ static bool sk_is_udp(const struct sock *sk)
 	       sk->sk_protocol == IPPROTO_UDP;
 }
 
+static bool sock_map_redirect_allowed(const struct sock *sk)
+{
+	return sk_is_tcp(sk) && sk->sk_state != TCP_LISTEN;
+}
+
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
 	return sk_is_tcp(sk) || sk_is_udp(sk);
-- 
2.25.1


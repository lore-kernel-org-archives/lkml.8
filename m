Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BF320870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JYPrHolp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgCDKNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:13:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgCDKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so1364297ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37n9ID/jQISQUdmUM2Xy9nSmU2zdBjkBqvMddVrEaU0=;
        b=JYPrHolptd1n2nSDReTgh2qB3EIJhFPcT8U2rWu0VGMz4ZfOXORHYPLWXVMzA2hkhv
         8i5RXCTGg8rYBAYowpL0n60igO49EEIw2yd8naNh3dsGnw1G6eg68anezW6ztoYc/W6J
         3CD+fjvY3YO9JCmls4GuxCUQrUdCuSmwfDHjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37n9ID/jQISQUdmUM2Xy9nSmU2zdBjkBqvMddVrEaU0=;
        b=gMlsxFC5y7WP0Q7L7/4FIBhd9pagh82QHuCCRNFsXEoSb/BL1APPU6gsbSsJq8FuU2
         16xjQEhW+WPmDJdj7fL3NN04zmXDmUw/+jcZBQBlHIJB2TsTCfguSP4mFZroGlXulD27
         sWUc468/jbuAmwPjNV7ZyTDWavxD/JW/D9tRBYDuo7a55afTwKbrDvL/nevdsbwEMkb1
         sD4Mv+Nv6UHN5QJCTwOgIaBn8fW53bOFYxu1TEnqNIp5lCjzTrlKToxSWJonvMoo7w9E
         vrr0X5MolyVj4eaHdgvRvDgfu6A4+hzwHzKRtLDW081RY96NygnLaiQqla1wQVsKwv1n
         6new==
X-Gm-Message-State: ANhLgQ3hRGYOyLIzg2ME5EpmhQ8s1AlCK8LxvgUHTLvtf6MA5ufJdA+B
        5oN/FDPiDDYy+/vawhiYY0Ts6g==
X-Google-Smtp-Source: ADFU+vvdRHJXk5KTON2lz3bzzhYKfTKoWcnjztS1Xi8SaNMzHXlSTQRuZRQFj4iNxNcGreu2af+oMw==
X-Received: by 2002:a2e:8884:: with SMTP id k4mr1535745lji.59.1583316826417;
        Wed, 04 Mar 2020 02:13:46 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:45 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 06/12] bpf: sockmap: simplify sock_map_init_proto
Date:   Wed,  4 Mar 2020 11:13:11 +0100
Message-Id: <20200304101318.5225-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can take advantage of the fact that both callers of
sock_map_init_proto are holding a RCU read lock, and
have verified that psock is valid.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9898294e119d..83c5082cefd3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -141,28 +141,17 @@ static void sock_map_unref(struct sock *sk, void *link_raw)
 	}
 }
 
-static int sock_map_init_proto(struct sock *sk)
+static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 {
-	struct sk_psock *psock;
 	struct proto *prot;
 
 	sock_owned_by_me(sk);
 
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-
 	prot = tcp_bpf_get_proto(sk, psock);
-	if (IS_ERR(prot)) {
-		rcu_read_unlock();
+	if (IS_ERR(prot))
 		return PTR_ERR(prot);
-	}
 
 	sk_psock_update_proto(sk, psock, prot);
-	rcu_read_unlock();
 	return 0;
 }
 
@@ -241,7 +230,7 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 
-	ret = sock_map_init_proto(sk);
+	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0)
 		goto out_drop;
 
@@ -286,7 +275,7 @@ static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
 	if (!psock)
 		return -ENOMEM;
 
-	ret = sock_map_init_proto(sk);
+	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0)
 		sk_psock_put(sk, psock);
 	return ret;
-- 
2.20.1


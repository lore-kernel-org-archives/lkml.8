Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE51C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D367206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfOGhGEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGYRWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgGYRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:22:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E6BC08C5C0;
        Sat, 25 Jul 2020 10:22:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so13075019ljp.6;
        Sat, 25 Jul 2020 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GPROL0OFn1Zoa+T/W5yPrIi0RKEcnBGefsIDz4lyL6Q=;
        b=SfOGhGEqbd1e6XTAE5PuBrVx2kWQ3rdM05hRG/3fifrCbwyL0f4TLmY+PuL4iUxGdD
         w/HF/C0JHJt1GZALzfgbUmBpYbjyvTLdQL4xyeTV1fNLYmFEe7jHGHQ/PeK4+9KO4ZTC
         uuFEVLiSp5hIwBooy9rXrd+p8ziwE0oXT48fN9bMbCmQ0VugRxveW3nAHQ1wXyQq5ICW
         QLU1+IGtzZoe4s3WTqA1G+KXaUuS+9YLKLambCHF+UGGV3cj2QKVa+hs+2LgHOJYAt/1
         scS9YOzGXIBAUnhgE5TvUyGsXhvCRcgN68+iBt5fEHzmBF/A7qP/9Qes5rF4EBgFSAag
         jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=GPROL0OFn1Zoa+T/W5yPrIi0RKEcnBGefsIDz4lyL6Q=;
        b=DYNDnGs1zRBs69aH3oBxt4twB3ysdHaS47IENAWvzuHxFRc5SwR8+mnvEF1bI5fPF7
         h20+gRDvpFpdrhJK+OJigpVLyVBmzsHVczbf5IzAJxpi5VDabgQPaN+ixi2uSD6ZOIjG
         cP5ZGB9kPID8rXOhpEey5Z4ize57AShAa0otKIORzrL/0YhqqZMlK24Ju2BJo/pRyy8h
         6HvE/OlC2/ONgjTWvmwVxBjXGN9Y9oDNEolIbXbrHNVuumjRQsAr8h7iq+Og7M1mFK9i
         mxObvkXE9hqamOizzxMQFc7ej+0pj0vPmIu3mXd/+6wuN22VqcPr7+NZJuYYI3CeZuxt
         dQXg==
X-Gm-Message-State: AOAM531lTvWAn5vfjC6thPKo3j2c4ZVy9uER/lORzr81omS8UEYVnAEt
        FKkgS9f+eq54l31nFwc5i7aEJHgk2dY=
X-Google-Smtp-Source: ABdhPJwMI8wk4gV0+3V16pDVDPI2MF9rhmNLUQt/3HAtRaAxqUG+l8UpKfD36rluJ48TOthBxS6sBA==
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr6123671ljm.249.1595697772037;
        Sat, 25 Jul 2020 10:22:52 -0700 (PDT)
Received: from localhost ([109.252.87.77])
        by smtp.gmail.com with ESMTPSA id 9sm1492255lff.82.2020.07.25.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 10:22:51 -0700 (PDT)
Subject: [PATCH] net/ipv4: add comment about connect() to INADDR_ANY
From:   Konstantin Khlebnikov <koct9i@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 25 Jul 2020 20:22:50 +0300
Message-ID: <159569777048.30163.2041497275480123382.stgit@zurg>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy comment from net/ipv6/tcp_ipv6.c to help future readers.

Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
---
 net/ipv4/route.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a01efa062f6b..303fe706cbd2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2591,6 +2591,7 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 		}
 	}
 
+	/* connect() to INADDR_ANY means loopback (BSD'ism). */
 	if (!fl4->daddr) {
 		fl4->daddr = fl4->saddr;
 		if (!fl4->daddr)


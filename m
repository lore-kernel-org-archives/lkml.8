Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE30CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9817222D00
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="RiFKf1ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgHFL5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgHFLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 07:17:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC1C0617AB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 04:06:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so25358002eds.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=PYSsCrOysop+Sh0mOiJ6j1B4kZ/DvpynNkFjKlnFTtk=;
        b=RiFKf1ZDy1QYFqUEaD38cJSlgDMEp2uzQNfOQF28/kHkXz8nwtGrTxRXuMrcxIYUCW
         i2SyC7q4a+Hlfbov9p/707mge6kYnZcvbb5lGvpuhHnY31qyhnKNTbtuVD2yDg9qiOEk
         qNaAgDRhdrN8EJBFTY21+UBpZpx4oQr7+6Fvj9CXtFRbGci0z3mOdfwp0aC+9050chrZ
         LLwgUne6B29yqzjvBmLRuhX/PYNrfZXCRyh0YlNI+DC5W0JzExy464GxzNPr5wtaLEDz
         Gk7/o17kfdrVqw+JiskeC3yrY8gnyjlwl4LeYXXih14fnlWw37D7OPiB9aJpJevfHU86
         mDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=PYSsCrOysop+Sh0mOiJ6j1B4kZ/DvpynNkFjKlnFTtk=;
        b=Sd+jE3k8NhB1AwLP2N8MnsV8GN3+rE4Q02Z6Ua2bzaSwYuygqsaLkaA7CeKzXxfOnx
         p5qbnYZAZUZEQSSFQcsUr8BSB061hvuSZ93ZqUpNVZe5a6PsaKuDG8Yc5aXlx4YH26nq
         mlXUjJdC3gwVGjlxP/Kp3Z5gf630C9jRpAsjNCeVVI2se8Y3NtjpeODpLtvRPd9+9uRt
         77TvX8pH5p0oUrRmBG0N0Jp0Fw00Rh4owE+a8GM2uAyWPoP9HhMCKuEBcheJX/98ryVL
         nZ29CY8fTtRJpdxtpx4Ia1Tp1Yf07k7U4f8LWWxyXO8CX7Oh04jHHu7BJYn9bbHBvdQg
         2ISA==
X-Gm-Message-State: AOAM530kZopWXRaFT78nLF74d9jq8B8snxul5v8ZMs7fzGcOf4WFgl/8
        9egPx/rZglj8SL99AMJnW/jBtQ1xVW1XOnjvUPxrMR545AyHdQMipBIMs5TJX+45wSYsGHhsa/G
        Quj9qR7Vu/22SLx6fbw==
X-Google-Smtp-Source: ABdhPJwLqyoWjwRDYILTF5e67AwRbZf7hhQrvTreE0IkPpokDMYDsXaFaI97KW0N6QvK5JTBtuHSbQ==
X-Received: by 2002:a05:6402:899:: with SMTP id e25mr3435126edy.311.1596712006085;
        Thu, 06 Aug 2020 04:06:46 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw15pracyli75x11.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:d05d:939:f42b:f575])
        by smtp.gmail.com with ESMTPSA id v13sm3597682edl.9.2020.08.06.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 04:06:45 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     tim.froidcoeur@tessares.net,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Patrick McHardy <kaber@trash.net>,
        KOVACS Krisztian <hidden@balabit.hu>
Cc:     matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: initialize fastreuse on inet_inherit_port
Date:   Thu,  6 Aug 2020 13:06:31 +0200
Message-Id: <20200806110631.475855-3-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806110631.475855-1-tim.froidcoeur@tessares.net>
References: <20200806110631.475855-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of TPROXY, bind_conflict optimizations for SO_REUSEADDR or
SO_REUSEPORT are broken, possibly resulting in O(n) instead of O(1) bind
behaviour or in the incorrect reuse of a bind.

the kernel keeps track for each bind_bucket if all sockets in the
bind_bucket support SO_REUSEADDR or SO_REUSEPORT in two fastreuse flags.
These flags allow skipping the costly bind_conflict check when possible
(meaning when all sockets have the proper SO_REUSE option).

For every socket added to a bind_bucket, these flags need to be updated.
As soon as a socket that does not support reuse is added, the flag is
set to false and will never go back to true, unless the bind_bucket is
deleted.

Note that there is no mechanism to re-evaluate these flags when a socket
is removed (this might make sense when removing a socket that would not
allow reuse; this leaves room for a future patch).

For this optimization to work, it is mandatory that these flags are
properly initialized and updated.

When a child socket is created from a listen socket in
__inet_inherit_port, the TPROXY case could create a new bind bucket
without properly initializing these flags, thus preventing the
optimization to work. Alternatively, a socket not allowing reuse could
be added to an existing bind bucket without updating the flags, causing
bind_conflict to never be called as it should.

Call inet_csk_update_fastreuse when __inet_inherit_port decides to create
a new bind_bucket or use a different bind_bucket than the one of the
listen socket.

Fixes: 093d282321da ("tproxy: fix hash locking issue when using port redirection in __inet_inherit_port()")
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
---
 net/ipv4/inet_hashtables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 2bbaaf0c7176..006a34b18537 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -163,6 +163,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 				return -ENOMEM;
 			}
 		}
+		inet_csk_update_fastreuse(tb, child);
 	}
 	inet_bind_hash(child, tb, port);
 	spin_unlock(&head->lock);
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>



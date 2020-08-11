Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193FDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E986620781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="eWrDxq9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHKSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgHKSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:33:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92045C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:33:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so14174393ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zkxFcinTHfMj4khM7FG54F6j6yiMTxLIRNiVhh2gB0=;
        b=eWrDxq9VYfwkzuIUjkmxzVxBmNfzYehpg4Y5omNwtjIgzP3B1Q2SzSAckkSgVFPi3/
         t+XmSk/bmitlZN4O83QIKiXXEQntfMF0Uf7eUr0CNuR0QsuLxlV5qwztSpUYq7N5xdv3
         ndA2fBuC6AwKWZOLiYdTTeAY2KDUTiimGFbjqI4LJjoSJEyj4gZlj/5hsn6c7froMd2u
         hhAz9uFBwKWNgcSj+bQuyFIPppd8jY6HdU0IyTW5qIYzGFtXvVKIgHnvcPtkmuh16jDA
         BUqsona4W6fuQRZxkTyOb1i1P/IYue5RRoZDoZDyc8CnNWO7i9FZ5oXB7C0ycqukxoLU
         CWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zkxFcinTHfMj4khM7FG54F6j6yiMTxLIRNiVhh2gB0=;
        b=TglJCXu1YtK0vhMBp7OvdStULlIK84Fm4Wipe2QcwcaZZ/wxOFIwSrXTeEnrJTBh2v
         RV13AxSRM9H8fye3kI/kuYskmHnNZHbFigsUn9pgobL1LcvRivsDX5d7euwhEgBUAMsY
         41rG1z1+YFl+HCTuA6A4k7pfqE3oMKMRaLL9oGYseec5yNQzE1CCK652aRrelocejFX6
         apWu04R4z/rglWmCZogE5ekxTdWnGQtAFq/61u63ZQTmJntiuyiOmB1UexDhoUxvq0UE
         t6S8EaqA+yM/MlKHQ8W7yBnO7FVy5+K/7j4NOO02YKxFlSyw1iVVlw8zMr55kj6cyHuM
         ePfg==
X-Gm-Message-State: AOAM532Zl1azgItnoQn+SC7T9+j5FH5UUM7tLkBivYiQBkSsAo7nJ676
        wSwj3SfuuNwbLXfYwxFoT9hsPxghy+8=
X-Google-Smtp-Source: ABdhPJwQslCBRc/Fs/iAQs3vp3X+/u4tO3njIOup9obJt1YgQQCuCqG6EaaEBhM34ZN0f+dNUXyL4Q==
X-Received: by 2002:a17:907:20e1:: with SMTP id rh1mr9323885ejb.106.1597170819141;
        Tue, 11 Aug 2020 11:33:39 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw14xncxzsvibs41.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:9d04:d01e:8e99:1111])
        by smtp.gmail.com with ESMTPSA id ch24sm15350222ejb.7.2020.08.11.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:33:38 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        KOVACS Krisztian <hidden@balabit.hu>,
        Patrick McHardy <kaber@trash.net>
Cc:     Tim Froidcoeur <tim.froidcoeur@tessares.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/2] net: initialize fastreuse on inet_inherit_port
Date:   Tue, 11 Aug 2020 20:33:24 +0200
Message-Id: <20200811183325.42748-3-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811183325.42748-1-tim.froidcoeur@tessares.net>
References: <20200811183325.42748-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4eb4cd8d20dd..239e54474b65 100644
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


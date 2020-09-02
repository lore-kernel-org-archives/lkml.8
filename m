Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B38FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F96420773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="DNH5Altg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIBOQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgIBOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:06:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B5C061251
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:05:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so5065004edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ms87tpPV92xBIrK+FIwRr75+U/FSoHz11mIuiBxrPvY=;
        b=DNH5AltgSY8a9qXUpBqw27brBXKQscc7pNvF5CWeZVI0Vgl0/fE7HqiUWPKXiw2VtB
         ZQ57MjmmwHbTeGIR6/0BLzFjS7wXwcF7TrjJjjUV1hNYGnEHz4eaYGGiwFaKfFSgaeoe
         4cKBZBB9sE24DiD0f5VjoffAKhLzfOLMgPrEPDjxMX+M+0wPZ5G/gPoy4qBfULEPO9uY
         yrV0DWSQhqEuNfHXT8fyfMQ8/KOmooSAqNujpWcN2LcMW7x02Y8hVbYcJ229yTkXLVue
         xi3hDDv7FvrXzM7E3S7fKB3CkcymDqZ/IMyBd02et+w8rtI1if8qxZfFs0uJhyZOJjK9
         dbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ms87tpPV92xBIrK+FIwRr75+U/FSoHz11mIuiBxrPvY=;
        b=YJU7Oeopj1Ubupdt9K4o3ydaFjlphcIhUzBrjwKzIxs/ySnq+foVFzvFL4MFxy1Z27
         j8CrMNAL7bbgTu8HmeZeRTHPhX0eQJhV9u/ynrIZD2CAEe8Vs3uGavvFpgF+eckcg2+Y
         quV0kLDVP35cjWSR+nTwfz5uWXMdQW+ZnPM12xXwO21dBsk0pafQ67aNw2KUfMeLi7BK
         Z0jDguWcvCN5+6AywPdOEKE87yldy98cV97DRSklV8d7+fNUmmChBbAPuLV6dWHJFgF5
         wweTKL5BYjRkjzvc8GG7iY3w3cCcOFMGsPElINJbzsP1YruRfRf6bEQfAS35OXfhlX3M
         5OIQ==
X-Gm-Message-State: AOAM531OWxZgHCCJ7t7uLPyy0s5QsC1226QXlNq9ARMt0yGWEquDE/rp
        V+pUpFltHO+gOcNRxulxfpZjtDNYf7zB00v4
X-Google-Smtp-Source: ABdhPJwU4/RFcwCT/6MW8VqKMPUyd1Q4rfOckVO1M7ldoyPYS00f319cNKXtA1SMP5UWcJ74nHoNxw==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr211480edq.149.1599055537868;
        Wed, 02 Sep 2020 07:05:37 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw14oqa3w7cibjsc.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:8cba:3abe:17e1:aaec])
        by smtp.gmail.com with ESMTPSA id os15sm4354775ejb.61.2020.09.02.07.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:05:36 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        matthieu.baerts@tessares.net, davem@davemloft.net,
        Tim Froidcoeur <tim.froidcoeur@tessares.net>
Subject: [PATCH 4.4 2/2] net: initialize fastreuse on inet_inherit_port
Date:   Wed,  2 Sep 2020 16:05:13 +0200
Message-Id: <20200902140513.866712-3-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902140513.866712-1-tim.froidcoeur@tessares.net>
References: <20200902140513.866712-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d76f3351cea2d927fdf70dd7c06898235035e84e ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
---
 net/ipv4/inet_hashtables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ccc5980797fc..738cd5c822b1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -160,6 +160,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 				return -ENOMEM;
 			}
 		}
+		inet_csk_update_fastreuse(tb, child);
 	}
 	inet_bind_hash(child, tb, port);
 	spin_unlock(&head->lock);
-- 
2.25.1


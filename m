Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D2C2D0B0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D88204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="YeOG74L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHFGl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgHFGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:41:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1BC06179E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:41:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so31090906edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=PYSsCrOysop+Sh0mOiJ6j1B4kZ/DvpynNkFjKlnFTtk=;
        b=YeOG74L0CWaS4dyv69sqi18DDA3OmbSJyoz5z4Iq4BCQy6J6+W/uFDEvqWXdcSiz71
         PiyO7Y5tjbvPnj+N6Pjgj5S1pO0tFgGm8tbES5Sbqdhc+FnQ2SpGND97Y8aCRgG0Z+Pm
         ikW3m6dkRbpl/6UHdMjBPF0LIkcV56pvKUZKug4Cp8tzUj//ZBPAy+G82GkCDz/ZiWuZ
         51QykkaPw6YE0Cb86WxTqdCg5RJpm8zVY8XY1gBdDt17/pkwhWhY1w4f1VwMzp1spBwZ
         vHezw6durJEeSd72auOjwnRhClKF4yYcxJQ2tIX0aUcYI9qafsEM7TblIX4inpkT2+Cb
         KpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=PYSsCrOysop+Sh0mOiJ6j1B4kZ/DvpynNkFjKlnFTtk=;
        b=RLDa7ondMskJu1vRwOETcAYNZQGyaLaKr0qo5YbfWvPOGeCV1EOtEqOB5a+xCRuudV
         WtjXp0uYQBukkrQo2g95uiQ1PsgWqErGK4/TjL/l1Wy2rlBGE49r/v2WNWPhVGhjSNF3
         ujSbZBJRU6ZRI/XORCN2vygzGL7+dJkrzcfsKu5vmoKoz2R6ViBGwzHMeEJLe1RpNcuq
         bMPDIHPZrIT8FV9MHnPG49I5lGhNc55W9h+z6kt4BWSx9cBqm2/zRFDiA/cJR3RGaLue
         AS6FAFhMb4f8uN68jLToHmRt/AnkoWgRA1Cud2Z1QWqEMFV8WB36vq2Dv8tl7gwkCfhc
         2skw==
X-Gm-Message-State: AOAM53101ASRh7SDpo1sLhfKow/Urtp7Zx91hRgCp83eg2LtSFXmJXnT
        GFOop2Iq1wvO8KTM+nPCwgDxg1kXvsY1zYDld2AlUEhTnXfWaKamwDOLQ062QSUaDaH5EMaq5d+
        73Cs0NmdBgvxDUMfikA==
X-Google-Smtp-Source: ABdhPJzfIEK9tWe/DKDr6hpoSUG7nnY0T65MTIA6Y1Po5B4MvXNS0VAdmc+Wmxzxpx2gXxEXqHr2gA==
X-Received: by 2002:a05:6402:1f8:: with SMTP id i24mr2580851edy.251.1596696078742;
        Wed, 05 Aug 2020 23:41:18 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw15pracyli75x11.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:d05d:939:f42b:f575])
        by smtp.gmail.com with ESMTPSA id h18sm2880984edw.56.2020.08.05.23.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 23:41:18 -0700 (PDT)
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
Subject: [PATCH net 2/2] net: initialize fastreuse on inet_inherit_port
Date:   Thu,  6 Aug 2020 08:41:08 +0200
Message-Id: <20200806064109.183059-3-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806064109.183059-1-tim.froidcoeur@tessares.net>
References: <20200806064109.183059-1-tim.froidcoeur@tessares.net>
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



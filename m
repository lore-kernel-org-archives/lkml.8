Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13868C35277
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CCA204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="znsX4TBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHFGln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFGlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:41:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:41:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o18so49049778eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=hA5JCTqaCCREAuEoCIHIc9jLTAOEK7qQNsr7rDO2FA0=;
        b=znsX4TBfyR5p6MWtCGhXPPD+DRyjOvaJE1NVfd8TuaurE/zcGlPGJrBhwa4gq9QOCl
         yR8WY3AZGrKKdYiIaV0mxgadgXt0TvJjTrr0C0cxrvaM5vT9ODEsfpbZkeEfofFzkZM5
         AZ560eyEC4kzBTm8RAon7PesCtCASvRuSvhE/1lJ4clbb1FUimJBWmzzwEBX6xXmXsn2
         Bp/pRIeNTIH3K83zLWOrMn09spoRLlZ/DQZe+NaL50MiCQmtk5drjVKLlIPXd4TbuiGZ
         sczMaCU9T2GPtL4xpFka18bvECRuBM8Pkq/lOeH+SgXi6gP5jHjelfJ/K46eeN2swKRd
         wUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=hA5JCTqaCCREAuEoCIHIc9jLTAOEK7qQNsr7rDO2FA0=;
        b=JWKvyQnU6qghZQZ0O4mzbeN/8sCkc58iphf/llw2oUJyvDxhuIEpBwH8KM6p+CTCIw
         4EC6VHbeYmnoHqIb5jsPQ+VpBcs6wlSzj5jKrB9JREKwJvgtqgHMSACleBKk6k7dQjNt
         xfTOLS83u93wuSadN+koYVy6d/BNjZWWoaDDqudl3VqlqiA9+nVWkvyjGfXzlpsf8gHa
         fCxjWFF3YY5PVLPVG8XryHQzw0Mu3U8LhZdLCNWDC0c0JQDuSff3w+9YlFMGlf8J6Dkf
         J+CAhcC1nk7rnoeQsjScNlPduAwriKabQ/JiJNZQC+7aE8Uy711agbOJEvtX7MJAg0oK
         nA9A==
X-Gm-Message-State: AOAM531SBNl1xFFjrigHt8jzYcUfUjeZ+adz2TncgjUYUOSle9IVf5jy
        UdZuKGd+ow/CwwrNjXK5xiW4LIf3/K+zJ2CcyCrRIcTbfp4Tm0kRylXXVQNoZ2hdHU/uaym9s9i
        2kaMPJg6GjkIapxisbQ==
X-Google-Smtp-Source: ABdhPJx36tiST5AcBE4fms9ytZlygeNek5jU38om01yv8EofclOiCTv1Z38KD4nfsreMho4H3f96jw==
X-Received: by 2002:a17:906:7253:: with SMTP id n19mr3006802ejk.387.1596696073363;
        Wed, 05 Aug 2020 23:41:13 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw15pracyli75x11.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:d05d:939:f42b:f575])
        by smtp.gmail.com with ESMTPSA id h18sm2880984edw.56.2020.08.05.23.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 23:41:12 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        KOVACS Krisztian <hidden@balabit.hu>,
        Patrick McHardy <kaber@trash.net>
Cc:     Tim Froidcoeur <tim.froidcoeur@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: initialize fastreuse on inet_inherit_port
Date:   Thu,  6 Aug 2020 08:41:06 +0200
Message-Id: <20200806064109.183059-1-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
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

Patch 1/2 refactors the fastreuse update code in inet_csk_get_port into a
small helper function, making the actual fix tiny and easier to understand. 

Patch 2/2 calls this new helper when __inet_inherit_port decides to create
a new bind_bucket or use a different bind_bucket than the one of the listen
socket.

Tim Froidcoeur (2):
  net: refactor bind_bucket fastreuse into helper
  net: initialize fastreuse on inet_inherit_port

 include/net/inet_connection_sock.h |  4 ++
 net/ipv4/inet_connection_sock.c    | 99 ++++++++++++++++--------------
 net/ipv4/inet_hashtables.c         |  1 +
 3 files changed, 59 insertions(+), 45 deletions(-)

-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>



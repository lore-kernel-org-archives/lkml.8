Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB80AC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9144824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271864;
	bh=AxKfZmAdFXCPVhMsF/7rjFQ7ZLiEFxpynnsIU06lQ8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hzbvCLi93IqSklv6rK00ETKcoV7uUUkpzkryH0v4Ty9gQCaxNh0Yb8kh+JJTL7mYY
	 q5baN1Z9bDjfbLwqmY4wYhF9Z9I8p8324V+7GDWpl8lO0DYGp9972PnEdo5auZnSEf
	 ebPPPnNt2EmPB/cieDUk/KjyD5P5aMCLUuuxjnYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgBUH5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbgBUH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:57:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D6B24670;
        Fri, 21 Feb 2020 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271857;
        bh=AxKfZmAdFXCPVhMsF/7rjFQ7ZLiEFxpynnsIU06lQ8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZcC3Vao0dtw0PJZzm0CeTY045MrLAAqdw830oJyJZskXQvHldH9+pwgEKx9aHwZj
         2y8I656NRKQ/Bs/gOHL0yAY3NA2lPG6hKcxNF0gIr20qVdULPre35eaCpm8kQQpwZQ
         RUgHR6FsSwcUtiU2RfATS6XHA3FC05KhnbFxKE4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 325/399] sunrpc: Fix potential leaks in sunrpc_cache_unhash()
Date:   Fri, 21 Feb 2020 08:40:50 +0100
Message-Id: <20200221072432.870451402@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit 1d82163714c16ebe09c7a8c9cd3cef7abcc16208 ]

When we unhash the cache entry, we need to handle any pending upcalls
by calling cache_fresh_unlocked().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index f740cb51802af..7ede1e52fd812 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1888,7 +1888,9 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
 	if (!hlist_unhashed(&h->cache_list)){
 		hlist_del_init_rcu(&h->cache_list);
 		cd->entries--;
+		set_bit(CACHE_CLEANED, &h->flags);
 		spin_unlock(&cd->hash_lock);
+		cache_fresh_unlocked(h, cd);
 		cache_put(h, cd);
 	} else
 		spin_unlock(&cd->hash_lock);
-- 
2.20.1




Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70922C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C4120722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6Kq5LL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBUT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:59:34 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:35988 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:59:33 -0500
Received: by mail-yb1-f202.google.com with SMTP id m62so2498835ybc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RAIlg0f7zdLpk9f1Byl/cwdgiwxUwp6aSHTCC3RY/oM=;
        b=v6Kq5LL08ClIooNXUY3nDPFgWPI70VdsrwNaD3pbavipoxOiOoJyBhjmpWp2d+htUB
         m12EesD8fukKMUJgNl4xdfmT5c4OuYOuWvovtiV/dIcx06EuCYYHAaYKg+UbNAUEEzSM
         ONFjph/fYxjmElgTODoeSFzmqW+oSCSmZ8ZawNY1iqbXHr5bruclTHeD11A4dQjQfXGw
         49pd1mMKkQG1ID5JtkSlnlZlPqYRvQTiR9HOKLRd7gC03H5pOmZPXoCOy0yDYXMIiDm1
         da5HxInP1D2BW9gLZlZZGSQYD0BGCRoO0uuaIEUAEBJfFHICupfExZrs6Xfln9y7SURv
         PJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RAIlg0f7zdLpk9f1Byl/cwdgiwxUwp6aSHTCC3RY/oM=;
        b=icDpAnEi6hDjkFTZuKBEJvcH5C0HGNBTV6GUqN0ggPngoUklNhunF7SQgYFIzzFEtj
         llcMwE8C570UXnzVTmZnDzwLHnujj/6FsNMdnJHVy1sIGk8lk7mQxhYLDViZ/JQFStKy
         t/9fCaYhJyHBPueoxQdrjWziIkWhEH/hudWGLq+JlajXdnBe826TZcQBL2BQAqbknMGH
         m/xCAMRQNP1P/Dgh8Hxpxx1xzhT2pOnCK+Ks1d06Rjlz++B6Q5Ojdp/i+TGHoxQa+zmN
         I3wgBnQD47W/luahgF/db+HRl2GyFdS01EEDsaZkBYKaBcTqMPD8YMKWDZuD/k3vGOQz
         xb/w==
X-Gm-Message-State: APjAAAWA3ANp7oinVHOihjBah2aDNOojNJswfBX+9IwA5uTS2lFQA2k1
        +wgKAqS+BLsedJ4WhWUQ75wr5Zvt39Xpxg==
X-Google-Smtp-Source: APXvYqxjnxy+eZRYTRVN8mAGrdTES2zjvK9Gx/bLaPZ5OB6bYfhHJPW6A8a13wzgYYHT2Kphl/2XA9Pmpmnu2Q==
X-Received: by 2002:a0d:c905:: with SMTP id l5mr29812030ywd.44.1582315171205;
 Fri, 21 Feb 2020 11:59:31 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:59:19 -0800
Message-Id: <20200221195919.186576-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] memcg: css_tryget_online cleanups
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently multiple locations in memcg code, css_tryget_online() is being
used. However it doesn't matter whether the cgroup is online for the
callers. Online used to matter when we had reparenting on offlining and
we needed a way to prevent new ones from showing up.

The failure case for couple of these css_tryget_online usage is to
fallback to root_mem_cgroup which kind of make bypassing the memcg
limits possible for some workloads. For example creating an inotify
group in a subcontainer and then deleting that container after moving the
process to a different container will make all the event objects
allocated for that group to the root_mem_cgroup. So, using
css_tryget_online() is dangerous for such cases.

Two locations still use the online version. The swapin of offlined
memcg's pages and the memcg kmem cache creation. The kmem cache indeed
needs the online version as the kernel does the reparenting of memcg
kmem caches. For the swapin case, it has been left for later as the
fallback is not really that concerning.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..75fa8123909e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -656,7 +656,7 @@ __mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	 */
 	__mem_cgroup_remove_exceeded(mz, mctz);
 	if (!soft_limit_excess(mz->memcg) ||
-	    !css_tryget_online(&mz->memcg->css))
+	    !css_tryget(&mz->memcg->css))
 		goto retry;
 done:
 	return mz;
@@ -962,7 +962,8 @@ struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 		return NULL;
 
 	rcu_read_lock();
-	if (!memcg || !css_tryget_online(&memcg->css))
+	/* Page should not get uncharged and freed memcg under us. */
+	if (!memcg || WARN_ON(!css_tryget(&memcg->css)))
 		memcg = root_mem_cgroup;
 	rcu_read_unlock();
 	return memcg;
@@ -975,10 +976,13 @@ EXPORT_SYMBOL(get_mem_cgroup_from_page);
 static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
 {
 	if (unlikely(current->active_memcg)) {
-		struct mem_cgroup *memcg = root_mem_cgroup;
+		struct mem_cgroup *memcg;
 
 		rcu_read_lock();
-		if (css_tryget_online(&current->active_memcg->css))
+		/* current->active_memcg must hold a ref. */
+		if (WARN_ON(!css_tryget(&current->active_memcg->css)))
+			memcg = root_mem_cgroup;
+		else
 			memcg = current->active_memcg;
 		rcu_read_unlock();
 		return memcg;
@@ -6703,7 +6707,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
 		goto out;
-	if (css_tryget_online(&memcg->css))
+	if (css_tryget(&memcg->css))
 		sk->sk_memcg = memcg;
 out:
 	rcu_read_unlock();
-- 
2.25.0.265.gbab2e86ba0-goog


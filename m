Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D62CC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51920705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgAaMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:09:47 -0500
Received: from relay.sw.ru ([185.231.240.75]:45418 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgAaMJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:09:47 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ixV76-0000Sj-VH; Fri, 31 Jan 2020 15:09:33 +0300
Subject: [PATCH] mm: Allocate shrinker_map on appropriate NUMA node
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
        shakeelb@google.com, vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Fri, 31 Jan 2020 15:09:32 +0300
Message-ID: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite shrinker_map may be touched from any cpu
(e.g., a bit there may be set by a task running
everywhere); kswapd is always bound to specific
node. So, we will allocate shrinker_map from
related NUMA node to respect its NUMA locality.
Also, this follows generic way we use for allocation
memcg's per-node data.

Two hunks node_state() patterns are borrowed from
alloc_mem_cgroup_per_node_info().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..8ccc8ceb1b17 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -323,7 +323,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 					 int size, int old_size)
 {
 	struct memcg_shrinker_map *new, *old;
-	int nid;
+	int nid, tmp;
 
 	lockdep_assert_held(&memcg_shrinker_map_mutex);
 
@@ -333,8 +333,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
-
-		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		/* See comment in alloc_mem_cgroup_per_node_info()*/
+		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : - 1;
+		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
 		if (!new)
 			return -ENOMEM;
 
@@ -370,7 +371,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 {
 	struct memcg_shrinker_map *map;
-	int nid, size, ret = 0;
+	int nid, size, tmp, ret = 0;
 
 	if (mem_cgroup_is_root(memcg))
 		return 0;
@@ -378,7 +379,9 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	mutex_lock(&memcg_shrinker_map_mutex);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
-		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		/* See comment in alloc_mem_cgroup_per_node_info()*/
+		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : - 1;
+		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, tmp);
 		if (!map) {
 			memcg_free_shrinker_maps(memcg);
 			ret = -ENOMEM;



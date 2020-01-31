Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72113206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgAaQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:09:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:54864 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgAaQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:09:00 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ixYqf-00030w-Uk; Fri, 31 Jan 2020 19:08:50 +0300
Subject: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
 <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
 <20200131160151.GB4520@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
Date:   Fri, 31 Jan 2020 19:08:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131160151.GB4520@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm: Allocate shrinker_map on appropriate NUMA node

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Despite shrinker_map may be touched from any cpu
(e.g., a bit there may be set by a task running
everywhere); kswapd is always bound to specific
node. So, we will allocate shrinker_map from
related NUMA node to respect its NUMA locality.
Also, this follows generic way we use for allocation
memcg's per-node data.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

v3: Remove node_state() patterns.
v2: Use NUMA_NO_NODE instead of -1.
---
 mm/memcontrol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..c37382f5a43c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -334,7 +334,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 		if (!old)
 			return 0;
 
-		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
 		if (!new)
 			return -ENOMEM;
 
@@ -378,7 +378,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	mutex_lock(&memcg_shrinker_map_mutex);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
-		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
 			memcg_free_shrinker_maps(memcg);
 			ret = -ENOMEM;

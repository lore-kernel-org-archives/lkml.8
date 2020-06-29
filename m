Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A85C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1695B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467268;
	bh=Zqude5qnOBHirtcGbn+BkrWVsEzMD4IgtxHeVuUXb3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=niycpuhMYf3NBDabye7Cd8X7mwqbEpR9x/Ao+JXQDTk6WXN6XAFIOFCEm9yvAZzeJ
	 Iihp++mfEHVWBB3W/ROQjw4zUnvbp/szjjsLjS0m8lcc7s1I6kPjuso07h+rqhUMOC
	 Yp5v5L8xplN0YWqPxZzciJr4Jwq+EHMoqIpPkpyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbgF2Vrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgF2Sfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498C5247C1;
        Mon, 29 Jun 2020 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444129;
        bh=Zqude5qnOBHirtcGbn+BkrWVsEzMD4IgtxHeVuUXb3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qY+fwUHSpn/TPC9Ory3EUlG87T2sB/szLoSAPniEASxguE1jmbAX5Uap3EGTgXokJ
         a2U+bkV+qnAXj49b/N99BkxnW6/JNLOp8Up9c40KBoPnu+9CjarSDJ3P2lNNn1anQz
         Rz/jm35XyfTmZdvl26QI3vz8OeqOzUchCyLObbZc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 236/265] mm/memcontrol.c: add missed css_put()
Date:   Mon, 29 Jun 2020 11:17:49 -0400
Message-Id: <20200629151818.2493727-237-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muchun Song <songmuchun@bytedance.com>

commit 3a98990ae2150277ed34d3b248c60e68bf2244b2 upstream.

We should put the css reference when memory allocation failed.

Link: http://lkml.kernel.org/r/20200614122653.98829-1-songmuchun@bytedance.com
Fixes: f0a3a24b532d ("mm: memcg/slab: rework non-root kmem_cache lifecycle management")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b05e25d8aef2..ef0e291a8cf46 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2790,8 +2790,10 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 		return;
 
 	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
-	if (!cw)
+	if (!cw) {
+		css_put(&memcg->css);
 		return;
+	}
 
 	cw->memcg = memcg;
 	cw->cachep = cachep;
-- 
2.25.1


Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF6821D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIHIMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:12:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45341 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729257AbgIHIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:12:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U8ISuh._1599552733;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8ISuh._1599552733)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Sep 2020 16:12:13 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: no one use charge_type
Date:   Tue,  8 Sep 2020 16:12:07 +0800
Message-Id: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 0a31bc97c80c3f mm: memcontrol: rewrite uncharge API, no one
using MEM_CGROUP_CHARGE_TYPE_xxx, let's remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: cgroups@vger.kernel.org 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/memcontrol.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d52b8a88bea..d925905920bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -199,14 +199,6 @@ struct mem_cgroup_event {
 #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
 #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
 
-enum charge_type {
-	MEM_CGROUP_CHARGE_TYPE_CACHE = 0,
-	MEM_CGROUP_CHARGE_TYPE_ANON,
-	MEM_CGROUP_CHARGE_TYPE_SWAPOUT,	/* for accounting swapcache */
-	MEM_CGROUP_CHARGE_TYPE_DROP,	/* a page was unused swap cache */
-	NR_CHARGE_TYPE,
-};
-
 /* for encoding cft->private value on file */
 enum res_type {
 	_MEM,
-- 
1.8.3.1


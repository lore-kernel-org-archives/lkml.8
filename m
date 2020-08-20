Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5789E207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJ9K69ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgHTNEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:04:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729252AbgHTNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597928656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9Qlf4jXoP5jt/C4m3Gv4DFULDSZN0cJYKBX7J86Hq4I=;
        b=dJ9K69apAqkL0vO5C4TdxJp07+o+lN8E1p5rDeqrOv6vVv7x340i1wEl8U4LxbadBf/yuL
        3NQ4VVMViYo1oPAWfLt2XCufybliOouJbfYrjCAtsEFd4V/UR86Q6FMs/srlLRqtUefUbQ
        zaQ/6A2zqecO7zw7JSFTQUrQ15Kd18w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Ip-RVODANsqHupFz5vvTlg-1; Thu, 20 Aug 2020 09:04:12 -0400
X-MC-Unique: Ip-RVODANsqHupFz5vvTlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 013441006702;
        Thu, 20 Aug 2020 13:04:11 +0000 (UTC)
Received: from llong.com (unknown [10.10.115.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8DE69C9D;
        Thu, 20 Aug 2020 13:04:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] mm/memcg: Clean up obsolete enum charge_type
Date:   Thu, 20 Aug 2020 09:03:48 -0400
Message-Id: <20200820130350.3211-2-longman@redhat.com>
In-Reply-To: <20200820130350.3211-1-longman@redhat.com>
References: <20200820130350.3211-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
enum charge_type was no longer used anywhere. However, the enum itself
was not removed at that time. Remove the obsolete enum charge_type now.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..26b7a48d3afb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -197,14 +197,6 @@ static struct move_charge_struct {
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
2.18.1


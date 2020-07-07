Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21412C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C7206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyRqItPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGGVij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgGGVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:38:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FCC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:38:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j80so39650290qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=86ZO0cDUMoFRuQFL1rAuMjsl3l6Acwgz3uk4qfYDTYw=;
        b=fyRqItPO3JMzl5UDYTAG3aDxi1u1Zt9gxagsbBYONe2VYOkTXrvOxV9OxonWeofXTR
         vnmLUGaW4hRzibnGl/5JFMXpFkWZY0wXAxajpYmGcAKooeoHcbgdVQkp86VuWSjLt4HO
         ltAXffK1FBIb/mmNBkZz5ugvlYqOCmx1wTUoTQWLrAYWmKQZU79luODl7ifDKTX9E5/0
         o3i+4WxTh2YSdP5RrnZmhyj/s+f0Pen/sh0c4p5LOUv2K8qiAx1xnSNKXTs9BDJu022l
         qiHm03WzbshWw2HbpRFpvbm6Qy+TdL8lmMudjOwWWAy1Ckn7DFDUve5wBZYXenxETYXL
         C/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=86ZO0cDUMoFRuQFL1rAuMjsl3l6Acwgz3uk4qfYDTYw=;
        b=Vtv/gvbV+GEkmGmgSMzEJ9oUb8G9TOK7c4RCDTXADdczH8HNl9DAmG3bzjB4x0JRJk
         2yHewqyHYqt0Jy1amB7vXxOQhiH456L/7JiCH0Tjj/1VT9qgVK9SlvQZ3xT/3XF6lhFI
         nWyd5fqLAMd4vv2OUrqUUgzhUjipsLXb5DQJsXZ2OtZMF7zx5BdyauZynVcPDkfr0wrk
         pJ553xmpNnC9e/5y4wwlRZFsvrNNNnz5HB0FmieNoW5ul0+Ep+TMlDUnxGaBN1Sp22E0
         9uIpOWqt6NthUeHW096JGRpN++v9iH+AoW5rslvFrPCBhOdO0JHOh6btvo2TV5pTk9pd
         Zd/Q==
X-Gm-Message-State: AOAM5307/IyxIcwQ+pnM4rSh26Oq3eSTge3gBEOHtD0OUJnhItjd/XOW
        RPtaR5Hx8eUU20duw0PpF9oP3ZUO+Ow=
X-Google-Smtp-Source: ABdhPJyKszth8tMIh6pR8yN8ofbc6P/8A7gz4EHsL6ItN6YAaqlN/yFzMzgexhDoqfLyvZIwxxJyOA==
X-Received: by 2002:a37:4289:: with SMTP id p131mr24422127qka.28.1594157917451;
        Tue, 07 Jul 2020 14:38:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o12sm26346467qtl.48.2020.07.07.14.38.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2020 14:38:36 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:38:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/memcg: fix refcount error while moving and swapping
Message-ID: <alpine.LSU.2.11.2007071431050.4726@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was hard to keep a test running, moving tasks between memcgs with
move_charge_at_immigrate, while swapping: mem_cgroup_id_get_many()'s
refcount is discovered to be 0 (supposedly impossible), so it is then
forced to REFCOUNT_SATURATED, and after thousands of warnings in quick
succession, the test is at last put out of misery by being OOM killed.

This is because of the way moved_swap accounting was saved up until the
task move gets completed in __mem_cgroup_clear_mc(), deferred from when
mem_cgroup_move_swap_account() actually exchanged old and new ids.
Concurrent activity can free up swap quicker than the task is scanned,
bringing id refcount down 0 (which should only be possible when offlining).

Just skip that optimization: do that part of the accounting immediately.

Fixes: 615d66c37c75 ("mm: memcontrol: fix memcg id ref counter on swap charge move")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
This was frustrating while testing Alex Shi's patches a few weeks
ago, and no fault of those.  I may have misattributed the "Fixes",
which was itself fixing an earlier, which were both backported to v3.19;
or maybe it goes back way further than those, I didn't pursue it - not
top of the list of user complaints!  Certainly goes back before the
refcount_add() in v4.20, which replaced a VM_BUG_ON(atomic_read <= 0).

 mm/memcontrol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 5.8-rc4/mm/memcontrol.c	2020-06-28 15:52:13.360672658 -0700
+++ linux/mm/memcontrol.c	2020-07-05 18:11:51.136542439 -0700
@@ -5669,7 +5669,6 @@ static void __mem_cgroup_clear_mc(void)
 		if (!mem_cgroup_is_root(mc.to))
 			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
 
-		mem_cgroup_id_get_many(mc.to, mc.moved_swap);
 		css_put_many(&mc.to->css, mc.moved_swap);
 
 		mc.moved_swap = 0;
@@ -5860,7 +5859,8 @@ put:			/* get_mctgt_type() gets the page
 			ent = target.ent;
 			if (!mem_cgroup_move_swap_account(ent, mc.from, mc.to)) {
 				mc.precharge--;
-				/* we fixup refcnts and charges later. */
+				mem_cgroup_id_get_many(mc.to, 1);
+				/* we fixup other refcnts and charges later. */
 				mc.moved_swap++;
 			}
 			break;

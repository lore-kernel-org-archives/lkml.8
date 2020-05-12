Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48425C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1985220722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCwr5v5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgELOG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgELOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:06:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1883C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pKb7TBlLHJxHT49BEZUwW80DII8+mBmNWxxoWsxXBxI=; b=LCwr5v5lNheIrqZTGzNsVqnRkd
        ZUGQj6kgJuWhpLZBrclbQ/F/npSJSXv3dDO413T6PfTvIWGCGtM9EVH7mpk0EKkyz3fHCfJSJQAVl
        2tJuZOFNwyoDQpooxdbGrlf0KfCv3bCw/cxlYz5N5UbLnLQBCrFMk7JVLf/msluUOTHSmVCQGOtSD
        XztDM/sqjJFP/gtOHKFYDNv0LH7qTLt19iB3dTi/FEJbbKnzoyaownBqdNPrIhbuTmM7rAAHwG9kI
        cB3+Q44ZMUF93DONv11zeB+Zi8jfdTP7fJWsuy+VVvwdfXE9hoQ6AiUXM/yrZV+T/2Bg3y2h7Dn1+
        x5DsroYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYVYa-0003uG-6G; Tue, 12 May 2020 14:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A7083011E6;
        Tue, 12 May 2020 16:06:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A3D620962E25; Tue, 12 May 2020 16:06:50 +0200 (CEST)
Date:   Tue, 12 May 2020 16:06:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200512140650.GJ2978@hirez.programming.kicks-ass.net>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
 <20200511204410.GI13245@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511204410.GI13245@lorien.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 04:44:10PM -0400, Phil Auld wrote:
> Peter/Ingo, do you want me to resend or can you fix when applying?

I now have this, do I need more edits?

---

Subject: sched/fair: Fix enqueue_task_fair warning some more
From: Phil Auld <pauld@redhat.com>
Date: Thu, 7 May 2020 16:36:12 -0400

From: Phil Auld <pauld@redhat.com>

sched/fair: Fix enqueue_task_fair warning some more

The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
did not fully resolve the issues with the rq->tmp_alone_branch !=
&rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
the first for_each_sched_entity loop exits due to on_rq, having incompletely
updated the list.  In this case the second for_each_sched_entity loop can
further modify se. The later code to fix up the list management fails to do
what is needed because se no longer points to the sched_entity which broke
out of the first loop.

Address this by calling list_add_leaf_cfs_rq if there are throttled
parents while doing the second for_each_sched_entity loop.

Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20200507203612.GF19331@lorien.usersys.redhat.com
---
 kernel/sched/fair.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
+
+               /*
+                * One parent has been throttled and cfs_rq removed from the
+                * list. Add it back to not break the leaf list.
+                */
+               if (throttled_hierarchy(cfs_rq))
+                       list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 enqueue_throttle:

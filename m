Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4B214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgAaRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:49:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgAaRtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:49:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA393AF73;
        Fri, 31 Jan 2020 17:49:36 +0000 (UTC)
Date:   Fri, 31 Jan 2020 09:39:22 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] locking/rtmutex: remove unused cmpxchg_relaxed
Message-ID: <20200131173922.hjvugxuybrn2wbsn@linux-p48b>
References: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing tglx.

On Tue, 21 Jan 2020, Alex Shi wrote:

>No one use this macro after it was introduced. Better to remove it?

You also need to remove it for the CONFIG_DEBUG_RT_MUTEXES=y case.

>
>Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Will Deacon <will@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>---
> kernel/locking/rtmutex.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>index 851bbb10819d..a849964a348d 100644
>--- a/kernel/locking/rtmutex.c
>+++ b/kernel/locking/rtmutex.c
>@@ -141,7 +141,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
>  * set up.
>  */
> #ifndef CONFIG_DEBUG_RT_MUTEXES
>-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
> # define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
> # define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)

Hmm unrelated, but do we want CCAS for rtmutex fastpath? Ie:

     (l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)

That would optimize for the contended case and avoid the cmpxchg - it would
also help if we ever do the top-waiter spin thing.

Thanks,
Davidlohr

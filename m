Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63101C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41197206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgBLPS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:18:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:45032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBLPS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:18:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92B19AE64;
        Wed, 12 Feb 2020 15:18:54 +0000 (UTC)
Date:   Wed, 12 Feb 2020 07:07:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: remove unused cmpxchg_relaxed
Message-ID: <20200212150756.vmehbn3znt6tnp3t@linux-p48b>
References: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200131173922.hjvugxuybrn2wbsn@linux-p48b>
 <87r1zfxtne.fsf@nanos.tec.linutronix.de>
 <87c1cdbc-6af0-3f56-e986-b9df894fe4da@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87c1cdbc-6af0-3f56-e986-b9df894fe4da@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Feb 2020, Alex Shi wrote:

>Thanks Thomas and David!
>Is this following patch ok?

So if anything, this really wants to be two patches.

>---
>From 4cf9e38a73c67c6894f3addb2ddca26bb51b1a28 Mon Sep 17 00:00:00 2001
>From: Alex Shi <alex.shi@linux.alibaba.com>
>Date: Tue, 21 Jan 2020 15:03:33 +0800
>Subject: [PATCH v2] locking/rtmutex: optimize rt_mutex_cmpxchg_xxx series func
>
>rt_mutex_cmpxchg_relexed isn't interested by anyone, so remove it.
>And Davidlohr Bueso suggests check l->owner before cmpxchg to reduce
>lock contention.
>
>Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Will Deacon <will@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>---
> kernel/locking/rtmutex.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>index 851bbb10819d..eb26f4e57ce4 100644
>--- a/kernel/locking/rtmutex.c
>+++ b/kernel/locking/rtmutex.c
>@@ -141,9 +141,10 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
>  * set up.
>  */
> #ifndef CONFIG_DEBUG_RT_MUTEXES
>-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
>-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
>-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
>+# define rt_mutex_cmpxchg_acquire(l,c,n)	\
>+		(l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
>+# define rt_mutex_cmpxchg_release(l,c,n)	\
>+		(l->owner == c && cmpxchg_release(&l->owner, c, n) == c)

Thomas, should I resend the top-waiter spin series? Otherwise yeah,
I see little point to the CCAS fastpath thing.

Thanks,
Davidlohr

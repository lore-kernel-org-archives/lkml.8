Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11455C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCB20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgBDKSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:18:10 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41231 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbgBDKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:18:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tp874Rw_1580811484;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tp874Rw_1580811484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Feb 2020 18:18:05 +0800
Subject: Re: [PATCH] locking/rtmutex: remove unused cmpxchg_relaxed
To:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200131173922.hjvugxuybrn2wbsn@linux-p48b>
 <87r1zfxtne.fsf@nanos.tec.linutronix.de>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <87c1cdbc-6af0-3f56-e986-b9df894fe4da@linux.alibaba.com>
Date:   Tue, 4 Feb 2020 18:18:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1zfxtne.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/2/1 ÉÏÎç4:23, Thomas Gleixner Ð´µÀ:
> Davidlohr Bueso <dave@stgolabs.net> writes:
>> On Tue, 21 Jan 2020, Alex Shi wrote:
> 
>   Subject: locking/rtmutex: remove unused cmpxchg_relaxed
> 
> should be
> 
>   Subject: locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()
> 
> You're not removing cmpxchg_relaxed, right?
> 
>>> No one use this macro after it was introduced. Better to remove it?
> 
> Please make that factual.
> 
>  The macro was never used at all. Remove it.
> 
>> You also need to remove it for the CONFIG_DEBUG_RT_MUTEXES=y case.
> 
> Yes.
> 
>> Hmm unrelated, but do we want CCAS for rtmutex fastpath? Ie:
>>
>>      (l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
>>
>> That would optimize for the contended case and avoid the cmpxchg - it would
>> also help if we ever do the top-waiter spin thing.
> 
> Not sure if it buys much, but it kinda makes sense.
> 
> Thanks,
> 
>         tglx
> 
Thanks Thomas and David!
Is this following patch ok?

Thanks
Alex
---
From 4cf9e38a73c67c6894f3addb2ddca26bb51b1a28 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 21 Jan 2020 15:03:33 +0800
Subject: [PATCH v2] locking/rtmutex: optimize rt_mutex_cmpxchg_xxx series func

rt_mutex_cmpxchg_relexed isn't interested by anyone, so remove it.
And Davidlohr Bueso suggests check l->owner before cmpxchg to reduce
lock contention.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/locking/rtmutex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 851bbb10819d..eb26f4e57ce4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,9 +141,10 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
+# define rt_mutex_cmpxchg_acquire(l,c,n)	\
+		(l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
+# define rt_mutex_cmpxchg_release(l,c,n)	\
+		(l->owner == c && cmpxchg_release(&l->owner, c, n) == c)
 
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we force
@@ -202,7 +203,6 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-# define rt_mutex_cmpxchg_relaxed(l,c,n)	(0)
 # define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
 # define rt_mutex_cmpxchg_release(l,c,n)	(0)
 
-- 
1.8.3.1


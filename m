Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A77C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC5246B1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HdE+OffD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgASDHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:07:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgASDH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lKx256qV42VUfcJn3Q/aWjf3VjkERjdSMK72eHx0NVw=; b=HdE+OffDBMWufdUf4KF4uzfkT
        ATug0N8+7YE9PqDYKwMpuGS3nTYrFGm8JIJMryUkXl2+TWqHN1jmUN8Mur3zUmqc2WFEyMuXm+9Ef
        hrBiyW32SQ2YUosqZxWGMtoKj5rtO1VvJVnypY6gc00NvF+7W6P2NN1Pi6tPTSedIuUB+jCSwr6vd
        la+l6R8+FHFj4R6br9bdGZthtaVqQsuHauAGOKCIDT4xpw0rRezVyZ3jriN9fvMEc1SscGKEnkr7V
        UvnaiqLHZ+/Cagpnt+2/mDhF6vMGj5cQ75qWV8eHm5M1dyO1fZcn3wbdqr07CC7mDBpQU1BzUOv1f
        2ND2pyeTg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it0vb-00077H-To; Sun, 19 Jan 2020 03:07:08 +0000
Subject: Re: [PATCH] workqueue: Document (some) memory-ordering properties of
 {queue,schedule}_work()
To:     Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20200118215820.7646-1-parri.andrea@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <86f582c3-6029-890f-6d63-d51b9d1274f2@infradead.org>
Date:   Sat, 18 Jan 2020 19:07:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200118215820.7646-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/20 1:58 PM, Andrea Parri wrote:
> It's desirable to be able to rely on the following property:  All stores
> preceding (in program order) a call to a successful queue_work() will be
> visible from the CPU which will execute the queued work by the time such
> work executes, e.g.,
> 
>   { x is initially 0 }
> 
>     CPU0                              CPU1
> 
>     WRITE_ONCE(x, 1);                 [ "work" is being executed ]
>     r0 = queue_work(wq, work);          r1 = READ_ONCE(x);
> 
>   Forbids: r0 == true && r1 == 0
> 
> The current implementation of queue_work() provides such memory-ordering
> property:
> 
>   - In __queue_work(), the ->lock spinlock is acquired.
> 
>   - On the other side, in worker_thread(), this same ->lock is held
>     when dequeueing work.
> 
> So the locking ordering makes things work out.
> 
> Add this property to the DocBook headers of {queue,schedule}_work().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  include/linux/workqueue.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 4261d1c6e87b1..4fef6c38b0536 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -487,6 +487,19 @@ extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
>   *
>   * We queue the work to the CPU on which it was submitted, but if the CPU dies
>   * it can be processed by another CPU.
> + *
> + * Memory-ordering properties:  If it returns %true, guarantees that all stores
> + * preceding the call to queue_work() in the program order will be visible from
> + * the CPU which will execute @work by the time such work executes, e.g.,
> + *
> + * { x is initially 0 }
> + *
> + *   CPU0				CPU1
> + *
> + *   WRITE_ONCE(x, 1);			[ @work is being executed ]
> + *   r0 = queue_work(wq, work);		  r1 = READ_ONCE(x);
> + *
> + * Forbids: r0 == true && r1 == 0
>   */
>  static inline bool queue_work(struct workqueue_struct *wq,
>  			      struct work_struct *work)
> @@ -546,6 +559,9 @@ static inline bool schedule_work_on(int cpu, struct work_struct *work)
>   * This puts a job in the kernel-global workqueue if it was not already
>   * queued and leaves it in the same position on the kernel-global
>   * workqueue otherwise.
> + *
> + * Shares the same memory-ordering properties of queue_work(), c.f., the

nit:                                                              cf. the

> + * DocBook header of queue_work().
>   */
>  static inline bool schedule_work(struct work_struct *work)
>  {
> 


-- 
~Randy


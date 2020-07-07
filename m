Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B901206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGGJGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:06:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGJGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 454C6AF6E;
        Tue,  7 Jul 2020 09:06:23 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:06:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, tj@kernel.org, akpm@linux-foundation.org,
        naresh.kamboju@linaro.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kthread: Work could not be queued when worker being
 destroyed
Message-ID: <20200707090621.GC4087@alley>
References: <20200706054647.5344-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706054647.5344-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-07-06 13:46:47, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> Before the work is put into the queue of the worker thread,
> the state of the worker thread needs to be detected,because
> the worker thread may be in the destruction state at this time.
> 
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

This patch is completely different from the one that I suggested
or acked. Please, never keep acks when doing major rework and
people did not agree with it.

For this patch:

Nacked-by: Petr Mladek <pmladek@suse.com>

See below why.


> ---
>  v1->v2:
>  Add warning information for condition "!worker->task".
>  v2->v3:
>  Modify submission information and add "Reviewed-by" tags.
>  v3->v4:
>  Fix spi controller register trigger Warning.
>  when a spi controller register, a "kthread_worker_fn" worker is created
>  through "kthread_run" instead of "kthread_create_worker" which in this
>  func the "worker->task" will be initialized. and then the "spi_start_queue"
>  func queue a work to worker queue, at this time, if the worker has not
>  begin to running, the "!worker->task" will be true, so a warning is triggered.
> 
>  kernel/kthread.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index bfbfa481be3a..825bd4dcdb95 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -791,6 +791,11 @@ static inline bool queuing_blocked(struct kthread_worker *worker,
>  {
>  	lockdep_assert_held(&worker->lock);
>  
> +	if (kthread_should_stop()) {

This does not make much sense.

kthread_should_stop() checks a flag set for the "current" process.
It works only when called from inside the kthread worker thread.

queuing_blocked() is called from kthread_queue_work()
or kthread_queue_delayed_work(). These are typically
called from another process. The only exception is when
they get re-queued from inside the work.

Best Regards,
Petr


> +		WARN_ON(1);
> +		return true;
> +	}
> +
>  	return !list_empty(&work->node) || work->canceling;
>  }
>  
> -- 
> 2.24.1

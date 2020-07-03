Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9EAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EFA206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGCILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:11:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCILj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 746D6B5E7;
        Fri,  3 Jul 2020 08:11:38 +0000 (UTC)
Date:   Fri, 3 Jul 2020 10:11:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: work could not be queued when worker being
 destroyed
Message-ID: <20200703081136.GD11587@alley>
References: <20200702044946.33142-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702044946.33142-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-02 12:49:46, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> The queuing_blocked func should returns true when the worker
> being destroyed.

Queuing work when the worker is not running usually means
a bad design on the API user side. The work is never done
and some job has not finished correctly. We should not go
over it quietly.

> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> ---
>  kernel/kthread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1166f2043e67..2ca711d0e78a 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -791,7 +791,7 @@ static inline bool queuing_blocked(struct kthread_worker *worker,
>  {
>  	lockdep_assert_held(&worker->lock);

A better solution would be:

	if (WARN_ON(!worker->task)
		return true;


> -	return !list_empty(&work->node) || work->canceling;
> +	return !list_empty(&work->node) || work->canceling || !worker->task;
>  }
>  
>  static void kthread_insert_work_sanity_check(struct kthread_worker *worker,

Best Regards,
Petr

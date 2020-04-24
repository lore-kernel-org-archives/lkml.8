Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1DC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BE720767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDXNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgDXNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:55:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD4E20700;
        Fri, 24 Apr 2020 13:55:04 +0000 (UTC)
Date:   Fri, 24 Apr 2020 09:55:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] sched: set p->prio reguardless of p->mm
Message-ID: <20200424095502.0063e857@gandalf.local.home>
In-Reply-To: <20200424043041.15084-1-hdanton@sina.com>
References: <20200424041832.11364-1-hdanton@sina.com>
        <20200424043041.15084-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 12:30:41 +0800
Hillf Danton <hdanton@sina.com> wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4795,14 +4795,6 @@ recheck:
>  	if (attr->sched_flags & ~(SCHED_FLAG_ALL | SCHED_FLAG_SUGOV))
>  		return -EINVAL;
>  
> -	/*
> -	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> -	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
> -	 * SCHED_BATCH and SCHED_IDLE is 0.
> -	 */
> -	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
> -	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
> -		return -EINVAL;


So if someone passes in sched_priority > MAX_RT_PRIO-1, where does it get
checked?

-- Steve

>  	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
>  	    (rt_policy(policy) != (attr->sched_priority != 0)))
>  		return -EINVAL;

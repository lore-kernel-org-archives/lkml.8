Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568352073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7YuvgTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGXHOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:14:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46294 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726543AbgGXHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595574873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/5K07WFbnYzpw23Eyz/mfTqQbQ4feMmgm06DmRfK4gw=;
        b=G7YuvgTihJLznHzZ5EQaUb9gI9nZPc7pRVAoseO9F0FHsZT4inYtn0UVQTvxDqh15weJ2T
        fUA/9ImAPfAmnMztY0rASZOp0Ib0HQi43cVYWnyizFBbOUKTGfGUz+S1NMEevB79Ox/co7
        ZWBkjEI5fhOn8dTSnj/QIoIfolqnEAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Yn_UAiYjOcOEgoBr_whdEQ-1; Fri, 24 Jul 2020 03:14:31 -0400
X-MC-Unique: Yn_UAiYjOcOEgoBr_whdEQ-1
Received: by mail-wm1-f69.google.com with SMTP id v8so2930242wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5K07WFbnYzpw23Eyz/mfTqQbQ4feMmgm06DmRfK4gw=;
        b=jXp5J+Cv7jhCXrC0cxx9JG41JMjcU+EA48Rx3NrvCAuZCD1MGZ4dBnIZOqEnuC+3YA
         K/iNH8q1rwIBhZmWoinrAKe0/zbmP7fpvhocIevIJb9H5zaMnnMzOS5vOYs9OdhCdTnO
         ZxqjHscnY8c4EyFVM04fRppRlYl14nmxqLTWhmsBqgUazUl+og+1gN9T49cUMUAYkZki
         OG8Sm4+pakdgN8QCMXI5EcW8Ji6kFjN/fBJh6fzltjvIEhiB7TtnQ3AZI+c5zs19Q8Vj
         mb99Dr2nmYsW+Yj+rgbQwACdaPllPogGQBNcYf+3owQVspJzl08uzIWOwIQiDZusiOma
         1Rvg==
X-Gm-Message-State: AOAM530B6qmWkudfT7QaJRdhUBAoC3pkRzVw73zDBNoULVWfzQwHlC83
        X5n0M/gP07ugN1Whd+PdWimhmRytSGYuoVUPovvKSHGscbf6taZS7TYdCdUT6dBlJHb2Y9id4cJ
        dT6fy5yOGZi2MjBQYOCC5y8Fs
X-Received: by 2002:a1c:988a:: with SMTP id a132mr7196230wme.14.1595574870050;
        Fri, 24 Jul 2020 00:14:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn4RnXakBtQEe/CdhK6+XDT3nF8XxcMdpkIbJsMpsIbqcJ3aKdpKNcDmpvmn7fNPLD+hAtyQ==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr7196208wme.14.1595574869790;
        Fri, 24 Jul 2020 00:14:29 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.4])
        by smtp.gmail.com with ESMTPSA id e5sm221437wrc.37.2020.07.24.00.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:14:28 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:14:26 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/deadline: dome some cleanup for push_dl_task()
Message-ID: <20200724071426.GD14912@localhost.localdomain>
References: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/07/20 00:04, Peng Liu wrote:
> 'commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq when pushing a task")'
> introduced the update_rq_clock() to fix the "used-before-update" bug.
> 
> 'commit f4904815f97a ("sched/deadline: Fix double accounting of rq/running bw in push & pull")'
> took away the bug source(add_running_bw()).
> 
> We no longer need to update rq_clock in advance, let activate_task()
> worry about that.
> 
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
>  kernel/sched/deadline.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 504d2f51b0d6..c3fa11f84d93 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2104,13 +2104,7 @@ static int push_dl_task(struct rq *rq)
>  
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, later_rq->cpu);
> -
> -	/*
> -	 * Update the later_rq clock here, because the clock is used
> -	 * by the cpufreq_update_util() inside __add_running_bw().
> -	 */
> -	update_rq_clock(later_rq);
> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> +	activate_task(later_rq, next_task, 0);
>  	ret = 1;

The change looks good to me, since now add_running_bw() is called later
by enqueue_task_dl(), but rq_clock has already been updated by core's
enqueue_task().

Daniel, Dietmar, a second pair of eyes (since you authored the commits
above)?

I'd chage subject to something like "sched/deadline: Stop updating
rq_clock before pushing a task".

Thanks,

Juri


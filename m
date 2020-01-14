Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CA9222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/ukjTZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgANS3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:29:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35968 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:29:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so6264111pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xvalv4jk2soL/e/FiXnFpGdN+0Q1Oxjo6xaDHJKcsiM=;
        b=d/ukjTZQfO8s56/Bm7eL6nnsIWHHUAxSvc9gMl83F1AK5hkq+mryx8OkD2GBVXuek3
         X0tYrBJjYuu06syiGyQs39b5PiV3Pb5fFyJIxIh0YtoeGO8h3DaFMa7jnUZ3NOdEdCsz
         DIDOSM0nT91MIhH4OYPRkaaFSRJWQfem5Vism8ahgkTdPVk8vmsZrPBBfB8SNW/kFLQa
         8VlU6NKoJmognEjuq89cuYy+Myf3kWfM1+FHMDdCxnAO+Mzs/juD2h0xjlN2mdwtkxnQ
         Eq0NOFKt0I6duYI0XC/hN9LSzidEe1lpWFo5wzk23aYXj9Jt+gtSHKcK6tBDD425ZKSj
         7oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xvalv4jk2soL/e/FiXnFpGdN+0Q1Oxjo6xaDHJKcsiM=;
        b=Vo9d80XT2aw6fa4IOQh31V6qZI7jsATreq4cthFevzP37txX3CfIDu09FKPEBvyBKr
         2VhuaHUCVWiWIAJube76d+Xi6ktqT/hKiZV696jQ3udDpbAwWrRxJ/nvdB/sF7ru32HZ
         Z8KSXkXdbrf6kflbDh+G13YcyG2eLwVcWfIXmxlUnzCaYsvaGyo6OJF2ifV2zxuYnir0
         chOvA4aH5NHDhA9GTBpWo6RGwOOQTXIJLQHWI9T7dzae7HVC3BbDAQ39Mwmeq7I3+Pj6
         6ITGN6/rv/3YuegXPLZV6y9C4PRG/Nx6fGRoNDDwVAgGhAhGX47NcyvSfg2NA9a4YaMh
         VJwQ==
X-Gm-Message-State: APjAAAUFwY2MzTV+hWHwBxTgXLn8+v28gca8Adm4VmXXj/iwFnFIJo1Y
        qnwjTKA/smu9IexRiPQM9pARf4pI+q4=
X-Google-Smtp-Source: APXvYqyRU3A3KDrz6Ny82QPuYclaFXEtDIkm6DDFB4IA2vOr+LKt1SUVt75tb6yfEt/QLD1KqHUcmw==
X-Received: by 2002:a17:90a:3643:: with SMTP id s61mr30595268pjb.44.1579026584941;
        Tue, 14 Jan 2020 10:29:44 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id f8sm18309037pjg.28.2020.01.14.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:29:44 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair : prevent unlimited runtime on throttled group
References: <1579011236-31256-1-git-send-email-vincent.guittot@linaro.org>
Date:   Tue, 14 Jan 2020 10:29:43 -0800
In-Reply-To: <1579011236-31256-1-git-send-email-vincent.guittot@linaro.org>
        (Vincent Guittot's message of "Tue, 14 Jan 2020 15:13:56 +0100")
Message-ID: <xm26blr5oprc.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> When a running task is moved on a throttled task group and there is no
> other task enqueued on the CPU, the task can keep running using 100% CPU
> whatever the allocated bandwidth for the group and although its cfs rq is
> throttled. Furthermore, the group entity of the cfs_rq and its parents are
> not enqueued but only set as curr on their respective cfs_rqs.
>
> We have the following sequence:
>
> sched_move_task
>   -dequeue_task: dequeue task and group_entities.
>   -put_prev_task: put task and group entities.
>   -sched_change_group: move task to new group.
>   -enqueue_task: enqueue only task but not group entities because cfs_rq is
>     throttled.
>   -set_next_task : set task and group_entities as current sched_entity of
>     their cfs_rq.
>
> Another impact is that the root cfs_rq runnable_load_avg at root rq stays
> null because the group_entities are not enqueued. This situation will stay
> the same until an "external" event triggers a reschedule. Let trigger it
> immediately instead.

Sounds reasonable to me, "moved group" being an explicit resched check
doesn't sound like a problem in general.

>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e7b08d52db93..d0acc67336c0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7062,8 +7062,15 @@ void sched_move_task(struct task_struct *tsk)
>  
>  	if (queued)
>  		enqueue_task(rq, tsk, queue_flags);
> -	if (running)
> +	if (running) {
>  		set_next_task(rq, tsk);
> +		/*
> +		 * After changing group, the running task may have joined a
> +		 * throttled one but it's still the running task. Trigger a
> +		 * resched to make sure that task can still run.
> +		 */
> +		resched_curr(rq);
> +	}
>  
>  	task_rq_unlock(rq, tsk, &rf);
>  }

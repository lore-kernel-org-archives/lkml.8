Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21E520708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRA390Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgEFQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729974AbgEFQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:36:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C8C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:36:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so3099082ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AW0DbDVyiatCB8sAddhnjdlJFC4LL5SS5PwuAdj23K8=;
        b=uRA390XvKGJm5je3FcgDwqU2YePovp5hCeU+TnnGxV26Pd48PucWT7Yi1yvJ797H8F
         cmpB4xLCMn/D8SGRnd3ebpSTTFFEJxXcqbwIlPMNXWNCthM6ucVj/DqMOtZ7lQosjZZe
         tbyeozgbo0dsT805UX5L4/y7AwLlMWlfEF4rZceEocog6TU0iHiwEnxF2RC9ZsSxvFBN
         W4QwgmUPvRR8vo6yAsNiFyFLTHxd2umhJ7jJV0xNY4O+bFEXAW87pX3mJoYlKX+gJvSe
         s37CezOyLUq7wKJAT19n5rTKFOu4j6Ob13A4o18bz323MgnKZlGhnlctjq3h2txtjwrR
         97zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW0DbDVyiatCB8sAddhnjdlJFC4LL5SS5PwuAdj23K8=;
        b=nmoSjL7n2REYKu+6q2A4xW+RYG9aqtZH9d6VJWURv20VSEHYG7QSUHQBG3L+Ty0j+B
         4H1pQ9uUZm9SwC9yM0Jnk1FYl35OzRCcpyA6vLeW4Ul2gnhgR19oibr7/vtLEHeeNOhh
         o/9OiT18pVZwmKQMm9kMULrBLXvHE5RvYdoM8yBPhgOnwqDVlrKO84/MNhjso4gqe/sX
         xFjxXaG7JXeqdiDIrUg+YGp4dX4Yog15K+1Xz1Im1yF3Ft5YEJ0bWnYk2/l+GpziPbKs
         EeTM9JNq4BWd8z3VbQCtwjkbEOhlBiuvh8BQHUDa0U/5gWWp4wqeeJQG6QTZI62fOz6N
         e40A==
X-Gm-Message-State: AGi0PuZZcjcYFEqeRMQzXZykPcn3mBnVEy8CN9eFrncZlbzSwEfVclXU
        LV1PmXGS74FegrP/m6e110s3M1ULCvsdbPprqnTPP2cIlEU=
X-Google-Smtp-Source: APiQypJGLnVS8vQSwI/SxmE088rxfs9WyHf2vj/xERjg+TgkwGRwgNFtHZ1LsysWZc3EMhlcIqG8+7eF/0D+1olc2fs=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr5354983ljg.21.1588783017175;
 Wed, 06 May 2020 09:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
In-Reply-To: <20200506141821.GA9773@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 May 2020 18:36:45 +0200
Message-ID: <CAKfTPtADSaFmxE_-qtfgYEQw0A90oma2tEwH=XrE7r=qfRVsaA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix enqueue_task_fair warning some more
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

- reply to all this time

On Wed, 6 May 2020 at 16:18, Phil Auld <pauld@redhat.com> wrote:
>
> sched/fair: Fix enqueue_task_fair warning some more
>
> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> did not fully resolve the issues with the (rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list) warning in enqueue_task_fair. There is a case where
> the first for_each_sched_entity loop exits due to on_rq, having incompletely
> updated the list.  In this case the second for_each_sched_entity loop can
> further modify se. The later code to fix up the list management fails to do

But for the 2nd  for_each_sched_entity, the cfs_rq should already be
in the list, isn't it ?

The third for_each_entity loop is there for the throttled case but is
useless for other case

Could you provide us some details about the use case that creates such
a situation ?

> what is needed because se does not point to the sched_entity which broke out
> of the first loop.
>
> Address this issue by saving the se pointer when the first loop exits and
> resetting it before doing the fix up, if needed.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..719c996317e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5432,6 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
>         struct cfs_rq *cfs_rq;
>         struct sched_entity *se = &p->se;
> +       struct sched_entity *saved_se = NULL;
>         int idle_h_nr_running = task_has_idle_policy(p);
>
>         /*
> @@ -5466,6 +5467,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 flags = ENQUEUE_WAKEUP;
>         }
>
> +       saved_se = se;
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> @@ -5510,6 +5512,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                  * leaf list maintenance, resulting in triggering the assertion
>                  * below.
>                  */
> +               if (saved_se)
> +                       se = saved_se;
>                 for_each_sched_entity(se) {
>                         cfs_rq = cfs_rq_of(se);
>
> --
> 2.18.0
>
>
> Cheers,
> Phil
>

Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB9C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E226520752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCzyF9ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgEKTZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731435AbgEKTZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:25:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d21so3161495ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8qsP9f01zYI2FG5AHJbY5zyiEiDXE7JO73B2LPyuuk=;
        b=eCzyF9ad4mLhonROo2UoMiLVGBExQnaiRf9l23hKPyejSyFqFIjrimXANkos02NXtb
         ByeavwvD4+oOP+T+BEJh5yWO2J+QfwDvd0k9mrUi2vnpE0uo5wKR887fKtXFr2tqimkz
         ZEQAo6a1ppAt2qKtd5Gw4rzdHzlwmEOwbEWHD/f4xxaweI2M24kRwl4hSnVF/23W4BV1
         k0px4mbhLGducOkZFLAhRgbKrPe7DVDoBBrTwDnAr95ywubHQ2osz8e0UmZokRPPTLzZ
         nYlwsbqcvg353xe4LO9UPmLR1Lw9BHWEwC/Mu4sPg1dv2TEB1ghZi3RK3oTdokUAyAuy
         Meag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8qsP9f01zYI2FG5AHJbY5zyiEiDXE7JO73B2LPyuuk=;
        b=VOe3YOtM2/u13xKJ3q4BUD0WWbIvCPeLZ05f7Xv9/C/lAzoDCxSsas0rIHThxsV2kk
         fjfRULnC9yoIBjCYy64m8dISm3n1eU1ZI9AMNGe9ifbVnYJVbdniEYRHPAWsUnOAZw8b
         Oz+HRTADM5EgutyLSq8Fz38TeE1uDbnKk7jwLA1kEdsWL9wznLzpL/PbmfKrNKLnsJPB
         mjU72oXpUvIrpuJsAWd88N6IRgmAoQzHMmZkFtSw1YN/3NRt7YHVSvU82ZHki22JpMIV
         Q4U+bgg65d02ZXqEWnmRiVjBev9lSJ8K9b3rsRvwv6HaNi6oQpskTNN5CrCgM6mSh2Em
         H1OQ==
X-Gm-Message-State: AOAM532PxTaOJTAEOSBd9JT4eaWXbKP744jzMig7SICMreISu8y9bZxt
        l9ltQ9l+mesaXhCkgIXgNc4uz0bGBnewCeFM2a3FaA==
X-Google-Smtp-Source: ABdhPJwF+9uUqhKZmYNQyo01CKwtZ1axcR7g6ZA7oelYkwDP2Zx4LgmYUhqID3o/t1Bw5kz5IC6j52EW5bbdBcn6HQ4=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr10617744ljp.209.1589225154955;
 Mon, 11 May 2020 12:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com> <20200507203612.GF19331@lorien.usersys.redhat.com>
In-Reply-To: <20200507203612.GF19331@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 21:25:43 +0200
Message-ID: <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
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

On Thu, 7 May 2020 at 22:36, Phil Auld <pauld@redhat.com> wrote:
>
> sched/fair: Fix enqueue_task_fair warning some more
>
> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> did not fully resolve the issues with the rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> the first for_each_sched_entity loop exits due to on_rq, having incompletely
> updated the list.  In this case the second for_each_sched_entity loop can
> further modify se. The later code to fix up the list management fails to do
> what is needed because se no longer points to the sched_entity which broke
> out of the first loop.
>
> Address this by calling leaf_add_rq_list if there are throttled parents while
> doing the second for_each_sched_entity loop.
>

Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)

> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>

With the Fixes tag and the typo mentioned by Tao

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..c6d57c334d51 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> +
> +               /*
> +                * One parent has been throttled and cfs_rq removed from the
> +                * list. Add it back to not break the leaf list.
> +                */
> +               if (throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>         }
>
>  enqueue_throttle:
> --
> 2.18.0
>
> V2 rework the fix based on Vincent's suggestion. Thanks Vincent.
>
>
> Cheers,
> Phil
>
> --
>

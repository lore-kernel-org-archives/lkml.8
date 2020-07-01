Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B21C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F87C20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR6mo9Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgGAKro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgGAKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:47:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE558C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 03:47:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so26322188ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkptkJEP+tdrFzmDzQWfCxG5o+z1NG6TF+2zaGvQQxI=;
        b=TR6mo9VqaTdozo8zppbxjZ/h7ur4irhMUUZjheWP09Efjfdikk/ySwGvMraVipheP9
         P1xrakMn5wvlPxI/02Dj58AuBtbEzBBLBV0mlaf0UgTGQ5v5o35d5l1Pr2/lA5hj0dEc
         JW9e0WfZ6LYhFrNUu0m8jxVVxj1wovADP6HRpaIzPYW9PBWyggeouzyuMDB2jCzWQFl8
         NBy8+TB77Bu2V0qtdmVBS4y19/jg+lAopz9g7do49ijp/eAmVi1f8iQy1CAGEc0w+Zy5
         mUfpWwwP1rI5NDlQM8nihWK+tuTRgTCwV8vxht+2M8uWrH8IoNut0S/vVQ/GsRXzIo0K
         Ehiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkptkJEP+tdrFzmDzQWfCxG5o+z1NG6TF+2zaGvQQxI=;
        b=KPTB5yeRF/yduKXh++ChSgTJRKlxC83ZoHur6xWpjdVGL2QICla1GslV4eZfRntsYF
         LMeKrrB51Q0qz+sRHHpl1Zs1oLiaCGrTnL2APQZ5KSdRQWjPJm97zGIcOtW+O0rMujVI
         oCX1RGUaTbEtDargRKqf/lKIgqtI1D8WwYrxInPwF23DKJuU56xd64gXXYTrH9qdmMVn
         HsF95UfDSsx1mfdpIvBtkwDMmWLNKSP7wlDSKQfn17cX/9uB70uZhjGRSMbCnMIpOXBH
         MkQHBtgWyqR3OxGv/HkMgxTcmaT4T/TkQ6J13tD3+C+gLvzUczouEzio3BoV9qRETu0c
         IjhA==
X-Gm-Message-State: AOAM533VPOOxVoQtYzQFRZIIqNcAeO1GqukCAx5vutxaefMQKAadZtVc
        rn6Jko5NOqiTG4H2Q69vMS2pDqhPq3mpX2rgfb12kQ==
X-Google-Smtp-Source: ABdhPJwEJpbAjTBeorrGRMoXykw2VU2jp3zPkE6fXaVdUO8Fj3tNNbOEbPOUWLaM4XKb7XjSXfnaDHiBJ/2zHkSyl7o=
X-Received: by 2002:a2e:7f10:: with SMTP id a16mr13603940ljd.69.1593600461320;
 Wed, 01 Jul 2020 03:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593598026-2451-1-git-send-email-zijuhu@codeaurora.org>
In-Reply-To: <1593598026-2451-1-git-send-email-zijuhu@codeaurora.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Jul 2020 12:47:29 +0200
Message-ID: <CAKfTPtBn0Bh4DjSs_nATYPvRt5Ks2Dg8n0TH7vuxtFfKFTxG5A@mail.gmail.com>
Subject: Re: [PATCH v1] sched/cfs: Fix pick_next_entity() implementation error
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 12:07, Zijun Hu <zijuhu@codeaurora.org> wrote:
>
> sched_entity @se not static @left should be compared
> to pick up @cfs_rq->next.

Could you elaborate why ?

left is the leftmost sched_entity and the one that should be used.

se != left means that left should be skipped after a yield and the
next se in the rbtree is not "far" from left although it has higher
vruntime

if we finally want to use last or next instead of se, we must ensure
that they are still not "far" from left otherwise you can promote a
sched entity that ends up having a really high vruntime

>
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 658aa7a2ae6f..4790f2d851ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4452,13 +4452,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         /*
>          * Prefer last buddy, try to return the CPU to a preempted task.
>          */
> -       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
> +       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, se) < 1)
>                 se = cfs_rq->last;
>
>         /*
>          * Someone really wants this to run. If it's not unfair, run it.
>          */
> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
> +       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, se) < 1)
>                 se = cfs_rq->next;
>
>         clear_buddies(cfs_rq, se);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>

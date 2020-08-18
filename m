Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C25206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c07Et75j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRJHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:07:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A133C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:07:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so20604546ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZnxPwWDe+137g4lC8OGah8jmu6F2XgBBRdxMx+JMFY=;
        b=c07Et75jGoRRCU9SGELs4oHTfr+/H4D/1uxObUPJ24ofLPA0OiSnJ0z8FFv3sPKr5T
         2igd4HF3xWCidJ0rSVvX4jTGDJ2HTkRt1jurlkYcrBpkuanWEojIfKyao9h8TnCb8K3s
         oy3VZZXAfv4W+pnTzZR9Yd7XtGZmVNVQART9TqKNKPc4n+8uTMWGiTCD408iN32X8VMm
         ITaFArMjiUKbHBRuMilWJh9IxXIYtTMa7y2ZesUWt7V1RibiTWWLjrx7CxAGbPFNOzQL
         KV5c6SKIYF0Hn0EImzAUDAduUnHadxKe6ffdg7lD4/U9Ysp9N5t4U1VzSz8TAyOqpCaL
         Kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZnxPwWDe+137g4lC8OGah8jmu6F2XgBBRdxMx+JMFY=;
        b=TRQFyL8PCZrIuEXZbRMehOwHRYi9BvJk2WYFb16qyvJzuS7PB6Y9bYEMk/GrwI9/Kz
         McIwk/7GMRDJjGx07FqoHoSbwpDLRL91bRB4Y6BbeSOCjyPrNh5WnWjA162Q6M+4Zd0E
         AsBXxVP02zLMXFzfXPLbcuogoDQqWVOuVd7cJvDjtSS942eAmKfQ0OMchz25UCQvGnVc
         ZDPztkdkOzLj+LvAnyRnhiYILKVQfAJF5bwjDanusgvnd0OQgMSETaBbttTHSWfTa9qZ
         IDCT5qirxvCRuHtllhjiegHrehIakoFjfzgF71mW/17plUdB6moY2eOtITbSSF2h3K81
         cNbA==
X-Gm-Message-State: AOAM530xqSwiSK9sPjLv6fj5wF7WLlfhZpAbyQkexQYxpBgjkh45lpBo
        EIs2gZaLD0gh2AaDKBppUCVc+XNtIaTWCeTnTraDDA==
X-Google-Smtp-Source: ABdhPJwhGVYumWhavpL2roJ7EphWNB1VFxxxuBXrJ2Q40IekG6bzaLeBvZSiFKHTVCMnmDfn0z0Y57aWaL0TnFLLzMs=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr8587816lji.156.1597741668678;
 Tue, 18 Aug 2020 02:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200811113209.34057-1-benbjiang@tencent.com>
In-Reply-To: <20200811113209.34057-1-benbjiang@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Aug 2020 11:07:37 +0200
Message-ID: <CAKfTPtBReSax0AK9sanzcSzBMJzx7jK-K8Umc3kfH_n11N7f3A@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: simplfy the work when reweighting entity
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 at 13:32, Jiang Biao <benbjiang@gmail.com> wrote:
>
> From: Jiang Biao <benbjiang@tencent.com>
>
> The code in reweight_entity() can be simplified.
>
> For a sched entity on the rq, the entity accounting can be replaced by
> cfs_rq instantaneous load updates currently called from within the
> entity accounting.
>
> Even though an entity on the rq can't represent a task in
> reweight_entity() (a task is always dequeued before calling this
> function) and so the numa task accounting and the rq->cfs_tasks list
> management of the entity accounting are never called, the redundant
> cfs_rq->nr_running decrement/increment will be avoided.
>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>

Minor typo of the subject: s/simplfy/simplify/

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v3<-v2: Amend commit log taking Dietmar's advice. Thx.
> v2<-v1: Amend the commit log
>
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..18a8fc7bd0de 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3086,7 +3086,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>                 /* commit outstanding execution time */
>                 if (cfs_rq->curr == se)
>                         update_curr(cfs_rq);
> -               account_entity_dequeue(cfs_rq, se);
> +               update_load_sub(&cfs_rq->load, se->load.weight);
>         }
>         dequeue_load_avg(cfs_rq, se);
>
> @@ -3102,7 +3102,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>
>         enqueue_load_avg(cfs_rq, se);
>         if (se->on_rq)
> -               account_entity_enqueue(cfs_rq, se);
> +               update_load_add(&cfs_rq->load, se->load.weight);
>
>  }
>
> --
> 2.21.0
>

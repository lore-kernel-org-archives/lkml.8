Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01384C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C675E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YisJlYix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEDN35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:29:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D08C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 06:29:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w14so9754923lfk.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6xAL6X5RvjN5mQi5HFr283gmog4T0ACtjZPScG4s5c=;
        b=YisJlYixqQ3kDPfcKEoMa0rZsFbsxNYzWqmR0FR8TfbFI9eFl0ZwBQEM2k+B7rzzOV
         DMhVFoxw7rTmePShVzfeq5sbtWNLIFMLmugOKoNu7qQfBT+kE1rJ1Vk7xrYANYyP2W5s
         wDVA1BcPcBV1qc7u7a6zf9Oc99g+821NHlJ27c23sRSdSWdNn7KT8vuwxSvE3+AZr5HY
         vL1fq2f1ef+UY4VqpCS/U/PdOHhiN3VsAfqMZD3iXQLuW+i2ZJmaxxF4cBXT1aRoLtaa
         sojc81r7OtikX8/aviPcJ3ltmv6OGIa8Z3f+QdOaf24DHCJpa2UzlcPO9SQmS3hOJ4Of
         I8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6xAL6X5RvjN5mQi5HFr283gmog4T0ACtjZPScG4s5c=;
        b=JMTfSG+k7H7JdxCFiU9IBDNaX1MYd+B+u+CwPwh6j6+Cm5cVhmgbzK3lN3ahh/gXr1
         kA0LJNzukM/uDkn0G38IzMXi1p9gVcaO3j5xFOPmYaLCxC8IuzM15HXRreTeNQ+0l5Ad
         DPlOipwx/QvAHbQvzszmjhJB6Z3HBQrqaor3vtAK5ijPOakQNbWCG2bH4TBeA5OYB2ue
         0mMluzxWP14dPiZa9CMYEagdWUZb0Sfgr9dDirk3B0GdBQAl38o03qP7KJOFLpT2H/55
         ObSWtaQwkeJ1cBrVPYklAtqWyob79ZlEXRkbGSoE+xSDLUKyJ/MShvoVK92taxfC/r43
         seCw==
X-Gm-Message-State: AGi0PuahKUe+2KTPqC6Y9MhMAP7g9+aYbSexjWeD3oKjJ65sjfyYZhqF
        EPG/udQ1xEeVs89h6evXRthZBfcPamEjZ+4Px6dNUNm7o5w=
X-Google-Smtp-Source: APiQypLe5p3MT0LNiXhYXRyluaADRv8y13qyDDzwW3DplynkkLB7KqMXtFrLpYM2Bm7BU+ippYOejMNFLGbBDyZXtXs=
X-Received: by 2002:a05:6512:104a:: with SMTP id c10mr12015812lfb.184.1588598992425;
 Mon, 04 May 2020 06:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200504015704.6952-1-hdanton@sina.com> <CAKfTPtA3wVD3X7+HqTs-ovSQ8FmZRyryAFb2zzUm4kAbPo4+tw@mail.gmail.com>
 <20200504114125.10180-1-hdanton@sina.com>
In-Reply-To: <20200504114125.10180-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 May 2020 15:29:41 +0200
Message-ID: <CAKfTPtBJvd244jdXXvjRcjcFdtVEpTauDjUpAs-uzWdKafbZrw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: correct llc shared domain's number of
 busy CPUs
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 at 13:41, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Mon, 4 May 2020 09:53:36 Vincent Guittot wrote:
> >
> > On Mon, 4 May 2020 at 03:57, Hillf Danton wrote:
> > >
> > > The comment says, if there is an imbalance between LLC domains (IOW we
> > > could increase the overall cache use),  we need some less-loaded LLC
> > > domain to pull some load.
> > >
> > > To show that imbalance, record busy CPUs as they come and go by doing
> > > a minor cleanup for sd::nohz_idle.
> >
> > Your comment failed to explain why we can get rid of sd->nohz_idle
> >
> The serialization added in 25f55d9d01ad ("sched: Fix init NOHZ_IDLE flag") to
> updating nr_busy_cpus is no longer needed after 0e369d757578 ("sched/core:
> Replace sd_busy/nr_busy_cpus with sched_domain_shared") AFAICT because a

I don't see the link between commit 0e369d757578 and the fact that we
can remove the nohz_idle field.

> recorded idle/busy CPU does not mean the current CPU could not become idle or
> busy. The right thing is to update the counter if we have a valid sd under rcu.

No it's not the root cause because the sd is per cpu so each cpu has
its own sd->nohz_idle so if cpu A set sd->nohz_idle, cpu B will not be
impact and will have to set its own.

We must ensure that nr_busy_cpus is inc/dec only once when
transitioning from/to idle/busy state in order to keep the shared
nr_busy_cpus correct. But set_cpu_sd_state_busy() is called from
scheduler_tick() which means potentially every tick:

scheduler_tick() -> trigger_load_balance() -> nohz_balancer_kick() ->
nohz_balance_exit_idle() -> set_cpu_sd_state_busy()

The nohz_idle field is there to prevent incrementing nr_busy_cpus at
every tick. But set_cpu_sd_state_busy() is called from
nohz_balance_exit_idle() since 00357f5ec5d6 ("sched/nohz: Clean up
nohz enter/exit") and the latter has a similar mechanism with
rq->nohz_tick_stopped so sd_llc->nohz_idle is useless

>
> > you remove the use of sd->nohz_idle but you don't remove it from
> > struct sched_domain
>
> A seperate cleanup for it is needed if it's no longer used somewhere else.

Please remove it in the same patch

>
> Hillf
>

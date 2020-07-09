Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B685C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FC020708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npvFezMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGINwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGINwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:52:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFCC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:52:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so2457717ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGVuo8ujJimg/zW9016fI/nLusAS6eB6X5j2AJ72Jog=;
        b=npvFezMTC8fOUcAN70TXMU8kzvjWJ2iynpk3U+Bf5E2N6rYnHzVn2idLDJ64d0yIDn
         idLfET28ODOTABtdRYtCqGmMJKGolCFnKUN+PIe7P0Gjg7dpGIyKAeHBhzyqbn9xOO3g
         DUkJ6ZCCf/89U8o3cCKCI3wRoLV6G7SFkMlhrzX+xFYOgeVDsdnS/Xa1VpPZanylz7qu
         UuTcYo4TZOOgh+c9GK3p295TFbpP0nx4m9XhUzRFTXxiwR+X2E7qL2Y4wVIrQO5+DP8+
         oyN3E96ugzvXaQHIX1og1wNJNI02ilr6dhwoJsLMm3lYvtq3+IwzB0gGaKID6Rkj9b5E
         BdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGVuo8ujJimg/zW9016fI/nLusAS6eB6X5j2AJ72Jog=;
        b=m1se6U2A2pETVReHnqWc+feh2/z06Tp9WXATpeHcxFoHo3RkKvSA308Dr4+IIcwYcr
         ACj+3BNUM+RfgBFUMisDkbeL6MA7T+wC4hRQWeKi5dAvQax7nc3TdD4FU2k8wloz/DJY
         H0bBgqlEgHGfIZcA0PAiA0cQXmJ0wRMzXlmViGrLV48CXAkuNX4UGEm5QhoY8rXtpSqD
         SYsQzE2XgxwKH2M/Z6ULSP7tdXHjWg8lJgFDXv8FtLzOS2C3ut80B87bHDP9XZgAncAY
         acpOlI3pfxgsHXOwYb6JGe/2KN3b+iowNWdTjEqQ2R29sA1f95ZVzleHjmt5zYEChvd5
         barw==
X-Gm-Message-State: AOAM533smSoqBGydFY+FNUXXxCBWv7ETyH5XjuDFsFbPNZu/AmhMFYOH
        Yg0+nOEId65g7Ox/SEMRlagligStfYM9BnmLuJ3THQ==
X-Google-Smtp-Source: ABdhPJyQqg3jfxMgebkWLUYMwv5N+RIZKCbN+OV/eVxLE/UvQPOv1OpAHpnmUdBAT2ATHZ+9p+dUPugRYkKtv+xlMb8=
X-Received: by 2002:a2e:7f10:: with SMTP id a16mr38244974ljd.69.1594302761669;
 Thu, 09 Jul 2020 06:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200702144258.19326-1-vincent.guittot@linaro.org>
 <4198cf3d-308e-feee-91c3-2edfd1748b4c@arm.com> <CAKfTPtBeRXCEWB3dTC8uOqbQ5xaZqQTAeG1EVGEk+pJcYz00sw@mail.gmail.com>
 <9a282390-1c81-0e77-9567-116c8777f7b5@arm.com>
In-Reply-To: <9a282390-1c81-0e77-9567-116c8777f7b5@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Jul 2020 15:52:29 +0200
Message-ID: <CAKfTPtDzsryz=V3WKo5zPkvWSagNAh1tr+ZaV5UwXBr7xMQPUQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 at 15:34, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/07/2020 11:47, Vincent Guittot wrote:
> > On Wed, 8 Jul 2020 at 11:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 02/07/2020 16:42, Vincent Guittot wrote:
> >>> task_h_load() can return 0 in some situations like running stress-ng
> >>> mmapfork, which forks thousands of threads, in a sched group on a 224 cores
> >>> system. The load balance doesn't handle this correctly because
> >>
> >> I guess the issue here is that 'cfs_rq->h_load' in
> >>
> >> task_h_load() {
> >>     struct cfs_rq *cfs_rq = task_cfs_rq(p);
> >>     ...
> >>     return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
> >>                     cfs_rq_load_avg(cfs_rq) + 1);
> >> }
> >>
> >> is still ~0 (or at least pretty small) compared to se.avg.load_avg being
> >> 1024 and cfs_rq_load_avg(cfs_rq) n*1024 in these lb occurrences.
> >>
> >>> env->imbalance never decreases and it will stop pulling tasks only after
> >>> reaching loop_max, which can be equal to the number of running tasks of
> >>> the cfs. Make sure that imbalance will be decreased by at least 1.
>
> Looks like it's bounded by sched_nr_migrate (32 on my E5-2690 v2).

yes

>
> env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
>
> [...]
>
> >> I assume that this is related to the LKP mail
> >
> > I have found this problem while studying the regression raised in the
> > email below but it doesn't fix it. At least, it's not enough
> >
> >>
> >> https://lkml.kernel.org/r/20200421004749.GC26573@shao2-debian ?
>
> I see. It also happens with other workloads but it's most visible
> at the beginning of a workload (fork).
>
> Still on E5-2690 v2 (2*2*10, 40 CPUs):
>
> In the taskgroup cfs_rq->h_load is ~ 1024/40 = 25 so this leads to
> task_h_load = 0 with cfs_rq->avg.load_avg 40 times higher than the
> individual task load (1024).
>
> One incarnation of 20 loops w/o any progress (that's w/o your patch).
>
> With loop='loop/loop_break/loop_max'
> and load='p->se.avg.load_avg/cfs_rq->h_load/cfs_rq->avg.load_avg'
>
> Jul  9 10:41:18 e105613-lin kernel: [73.068844] [stress-ng-mmapf 2907] SMT CPU37->CPU17 imb=8 loop=1/32/32 load=1023/23/43006
> Jul  9 10:41:18 e105613-lin kernel: [73.068873] [stress-ng-mmapf 3501] SMT CPU37->CPU17 imb=8 loop=2/32/32 load=1022/23/41983
> Jul  9 10:41:18 e105613-lin kernel: [73.068890] [stress-ng-mmapf 2602] SMT CPU37->CPU17 imb=8 loop=3/32/32 load=1023/23/40960
> ...
> Jul  9 10:41:18 e105613-lin kernel: [73.069136] [stress-ng-mmapf 2520] SMT CPU37->CPU17 imb=8 loop=18/32/32 load=1023/23/25613
> Jul  9 10:41:18 e105613-lin kernel: [73.069144] [stress-ng-mmapf 3107] SMT CPU37->CPU17 imb=8 loop=19/32/32 load=1021/23/24589
> Jul  9 10:41:18 e105613-lin kernel: [73.069149] [stress-ng-mmapf 2672] SMT CPU37->CPU17 imb=8 loop=20/32/32 load=1024/23/23566
> ...
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks

>
>
>
>
>
>
>

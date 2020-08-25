Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD45C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A241D2074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HInXVE0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHYMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:46:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F82C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:46:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so10227512oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=60uL+h5b+6ih2TnIJjU3qXOn+0BSH0uPg029KCCJl2k=;
        b=HInXVE0jR1KvM8zLLf16JOGE9QAnLah3QmJyZ9SEXYb9vZA9xxULElMMsH1MJv6HKG
         cUYr0pHqlOz7X7IAw6LwqBDI4PcdxHwJk7Gx2WDu02P9r8htTV+MG20NPqCDka/PKIPS
         9Ci2rqtiGzHZXlwv5UnaOm4QmS8zHdf7Y0HSHr8QTFVdCLtC36QyHmXhDCX+pr8+Gipe
         r3KGJz4Dgm0gLFKBQ6LSUphNIWpkb9KPLATa9mM9bO97MshBgB3zRqufSn4752IoMwtp
         60fN7XufiIZ7pWyx13vGZI7glvWuI0Roj2ANB7YXU/HkZLEhFL201FQ9zeB6s5LOwmtl
         QQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60uL+h5b+6ih2TnIJjU3qXOn+0BSH0uPg029KCCJl2k=;
        b=pmQqXCJkgc/ik191BUYsecGxzquVSA87rf1NJB/do0tmQ7s9+s5xFcA6DgPTfh2NO6
         yFPDqBtO7MRyFt84XnYKg82UyXaxhZeIvmX06FhlGW70nUr6t1TY30ddh0gAlzzHL4UO
         TVKu+zLOBakYfN9K+6wkjH1o470Hcz79mmqvfJCvhAfZIcHI/hH0acQ+0FlDRbBWZ55/
         BNY9flNu8CIkRoHolH5j/BEbdb0TAO6bUESIBVnZYFN78/+BvQB964vcPpsguvZXli47
         TkGKdcgPI2M1yYdN9+iCJ2PzLPg754dpiHUVWoqIgTYHomnrEHWcVw7JFa9qqclGOBYy
         zBsQ==
X-Gm-Message-State: AOAM533Q90ZTHQYHw43TXBHVi9WGYl2DJ/p1CgaXX/oSm11yqD48dqCz
        qHXb6pFbyshaTL961S/AybOxLdt3SXF5Y+0DCp4=
X-Google-Smtp-Source: ABdhPJxpnOjnlRfxd96FNwDYjBSplh1Pj1fEE86RtsXREMizZOMLQVZSTL8P782LOxyvBGDxFGCxR4276K0RTCbn8Eo=
X-Received: by 2002:a05:6830:1e5b:: with SMTP id e27mr5295296otj.4.1598359595170;
 Tue, 25 Aug 2020 05:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
 <CAPJCdBnTm0=Nazi2w9a6mBcKNv=_66UwvMfTNg6vLNKqW6qfwQ@mail.gmail.com> <495238bd-ea0d-56c6-4a9c-7b18deafcc8f@linux.alibaba.com>
In-Reply-To: <495238bd-ea0d-56c6-4a9c-7b18deafcc8f@linux.alibaba.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 25 Aug 2020 20:46:24 +0800
Message-ID: <CAPJCdBm4thJ7NT9uGRPLn7Be4tNA8c33fXCvdWiGfbRJcdKf+w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 at 17:28, xunlei <xlpang@linux.alibaba.com> wrote:
>
> On 2020/8/25 =E4=B8=8B=E5=8D=882:37, Jiang Biao wrote:
> > On Mon, 24 Aug 2020 at 20:31, Xunlei Pang <xlpang@linux.alibaba.com> wr=
ote:
> >>
> >> We've met problems that occasionally tasks with full cpumask
> >> (e.g. by putting it into a cpuset or setting to full affinity)
> >> were migrated to our isolated cpus in production environment.
> >>
> >> After some analysis, we found that it is due to the current
> >> select_idle_smt() not considering the sched_domain mask.
> >>
> >> Fix it by checking the valid domain mask in select_idle_smt().
> >>
> >> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_sibl=
ings())
> >> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> >> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> >> ---
> >>  kernel/sched/fair.c | 9 +++++----
> >>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 1a68a05..fa942c4 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *=
p, struct sched_domain *sd, int
> >>  /*
> >>   * Scan the local SMT mask for idle CPUs.
> >>   */
> >> -static int select_idle_smt(struct task_struct *p, int target)
> >> +static int select_idle_smt(struct task_struct *p, struct sched_domain=
 *sd, int target)
> >>  {
> >>         int cpu;
> >>
> >> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p=
, int target)
> >>                 return -1;
> >>
> >>         for_each_cpu(cpu, cpu_smt_mask(target)) {
> >> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >> +               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> >> +                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > Maybe the following change could be better, :)
> > for_each_cpu_and(cpu, cpu_smt_mask(target), sched_domain_span(sd))
> > keep a similar style with select_idle_core/cpu, and could reduce loops.
> >
>
> I thought that, but given that smt mask is usually small, the original
> code may run a bit faster?
Not sure. :)
It's OK for me.

Regards,
Jiang

Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980D020842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfJIH6ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgCCNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:12:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40554 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCCNMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:12:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so3443385ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14TETtsCeDLsnW+i1qFuKgD8Ulv00VFkHeJNS0lRmyc=;
        b=UfJIH6oxIMmm46ZxZ24ogjsflfGT+Lg+KNYbetFEMYm/a8N6m9/vykGXOdbScN/eCP
         WoYXG/RTGfGqIQ+J8G7aGREYVdEfoE1EwvYXziqMHpxS1GSVrnLwR9/0tvEYOnEK+hOF
         e0gLPSgGDfOMOJDqIeoyfkL2wen6R3sfypHPK415n9g9jUu4MQZ8PBoNGlXFtN8iO44S
         hBg8sWA57a3V+KBftwLNKB+GAMEiX7iJnOFjrkIIk/xxGCK4cWHav+LNSUuJjXddfuaA
         GAhLw1khaNY2seLACj3eXU0AQPAM/Et3mNjvfSDRKoe8+hz03Rng8Z5Fin7cQv4EjnKW
         tfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14TETtsCeDLsnW+i1qFuKgD8Ulv00VFkHeJNS0lRmyc=;
        b=Vqj+g1+dlwuV7i3Vidw9vaPyDs+88gTIElY5UPosCO639nx9ib+riEBMSk285odUc+
         c7OlAGVzV4g89gi+DI/Ioyr6/+8OyFYxOIbdqHfq+eO7+amhdpvUqXaOb38KqVwbcUfT
         pmtZX2TS8lNe9Xj/mC/zmXToGtNJErzJejOfbYMlZqRPfKeOzSU5Tb62nsWVDVFyfPLo
         xDm7Sa/TipAxG0+pntb00NnwwK9kZy9Ri+o0pCvxOxqn2r7kd2vi6E4i6xBiL7fCACJ5
         MRLpx+hrPUliIcwTdxH9LQykzbZvs0j4z39uYeZXheMpRkpiIPSJo+iNbooc8HRXHVNu
         eiUQ==
X-Gm-Message-State: ANhLgQ20w3ycpyuXuZg+dqQDvGhMVsXH2EIfgMmr3z1+lJkIrFUw02bF
        LqPpJpXFG4UVNzwkvUbamw7ExiKS4Dm0sekvX2h4DA==
X-Google-Smtp-Source: ADFU+vvRR57tLL4WBrhYqm8T+G58WNEAyuSNZkrZl/lSurB58p0mTBMWcpMn2cgMFtRvyRc5APGlYId28bxV2yGR15s=
X-Received: by 2002:a2e:8546:: with SMTP id u6mr2325365ljj.21.1583241125398;
 Tue, 03 Mar 2020 05:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20200303110258.1092-1-mgorman@techsingularity.net>
 <20200303110258.1092-2-mgorman@techsingularity.net> <CAKfTPtC5LAU9mmfqX9qydR-GQekXrSSNTErONm493UBpZWHZsA@mail.gmail.com>
 <20200303114444.GM3818@techsingularity.net>
In-Reply-To: <20200303114444.GM3818@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Mar 2020 14:11:53 +0100
Message-ID: <CAKfTPtDzE4KZ6jDAgOqB2dn6866iiR6XJSAzTrS6GEn+nvWOFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Fix statistics for find_idlest_group()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 12:44, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Mar 03, 2020 at 12:14:07PM +0100, Vincent Guittot wrote:
> > Hi Mel,
> >
> > On Tue, 3 Mar 2020 at 12:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > From: Vincent Guittot <vincent.guittot@linaro.org>
> > >
> > > From: Vincent Guittot <vincent.guittot@linaro.org>
> > >
> > > sgs->group_weight is not set while gathering statistics in
> > > update_sg_wakeup_stats(). This means that a group can be classified as
> > > fully busy with 0 running tasks if utilization is high enough.
> > >
> > > This path is mainly used for fork and exec.
> > >
> > > Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > Link: https://lore.kernel.org/r/20200218144534.4564-1-vincent.guittot@linaro.org
> >
> > This one has been merged in tip/sched/urgent
> >
>
> I know and it appears in next but not in mainline yet. As tip/sched/core
> is the development baseline for scheduler patches, it should have the
> patch -- most likely via mainline to preserve git history. By including
> it here, I wanted to highlight that anyone working on tip/sched/core at
> the moment should include the patch if they want to avoid invalidating
> any test results.

ok. Make sense

>
> --
> Mel Gorman
> SUSE Labs

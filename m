Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A5C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562920801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9cpGOUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBQQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:15:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35254 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBQQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:15:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so19492692ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0TipqMdhS4pxSY1hXNLauRtrTPhbqoPJrasfWKPg4UA=;
        b=X9cpGOUnC7I2syG97wbgPrFA0XREObGZFM3ywzOMlKsnnGr8hq6nFPRfsHsUT+52Vg
         YqnSxdm7CifC6geCL8YczKeojwkw1whC57P7DdV3qySkkiG2lvhtgEBNhJPxrqwAsmYi
         kRt8tKD+aiZZX8jY/v5dHWP2c44G3q2NeilXcU2vFveCwK5htriC6tBVD9Xs57X5Hw+D
         zaaH5AfrZjOgDh3JAhguTdIYQMHXewcGKYqrJeftBnwsH3biOTvZ30SMqIlMFwJBJ/N+
         hpOfq9Q6Vl5rH55EnxYqpiOqoehm2qxiKuYgTDH8K1RPj4WmVqysmKmtGiIMEybw+C6y
         /2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TipqMdhS4pxSY1hXNLauRtrTPhbqoPJrasfWKPg4UA=;
        b=HBkE7OJRePvHBJb6l5Y0XJBMprKBgRMdzlfHmCytUYqZ2M1Hbn5UUoA1R6b39SQlLg
         gneA0Z5kMpFS0xj6C+5moEIyOlji6U8WwnOxn+s/AEdu5GforhMr9V+OhmLaWZ/pc6a3
         3Anfn+Q8LVrhNw+bO7V3UMfW4nPHQQgibcTKByS2G3Y4a/QdctUANXzQ7M9FMXoT2pDc
         eEy6N6iDRe0fF1VNy3h3dnoo9MHprZTcZ73bgA8TbEdB/AZAZ/0oACHQmPYOnAjISsNW
         KegNIGZbjvWfAu0MfTZgk27190wx+p6uZmCHSpv3ZrIKiiTexkDBFZE5+9u8y/Aw8Un5
         ciJw==
X-Gm-Message-State: APjAAAW+M1mk0n3qhMkmLnlS6G5QMOdl0GwQNkehvksVJs7udrmQQ4I8
        h19JKFLg2eW35JYAXuwgXmxukPlQwn/GpL8Nqvq+Vg==
X-Google-Smtp-Source: APXvYqyxW5nhhU0QL+zmNwGJ49EdB0T0eePErUamWSBb9m3JbBjOMYFhwy5qIsdYpWiSh6W5IcQYngfSXV6IbjzNfIk=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr10282795ljg.151.1581956144038;
 Mon, 17 Feb 2020 08:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com> <20200217151412.GK3466@techsingularity.net>
In-Reply-To: <20200217151412.GK3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Feb 2020 17:15:32 +0100
Message-ID: <CAKfTPtDEFvYv3oOAzDHZE5BLE0AByvvHB+67yL=SfAQgEotbGw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v3
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 at 16:14, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Feb 17, 2020 at 02:49:11PM +0100, Vincent Guittot wrote:
> > On Mon, 17 Feb 2020 at 11:44, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > Changelog since V2:
> > > o Rebase on top of Vincent's series again
> > > o Fix a missed rcu_read_unlock
> > > o Reduce overhead of tracepoint
> > >
> > > Changelog since V1:
> > > o Rebase on top of Vincent's series and rework
> > >
> > > Note: The baseline for this series is tip/sched/core as of February
> > >         12th rebased on top of v5.6-rc1. The series includes patches from
> > >         Vincent as I needed to add a fix and build on top of it. Vincent's
> > >         series on its own introduces performance regressions for *some*
> > >         but not *all* machines so it's easily missed. This series overall
> > >         is close to performance-neutral with some gains depending on the
> > >         machine. However, the end result does less work on NUMA balancing
> > >         and the fact that both the NUMA balancer and load balancer uses
> > >         similar logic makes it much easier to understand.
> > >
> > > The NUMA balancer makes placement decisions on tasks that partially
> > > take the load balancer into account and vice versa but there are
> > > inconsistencies. This can result in placement decisions that override
> > > each other leading to unnecessary migrations -- both task placement
> > > and page placement. This series reconciles many of the decisions --
> > > partially Vincent's work with some fixes and optimisations on top to
> > > merge our two series.
> > >
> > > The first patch is unrelated. It's picked up by tip but was not present in
> > > the tree at the time of the fork. I'm including it here because I tested
> > > with it.
> > >
> > > The second and third patches are tracing only and was needed to get
> > > sensible data out of ftrace with respect to task placement for NUMA
> > > balancing. The NUMA balancer is *far* easier to analyse with the
> > > patches and informed how the series should be developed.
> > >
> > > Patches 4-5 are Vincent's and use very similar code patterns and logic
> > > between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
> > > is necessary to avoid serious imbalances being introduced by the NUMA
> >
> > Yes the test added in load_too_imbalanced() by patch 5 doesn't seem to
> > be a good choice.
>
> But it *did* make sense intuitively!

Yes. In fact, one difference compared to your fix is that
load_too_imbalance() is also called by task_numa_compare() whereas
node_type only is only tested in task_numa_find_cpu() in your patch

>
> > I haven't remove it as it was done by your patch 6 but it might worth
> > removing it directly if a new version is needed
> >
>
> They could be folded together or part folded together but I did not see
> much value in that. I felt that keeping them seperate both preserved the
> development history and acted as a historical reference on why using a
> spare CPU can be hazardous. I do not believe it is a bisection hazard
> as performance is roughly equivalent before and after the series (so
> far at least). LKP might trip up on it and if so, we'll simply ask for
> confirmation that patch 6 fixes it.

that's fine for me

>
> --
> Mel Gorman
> SUSE Labs

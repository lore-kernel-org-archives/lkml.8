Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B3C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49B12184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPCRxhMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEIOGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgEIOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:06:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8FEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 07:06:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b26so3696842lfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3sW6gGxSFYLbQMqiE2OgOKIm35ARKyWWruHIK3w6PQ=;
        b=CPCRxhMfKQFuwDgy/ZmcW/xhfqV9MdzE0YYS6RcYSPljXI+g3UHNduR7qxy2YGhc02
         GoaSSHkPldIsQRT8xbeolWkO3usdS1kv3Dhxp0Ca4hBTTQrWvNsZJuNkYkZLVpuXFoB8
         oI8WDKM34ouq9Js46hM3qWS8zrhxK2DBmWc9mPr/tqH1XX5lNSnvx6Yvw+vTiuNiFV2U
         Z+p5NLf4IIdQ4G5rPcYJbwweK01tArCoId4O6qFw7jvLqx2MJ87hZaMXC9WrTuzzQAXY
         OdOS/3YRXvUFDzEYQlGiyGA/TdrvopOsFm+IJyLwCx+BAU+35ZByFSjxEAknOiwmj5Yv
         E+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3sW6gGxSFYLbQMqiE2OgOKIm35ARKyWWruHIK3w6PQ=;
        b=b2tMsIc87HuAQ4TaglWGRzLe4D0nIVwswHUuO4YC0Mc+woQ8xKFeoLTCjNNmOHq6jV
         OhnaCnOYg1Y74R7H7JQjgpFDmXZ0P4XQt/mkJMXIbVGwZcsrgivw/+HPPHg896OKuuh+
         s0ReqIvVXTS+3IQh3hSenvVc5o+24hEg9ycObwo/M1YPupy4NSzQmSrNWB4viteLhWgy
         MFuRWpJeqsnaSTCmEZ2MM3vlx0CW2YRBvcfDymdcIViiCdEkftA1sc/w0bxP4nvvpuqu
         V2RAhVVkb+XgMYxdNWFiMNis8TClcOAS6xdggZsCCjhFa08vwYKgqKMsG8WJkgmEA9QX
         VjAw==
X-Gm-Message-State: AOAM5333KzWoOgnzVkNgHPoC+VBEys+kmsSy4Km7+04mlU8b1ZqQPJGn
        +Mp4wrsQdUiJ5+lmBSGK7vRWk4So2wNbT5CxdL3BZg==
X-Google-Smtp-Source: ABdhPJyWWhFBVG4eHjWySAi6pwQCblm+7itP1oOjJ6xL2tX+stPpmpIqFW5098YtOuNnNxwD27REHPC+dSfHiPA65c0=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr5288736lfb.124.1589033209912;
 Sat, 09 May 2020 07:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
In-Reply-To: <20200508214405.GA226164@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 9 May 2020 07:06:38 -0700
Message-ID: <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > One way to measure the efficiency of memory reclaim is to look at the
> > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > not updated consistently at the system level and the ratio of these are
> > not very meaningful. The pgsteal and pgscan are updated for only global
> > reclaim while pgrefill gets updated for global as well as cgroup
> > reclaim.
> >
> > Please note that this difference is only for system level vmstats. The
> > cgroup stats returned by memory.stat are actually consistent. The
> > cgroup's pgsteal contains number of reclaimed pages for global as well
> > as cgroup reclaim. So, one way to get the system level stats is to get
> > these stats from root's memory.stat, so, expose memory.stat for the root
> > cgroup.
> >
> >       from Johannes Weiner:
> >       There are subtle differences between /proc/vmstat and
> >       memory.stat, and cgroup-aware code that wants to watch the full
> >       hierarchy currently has to know about these intricacies and
> >       translate semantics back and forth.
> >
> >       Generally having the fully recursive memory.stat at the root
> >       level could help a broader range of usecases.
>
> The changelog begs the question why we don't just "fix" the
> system-level stats. It may be useful to include the conclusions from
> that discussion, and why there is value in keeping the stats this way.
>

Right. Andrew, can you please add the following para to the changelog?

Why not fix the stats by including both the global and cgroup reclaim
activity instead of exposing root cgroup's memory.stat? The reason is
the benefit of having metrics exposing the activity that happens
purely due to machine capacity rather than localized activity that
happens due to the limits throughout the cgroup tree. Additionally
there are userspace tools like sysstat(sar) which reads these stats to
inform about the system level reclaim activity. So, we should not
break such use-cases.

> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks a lot.

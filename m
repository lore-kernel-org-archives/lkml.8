Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA30C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5221473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoiJ4pfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgEIGxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgEIGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:53:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C3C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 23:53:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so3543331ilp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUEhOioMUS93dlkp4Cr67Jf/qlMjy8RLVtg/oke/DHw=;
        b=WoiJ4pfr48so+/dqNV5Kgme6+3JAEIXPwPtXbhOR4lmnqiH04A/mHkd02ADyZghkru
         aoN3Uv7GCNvNW0lkqONTHDYiQHpJg7XTvmqXLKPSs8/Lb0H48PJqDnnifkJY4fcoXn+9
         KYChleT7MZ189GAJukrHgM83CNWyqVeuyzI6udJtj1G3RCVrLwkQ3/rxGian9mMKZWoI
         ReOZLBL4hbpH6QcGtEavFzabFyEAiLPSrlu0CmETn2Y+oTVYhaUADCDeZ9q9yyK0NvOP
         C2QoJ34TXNeSuEIrXZTjoFhKWolg665zSV6xqKRBYWKnVTA//RMK7SGNdkkJhAv6goGM
         NI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUEhOioMUS93dlkp4Cr67Jf/qlMjy8RLVtg/oke/DHw=;
        b=HSlerH+lb35l/+xc5W9EGH3Xbwc6+m8f0eIoyrxaO4LVBETrcQPhOvkNyat0LARKIY
         YU1u4J71U2rpxeoX8VTeNunv98xTXiKaG8+/B3/rng9geLFJaIG+lf2iaLgUj+pNghY5
         jpTniF8JeMVJEpJQnNYTpsiyYqoXF3/3viJbQytHYEd+wHkYsiF3QKqiEhG2y9m4I/+s
         gfqKkRiCZqp59PiuxvQsfYLimC21skv7MgaCfxfgMTUpQLTQhYPnd0N7QShFBeniiHNA
         tamvTCq56/o0xpNXlSjI8rNvKpOizyJf4B7TJvmx0k7QM4rkOSPFCCqv0ylHstbdMVwB
         N+MA==
X-Gm-Message-State: AGi0PuZiHRtn+qC2mB0n0HGzLDSXbwiZoVNWT3RNHVIw1/oc51foWOjx
        D3z+CIdfNCkbseQSViMehQarSRAkjH7jteWDlWc=
X-Google-Smtp-Source: APiQypJixX5XSny93qc69GJLQhJ9crL7NAzyIaoDQrhsQAeGPF+whF/G7rmuG24QwC0sTVPyAuhZqtsQNEObF94sU8Y=
X-Received: by 2002:a92:1b91:: with SMTP id f17mr6741757ill.142.1589007230444;
 Fri, 08 May 2020 23:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200507204913.18661-1-shakeelb@google.com> <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
 <CALvZod7VujYgU=6XfgjSZnzLqDpbHwEYsp2Xbq9MK7w_z=LphA@mail.gmail.com> <20200508133833.GA181181@cmpxchg.org>
In-Reply-To: <20200508133833.GA181181@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 9 May 2020 14:53:14 +0800
Message-ID: <CALOAHbBPZgqS47e=TMCP8yas5kV7MrscZYEgH+sBO1JzXgPh_Q@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:38 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 08, 2020 at 06:25:14AM -0700, Shakeel Butt wrote:
> > On Fri, May 8, 2020 at 3:34 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Fri, May 8, 2020 at 4:49 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > not updated consistently at the system level and the ratio of these are
> > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > reclaim.
> > > >
> > >
> > > Hi Shakeel,
> > >
> > > We always use pgscan and pgsteal for monitoring the system level
> > > memory pressure, for example, by using sysstat(sar) or some other
> > > monitor tools.
>
> I'm in the same boat. It's useful to have activity that happens purely
> due to machine capacity rather than localized activity that happens
> due to the limits throughout the cgroup tree.
>

Hi Johannes,

When I used PSI to monitor memory pressure, I found there's the same
behavoir in PSI that /proc/pressure/{memroy, IO} can be very large due
to some limited cgroups rather the machine capacity.
Should we separate /proc/pressure/XXX from /sys/fs/cgroup/XXX.pressure
as well ? Then /proc/pressure/XXX only indicate the pressure due to
machine capacity and /sys/fs/cgroup/XXX.presssure show the pressure
throughout the cgroup tree.

Besides that, there's another difference between /proc/pressure/XXX
and /sys/fs/cgroup/XXX.pressure, which is when you disable the psi
(i.e. psi=n) /proc/pressure/ will disapear but
/sys/fs/cgroup/XXX.pressure still exist.  If we separate them, this
difference will be reasonable.

> > Don't you need pgrefill in addition to pgscan and pgsteal to get the
> > full picture of the reclaim activity?
>
> I actually almost never look at pgrefill.
>
> > > But with this change, these two counters include the memcg pressure as
> > > well. It is not easy to know whether the pgscan and pgsteal are caused
> > > by system level pressure or only some specific memcgs reaching their
> > > memory limit.
> > >
> > > How about adding  cgroup_reclaim() to pgrefill as well ?
> > >
> >
> > I am looking for all the reclaim activity on the system. Adding
> > !cgroup_reclaim to pgrefill will skip the cgroup reclaim activity.
> > Maybe adding pgsteal_cgroup and pgscan_cgroup would be better.
>
> How would you feel about adding memory.stat at the root cgroup level?
>
> There are subtle differences between /proc/vmstat and memory.stat, and
> cgroup-aware code that wants to watch the full hierarchy currently has
> to know about these intricacies and translate semantics back and forth.
>
> Generally having the fully recursive memory.stat at the root level
> could help a broader range of usecases.



-- 
Thanks
Yafang

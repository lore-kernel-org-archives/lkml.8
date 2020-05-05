Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B7E207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/lrwQCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEEPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729366AbgEEPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:35:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:35:58 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u4so1724263lfm.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huzUgNgktrhOCuskegeISs0vb5n+2XRI/TAh0nK4ACg=;
        b=o/lrwQCJd50bIYfIsq0VJczMjBR58BsANK+atKw0wvz6n+yx9YZx/Nc940iF+0GKBy
         hLX1vW57uKXqlQoqbEXWwWB2OPzsPSs/1Xv/IRnVkZZWUic1oqJOZTjNYVBgM85e4p9T
         q8V0YzTKSnkWNS653jK6QCarT5rXXuYcYhLL6Xto3yX0F2uUtYNLwFfjKikUad8LtsLY
         ciEJ2WNrIfEJBpPgnOwymUO911icskpbfrUvh1BEasE+MWoaV1+0SJoxVx7syjB0Tn6T
         ClJ0LaUAT1XBPSTG5mhidZZSbLV0oOhaHpAYDKo6GLj1Yk57GrgqZdRwIiAP3TPvUzfi
         scRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huzUgNgktrhOCuskegeISs0vb5n+2XRI/TAh0nK4ACg=;
        b=cwRtm3TOqqTv36oUPMZ4fkdCSPer6OFcy4UnnTjkTufHQYx0v/naiQ89EvdA6cr0Gs
         VDyG1X8iHXjOKeqNjL5SlQktlQD2M8dBDlAe2JHponARVSZ6iwg+tQoMTG0ekK4fURec
         x8TRBe5P6Wnx8z97lKf3cBHsSyJSqlB5tmpe58Aue1946HvVL0pgoU8r7Kty4RRetErq
         onAo6KOAVJs9db9r0zlZ8DyCqAUmbbL/vaC9LZ8n4p3sm51rANVpkoBz9PfZQVZGGPYM
         l7Oyu3AA6FyyNEZnhzyYSjYzJSabKoUXus1iWuih+64mWMtz6S/xrG1KCPdj+ACwnsy7
         5Bwg==
X-Gm-Message-State: AGi0Pua0moa8AXj3kOl4dT5vbr+B8D3RJLk/+F36WIFIw0/5dKrfmZN0
        QGSOlNHiIRWKja49akksFb3HAWEGJd8Djk1k3hbfgw==
X-Google-Smtp-Source: APiQypLnRYOoUJwZCqblQY9KaIwvVTlVdl1d9jFGkPlVkiHRoPkT9L7oyjRWTeGVG6V/2ICMPJ5TIkqiS2OgBQIs4Jg=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2067094lfl.125.1588692956784;
 Tue, 05 May 2020 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz> <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz> <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz> <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505152712.GB58018@cmpxchg.org>
In-Reply-To: <20200505152712.GB58018@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 May 2020 08:35:45 -0700
Message-ID: <CALvZod48mu1w=fjpD=GXqCMdNq_8rExQ177_EP+Lx+TvR6fw+w@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, May 04, 2020 at 12:23:51PM -0700, Shakeel Butt wrote:
> > On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > I really hate to repeat myself but this is no different from a regular
> > > oom situation.
> >
> > Conceptually yes there is no difference but there is no *divine
> > restriction* to not make a difference if there is a real world
> > use-case which would benefit from it.
>
> I would wholeheartedly agree with this in general.
>
> However, we're talking about the very semantics that set memory.max
> apart from memory.high: triggering OOM kills to enforce the limit.
>
> > > when the kernel cannot act and mentions that along with the
> > > oom report so that whoever consumes that information can debug or act on
> > > that fact.
> > >
> > > Silencing the oom report is simply removing a potentially useful
> > > aid to debug further a potential problem.
> >
> > *Potentially* useful for debugging versus actually beneficial for
> > "sweep before tear down" use-case. Also I am not saying to make "no
> > dumps for memory.max when no eligible tasks" a set in stone rule. We
> > can always reevaluate when such information will actually be useful.
> >
> > Johannes/Andrew, what's your opinion?
>
> I still think that if you want to sweep without triggering OOMs,
> memory.high has the matching semantics.
>
> As you pointed out, it doesn't work well for foreign charges, but that
> is more of a limitation in the implementation than in the semantics:
>
>         /*
>          * If the hierarchy is above the normal consumption range, schedule
>          * reclaim on returning to userland.  We can perform reclaim here
>          * if __GFP_RECLAIM but let's always punt for simplicity and so that
>          * GFP_KERNEL can consistently be used during reclaim.  @memcg is
>          * not recorded as it most likely matches current's and won't
>          * change in the meantime.  As high limit is checked again before
>          * reclaim, the cost of mismatch is negligible.
>          */
>
> Wouldn't it be more useful to fix that instead? It shouldn't be much
> of a code change to do sync reclaim in try_charge().

Sync reclaim would really simplify the remote charging case. Though
should sync reclaim only be done for remote charging or for all?

>
> Then you could express all things that you asked for without changing
> any user-visible semantics: sweep an empty cgroup as well as possible,
> do not oom on remaining charges that continue to be used by processes
> outside the cgroup, do trigger oom on new foreign charges appearing
> due to a misconfiguration.
>
>         echo 0 > memory.high
>         cat memory.current > memory.max
>
> Would this work for you?

Yes that would work. I will work on a patch.

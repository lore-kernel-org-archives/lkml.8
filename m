Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D9C2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9420753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpgM4oEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgCLCEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:04:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:04:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so2492961lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3hzFOv+ufMUG9fZYGvNPf1Rj5SadPChsc427Pq4MuU=;
        b=vpgM4oEg5vQg7zF+tYEv7Vyyu3scK/a95qbpaEP7UrD/aYmlQ6SeWqFvun0hZ3k67e
         OtBqqS+3D0XjK7YxmxKEvnYIlia/p2feYBe18wkmL347YysBay5yMKLF2zJyOsjObWG3
         nYyq2KALh1S+6KACoAWixnLjFD8geRrFQ9cYz7SmG6RCJZ+iqI6xa6zvxpHBHgUsME0D
         vakqiL/MWiRRrmMN7HzSSkWbBv+e326Y5hpVdwc7nGjb/kOxy6a6qCVWlUQ7JZHCV5IO
         3eYWuWuLreDi+8F7hqmTuKnuQdGVfl+AlUIjqrrF4uhddIsSNDIokXjuJU3d3A+RNeXo
         xbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3hzFOv+ufMUG9fZYGvNPf1Rj5SadPChsc427Pq4MuU=;
        b=s9GfnvOwZkblgBZdc8nmw/p900j8T7QaJR4U2gago12lEKVvRL6muJI9iv+XQCilaz
         rLlSJEJDf3ugI5zRHnn/RNG9uLwD6+BZ9DYnrhsAbEl/HO8lH9cRyLcCa+1NuTKbkjvL
         8GuaqtgsjfgV1VAVAATxZpxIoUMxssh0zbzmvRMmeuaAwwNv5j12Ax4at/11F9MsCiGL
         dzl6OoFl3lWMaUKbodbcLiH2zXnaEER9VmUV/PW/ZI12V+lqQ/98Uot05BRny54gi2th
         n5dRGMRAqgTtz2Cinj7Mdy3ZqyOicRATfWJo9XvFcGuv6E4O5+Ft1ETzsjjfqZyhogym
         Blmw==
X-Gm-Message-State: ANhLgQ0iLpiJIzmUeaUH/b2WOZ/+xQ+4pDaxk7Yq/0Sm7xS6RbDUUSkm
        8eGJ2ovOgbMfGuxyeg2Y+EVPqsmTQ7RYahnVe2ki1A==
X-Google-Smtp-Source: ADFU+vsU/OyV5rdK4QGYblP7aUk0KmFAJfC4f7yZQUDmeMQmHszyALYMvHMr33qX8nhSOez1pD8RqJNQFihyA+tyDgQ=
X-Received: by 2002:ac2:4c14:: with SMTP id t20mr3677256lfq.193.1583978646217;
 Wed, 11 Mar 2020 19:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz> <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz> <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
 <20200311084513.GD23944@dhcp22.suse.cz> <CALvZod6b73_ay_kxph143Aj+XBq04Np0z2bK4Rfn8qppihrmTw@mail.gmail.com>
 <20200312001849.GA96953@google.com>
In-Reply-To: <20200312001849.GA96953@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 11 Mar 2020 19:03:29 -0700
Message-ID: <CAKOZuev1XzbsCPJtOA=v9QMuVpEBKc0_5ZE4Oc4tzmKdFHy2Dg@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Minchan Kim <minchan@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 5:18 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Mar 11, 2020 at 04:53:17PM -0700, Shakeel Butt wrote:
> > On Wed, Mar 11, 2020 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> > > > Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> > > > only let it affect the *local* process.  We could still put the page in
> > > > the swap cache, we just wouldn't go do the rmap walk.
> > >
> > > Is it really worth medling with the reclaim code and special case
> > > MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
> > > implementation that doesn't really touch shared pages because that can
> > > lead to all sorts of hard to debug and unexpected problems. So I would
> > > much rather go with a simple patch to check map count first and see
> > > whether somebody actually cares about those shared pages and go from
> > > there.
> > >
> > > Minchan, do you want to take my diff and turn it into the proper patch
> > > or should I do it.
> > >
> >
> > What about the remote_madvise(MADV_PAGEOUT)? Will your patch disable
> > the pageout from that code path as well for pages with mapcount > 1?
>
> Maybe, not because process_madvise syscall needs more previliedge(ie,
> PTRACE_MODE_ATTACH_FSCREDS) so I guess it would be more secure.
> So in that case, I want to rely on the LRU chance for shared pages.

I don't want the behavior of an madvise command to change depending on
*how* the command is invoked. MADV_PAGEOUT should do the same thing
regardless. If you want to allow purging of shared pages as well,
please add a new MADV_PAGEOUT_ALL or something and require a privilege
to use it.

> With that, the manager process could give a hint to several processes
> and finally makes them paging out.

On many different occasions over the past few years, I've found myself
wanting to ask the kernel to do bulk memory management operations. I'd
much rather add *one* facility to allow for multiple-target mm
operations than add one-off special cases for specific callers cases
as they come up. If we had such a bulk operation, the kernel could
inspect the bulk operation payload, see whether the number of
MADV_PAGEOUT requests for a given page were equal to the share count
for that page, and, if so, evict that page despite it being shared.

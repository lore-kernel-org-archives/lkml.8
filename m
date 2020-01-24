Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CA72075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PseXiLUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbgAXQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:37:26 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45003 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgAXQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:37:26 -0500
Received: by mail-io1-f65.google.com with SMTP id e7so2583273iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhdyP2R1pzKJgQYs4b5e0DuELiessERSVhnO5/9H1lM=;
        b=PseXiLUEGavafEcyD3qENC7uBgBp0mUuS+ESgjyl6Rma5dbjIopC9D1sF57pwNjkD9
         pOsXzgzEKsPbiFexf+GUHQTP0p447KvT09vLTJOexKNQ63yCRihECeD0Af2vycVsA3/W
         wIHdir+Ty9bw5qMVNdGLuOquZmprHgkK6IE00EoKyETVa1//IbWc0sbRWQOlPcdEz9b5
         woySlNgbyJAATurbh8tDp3b7wrbtw75FTpDlHcE0bHnDdqMuRgbNbgihxD1qrg5n+6v3
         ZfHWnvl474YcqPgWltD2PZ4c9MSIv1Gj21o7dMoGyKvzlwSTA0TR76nXMCYm+oGCP9+m
         bQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhdyP2R1pzKJgQYs4b5e0DuELiessERSVhnO5/9H1lM=;
        b=F6vMS93Flnr///pGOFyTwnw0vc35JHR2ZUYnzPdDB3+3jzPodefRA230G/x55svPAX
         m+r6PM1JDgiAwpaCQbFa9z0DlM+nrf2wU6uK2JfPOWilPfzCMI1OOZqgmwNe22+NQTu0
         ZnILfCf0jVhl87tZXY9sdTMRib0EwIESHnmJFcZHDs3ZGQE1GKKRkiNTXMKv8ItXM+Tt
         C8KwSJSSimQf2NNvp9C0GlwBSSR9ZulyaxwvMzRFuIaADxtWmvC3PDTmvX/7IMqXypQp
         l60pjjYFH4LOITaGDx/XcUgH8JqRrJcwczrauHUTw8fSJOrKKHMCqBPdAp0rs8U5Rm8c
         bVkg==
X-Gm-Message-State: APjAAAX7e7X06Qjpmt1UgUWv7YJ9UfltZFNXbJZ+1QBBzIttWAag9mq/
        OSmNFjhML6v220wuMtGQ/bq5NCFln5nDmckdnTDBhw==
X-Google-Smtp-Source: APXvYqxh3uR7vuRcLiz3bx95DqTAqg+FJcm6nZKBhbhrkKWFae/Iw9Orj/T3WTBf7kj3f+U2uCP2WyM8tAxC1mr2bqM=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr3059846jap.35.1579883845056;
 Fri, 24 Jan 2020 08:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz>
In-Reply-To: <20200108114952.GR32178@dhcp22.suse.cz>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Fri, 24 Jan 2020 08:37:12 -0800
Message-ID: <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for the replies and sorry for the delay (vacation + flu).

This has given me various ideas for experiments and I will try to get
to them in the future.  For now, the cgroup workaround (described in
my first version of the patch, but removed later) will do for us.

The purpose of my documentation patch was to make it clearer that
hibernation may fail in situations in which suspend-to-RAM works; for
instance, when there is no swap, and anonymous pages are over 50% of
total RAM.  I will send a new version of the patch which hopefully
makes this clearer.

From this discussion, it seems that it should be possible to set up
swap and hibernation in a way that increases the probability of
success when entering hibernation (or maybe make it a certainty?).  It
would be useful to include such setup in the documentation.  I don't
know how to do this (yet) but if anybody does, it would be a great
contribution.

Thanks!

On Wed, Jan 8, 2020 at 3:49 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 06-01-20 11:08:56, Luigi Semenzato wrote:
> > On Mon, Jan 6, 2020 at 4:53 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 26-12-19 14:02:04, Luigi Semenzato wrote:
> > > [...]
> > > > +Limitations of Hibernation
> > > > +==========================
> > > > +
> > > > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > > > +enough to contain a copy of all pages in use, to use it for the system
> > > > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > > > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > > > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > > > +
> > > > +One possible workaround (besides terminating enough processes) is to force
> > > > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > > > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > > > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > > > +operation is not guaranteed to succeed.
> > >
> > > I am not familiar with the hibernation process much. But what prevents
> > > those allocations to reclaim memory and push out the anonymous memory to
> > > the swap on demand during the hibernation's allocations?
> >
> > Good question, thanks.
> >
> > The hibernation image is stored into a swap device (or partition), so
> > I suppose one could set up two swap devices, giving a lower priority
> > to the hibernation device, so that it remains unused while the kernel
> > reclaims pages for the hibernation image.
>
> I do not think hibernation can choose which swap device to use. Having
> an additional swap device migh help though because there will be more
> space to swap out to.
>
> > If that works, then it may be appropriate to describe this technique
> > in Documentation/power/swsusp.rst.  There's a brief mention of this
> > situation in the Q/A section, but maybe this deserves more visibility.
> >
> > In my experience, the page allocator is prone to giving up in this
> > kind of situation.  But my experience is up to 4.X kernels.  Is this
> > guaranteed to work now?
>
> OK, I can see it now. I forgot about the ugly hack in the page allocator
> that hibernation is using. If there is no way to make a forward progress
> for the allocation and we enter the allocator oom path (__alloc_pages_may_oom)
> pm_suspended_storage() bails out early and the allocator gives up.
>
> That being said allocator would swap out processes so it doesn't make
> much sense to do that pro-actively. It can still fail if the swap is
> depleted though and then the hibernation gives up. This makes some sense
> because you wouldn't like to have something killed by the oom killer
> while hibernating right? Graceful failure should be a preferable action
> and let you decide what to do IMHO.
> --
> Michal Hocko
> SUSE Labs

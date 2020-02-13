Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457D3C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A02465D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="QQCi3sJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgBMNqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:46:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45533 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgBMNqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:46:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so4348463qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aw5WCdrOr580cO7oznYIDuNtsM6o28rEuLnOqaeZRwU=;
        b=QQCi3sJYPmlDH0+08h7f5QPcRZToa2l5Ay1lqldX9AFSHlwpwDsg9zFpn3G+maFQb1
         mxBkqapaVf2GFKPujVvHLUkAYazoB0Os3g9DsFUvav9VA8rFnOGGxWUZxDtPAgWpIfgC
         GErz0RmyTRICexIwjowvev80sx/HOUOqk6TBAtsCzsCfB3HOoxQKHvihfzetImr1HD9t
         jLGvuV0WSaG64pJGFlYkiEOEpvEu2SNFogeViOCAdem+ae2b8DT3MpvtrflblclDHDoB
         wDnUksoT2vuKaPMEav/3Zb+xiPr6RmO36fOMMzmGEagJ67X8FfdqIDritqGsxr2bJb2Q
         pP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aw5WCdrOr580cO7oznYIDuNtsM6o28rEuLnOqaeZRwU=;
        b=IxxTSw+QHhrAxdlILxRSBWC7T5q604KYU4FE5AOs3g4X0oU04hTbxZaqmtnR8OVmiI
         rW4mMmy3VFwOwhCyRsYnOuRb0iNgk3cGDD1Kps28o43gQdkIwBH3A7rBQ9GlF7Efq919
         xqziWJn91rP0htng9trjVuYCLi2aMSL3tIdzQBN/rVTNZdb1Y8HNg4Ez8rQDTnNe7skM
         3t5cWty0Rzyan3weq/5kFf+mXgY8iuG1lGFL6uF6HwHiG3ylb6DkhTLxsqtJpiGhIUlF
         LqX3vDzhYeo7hWCYuWqKgemJuACcIGu0UuYxqxo14pjECIk9YtrhkcHmPVXC5W7LWozy
         8p9A==
X-Gm-Message-State: APjAAAWihLt/OC+A21eIPwkyqu/Z0ek6zj55Jcdc2nNgnrWdG8fuPaKy
        WHCcJEwdwt9svsBJF3oV8zAc0Q==
X-Google-Smtp-Source: APXvYqyljAHy/xbcfUXzeaELTJkaqzwbXM/XyIPBZMe3LaVIHVB/IUQ8bhpTzXW6tq+JBV6tz2RgXg==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr11642514qtp.349.1581601588915;
        Thu, 13 Feb 2020 05:46:28 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id z21sm1331911qka.122.2020.02.13.05.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:46:28 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:46:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200213134627.GB208501@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <CALOAHbC3Bx3E7fwt35zuiHfuC8YyhVWA1tDh2KP+gQJoMtED3w@mail.gmail.com>
 <20200212164235.GB180867@cmpxchg.org>
 <CALOAHbCiBqdZzZVC7_c3Um_vDUu9ECsDYUebOL4+=MP9owA_Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCiBqdZzZVC7_c3Um_vDUu9ECsDYUebOL4+=MP9owA_Og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:47:29AM +0800, Yafang Shao wrote:
> On Thu, Feb 13, 2020 at 12:42 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Feb 12, 2020 at 08:25:45PM +0800, Yafang Shao wrote:
> > > On Wed, Feb 12, 2020 at 1:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > Another variant of this problem was recently observed, where the
> > > > kernel violates cgroups' memory.low protection settings and reclaims
> > > > page cache way beyond the configured thresholds. It was followed by a
> > > > proposal of a modified form of the reverted commit above, that
> > > > implements memory.low-sensitive shrinker skipping over populated
> > > > inodes on the LRU [1]. However, this proposal continues to run the
> > > > risk of attracting disproportionate reclaim pressure to a pool of
> > > > still-used inodes,
> > >
> > > Hi Johannes,
> > >
> > > If you really think that is a risk, what about bellow additional patch
> > > to fix this risk ?
> > >
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 80dddbc..61862d9 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -760,7 +760,7 @@ static bool memcg_can_reclaim_inode(struct inode *inode,
> > >                 goto out;
> > >
> > >         cgroup_size = mem_cgroup_size(memcg);
> > > -       if (inode->i_data.nrpages + protection >= cgroup_size)
> > > +       if (inode->i_data.nrpages)
> > >                 reclaimable = false;
> > >
> > >  out:
> > >
> > > With this additional patch, we skip all inodes in this memcg until all
> > > its page cache pages are reclaimed.
> >
> > Well that's something we've tried and had to revert because it caused
> > issues in slab reclaim. See the History part of my changelog.
> 
> You misuderstood it.
> The reverted patch skips all inodes in the system, while this patch
> only works when you turn on memcg.{min, low} protection.
> IOW, that is not a default behavior, while it only works when you want
> it and only effect your targeted memcg rather than the whole system.

I understand perfectly well.

Keeping unreclaimable inodes on the shrinker LRU causes the shrinker
to build up excessive pressure on all VFS objects. This is a
bug. Making it cgroup-specific doesn't make it less of a bug, it just
means you only hit the bug when you use cgroup memory protection.

> > > > while not addressing the more generic reclaim
> > > > inversion problem outside of a very specific cgroup application.
> > > >
> > >
> > > But I have a different understanding.  This method works like a
> > > knob. If you really care about your workingset (data), you should
> > > turn it on (i.e. by using memcg protection to protect them), while
> > > if you don't care about your workingset (data) then you'd better
> > > turn it off. That would be more flexible.  Regaring your case in the
> > > commit log, why not protect your linux git tree with memcg
> > > protection ?
> >
> > I can't imagine a scenario where I *wouldn't* care about my
> > workingset, though. Why should it be opt-in, not the default?
> 
> Because the default behavior has caused the XFS performace hit.

That means that with your proposal you cannot use cgroup memory
protection for workloads that run on xfs.

(And if I remember the bug report correctly, this wasn't just xfs. It
also caused metadata caches on other filesystems to get trashed. xfs
was just more pronounced because it does sync inode flushing from the
shrinker, adding write stalls to the mix of metadata cache misses.)

What I'm proposing is an implementation that protects hot page cache
without causing excessive shrinker pressure and rotations.

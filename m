Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F707C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7004420714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Ju6xzVVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLQmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:42:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45650 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:42:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id a2so2630232qko.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lC+Mj++3/YMXsXdmajO0Uv+d9BNYm/4DozkgCzMx0BQ=;
        b=Ju6xzVVYJuf1V04IsW43lvJOoF0zm1mTaMQ/PSiBynZq6VxAQTaoI3riOkEyS4wYj5
         gh5Ky9uPnY3nC77nxWhWbxQic03Y6rTivuXjxT+HHMhOZ7uaMDRHzkCxWsYlNoNOYo+8
         R7GvNf8bZSx7zxJVp5YSGq6iFVr09xiXA9jywKHwnqRVB30qmvGW+tRMI0MkyV3kL8VL
         phfinaVmeAAbzvJWFrOgl6MFfjkH4Lu39AkI6zDv3t+F/9Hjuffz3i1t0fCyPeAGXUds
         gXYQ6cfasR0c9iDHo+DTD6lbhf4qTFZWsbhW4XKnMOprjGKkrHP2D6dhSVnK35OXS4V7
         pWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lC+Mj++3/YMXsXdmajO0Uv+d9BNYm/4DozkgCzMx0BQ=;
        b=rYbRIAZNqYYpxpu69t9VO9Z1Xch0Fj7X/UOmeojnz5T9KVHHmVwYfR0q86zqYDvhnv
         hsieMW+jrHBzF5HfhqEaKx1YKmVz2bVrcidXQvo4NNskIQx57jvo3dWLt3p5tMJyztTV
         36FryUV3zlHafIvIGw9C3kGPKiyp3kConNr/6uCgjB0/ClUS6PP83MpZd1/QgiCRGCj+
         tbJDxDxm08bmP1McYInN7/Mz1NKYzEi2yGmHVfhIvrBEqa9gaa0fwKmcintKMUgr+unX
         gSklWZZ52vtzeygs76TCHPeScL8BQ0QDgXGVMBSw96B/j9zjK/GMiNb4eEd3zXZrUf+f
         MA8g==
X-Gm-Message-State: APjAAAWGbLnKDvY+4MrP8hBJVCbxc3z2YWpTfGm8NAGkCBtt+b7IX2Lp
        srf3nWtw5zCgrjyxTryBCMiUgQ==
X-Google-Smtp-Source: APXvYqz7V5yTkuSB9pl1fNnJzdUoKrXHVZQvM+wS9anG9Lq+6SvM0jdgqYqGHETcydHb23ay3CgY1A==
X-Received: by 2002:a05:620a:c91:: with SMTP id q17mr11958572qki.168.1581525756526;
        Wed, 12 Feb 2020 08:42:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:26be])
        by smtp.gmail.com with ESMTPSA id v55sm517848qtc.1.2020.02.12.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:42:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:42:35 -0500
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
Message-ID: <20200212164235.GB180867@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <CALOAHbC3Bx3E7fwt35zuiHfuC8YyhVWA1tDh2KP+gQJoMtED3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC3Bx3E7fwt35zuiHfuC8YyhVWA1tDh2KP+gQJoMtED3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:25:45PM +0800, Yafang Shao wrote:
> On Wed, Feb 12, 2020 at 1:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Another variant of this problem was recently observed, where the
> > kernel violates cgroups' memory.low protection settings and reclaims
> > page cache way beyond the configured thresholds. It was followed by a
> > proposal of a modified form of the reverted commit above, that
> > implements memory.low-sensitive shrinker skipping over populated
> > inodes on the LRU [1]. However, this proposal continues to run the
> > risk of attracting disproportionate reclaim pressure to a pool of
> > still-used inodes,
> 
> Hi Johannes,
> 
> If you really think that is a risk, what about bellow additional patch
> to fix this risk ?
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 80dddbc..61862d9 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -760,7 +760,7 @@ static bool memcg_can_reclaim_inode(struct inode *inode,
>                 goto out;
> 
>         cgroup_size = mem_cgroup_size(memcg);
> -       if (inode->i_data.nrpages + protection >= cgroup_size)
> +       if (inode->i_data.nrpages)
>                 reclaimable = false;
> 
>  out:
> 
> With this additional patch, we skip all inodes in this memcg until all
> its page cache pages are reclaimed.

Well that's something we've tried and had to revert because it caused
issues in slab reclaim. See the History part of my changelog.

> > while not addressing the more generic reclaim
> > inversion problem outside of a very specific cgroup application.
> >
> 
> But I have a different understanding.  This method works like a
> knob. If you really care about your workingset (data), you should
> turn it on (i.e. by using memcg protection to protect them), while
> if you don't care about your workingset (data) then you'd better
> turn it off. That would be more flexible.  Regaring your case in the
> commit log, why not protect your linux git tree with memcg
> protection ?

I can't imagine a scenario where I *wouldn't* care about my
workingset, though. Why should it be opt-in, not the default?

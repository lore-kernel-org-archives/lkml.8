Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4204EC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EBC2495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceRHV0SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgEHOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:05:59 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A2EC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 07:05:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so1512443lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haWmS+1+Op4dfd1PUhzKPboaEpLi6w7LL8kma7vTFIQ=;
        b=ceRHV0SNg4h4ryrKrtL+3goG0C5w1BGZ6KqlDlRV87kNxeqK3n/RrJb77F/LD7K2kA
         ajA4v6WXyozZqr4ooDAaotW6Gmp4FSRZRsz+KBrUVuwipH9+gQAH66kcLQltW6kzCgAX
         k56pf083vAds2fUez4gXK949rfm5yqXY7RJ9ZhCN852Nn1+lrsqAfTmNSxQxGKLJsu1p
         xPNV21RUEmi+zihVeAo/MEyl18ZwkrvqtQ4oXiJ8L4EuE5auYTVNqBH9v8xXv+OBWUV9
         +qXN+nn3ZxbaTQqQxc4yYAZK/ULG64bAfRo4PAypAXFuoM8Cn8KuLEWp7sW/DjSu70kd
         egLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haWmS+1+Op4dfd1PUhzKPboaEpLi6w7LL8kma7vTFIQ=;
        b=tOIdt5uXadPU5Y658VpHtgd1qAxbuJBMl5UIaDm0obk0gSB91OO0X3NsMKvwmfyYQ4
         ht+O0oPiQJ/o6lsv8go32Op+fUTz3QaxOtguu0VwBgCyZQfMWDoSVu0zMW9mOKAXZQ1K
         YKhT/VRTEprIPrzlJJaU4jbaYaM+sXeE5IfAmN9PZiBnKYlqv41R4jwqWPDbP0grGJPo
         wAEIvA95f9mKI8GQHRh1b1nP6cOFAIHy98stNHT3pkHJ6/SmebDxcGY/BQys0yQca+Wa
         ykexEGuI+PWJ0Z7y/u8BjWufoWpG2q2hUxVUTCcrmgKkSXOzWPYvGBYMno0vqiyYOpCu
         xR9A==
X-Gm-Message-State: AOAM532K5Vsk2oFauf/L1tJFMpnfL195n55h7L8pr5uGMHAv8JTfNbz/
        2hVsEAQ9+QgDqI8ZlYD7MoKwxXJW2vJrauxQdAs4/g==
X-Google-Smtp-Source: ABdhPJzWKnpzpuP5Fo7MSokFci1F2YxKHYybV0HCCXbto4nKblgCcA1HHeNX6K7OjYTbWvgiqleAt6aGcHWTXLAbNOI=
X-Received: by 2002:a19:f512:: with SMTP id j18mr2007829lfb.33.1588946757557;
 Fri, 08 May 2020 07:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200507204913.18661-1-shakeelb@google.com> <CALOAHbAHK4b2p0oWXY6oHG+WQzK3+TEa46=dPabhYT8ab=65zA@mail.gmail.com>
 <CALvZod7VujYgU=6XfgjSZnzLqDpbHwEYsp2Xbq9MK7w_z=LphA@mail.gmail.com> <20200508133833.GA181181@cmpxchg.org>
In-Reply-To: <20200508133833.GA181181@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 8 May 2020 07:05:46 -0700
Message-ID: <CALvZod4iq9vwgDsg1dV1eoVTpOpio0BSwxgf-H-QUGwzTDCc8g@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 6:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
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
> > Don't you need pgrefill in addition to pgscan and pgsteal to get the
> > full picture of the reclaim activity?
>
> I actually almost never look at pgrefill.
>

Nowadays we are looking at reclaim cost on high utilization
machines/devices and noticed that rmap walk takes more than 60/70% of
the CPU cost of the reclaim. Kernel does rmap walks in
shrink_active_list and shrink_page_list and pgscan and pgrefill are
good approximations of the number of rmap walks during a reclaim.

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

Actually I would prefer adding memory.stat at the root cgroup level as
you noted below that more use-cases would benefit from it.

> There are subtle differences between /proc/vmstat and memory.stat, and
> cgroup-aware code that wants to watch the full hierarchy currently has
> to know about these intricacies and translate semantics back and forth.
>
> Generally having the fully recursive memory.stat at the root level
> could help a broader range of usecases.

Thanks for the feedback. I will send the patch with the additional motivation.

Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A422C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuH+P3Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGJOMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:12:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9FC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:12:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so6609006ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKCWrTfr3M3VE4zZraZncAFHMeh1ED72eMf914LZfYE=;
        b=vuH+P3LxQOhQzesxYlIlfiMh1qXv9/xVVXJv14axnvi9nFSaX0pINMUMb3BuL/K29E
         8xjQ+MPMBLBSys5Npfb+b9A9SWsdvjMFZ7AbFQD1KRDWUkNX308eSDqg0AAz9UaLwj6J
         qpQMQZ9PxlFmIuGPQ4NI9buSv9aP9P3EfCInUHeaVaVTIT3Tfr6qDd57DUnSvOHMkzJQ
         JGMdTceGMmn1A5xPQfaZQjJGeajN0FPeNvmAmWY0OTp8XsOxyg/waavYXcu30KyNqXdC
         p8TkcQvqHrlLWeHu8EJeBhkqH72QPFopaz4sIjtAXuicSSLd4hYpCIa9O7Ct/DKWR8Wt
         9/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKCWrTfr3M3VE4zZraZncAFHMeh1ED72eMf914LZfYE=;
        b=aFjptTj/KZpxyTPf5ULS82eSygJCuOI16JMWOJHmxyi/rCe4QTpypKUzJYUQdIDtXl
         Y8CSucxFRwCMT/xWKi1qMhQyn3yoRq7r5rAbUEaMi9agh1S57jhe8S6dxzXBN3NV4H9l
         9Fgv5YnHJ7IexgrqiKtOJ6eNtvH5/w8GrrZHVRo25J2qfvLFbjf9gezBk352JhLYjxVM
         AKzfj9ayUelYtPdcDyC/sKbUGT9NwTOXDpZHDUwu100KQJorEuCLWj3VXcYLCDDozCHR
         /tsgcs45RQNrXHFjN4Ao9q/X39fJCsSaxAcioiWhQZDQT2O32ujZYv+KnGr3GD/C8Fzw
         QaXQ==
X-Gm-Message-State: AOAM530K0ZH9NLvqtdrNyWVEeUHi5ak/AoEqIgMu6MHznWyIRITGZ1+f
        xr3INFBl8a6cqfqIV8qL0iwMbIQJE8OjgnhygeYTMQ==
X-Google-Smtp-Source: ABdhPJzlre8tOErvRW+mpIkqnqyceO+sOQTbl0pF6vq8FjFLcm4k96A3c2vvmcqnvoMOopZqXZ7b09p1tN16Pya7kWQ=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr38227429ljb.192.1594390354195;
 Fri, 10 Jul 2020 07:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200709194718.189231-1-guro@fb.com> <20200710122917.GB3022@dhcp22.suse.cz>
In-Reply-To: <20200710122917.GB3022@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jul 2020 07:12:22 -0700
Message-ID: <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering memory.high
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > Memory.high limit is implemented in a way such that the kernel
> > penalizes all threads which are allocating a memory over the limit.
> > Forcing all threads into the synchronous reclaim and adding some
> > artificial delays allows to slow down the memory consumption and
> > potentially give some time for userspace oom handlers/resource control
> > agents to react.
> >
> > It works nicely if the memory usage is hitting the limit from below,
> > however it works sub-optimal if a user adjusts memory.high to a value
> > way below the current memory usage. It basically forces all workload
> > threads (doing any memory allocations) into the synchronous reclaim
> > and sleep. This makes the workload completely unresponsive for
> > a long period of time and can also lead to a system-wide contention on
> > lru locks. It can happen even if the workload is not actually tight on
> > memory and has, for example, a ton of cold pagecache.
> >
> > In the current implementation writing to memory.high causes an atomic
> > update of page counter's high value followed by an attempt to reclaim
> > enough memory to fit into the new limit. To fix the problem described
> > above, all we need is to change the order of execution: try to push
> > the memory usage under the limit first, and only then set the new
> > high limit.
>
> Shakeel would this help with your pro-active reclaim usecase? It would
> require to reset the high limit right after the reclaim returns which is
> quite ugly but it would at least not require a completely new interface.
> You would simply do
>         high = current - to_reclaim
>         echo $high > memory.high
>         echo infinity > memory.high # To prevent direct reclaim
>                                     # allocation stalls
>

This will reduce the chance of stalls but the interface is still
non-delegatable i.e. applications can not change their own memory.high
for the use-cases like application controlled proactive reclaim and
uswapd.

One more ugly fix would be to add one more layer of cgroup and the
application use memory.high of that layer to fulfill such use-cases.

I think providing a new interface would allow us to have a much
cleaner solution than to settle on a bunch of ugly hacks.

> The primary reason to set the high limit in advance was to catch
> potential runaways more effectively because they would just get
> throttled while memory_high_write is reclaiming. With this change
> the reclaim here might be just playing never ending catch up. On the
> plus side a break out from the reclaim loop would just enforce the limit
> so if the operation takes too long then the reclaim burden will move
> over to consumers eventually. So I do not see any real danger.
>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Domas Mituzas <domas@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Chris Down <chris@chrisdown.name>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>

This patch seems reasonable on its own.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

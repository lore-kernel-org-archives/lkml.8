Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCACAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976E220724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDiTpn6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHTOKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgHTOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:09:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F23C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:09:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so2248411ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QmlrH5CiuRkmxJXZDPt36i/vip9Z2n7QUlr3nkzcfk=;
        b=TDiTpn6AvNVYAPAHe+WHOdpes7ZCrPGKCWgYxRBAcehaFP/IOqxo11ftGmwkrlj03N
         IaSctJ248Ukd4xPn78MBWwSm18dDZmgIhBuPcj2woTw4jJMKIZ2wiLsqRsA9s7ACbJ69
         WYymgdJAZISKTjdBQoewYjE9nCTFg6ahn4+6jdb5O87srLm9FAYFd/euB2gVVeQ3WQRa
         BCptZ6t8vI3WaMp0KZeDiH+qy14I2o1XTLNGS8j7U8VH5LZSOWRhK+OQcB6rqz6dyPG+
         sf65dk/z5nw0v2KAAWAnHwWMpGPj3yZaX7ZV66AJGTiB2MbPSbQlXWe8IkDyuBllti+0
         A+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QmlrH5CiuRkmxJXZDPt36i/vip9Z2n7QUlr3nkzcfk=;
        b=MBEwNVZXpGCcm4YgEbACc/Lk84gVbuVYgsxRNI8FR7Go1qIKG2KtwIFSXex3II9ns9
         DFjZxi7QUuFdIZmBJit0GcdQmsrorvFh69P/oJSpf+NXX70iYGwUanWNF4WLiFdRthOj
         VyarL/kXMRfQn1+93+3EDapu282CO6zkNA41FJQoYNlZf01Cow05DEVQ9YeE8wO/NKfo
         TY9rez+s6HoYfZsKXWOKjkDgg14RI06gwIAmriELewdlu2NAYiUh+6tCEaPCMnZTGKKt
         Z6x2i7q+H9kz8T8XycgD2RFZvL55G14S76gQO9TCDevBrZnkW2dcs/cfxR4g8+llLG8X
         BvtQ==
X-Gm-Message-State: AOAM5314Au+j5aVRtGI8Reztb4pXWHGCIsVTbP8l0peu3kXXKT5PHgpT
        pLItpWupMug8wt8rGYHw3MwRS2tJpqCeDW8JByXyMQ==
X-Google-Smtp-Source: ABdhPJz571tnLGBkD4FyDqGMVdula/BPOvEP0VwtBTQiIWOGyD16OIXKdiik3BeH69NRziD5pTJE41AkBgKTE1Gk9og=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr1608004lji.156.1597932568936;
 Thu, 20 Aug 2020 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200820134341.GW2674@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Aug 2020 16:09:17 +0200
Message-ID: <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiang Biao <benbjiang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
>
> > That's been said, not compensating the vruntime for a sched_idle task
> > makes sense for me. Even if that will only help for others task in the
> > same cfs_rq
>
> Yeah, but it is worth the extra pointer chasing and branches?

For that I let Jiang provides figures to show the worthful

>
> Then again, I suppose we started all that with the idle_h_nr_running
> nonsense :/

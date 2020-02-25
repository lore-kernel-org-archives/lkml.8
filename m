Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BEEC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6AE2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CE5SJGtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgBYOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:53:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42455 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgBYOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:53:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id 83so9945180lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt/wWhOlTt8p3C5+NXIFHX4ZEi4eWU8DqAZIDXX33/8=;
        b=CE5SJGtVy3XV0e5b2esEZytrlbaIIZXk1k+zoMBg/HQ0ASUdTbDvFXCW/4FsTRXtyY
         18O3on0BNjjHVwk7fHUiwKY+iwJZLSN9q0ku/6WGtlHhhuYQO61huYOw7u7gEGiFzKBW
         W3Z5rJFz8XazVGRg5D4UhMfXUhH+u+O1ZciirXngKrJ+xauCbtFH4Ri753UFbjPGjynd
         czgZYRs+7iQ5X8RbQkdQoqADOzq8q4bL/G6xPCuLKgpTKFY4v+MLw+E1kmRz49e7krxn
         dU3TmgyAH89eLlS+bVuwAGCcLzEFIp40QBZgjvONrYoBvAKpO6MGUPlsNiYpcYtKXUfH
         sAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt/wWhOlTt8p3C5+NXIFHX4ZEi4eWU8DqAZIDXX33/8=;
        b=XQDh8k+eOd/61B3l6XekfH/lLmTsadtfw3OCcLcOy4xeQA68WIU1r48nalSRGZtbkZ
         74oG3FSR9ZikCQbvSnhsOQZu/Wt3MQ8HSpFIWoX5jcjsJOzOCmRXzhpW3j3otH927F/J
         DjNMThytNAU7yhNMCWGKP09qYsQ8dFr2v//1TzMNmVhS+dEKXfW6FkcPerzJJuQYN8wp
         D8R60ICSgoa+KGZXSJTrktfbScB7rRz6hu/I2984mPWO+Kuk8A/GE3Ozq1daZW7Hn3sR
         56kd26ErXPNmNhzTn0mffbRQZ0CahXqVU3ugP/wG7PsS+ip3r7OHM5SrJKmhblrkGb65
         Jf2A==
X-Gm-Message-State: APjAAAWASq037cz77zwBH7qDssSLHRQooUleWPYyAXBH7Sxqnx8hYeuo
        k2v8Yau/pI+N1fkTFv8wcyiU3vMrrdIN5KgozXfKng==
X-Google-Smtp-Source: APXvYqxrjLKs7J1HoXBE045RYrnnvUJLZSYEDFqoQc6nXOJPfWxG/Gcgk381zcGTm4VVAMqIb9INUjc05A4gWkEDOOE=
X-Received: by 2002:ac2:5633:: with SMTP id b19mr20123317lff.149.1582642434876;
 Tue, 25 Feb 2020 06:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200224151641.GA24316@gmail.com> <20200225115901.GB3466@techsingularity.net>
 <CAKfTPtDN-XP7LAyy-zQ-J=nxv5M1x_f2AZ2qJ8CK6B82f5WwYg@mail.gmail.com> <20200225142430.GC3466@techsingularity.net>
In-Reply-To: <20200225142430.GC3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Feb 2020 15:53:43 +0100
Message-ID: <CAKfTPtBC1o5hV7riKdNi+QswqxJ1p9ZdYSDSTNAQFtf8GKtzww@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 15:24, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Feb 25, 2020 at 02:28:16PM +0100, Vincent Guittot wrote:
> > >
> > > Will do.
> > >
> > > However I noticed that "sched/fair: Fix find_idlest_group() to handle
> > > CPU affinity" did not make it to tip/sched/core. Peter seemed to think it
> > > was fine. Was it rejected or is it just sitting in Peter's queue somewhere?
> >
> > The patch has already reached mainline through tip/sched-urgent-for-linus
> >
>
> Bah, I pasted the wrong subject. I am thinking of your
> patch "sched/fair: fix statistics for find_idlest_group" --
> https://lore.kernel.org/lkml/20200218144534.4564-1-vincent.guittot@linaro.org/
> It still appears to be relevant or did I miss something else?

you're right, it's not yet in tip/sched/core but most probably in Peter's queue

>
> --
> Mel Gorman
> SUSE Labs

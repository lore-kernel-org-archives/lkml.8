Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE1C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHg3n63C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgBYN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:28:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36414 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:28:31 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so9773422lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN3nklLh7iurBWH/UJXuipp0J1sWWgcAqmwXBEBoy0U=;
        b=nHg3n63CTCpz4DEPtME/gXivdxRFXAg50TUq8/vcR0zAaaGEff/9v8/fCmVblZRW9Q
         vniun1gTztuq4WPovSIDFHjqLU1Y7qD/l9vfkzRuImdCSGdXH7a9MdavDkjWm4yRBqCM
         4ljDlVkHmBEiOMmnFxSKVFME3llOuR9HI3qey/pJg1ISNgg1txxEAKtjERtUqb+rgdcP
         HhKw++MrNmkN3T8GPoXdSWFeU5/dBDtQmTlwruWg6mmp7ko7GfTtNOQmyyGOX8dZGGQF
         82dxlmKlePiyI6MsQG+B1wpI0xSbj7wNJlaRybL6jMUDwnlBs5l1HjHmThGINJStZI6j
         264Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN3nklLh7iurBWH/UJXuipp0J1sWWgcAqmwXBEBoy0U=;
        b=XuN4qhEICQ1jjx7bSEikuQh1W2Xv4r5ZFUyFqn6XYj/mlejRnwAm4wC7cVQHxKyIMn
         r1lk0pZbdiaQVw4r1sGBOsFiGu6C9UjPNmHnTqdmGUdHoq7XCVZEiwSZ9QEY+5UwSITP
         naVX3UJQrQQBVNHTamgz2Aa4MontU+MOWer8tj2YrmHM5YANVH9jfq5ZT3lFwSMPnCeZ
         r0YXIWEq+ZQBlorrUPbGjwZjnIPOxlml9aL8UotSuQfOzvIYsbrhDrXmQaMZkGnlw2Ja
         SWLU3WntytmqfljHwJR1LZ/vme7YkbTeL7dk8DxLj5z+85D4kQvAn9I+h47PSSbLj8u4
         z/4A==
X-Gm-Message-State: APjAAAXNmdTjatBYkaVcxvTOmp07VcPZrYqVtzp9tdW6tBjqn7MXtTUn
        UPUV/YbXyylgKdfPFr99z2DzxvV8zXVWG4NP36LVKg==
X-Google-Smtp-Source: APXvYqwI88JXS8cPaahsAw4faFuvHw4zBrJlJDpAxF5rQm8C/i5fWixRyqbaPdexBGZNsdqo3ImTLzD4pk4K3FTIbAg=
X-Received: by 2002:ac2:5492:: with SMTP id t18mr13522828lfk.184.1582637307767;
 Tue, 25 Feb 2020 05:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200224151641.GA24316@gmail.com> <20200225115901.GB3466@techsingularity.net>
In-Reply-To: <20200225115901.GB3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Feb 2020 14:28:16 +0100
Message-ID: <CAKfTPtDN-XP7LAyy-zQ-J=nxv5M1x_f2AZ2qJ8CK6B82f5WwYg@mail.gmail.com>
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

On Tue, 25 Feb 2020 at 12:59, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Feb 24, 2020 at 04:16:41PM +0100, Ingo Molnar wrote:
> >
> > * Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > > The only differences in V6 are due to Vincent's latest patch series.
> > >
> > > This is V5 which includes the latest versions of Vincent's patch
> > > addressing review feedback. Patches 4-9 are Vincent's work plus one
> > > important performance fix. Vincent's patches were retested and while
> > > not presented in detail, it was mostly an improvement.
> > >
> > > Changelog since V5:
> > > o Import Vincent's latest patch set
> >
> > >  include/linux/sched.h        |  31 ++-
> > >  include/trace/events/sched.h |  49 ++--
> > >  kernel/sched/core.c          |  13 -
> > >  kernel/sched/debug.c         |  17 +-
> > >  kernel/sched/fair.c          | 626 ++++++++++++++++++++++++++++---------------
> > >  kernel/sched/pelt.c          |  59 ++--
> > >  kernel/sched/sched.h         |  42 ++-
> > >  7 files changed, 535 insertions(+), 302 deletions(-)
> >
> > Applied to tip:sched/core for v5.7 inclusion, thanks Mel and Vincent!
> >
>
> Thanks!
>
> > Please base future iterations on top of a0f03b617c3b (current
> > sched/core).
> >
>
> Will do.
>
> However I noticed that "sched/fair: Fix find_idlest_group() to handle
> CPU affinity" did not make it to tip/sched/core. Peter seemed to think it
> was fine. Was it rejected or is it just sitting in Peter's queue somewhere?

The patch has already reached mainline through tip/sched-urgent-for-linus

>
> --
> Mel Gorman
> SUSE Labs

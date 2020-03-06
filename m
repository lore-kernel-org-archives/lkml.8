Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFFBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1F206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncOXjfUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCFWeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:34:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41669 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgCFWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:34:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so4172479oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olqcvdNDEsEEHVidSmBf224StzdHlYaDh6Q/H8VQ18U=;
        b=ncOXjfUXXjzZmhUyLfXPdhqFTnTUDE3cbPGJmmH+5gyunAAbQJNixohNMdpUXu3weq
         u3g72vmPpNK9Za0wb96gzEnLKkQi3kMENHQwul4TJ30lrAe2jS2MEW3Xl0xFFrw59JSM
         eTyr5+ovLGL2FfnWz74Rx5rsr6KwTa8cidtSiIXAFcLR2R1INwjLAb6IGNthq5njhTfi
         MzT7L7ALNJd4lfU33h9yxtr7Ci4zuxUG3bmFKoniFNh11yAm7+QaNR10Z/WEzL57NITe
         j59SHdXYLUzyz4cU0LnyC39/HzF2OIcKZL2mCVBMx9a3ioPiZ4OrnfMGaHhUiXqy8s8r
         Ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olqcvdNDEsEEHVidSmBf224StzdHlYaDh6Q/H8VQ18U=;
        b=O76O7PMVKc2usuZSpjVE/d9yDUiNd1foGOGCDaYahPjGtpGj1ZApViH9NP8nzjRlHN
         opDpprGijlcwmmjNI9nDgLmGyhe9gUTsMQ3PdCr5ooqDy5VSEKaE7RmPOAYHpaZfzzoB
         vThAxDkq+9y6e9i/kDzkd8NTnZeUzi3RBrY+pLbNbNsV1PLUgUQ0sXMcmjsNR6sTOyLD
         Dn84jHyhb6zNBJ2NQhscORxifHbsDBCTYIuxoJWLt8N/FqaGNSVMPjBtWTqI51WlhP+l
         japNHQFlDzjuInLZ16QjjUaIVfy84jQXFLw/NwZLHovvydf+NcNyrT8AoTokRYSFmKm4
         tRtw==
X-Gm-Message-State: ANhLgQ2N9xDzI2wOYAhk2ySNFYMPOWBqAH2pDOg2QWiJy9cHSI6b8JYB
        b3nZ6MOgYkDhRfgeG+RUHMOBkK8tDL9XpSL4dWIx6A==
X-Google-Smtp-Source: ADFU+vtTQSCYfIkPWGQBtgesUsSbSZpEfanm2wnfHb9jO/zQFzUpzK3PpcOTydL+5qHVyJMO0k3v0fOAvG43iDXTH0c=
X-Received: by 2002:aca:75c1:: with SMTP id q184mr4264436oic.35.1583534054174;
 Fri, 06 Mar 2020 14:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com> <20200306084039.GC12561@hirez.programming.kicks-ass.net>
In-Reply-To: <20200306084039.GC12561@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Fri, 6 Mar 2020 14:34:20 -0800
Message-ID: <CAOBoifiWWcodi9HddxVsKUahTSdAS5OiQOcapDJ-4p+HufRzeQ@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 05, 2020 at 02:11:49PM -0800, Paul Turner wrote:
> > The goal is to improve jitter since we're constantly periodically
> > preempting other classes to run the watchdog.   Even on a single CPU
> > this is measurable as jitter in the us range.  But, what increases the
> > motivation is this disruption has been recently magnified by CPU
> > "gifts" which require evicting the whole core when one of the siblings
> > schedules one of these watchdog threads.
> >
> > The majority outcome being asserted here is that we could actually
> > exercise pick_next_task if required -- there are other potential
> > things this will catch, but they are much more braindead generally
> > speaking (e.g. a bug in pick_next_task itself).
>
> I still utterly hate what the patch does though; there is no way I'll
> have watchdog code hook in the scheduler like this. That's just asking
> for trouble.
>
> Why isn't it sufficient to sample the existing context switch counters
> from the watchdog? And why can't we fix that?

We could go to pick next and repick the same task. There won't be a
context switch but we still want to hold the watchdog. I assume such a
counter also needs to be per cpu and inside the rq lock. There doesn't
seem to be an existing one that fits this purpose.

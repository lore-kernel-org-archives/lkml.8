Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6113BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCC322D00
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="do/I7ZmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgH0PnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgH0PnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:43:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3BC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:43:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so6988373ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIpBinZVLwccOBlQBwmOknbrZNBrR3bkWjqwBSx1Ckk=;
        b=do/I7ZmOR+XxfTQSZQQaQ86eu/9s9+55pppFDCRfQVmCBPn46dcJvtoSCNbWpXtLfu
         gNHYltkazjgDNSkazXFvBneCeymvSKxWuuhdtYjX7h7AqkZthPn4B2Sgt3F3StbC4TLK
         ezCNJMCiVaiNm0ZFilZFiLjiLJ8o6F8xl8Hmqm4H5khKSO+ysQWZBoB2qaEavG1D/3LH
         nSFPh/vz+UDNUbRqGbdl6RMUnx/ojj/PZPvoVqJKJvYVgnzbb0OojXmC+DLMW6o5cX1z
         5LdwEHy90I9RnPiejmoo5mH9lV8CKh6CUgGfDp6oCbbo6rbf0GzSokbnQyuoNx2cHgc1
         Cosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIpBinZVLwccOBlQBwmOknbrZNBrR3bkWjqwBSx1Ckk=;
        b=qtSXptf0VakKQAWG2TAxFWfmiRKoFHFyvV+eIX4JthckMbPsSNqhSezw1ndZj96tX/
         Pvzh5VJTvuca+BXue2ZOBU4RHyrvNIg0tHpnl8vhbBhnc2C9LNq3HP7X7DOXcDModSZN
         ApN5rvHG9MiqGf/lrweDQAgo/gbm7RPa9w7Go7n5u+HMDLldKd1wLGeWdfjBYSy1PPW+
         oRL5n9aT40blgx9hiflEFHjridNBXAtFu88/AMjFjr2W8656kpMqtY4/MqHcbhwaBpLv
         AQ3FEXlENHUgUYG7hYXbF43htA99Q2KCbJJju2h4+e9l1uY9C78GdhP2YUrHvia2HEEc
         8NUQ==
X-Gm-Message-State: AOAM531T3z4euyFRqPcuhDIViDv1a6UNpspy1mBU81tY8GCcjrKs1scd
        m4qHKMeXaB3q5T4ZUdLGS59W6pq9HLUaaWmzz1ibBg==
X-Google-Smtp-Source: ABdhPJyVXHaWDvLF6jvFEiQw9jw4Oje6jc/9baf3oe2YEBqqjLzQH3oGnTTaDIRk2YN+H3bR/D4WHwMzPUPYw481bnU=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr10463710lji.226.1598543003021;
 Thu, 27 Aug 2020 08:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200825121818.30260-1-vincent.guittot@linaro.org> <20200827153534.GF3033@suse.de>
In-Reply-To: <20200827153534.GF3033@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Aug 2020 17:43:11 +0200
Message-ID: <CAKfTPtCRmts+qH+hexKbhZ7595zGs1U3Q5V4-XzHgpU0dJd+1Q@mail.gmail.com>
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 17:35, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Aug 25, 2020 at 02:18:18PM +0200, Vincent Guittot wrote:
> > Use runnable_avg to classify numa node state similarly to what is done for
> > normal load balancer. This helps to ensure that numa and normal balancers
> > use the same view of the state of the system.
> >
> > - large arm64system: 2 nodes / 224 CPUs
> > hackbench -l (256000/#grp) -g #grp
> >
> > grp    tip/sched/core         +patchset              improvement
> > 1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
> > 4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
> > 16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
> > 32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
> > 64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
> > 128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
> > 256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> The testing was a mixed bag of wins and losses but wins more than it
> loses. Biggest loss was a 9.04% regression on nas-SP using openmp for
> parallelisation on Zen1. Biggest win was around 8% gain running
> specjbb2005 on Zen2 (with some major gains of up to 55% for some thread
> counts). Most workloads were stable across multiple Intel and AMD
> machines.
>
> There were some oddities in changes in NUMA scanning rate but that is
> likely a side-effect because the locality over time for the same loads
> did not look obviously worse. There was no negative result I could point
> at that was not offset by a positive result elsewhere. Given it's not
> a univeral win or loss, matching numa and lb balancing as closely as
> possible is best so
>
> Reviewed-by: Mel Gorman <mgorman@suse.de>

Thanks.

I will try to reproduce the nas-SP test on my setup to see what is going one

Vincent

>
> Thanks.
>
> --
> Mel Gorman
> SUSE Labs

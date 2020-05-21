Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47531C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B5D2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agJptvDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgEUV6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgEUV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:58:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42BC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:58:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so6802618ote.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OC7pxxrJMqItGQPkx3AN3oqBodwXwxXMLvm54F0Ovsc=;
        b=agJptvDPSQjxg/DsE2tCtsnV2z/LvokUuBh021Hk7gHFmAeZIaFSMroK1vn1omWhzK
         uFr2ZIZgIJQVUiio0NurWPJDb/T/iB2P4NjYCAOjtLYAu9xdTTRpKU8tS6j63ZCaMSm/
         r6ssH40PnZaTQ7986SY+MZc2bh6QefQ6ccGGp9qpDtBOIicwF/UrWPZKn2aVGvkek/U9
         Bf3CjuUiy36of9wsCRLuG1eH2Q7Nk665kfzcKRdh5Y06k/FBYKuxaoSzdbGR15Wxwnkw
         FDmkMBg0cAUByhFBo3dW0x5zVYW1PxWdLEkAC6KDTWHfaJOF8vWe9qd0ibxXAmWgRMs5
         ug6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OC7pxxrJMqItGQPkx3AN3oqBodwXwxXMLvm54F0Ovsc=;
        b=LCcVRYJ7sIw1RTCHZNDN8H8vtGmFyUF0nV0oiTZNPYv6vZznhGVXRow6Rfq6/+U2VQ
         vkJzMKDoi3YSs1mbUHRoyzAARWBbboqIVIrN2RGbjcwZ8XlGXL7poOs6i9lJ1u3ESO/X
         TJwj4Ic+DafWFIBdKTHDgE1Cb/0B7hZ2pGVRSi+8M0xOKaqaCf18oC0/U7nAV3AS+5ij
         hbQSxXyWBAI3zBaALPyjH+Rz8u4+yirQM3ud/FUew2ZaQJswhiwyUsECcqlmMWJ+vFM1
         E9zMkLA7zLPfwHz16A6JMSxuAC9MJeFQ7JM/Sv35+QzjOH+dTUdwDEsFSNlfnrVnrVVt
         IXvw==
X-Gm-Message-State: AOAM532xYdCKp/rL5cAg97PBtYHw7429o292UZyi/1+XxuhHt028O4Ay
        X46irHH24S7toprsF1kbMirrnGURXGRBe4/lmt/PLw==
X-Google-Smtp-Source: ABdhPJxDMM+6Ji1T4X6OwV6GPysEiOItkB0Kq3KQo8S9lFwpkxcBDW1FZjeQiE79nQx+TxwbCYIlUB28dephPUquI6o=
X-Received: by 2002:a05:6830:22d6:: with SMTP id q22mr8634292otc.274.1590098295812;
 Thu, 21 May 2020 14:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org> <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
 <20200521204044.GD140701@google.com>
In-Reply-To: <20200521204044.GD140701@google.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 21 May 2020 14:58:04 -0700
Message-ID: <CAJmaN=nq7qaLRdN6CTAqtYy4nfMe4NvAutF5m2v-Ng+5Kijx_A@mail.gmail.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        vpillai <vpillai@digitalocean.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 1:45 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Linus,
>
> On Thu, May 21, 2020 at 11:31:38AM -0700, Linus Torvalds wrote:
> > On Wed, May 20, 2020 at 3:26 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > Generally throughput benchmarks are much easier to do, how do you do
> > this latency benchmark, and is it perhaps something that could be run
> > more widely (ie I'm thinking that if it's generic enough and stable
> > enough to be run by some of the performance regression checking
> > robots, it would be a much more interesting test-case than some of the
> > ones they run right now...)
>
> Glad you like it! The metric is calculated with a timestamp of when the
> driver says the key was pressed, up until when the GPU says we've drawn
> pixels in response.
>
> The test requires a mostly only requires Chrome browser. It opens some
> pre-existing test URLs (a google doc, a window that opens a camera stream and
> another window that decodes video). This metric is already calculated in
> Chrome, we just scrape it from
> chrome://histograms/Event.Latency.EndToEnd.KeyPress.  If you install Chrome,
> you can goto this link and see the histogram.  We open a Google docs window
> and synthetically input keys into it with a camera stream and video decoding
> running in other windows which gives the CPUs a good beating. Then we collect
> roughly the 90th percentile keypress latency from the above histogram and the
> camera and decoded video's FPS, among other things. There is a test in the
> works that my colleagues are writing to run the full Google hangout video
> chatting stack to stress the system more (versus just the camera stream).  I
> guess if the robots can somehow input keys into the Google docs and open the
> right windows, then it is just a matter of scraping the histogram.

Expanding on this a little, we're working on a couple of projects that
should provide results like these for upstream.  One is continuously
rebasing our upstream backlog onto new kernels for testing purposes
(the idea here is to make it easier for us to update kernels on
Chromebooks), and the second is to drive more stuff into the
kernelci.org infrastructure.  Given the test environments we have in
place now, we can probably get results from our continuous rebase
project first and provide those against -rc releases if that's
something you'd be interested in.  Going forward, I hope we can
extract several of our tests and put them into kernelci as well, so we
get more general coverage without the potential impact of our (still
somewhat large) upstream backlog of patches.

To Joel's point, there are a few changes we'll have to make to get
similar results outside of our environment, but I think that's doable
without a ton of work.  And if anyone is curious, I think most of this
stuff is already public in the tast and autotest repos of the
chromiumos tree.  Just let us know if you want to make changes or port
to another environment so we can try to stay in sync wrt new features,
etc.

Thanks,
Jesse

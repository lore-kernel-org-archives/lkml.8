Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9092C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4FE20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPE5dpfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgFCRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:06:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF10C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:06:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w15so1771693lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6zw568lGzDFGHL5XVvIARMx1P85cewTscx7W3dgrL0=;
        b=kPE5dpfQq4IM8KoXoB5thP41s+o7r2WAnEMNOXMGRX/0vgmyhI2PMHQEodLtR95VCt
         LIZmGff8fAGD4IaUW3OiCaBRBqRrRDAXKQ0xnpSuQ+J32c15HPzgaroFRjm7XnSeBRAi
         WJ2csy+3mrRhTaey0SJgqmDIEsQDuSt5d4P0Ha3NIpqM2RrR+sjE3vIHmd5/nBZkNveb
         FV9ptdjUOq8RBcccyPwRH2lGqaafJICDt5kXTJrESjan0GaqQag/mU/Gugjeu52uimGq
         6ouXMLUgL5eNFvR6CFDZxcTURBI51qYtjInHzfJTUKqmQee1KbKImohH3O52D6+WSxY2
         qCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6zw568lGzDFGHL5XVvIARMx1P85cewTscx7W3dgrL0=;
        b=e8qNOFvSSHRHChTQ5ZFCTGSIhbn7cXigEXtW3Oh67HgOaKJZAowqDQljeY+pbBNr5l
         dTV2A92y2j3oloWXJOecItQvoOFnFbzza9hNBaoCbwCLsGZYPzXfSmEW0kNvw7YvCncx
         IKrWqrTf3BtBY2ofwNXr41burBDd/TWzKUh2MdYE/AuQCyqwb72QPjAjQoOLmnEzuEdx
         7FwNf1oyg7PI0clLEKwRSYsk5HjP1Y1Q4wrFuE0lQ/wl9RR2fr+djqmnfEiiiQaSPQGg
         DPHiIAPxhSvICjG234MbZMJ+bK6u1BBTvVB1fThFryJXUKI9O/xcCUrerVomjdRVVHzU
         Lb/w==
X-Gm-Message-State: AOAM5322Y49FyhQbd+NlE+i7MUeoZzh92RFmMIJZvbOJ1OwneZfgOh67
        fJU8b2lhio5rMv42Q5LGIeVFBolLq/sMRhe/daAIFA==
X-Google-Smtp-Source: ABdhPJw+qJGwrv+30OF25zPVfIn3GM5dhgzaUq5dO2uaR/r/Uwrhg2S7kZn2CNByeVTAR+rGHWX0vSKmt+j/yBV9bbQ=
X-Received: by 2002:a19:2250:: with SMTP id i77mr245208lfi.133.1591203991159;
 Wed, 03 Jun 2020 10:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141526.GA30976@xsang-OptiPlex-9020> <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020> <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
 <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
 <20200602052319.GA24856@xsang-OptiPlex-9020> <20200602142305.GA31901@xsang-OptiPlex-9020>
In-Reply-To: <20200602142305.GA31901@xsang-OptiPlex-9020>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 19:06:18 +0200
Message-ID: <CAKfTPtBLKUBF_p-LxfRce2nJQFqGj95KZ+yisAN_qrMq5VxW=w@mail.gmail.com>
Subject: Re: [sched/fair] 0b0695f2b3: phoronix-test-suite.compress-gzip.0.seconds
 19.8% regression
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Si, Beibei" <beibei.si@intel.com>,
        "Du, Julie" <julie.du@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, Rui Zhang <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, 2 Jun 2020 at 16:11, Oliver Sang <oliver.sang@intel.com> wrote:
>
> On Tue, Jun 02, 2020 at 01:23:19PM +0800, Oliver Sang wrote:
> > On Fri, May 29, 2020 at 07:26:01PM +0200, Vincent Guittot wrote:
> > > On Mon, 25 May 2020 at 10:02, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >

> > > > > > > > We also confirmed this regression on another platform
> > > > > > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > > > > > below is the data (lower is better).
> > > > > > > > v5.4    4.1
> > > > > > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > > > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > > > > > v5.5    5.18
> > > > > > > > v5.6    4.62
> > > > > > > > v5.7-rc2    4.53
> > > > > > > > v5.7-rc3    4.59
> > > > > > > >
> > > > > > > > It seems there are some recovery on latest kernels, but not fully back.
> > > > > > > > We were just wondering whether you could share some lights the further works
> > > > > > > > on the load balance after patch set [2] which could cause the performance
> > > > > > > > change?
> > > > > > > > And whether you have plan to refine the load balance algorithm further?
> > > > > > >

> >
> > Hi Vincent, sorry for late. I selected the turbostat while running
> > compress-gzip on Clear OS, as attached. Besides v5.4 and v5.7-rc7,
> > I got the data for v5.5 and v5.7, too. Not sure it's enough since you
> > said "All C-state statistics". Hope it could be useful and if you want
> > more data, please let us know.
> >
> > Again, I collect these data on our "Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
> > with 8G memory" platform. for each release, I ran test twice to assure
> > the results consistent.
> >
> > phoronix-test-suite.compress-gzip.0.seconds
> > release               run1    run2
> > v5.4          4.37    4.37
> > v5.5          5.37    5.46
> > v5.7-rc7      4.82    4.85
> > v5.7          4.86    4.83
> >
> > >
> > > Could you run the test after disabling deep idle states like C6 and
> > > above and check what is the difference between v5.7-rc7 and v5.4 ?
> >
> > thanks for suggestion, will collect this data later.
>
> Hi Vincent, I test by disabling deep idle states, but the regression
> still exists, just the gap becomes smaller -
> release         run1    run2
> v5.4            4.32    4.3     <-- little change comparing to above
> v5.5            5.04    5.06    <-- improves
> v5.7-rc7        4.79    4.78
> v5.7            4.77    4.77
>
> I also attached turbostat data as attached.

Thanks for the test results and the turbo stats figures.
The outcomes are not as obvious as I would have expected. The
performance difference for v5.5 and v5.7 when C6 and above are
disabled tends to confirm that the idle state is impacting the
performance but the difference still remain.
Regarding turbostat output, the 1st main difference is the number of
time the CPUs entered idle state:
v5.4 run1 : 587252+905317+367732+859828+108+332436+110+217=3053000
v5.7 run1 : 807623+639635+466723+1298557+108+283548+63+156=3496413
which is +14% of entering idle.
This is even more obvious on v5.5 run1:
761950+1320362+1681750+682042+91+304755+79+243=4751272 which is +55%
of entering idle

We have a similar ratio without c6 and above c-state between v5.4 and
v5.7 and the ratio has decreased to +22% between v5.4 and v5.5.

So this tends to confirm my assumption that tasks are more spread and
this generates more enter/leave cpuidle. I still need to think about
how to balance this


>
> >
> > > comparing fcf0553db6 ("sched/fair: Remove meaningless imbalance
> > > calculation") and
> > >   0b0695f2b3 ("sched/fair: Rework load_balance()") is not really
> > > useful because they are part of the same rework and should be
> > > considered a one single change.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > After analysing the benchmark, it doesn't overload the system and is
> > > > > > mainly based on 1 main gzip thread with few others waking up and
> > > > > > sleeping around.
> > > > > >
> > > > > > I thought that scheduler could be too aggressive when trying to
> > > > > > balance the threads on your system, which could generate more task
> > > > > > migrations and impact the performance. But this doesn't seem to be the
> > > > > > case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> > > > > > context switch is +16% and more interestingly idle state C1E and C6
> > > > > > usages increase more than 50%. I don't know if we can rely or this
> > > > > > value or not but I wonder if it could be that threads are now spread
> > > > > > on different CPUs which generates idle time on the busy CPUs but the
> > > > > > added time to enter/leave these states hurts the performance.
> > > > > >
> > > > > > Could you make some traces of both kernels ? Tracing sched events
> > > > > > should be enough to understand the behavior
> > > > > >
> > > > > > Regards,
> > > > > > Vincent
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > > Vincent
> > > > > > >
> > > > > > > > thanks
> > > > > > > >
> > > > > > > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > > > > > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > > > > > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler
>
>

Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9710EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B537207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnFgAAwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgEYIDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgEYIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:03:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:02:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z206so6376328lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qGJ3p8AxbOtvPVaCa2X3rPEUFkUCQ4jgVLRK7oTn3E=;
        b=QnFgAAwBqZMtHSgiq098Os0xcqdpNU1sAFh+7pehkbzeqX9yXcyk4DQ3Oi+CL16PFx
         Q5wGbL5WQqnV7Tp5IcfEfXNwOSieb1Y1q6sW4ldY6NVt0oOzWScp/W0N943elV/xtbYz
         RuDL1pMu7z3XpW2f96B81k/ESYb3LnyPyv6jzyxp+lfICEj+OlrUeniduEbk1OyHV5H3
         q5Xu/iXGLprCeMg8++UKgE0tS8DBJCWpLyT+sbcOtgpVDA65ICsMJ4ffQiIHEFa2DBN6
         twefdTivNqrixP+gyUXvHGo/+rx1HV+TSF9Mjf1HuvZYntQrnq2dncrY98kf4BPHj1sA
         O4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qGJ3p8AxbOtvPVaCa2X3rPEUFkUCQ4jgVLRK7oTn3E=;
        b=A4p5w41Dz9QnFgUj2yPjevcl5QDPzz3snYFLfYWX1pfp3SKMhbdc1ttSKvJqe3Ozyw
         RPiZD7txWRThw69BvFf3xiy/svjh5BAkowo41LKfZD+pmtSjUk/bSWSGpKybcJFKUpYD
         aGtNnTmpYDzJP0VZ1uU8ie/igbU91ohAFBAoEUR7nK6ENmPCenGIIdWoHKA3mpRN0Zh9
         7/EKWccnsh5u05m71sNp1CEJyCy3IckXQm2ry/hQ/G1ToqlSjd0JcrymA4rPyWTIhgro
         exRhFC0iCUR8PtlQquLIptCQAYdaif1pmm4NJZu3Rk8xUfajh6wjV843R9iRwteJHmmt
         Cr2Q==
X-Gm-Message-State: AOAM531CgDVgf268ElCj5sTwQWfpwOo1IT7frlEEjcoV0/3Rfhnysv7O
        wEH8nUcO92is5GZRJiZzfOhvrobMqDQ+z0OxqhfDIw==
X-Google-Smtp-Source: ABdhPJzOsha0KW/bJ92xw7eQDRgi4XsGAIJ8g+nN3BujrmaEPGYVFptTBqnq6Clr2HeoefZoH/tPTy4xW8Q9+Yj035M=
X-Received: by 2002:a19:4854:: with SMTP id v81mr13726652lfa.189.1590393777599;
 Mon, 25 May 2020 01:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141526.GA30976@xsang-OptiPlex-9020> <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com> <20200521083815.GA19280@xsang-OptiPlex-9020>
In-Reply-To: <20200521083815.GA19280@xsang-OptiPlex-9020>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 May 2020 10:02:44 +0200
Message-ID: <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
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
        "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 10:28, Oliver Sang <oliver.sang@intel.com> wrote:
>
> On Wed, May 20, 2020 at 03:04:48PM +0200, Vincent Guittot wrote:
> > On Thu, 14 May 2020 at 19:09, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Hi Oliver,
> > >
> > > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > > >
> > > > Hi Vincent Guittot,
> > > >
> > > > Below report FYI.
> > > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > > vm-scalability.median 3.1% improvement" on link [1].
> > > > but now we found the regression on pts.compress-gzip.
> > > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > > load balance" (link [2]), where showed the reworked load balance could have
> > > > both positive and negative effect for different test suites.
> > >
> > > We have tried to run  all possible use cases but it's impossible to
> > > covers all so there were a possibility that one that is not covered,
> > > would regressed.
> > >
> > > > And also from link [3], the patch set risks regressions.
> > > >
> > > > We also confirmed this regression on another platform
> > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > below is the data (lower is better).
> > > > v5.4    4.1
> > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > v5.5    5.18
> > > > v5.6    4.62
> > > > v5.7-rc2    4.53
> > > > v5.7-rc3    4.59
> > > >
> > > > It seems there are some recovery on latest kernels, but not fully back.
> > > > We were just wondering whether you could share some lights the further works
> > > > on the load balance after patch set [2] which could cause the performance
> > > > change?
> > > > And whether you have plan to refine the load balance algorithm further?
> > >
> > > I'm going to have a look at your regression to understand what is
> > > going wrong and how it can be fixed
> >
> > I have run the benchmark on my local setups to try to reproduce the
> > regression and I don't see the regression. But my setups are different
> > from your so it might be a problem specific to yours
>
> Hi Vincent, which OS are you using? We found the regression on Clear OS,
> but it cannot reproduce on Debian.
> On https://www.phoronix.com/scan.php?page=article&item=mac-win-linux2018&num=5
> it was mentioned that -
> Gzip compression is much faster out-of-the-box on Clear Linux due to it exploiting
> multi-threading capabilities compared to the other operating systems Gzip support.

I'm using Debian, I haven't noticed it was only on Clear OS.
I'm going to look at it. Could you send me traces in the meantime ?

>
> >
> > After analysing the benchmark, it doesn't overload the system and is
> > mainly based on 1 main gzip thread with few others waking up and
> > sleeping around.
> >
> > I thought that scheduler could be too aggressive when trying to
> > balance the threads on your system, which could generate more task
> > migrations and impact the performance. But this doesn't seem to be the
> > case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> > context switch is +16% and more interestingly idle state C1E and C6
> > usages increase more than 50%. I don't know if we can rely or this
> > value or not but I wonder if it could be that threads are now spread
> > on different CPUs which generates idle time on the busy CPUs but the
> > added time to enter/leave these states hurts the performance.
> >
> > Could you make some traces of both kernels ? Tracing sched events
> > should be enough to understand the behavior
> >
> > Regards,
> > Vincent
> >
> > >
> > > Thanks
> > > Vincent
> > >
> > > > thanks
> > > >
> > > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler

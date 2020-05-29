Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6313EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA472072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRGWrkqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgE2Rcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgE2Rck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:32:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F142C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:26:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z6so131391ljm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzS5j+PLGQoRVE0c1cf5igMMR8GuGoRB1BMzB90CN1g=;
        b=FRGWrkqyVoL+naP0mWdBZYsuK3q7PgorvCN0PTplWsO1MCmMGjDfBy4aFhmXMtDghi
         ziS6E6JP9+aanHlFQZuIrqBixH+TZI3ttOsktL1chqpSKL3yM4o3d4ZvKV0vilvLRnLK
         HWfJ4IoBzBd4bCJCeeB0JMLAwC9Fe9xplK158gpW+3KbPFgLJIbGoZKuvTlnuGsrJaPQ
         JJTG5A75zpYrlxTTYo6HF1PGrGC1ZxbRUHL3uq5kLUrk0ab+0xKZEZhKVhnIOFlW168F
         Emv40mAo8f3X1kPAMM60XRYfUsVJAoOEVFUFX8S+tmaPdB1kcs+9DhrXLDMGUT7GJrcg
         5JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzS5j+PLGQoRVE0c1cf5igMMR8GuGoRB1BMzB90CN1g=;
        b=ZtmHdV3uwq6HnfOsCXCdgZeOfto7FtoyaaoGexOd0DIMjy8rsB9HXNur6ikwSce8aO
         miTv7OzWZGqqdiRpkGcC1RCBDAUEXqT3OZXhGNfmBk0Bn6rpTh5Qfgyu4DW1GxdbmUbK
         qpQ7RtoYyuJlBy1jC5OmwC8QlKQiiPtCDa2eQC/ZkwIxYH4jgpzzMwoPs2CtDaL195C/
         S6dVKfhfIDY7tEq6heN45jZomXH2etgfmoqzJsRM/XxMyL/mh2OUyYvLebbNETm9bbCJ
         gxAXjn6XzsPUZfywvlzl9bvKJGTWYEg1oE+guXmG8UWo8C/1HUAmdv9SEW6WiDjetUMF
         Kl7Q==
X-Gm-Message-State: AOAM533bPj5oKgzVDg8OSohWYFHV/w4W2uSZAQpgADF/d5VjUvPQXbrn
        Z8Qp5KDXteiIv1N6cIJ2XwhCsxPg9fujQMxmJMgGIg==
X-Google-Smtp-Source: ABdhPJyYjBlAB+Uudt8KDgZdklMiqSS3eoMJDsyEWFH5NbxsQJpNG9srllXHRAxYHXuarCHY6md+QIeiojk4391OuXs=
X-Received: by 2002:a2e:760b:: with SMTP id r11mr4863577ljc.69.1590773172628;
 Fri, 29 May 2020 10:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141526.GA30976@xsang-OptiPlex-9020> <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020> <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
In-Reply-To: <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 May 2020 19:26:01 +0200
Message-ID: <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
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

On Mon, 25 May 2020 at 10:02, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 21 May 2020 at 10:28, Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > On Wed, May 20, 2020 at 03:04:48PM +0200, Vincent Guittot wrote:
> > > On Thu, 14 May 2020 at 19:09, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > Hi Oliver,
> > > >
> > > > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > > > >
> > > > > Hi Vincent Guittot,
> > > > >
> > > > > Below report FYI.
> > > > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > > > vm-scalability.median 3.1% improvement" on link [1].
> > > > > but now we found the regression on pts.compress-gzip.
> > > > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > > > load balance" (link [2]), where showed the reworked load balance could have
> > > > > both positive and negative effect for different test suites.
> > > >
> > > > We have tried to run  all possible use cases but it's impossible to
> > > > covers all so there were a possibility that one that is not covered,
> > > > would regressed.
> > > >
> > > > > And also from link [3], the patch set risks regressions.
> > > > >
> > > > > We also confirmed this regression on another platform
> > > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > > below is the data (lower is better).
> > > > > v5.4    4.1
> > > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > > v5.5    5.18
> > > > > v5.6    4.62
> > > > > v5.7-rc2    4.53
> > > > > v5.7-rc3    4.59
> > > > >
> > > > > It seems there are some recovery on latest kernels, but not fully back.
> > > > > We were just wondering whether you could share some lights the further works
> > > > > on the load balance after patch set [2] which could cause the performance
> > > > > change?
> > > > > And whether you have plan to refine the load balance algorithm further?
> > > >
> > > > I'm going to have a look at your regression to understand what is
> > > > going wrong and how it can be fixed
> > >
> > > I have run the benchmark on my local setups to try to reproduce the
> > > regression and I don't see the regression. But my setups are different
> > > from your so it might be a problem specific to yours
> >
> > Hi Vincent, which OS are you using? We found the regression on Clear OS,
> > but it cannot reproduce on Debian.
> > On https://www.phoronix.com/scan.php?page=article&item=mac-win-linux2018&num=5
> > it was mentioned that -
> > Gzip compression is much faster out-of-the-box on Clear Linux due to it exploiting
> > multi-threading capabilities compared to the other operating systems Gzip support.
>
> I'm using Debian, I haven't noticed it was only on Clear OS.
> I'm going to look at it. Could you send me traces in the meantime ?

I run more tests to understand the problem. Even if Clear Linux uses
multithreading, the system is not overloaded and there is a
significant amount of idle time. This means that we use the has_spare
capacity path that spreads tasks on the system. At least that is what
I have seen in the KVM image. Beside this, I think that I have been
able to reproduce the problem on my platform with debian using pigz
instead of gzip for the compress-gzip-1.2.0 test. On my platform, I
can see a difference when I enable all CPU idle states whereas there
is no performance difference when only the shallowest idle state is
enabled.

The new load balance rework is more efficient at spreading tasks on
the system and one side effect could be that there is more idle time
between tasks wake up on each CPU. As a result, CPUs have to wake up
from a deeper idle state. This could explain the +54% increase of C6
usage that is reported.  Is it possible to get All C-state statistics
?

Could you run the test after disabling deep idle states like C6 and
above and check what is the difference between v5.7-rc7 and v5.4 ?
comparing fcf0553db6 ("sched/fair: Remove meaningless imbalance
calculation") and
  0b0695f2b3 ("sched/fair: Rework load_balance()") is not really
useful because they are part of the same rework and should be
considered a one single change.

>
> >
> > >
> > > After analysing the benchmark, it doesn't overload the system and is
> > > mainly based on 1 main gzip thread with few others waking up and
> > > sleeping around.
> > >
> > > I thought that scheduler could be too aggressive when trying to
> > > balance the threads on your system, which could generate more task
> > > migrations and impact the performance. But this doesn't seem to be the
> > > case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> > > context switch is +16% and more interestingly idle state C1E and C6
> > > usages increase more than 50%. I don't know if we can rely or this
> > > value or not but I wonder if it could be that threads are now spread
> > > on different CPUs which generates idle time on the busy CPUs but the
> > > added time to enter/leave these states hurts the performance.
> > >
> > > Could you make some traces of both kernels ? Tracing sched events
> > > should be enough to understand the behavior
> > >
> > > Regards,
> > > Vincent
> > >
> > > >
> > > > Thanks
> > > > Vincent
> > > >
> > > > > thanks
> > > > >
> > > > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler

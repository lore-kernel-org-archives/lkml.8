Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74255C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4665D21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U+Dqv2Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgDRQCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDRQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:02:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 09:02:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so5881429ioh.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+XFUwJ/PfRgJkIAz2PEdRh3Cw//nk8ZvKYovbEgnn4=;
        b=U+Dqv2KgvYAWCTkA2e5rX0oldOiN+C94mKiaaYe0isc5zaMBKHVFI0rMWxTBNmmsAS
         8UfFD2ptJ8ewGthKsZqOCkAFqxc+SMq7J1q7eoNxkclZKpQdStIzD/XvjyXTMT7YqnNp
         OIfTTcpGdDWuskzIz5WZJL7oqhBeupWQHqwsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+XFUwJ/PfRgJkIAz2PEdRh3Cw//nk8ZvKYovbEgnn4=;
        b=oILaiHhLbdyKwTEmSeLDV9gJREP+Nx9WnaCZpzGARRMJkf5bI+szhfTW70gEd3wiDC
         S3Wbjrw5Dk+U4BeH5jIkopAMZOsw+CiEepsz0iJZTQFCDu+Xiq4/nrSh91W6OEBnXCSA
         /qtg8L4jPmJYvQoCTKVbfFRdqUWG5xrbLFSgvzuzTgq7qjliXo5a8G7bxnRh3xKRf9Wj
         yugZ7w330iXQY2NRdYvWJ6CW02h0CN6uzU2ocVZWnrJh3kX+YFXNIU342b4RP3seAPvu
         l10nVuB/TmVrhFgy5W/JEIfPQanoTUF//vIIk1RoFol4caYrTUKKonB2Ps6bn+1IH6+i
         EJ2w==
X-Gm-Message-State: AGi0PuYx6ZJ4EyJXN/N06OB+4S+1lL1V2c+d1QIphkY3SaE/ua9jT34E
        6kPbj8li9HjztqlFZB3ucMK2XfBl0OYFwyoeHsog6Q==
X-Google-Smtp-Source: APiQypJrjNA1JrKrB+AAf+5C/IYkIHFyauMfAvflKufAJa0fEjdwXQnh4PXNX3sS3ywbVeyMbGzyp3kG/9aBkWrj18k=
X-Received: by 2002:a02:c998:: with SMTP id b24mr8303887jap.23.1587225729324;
 Sat, 18 Apr 2020 09:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com> <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com> <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net> <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com> <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
In-Reply-To: <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 18 Apr 2020 12:01:58 -0400
Message-ID: <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        steven.sistare@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, parth@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Thu, Apr 16, 2020 at 1:23 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Hi Joel,
>
> On 16.04.20 02:02, Joel Fernandes wrote:
> > On Thu, Sep 05, 2019 at 12:47:26PM +0100, Qais Yousef wrote:
> >> On 09/05/19 13:30, Peter Zijlstra wrote:
> >>> On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
> >>>> On 09/05/19 12:46, Peter Zijlstra wrote:
> >>>
> >>>>> This is important because we want to be able to bias towards less
> >>>>> importance to (tail) latency as well as more importantance to (tail)
> >>>>> latency.
> >>>>>
> >>>>> Specifically, Oracle wants to sacrifice (some) latency for throughput.
> >>>>> Facebook OTOH seems to want to sacrifice (some) throughput for latency.
> >>>>
> >>>> Another use case I'm considering is using latency-nice to prefer an idle CPU if
> >>>> latency-nice is set otherwise go for the most energy efficient CPU.
> >>>>
> >>>> Ie: sacrifice (some) energy for latency.
> >>>>
> >>>> The way I see interpreting latency-nice here as a binary switch. But
> >>>> maybe we can use the range to select what (some) energy to sacrifice
> >>>> mean here. Hmmm.
> >>>
> >>> It cannot be binary, per definition is must be ternary, that is, <0, ==0
> >>> and >0 (or middle value if you're of that persuasion).
> >>
> >> I meant I want to use it as a binary.
> >>
> >>>
> >>> In your case, I'm thinking you mean >0, we want to lower the latency.
> >>
> >> Yes. As long as there's an easy way to say: does this task care about latency
> >> or not I'm good.
> >
> > Qais, Peter, all,
> >
> > For ChromeOS (my team), we are planning to use the upstream uclamp mechanism
> > instead of the out-of-tree schedtune mechanism to provide EAS with the
> > latency-sensitivity (binary/ternary) hint. ChromeOS is thankfully quite a bit
> > upstream focussed :)
> >
> > However, uclamp is missing an attribute to provide this biasing to EAS as we
> > know.
> >
> > What was the consensus on adding a per-task attribute to uclamp for providing
> > this? Happy to collaborate on this front.
>
> We're planning to have a session about this topic (latency-nice
> attribute per task group) during the virtual Pisa OSPM summit
> retis.sssup.it/ospm-summit in May this year.

Cool, I registered as well.

>
> There are two presentations/discussions planned:
>
> "Introducing Latency Nice for Scheduler Hints and Optimizing Scheduler
> Task Wakeup" and "The latency nice use case for Energy-Aware-Scheduling
> (EAS) in Android Common Kernel (ACK)"
>
> We'll probably merge those two into one presentation/discussion.
>
> So far we have Parth's per-task implementation
>
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com

Cool, I see it has some Reviewed-by tags so that's a good sign. Will
look more into that.

> What's missing is the per-taskgroup implementation, at least from the
> standpoint of ACK.
>
> The (mainline) EAS use-case for latency nice is already in ACK
> (android-5.4):
>
> https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54

Yes, I was aware of this. But if we use task groups, then the
transition from schedtune -> uclamp means now the tasks that use
uclamp would also be subjected to cpu.shares. That's why we were
looking into the per-task interface and glad there's some work on this
already done.

Thanks!

 - Joel

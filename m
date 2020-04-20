Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3ABC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EB2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aCC3ants"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDTTOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:14:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B18C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:14:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n20so3311178qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HGDegx+kGpjwn1/GckrWYW28OTALFvmx7Qs3hk7rBM=;
        b=aCC3antsZfqvzj5CdafkTpV3OjDe2nl4TxRPqk3Bi5acoWuTSpuEVT/wb28db7wFR0
         3axoAkSyoADptYw5L20w1h5mCVUFDl03Xb4o5xQX1LVmgo6hHnoXhBKf0/YKtlA/cwFI
         DiB92+KQ2SlbLiTN5KAAi1qlgGzLcQozCjAkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HGDegx+kGpjwn1/GckrWYW28OTALFvmx7Qs3hk7rBM=;
        b=YcrLYUr0KNFI1laS9+Zrx2J1t+oYkrgLTTSpviAIPpVAyDMNJ5mGfB5s2m7LHyA7Xr
         3noGY2JsWhlYLE3qt6CjrHtBDn9x+eohawJMAnDx7VoEMf6/lQw2maw3QLhihE0dFf9D
         JhsmC4LN6shZL8p6gBJhWD3o6nbJG1Tei570kmPfI8BpQIp5XTVRQ2nrbyXjYW0KxbNv
         gDgjOQt5BiibRJl581SA9VMwS36AC049I+G4SW5v0TySk4nrtuHd0SyUfPAarl2uCD/J
         f2JBg/+ANTOvvJYr++1lCO7m1fMslI/GQ2caTR38juqKnfVG1p190wFI9wd4m7isMvI7
         xxFA==
X-Gm-Message-State: AGi0Pua32xBDcac/iq9eKCknJt4UxTACeAanEv7yBrXGj4JbusK01wD0
        H0i0mpIfHPygsxS7OinO7wO33A==
X-Google-Smtp-Source: APiQypLQkyKjCZ7v1YIJf7h+snt3BgQV1BgXq7i4tB5vQp0t9N7MDcKchLWsEB2VPPRXPt4WnYC9uw==
X-Received: by 2002:aed:2b64:: with SMTP id p91mr17061597qtd.202.1587410072709;
        Mon, 20 Apr 2020 12:14:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s15sm158958qtc.31.2020.04.20.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:14:32 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:14:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20200420191431.GB67569@google.com>
References: <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com>
 <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
 <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
 <7d4637c8-da8c-463d-30c6-a55c0a173316@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4637c8-da8c-463d-30c6-a55c0a173316@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 04:56:55PM +0530, Parth Shah wrote:

> >>
> >> There are two presentations/discussions planned:
> >>
> >> "Introducing Latency Nice for Scheduler Hints and Optimizing Scheduler
> >> Task Wakeup" and "The latency nice use case for Energy-Aware-Scheduling
> >> (EAS) in Android Common Kernel (ACK)"
> >>
> >> We'll probably merge those two into one presentation/discussion.
> >>
> >> So far we have Parth's per-task implementation
> >>
> >> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com
> > 
> > Cool, I see it has some Reviewed-by tags so that's a good sign. Will
> > look more into that.
> > 
> >> What's missing is the per-taskgroup implementation, at least from the
> >> standpoint of ACK.
> >>
> >> The (mainline) EAS use-case for latency nice is already in ACK
> >> (android-5.4):
> >>
> >> https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54
> > 
> > Yes, I was aware of this. But if we use task groups, then the
> > transition from schedtune -> uclamp means now the tasks that use
> > uclamp would also be subjected to cpu.shares. That's why we were
> > looking into the per-task interface and glad there's some work on this
> > already done.
> > 
> 
> Yes, that series of latency_nice seems to be in good shape to be used for
> any usecases. Hopefully, OSPM will lead to its upstreaming sooner :-)

Cool :)

> But at the end, we aim to have both the per-task and cgroup based interface
> to mark the latency_nice value of a task.

Ok. We'd likely use the per-task interface unless we decide to assign
cpu.shares for the groups as well.

> Till, then I'm finding some generic use-cases to show benefits of such task
> attribute to increase community interest.

Ok. Feel free to add ChromeOS as a usecase as well.

thanks,

 - Joel


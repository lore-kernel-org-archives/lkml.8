Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8830CC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665602145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="coABxXCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgDTTKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:10:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA03C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:10:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b62so11941809qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aTDI+EJs0M0kJGbpFd6Q8vcUdxuIOGt0F4hNcJOF1Bs=;
        b=coABxXCMnijlmrd3Gvvr5BLZLjZVcbfygcvfqavZW87LeIdIkMffnctr2rmwkr/VEd
         dx6J/sOiV0sGX8/UEYz2m284IQnnOkIEUBFqAzZkwyvmnlsnbM9R4cGlfacfvj+DVyPD
         aQRa4DEq2UXZl9VtFiM/t4NfZ9oPI18Mze4k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTDI+EJs0M0kJGbpFd6Q8vcUdxuIOGt0F4hNcJOF1Bs=;
        b=FvX29a1XjHTN+grNtMktQnVGmppRykea4KbcEkzaGKJERY2uavN7v2XehRN0cwMCJB
         1x+nC82SSdxTBCB1NvBY7eIYPDTs55FmJJgOEerZa7VG3jYVkW3NKGgE1pgGztebtHgI
         W4UhICTfx9YMQQKFVeKtJuzIUO7BMysWr4FUPARa6V/ESSS5CFO/QxyoLcj3az4aLlXL
         V/QvPkAvwE9lBxemQggapxnrCy8VJKIkdPvSq2dYxZWpK2MpuAYi4A8O/dUxrU2O/DjU
         euzD56y0xYdcF/XgG61BEShrJvB5dGevJhmJ703Ous6yXlTo5yVLIn8vLKVUoXOANfok
         a87w==
X-Gm-Message-State: AGi0PuYsS/Tp08rQcyQ0bHZLzvmXRtTefkSxJ4CZqMmGX1ReNqCN7QBk
        oagMimIvnRmAh14PpUbIaUnEGw==
X-Google-Smtp-Source: APiQypLa8oDcLCrysnkHdjZx8h4i4v04h6Dci2mOJpfUBkhn6KkgMxFHIhIBl5uL64cv/d6yxVcmAA==
X-Received: by 2002:a05:620a:16cf:: with SMTP id a15mr17419307qkn.156.1587409848264;
        Mon, 20 Apr 2020 12:10:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l13sm144236qtj.17.2020.04.20.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:10:47 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:10:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20200420191047.GA67569@google.com>
References: <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com>
 <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
 <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
 <20200420114728.iy6w34khketplxvk@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420114728.iy6w34khketplxvk@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais!

On Mon, Apr 20, 2020 at 12:47:29PM +0100, Qais Yousef wrote:
> On 04/18/20 12:01, Joel Fernandes wrote:
> > > What's missing is the per-taskgroup implementation, at least from the
> > > standpoint of ACK.
> > >
> > > The (mainline) EAS use-case for latency nice is already in ACK
> > > (android-5.4):
> > >
> > > https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54
> > 
> > Yes, I was aware of this. But if we use task groups, then the
> > transition from schedtune -> uclamp means now the tasks that use
> > uclamp would also be subjected to cpu.shares. That's why we were
> > looking into the per-task interface and glad there's some work on this
> > already done.
> 
> Hmm uclamp doesn't do anything with cpu.shares. I assume this is some
> implementation detail at your end? IOW, you don't have to use cpu.shares to use
> uclamp.

Right, it is a ChromeOS-specific issue. We have CONFIG_FAIR_GROUP_SCHED
enabled in the kernel for container workloads. However there are CGroups of
tasks that used "schedtune" CGroup interface before to provide util clamping
like behavior. We are now migrating these to the upstream util-clamp.

We can't disable CONFIG_FAIR_GROUP_SCHED because that would break the
container workloads.

So we have to use the per-process interface of util clamp.

If we used the CGroups interface of util clamping, we would get the
cpu.shares as well since the CGroup interface comes with shares. There's no
way to avoid being subject to cpu.shares (that I'm aware off anyway).

> Although there should be few tasks in the system that need the latency-nice, so
> I prefer the per-task interface rather than lump everything in a cgroup. Though
> there could be valid use cases for the latter.

Yes, with either interface, we need something like latency_nice to indicate
that the task is low-latency (something we used for a number of years with
the out-of-tree schedtune).

thanks!

 - Joel


> 
> Thanks
> 
> --
> Qais Yousef

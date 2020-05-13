Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E696C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78362224C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehPiQBWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbgEMO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:57:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389056AbgEMO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589381852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Gr9j6Rd61DDfSe1NpMl5Rv79C50cMkRjH7UKQLe0Fs=;
        b=ehPiQBWvtdBd1lSwSubHduVN77sFvW7+aZHfpnsfX2zlqnZHxZiOsAfI/vKigrcuNJQH9P
        9GRXtyBB9y3hrrkbzZIq8bIOr0p7wNjhrtfXXk0jBxPkO0B87Cn0zb0zuNic+IAdSg63Re
        ziDoKEDpDVtAPeSeqTEhSZ4tNISTdvQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-JLYHNcDiPDS8VMf9vbFejQ-1; Wed, 13 May 2020 10:57:28 -0400
X-MC-Unique: JLYHNcDiPDS8VMf9vbFejQ-1
Received: by mail-ed1-f72.google.com with SMTP id b7so6767781edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Gr9j6Rd61DDfSe1NpMl5Rv79C50cMkRjH7UKQLe0Fs=;
        b=L41JlW3H31hMs3PnSVpVO9fWHeUHbdBxLAtQ5lRILRLansE6MxqMetAqwJu6/4XN2M
         AHGGBTD1x0DGhIhfwGwRJakE8fEWM3Ffm7x5gs9Pc7sTsL45EZE3Hov8n7E2v808twZQ
         oVWjBjWXcWX1CGGR2yWjQbUZc9aq6/tj2Ejd5HvyiZIeN5qRmFWZRDbkKjQjvQKG7PXb
         Ybta/8GuUtL3p6UhhZ0iv8XE9qS2uKShh77COfPwqkl8cq6QXGhvbKCdE174Zi9ZcqDX
         EUBI4hF5qJ/DkzBAnFN/hDbFhmUMT21yeiO/Dm9/1maugZ9gmQZNNqEBby0VMJyaWjLX
         bbEw==
X-Gm-Message-State: AOAM532mOXRbkNlnoyCtJzzc50dRAUtKrW/T8yB8ftnOopunpdnAFyUO
        6PLAyL4uis5eulxx0acKCuvvrYF/v54PawKsEcYzt5ixykoeFJOSxxma4v7ZJfJOXx4Vo4+VkEP
        jmLXr6EtbOQgPWKnZg+VfsOw6eiEsGr0qo2g/7csT
X-Received: by 2002:a17:906:2f90:: with SMTP id w16mr11170510eji.252.1589381847173;
        Wed, 13 May 2020 07:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTglE4CrKb8ZManfM1PMEq+rMBztwbrwVNw/RB1WfUL1Cy1K+uw23xc1A9QAIAt6GD21sdM37Sx1+x9kzErwo=
X-Received: by 2002:a17:906:2f90:: with SMTP id w16mr11170485eji.252.1589381846860;
 Wed, 13 May 2020 07:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net> <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
In-Reply-To: <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 13 May 2020 16:57:15 +0200
Message-ID: <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

we have tried the kernel with adjust_numa_imbalance() crippled to just
return the imbalance it's given.

It has solved all the performance problems I have reported.
Performance is the same as with 5.6 kernel (before the patch was
applied).

* solved the performance drop upto 20%  with single instance
SPECjbb2005 benchmark on 8 NUMA node servers (particularly on AMD EPYC
Rome systems) => this performance drop was INCREASING with higher
threads counts (10% for 16 threads and 20 % for 32 threads)
* solved the performance drop for low load scenarios (SPECjvm2008 and NAS)

Any suggestions on how to proceed? One approach is to turn
"imbalance_min" into the kernel tunable. Any other ideas?

https://github.com/torvalds/linux/blob/4f8a3cc1183c442daee6cc65360e3385021131e4/kernel/sched/fair.c#L8914

Thanks a lot!
Jirka






On Fri, May 8, 2020 at 12:40 PM Jirka Hladky <jhladky@redhat.com> wrote:
>
> Hi Mel,
>
> thanks for hints! We will try it.
>
> @Phil - could you please prepare a kernel build for me to test?
>
> Thank you!
> Jirka
>
> On Fri, May 8, 2020 at 11:22 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>>
>> On Thu, May 07, 2020 at 06:29:44PM +0200, Jirka Hladky wrote:
>> > Hi Mel,
>> >
>> > we are not targeting just OMP applications. We see the performance
>> > degradation also for other workloads, like SPECjbb2005 and
>> > SPECjvm2008. Even worse, it also affects a higher number of threads.
>> > For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
>> > server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
>> > threads (the system has 64 CPUs in total). We observe this degradation
>> > only when we run a single SPECjbb binary. When running 4 SPECjbb
>> > binaries in parallel, there is no change in performance between 5.6
>> > and 5.7.
>> >
>>
>> Minimally I suggest confirming that it's really due to
>> adjust_numa_imbalance() by making the function a no-op and retesting.
>> I have found odd artifacts with it but I'm unsure how to proceed without
>> causing problems elsehwere.
>>
>> For example, netperf on localhost in some cases reported a regression
>> when the client and server were running on the same node. The problem
>> appears to be that netserver completes its work faster when running
>> local and goes idle more regularly. The cost of going idle and waking up
>> builds up and a lower throughput is reported but I'm not sure if gaming
>> an artifact like that is a good idea.
>>
>> > That's why we are asking for the kernel tunable, which we would add to
>> > the tuned profile. We don't expect users to change this frequently but
>> > rather to set the performance profile once based on the purpose of the
>> > server.
>> >
>> > If you could prepare a patch for us, we would be more than happy to
>> > test it extensively. Based on the results, we can then evaluate if
>> > it's the way to go. Thoughts?
>> >
>>
>> I would suggest simply disabling that function first to ensure that is
>> really what is causing problems for you.
>>
>> --
>> Mel Gorman
>> SUSE Labs
>>
>
>
> --
> -Jirka



-- 
-Jirka


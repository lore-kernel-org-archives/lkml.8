Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83420C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B81F207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ix7gGAEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgHCQxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgHCQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:53:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80173C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:53:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z6so39280409iow.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SBrsrtBimBKkg7qDhFYfBy7gcXZgvjEPufm9jML8wU=;
        b=ix7gGAEAQMFkzgqGuk9LOa4NFPauDBwEoFYYcpfRxSL6NRn/XaR8y+511Ex8CF7Hz+
         dJQ2/qdCb8NpaVu23CA8Bpa5CHWeVzLZnZhSMr2t3PvDJcs6DCEi+/wW+Es9IETY8iLp
         9nbkwudKKpeS0NQw9d787f/4BfFQNnG1msHfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SBrsrtBimBKkg7qDhFYfBy7gcXZgvjEPufm9jML8wU=;
        b=nmw8eObFjZ7G9i8axHGxYzNcvKvTNhxWlp1aC9E1vUAEdyo3tjT1Kk/25IAjfaCarb
         ECLLyCvd1cYZNrGrDw0vYaqBlaPEDjKspErgwztUajBFxqiq0iHBk8j3Y/3yMuxrU3YQ
         eI26ZmTCKBtEtE2eWHyy3EXSBH98RyddG9L0Dv44AJ9Fh1nPwZJ7+ubjjX5526OKsyVA
         C6iS4AvyGNJTUw54cerIDY2tIJrWqurp6Ovs4V/qSFsNVT7pV00Tm/6vkHqLCEa3+T/m
         zwYLUdakFt9LCkuZVTtQ/b2xSLh6I/Cs1OsgCZRAbxk/DN7vFXewCZXoTCWwcsyXYk/+
         zD4g==
X-Gm-Message-State: AOAM530Mog3ElvIlH2kiQGY9Km7GbEfrWLwcUqXjRDyMa9b5n3n5aJaP
        0Ovg9vX7koAjp6QltkXQTKqrwhKZGplBlz40lsuTUA==
X-Google-Smtp-Source: ABdhPJwqy8QX624CwctZkArTshbfUnYgtScSQX09+E2VP2YF1FzGr0WkL1gROqyUx6S+tmENId+ne8W5PJYjL8Uy7g8=
X-Received: by 2002:a02:3843:: with SMTP id v3mr613863jae.23.1596473615476;
 Mon, 03 Aug 2020 09:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com> <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
In-Reply-To: <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 3 Aug 2020 12:53:24 -0400
Message-ID: <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     viremana@linux.microsoft.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

On Mon, Aug 3, 2020 at 4:23 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
> > Sixth iteration of the Core-Scheduling feature.
> >
> > Core scheduling is a feature that allows only trusted tasks to run
> > concurrently on cpus sharing compute resources (eg: hyperthreads on a
> > core). The goal is to mitigate the core-level side-channel attacks
> > without requiring to disable SMT (which has a significant impact on
> > performance in some situations). Core scheduling (as of v6) mitigates
> > user-space to user-space attacks and user to kernel attack when one of
> > the siblings enters the kernel via interrupts. It is still possible to
> > have a task attack the sibling thread when it enters the kernel via
> > syscalls.
> >
> > By default, the feature doesn't change any of the current scheduler
> > behavior. The user decides which tasks can run simultaneously on the
> > same core (for now by having them in the same tagged cgroup). When a
> > tag is enabled in a cgroup and a task from that cgroup is running on a
> > hardware thread, the scheduler ensures that only idle or trusted tasks
> > run on the other sibling(s). Besides security concerns, this feature
> > can also be beneficial for RT and performance applications where we
> > want to control how tasks make use of SMT dynamically.
> >
> > This iteration is mostly a cleanup of v5 except for a major feature of
> > pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
> > introducing documentation and includes minor crash fixes.
> >
> > One major cleanup was removing the hotplug support and related code.
> > The hotplug related crashes were not documented and the fixes piled up
> > over time leading to complex code. We were not able to reproduce the
> > crashes in the limited testing done. But if they are reroducable, we
> > don't want to hide them. We should document them and design better
> > fixes if any.
> >
> > In terms of performance, the results in this release are similar to
> > v5. On a x86 system with N hardware threads:
> > - if only N/2 hardware threads are busy, the performance is similar
> >   between baseline, corescheduling and nosmt
> > - if N hardware threads are busy with N different corescheduling
> >   groups, the impact of corescheduling is similar to nosmt
> > - if N hardware threads are busy and multiple active threads share the
> >   same corescheduling cookie, they gain a performance improvement over
> >   nosmt.
> >   The specific performance impact depends on the workload, but for a
> >   really busy database 12-vcpu VM (1 coresched tag) running on a 36
> >   hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
> >   their own coresched tag), the performance drops by 54% with
> >   corescheduling and drops by 90% with nosmt.
> >
>
> We found uperf(in cgroup) throughput drops by ~50% with corescheduling.
>
> The problem is, uperf triggered a lot of softirq and offloaded softirq
> service to *ksoftirqd* thread.
>
> - default, ksoftirqd thread can run with uperf on the same core, we saw
>   100% CPU utilization.
> - coresched enabled, ksoftirqd's core cookie is different from uperf, so
>   they can't run concurrently on the same core, we saw ~15% forced idle.
>
> I guess this kind of performance drop can be replicated by other similar
> (a lot of softirq activities) workloads.
>
> Currently core scheduler picks cookie-match tasks for all SMT siblings, does
> it make sense we add a policy to allow cookie-compatible task running together?
> For example, if a task is trusted(set by admin), it can work with kernel thread.
> The difference from corescheduling disabled is that we still have user to user
> isolation.

In ChromeOS we are considering all cookie-0 tasks as trusted.
Basically if you don't trust a task, then that is when you assign the
task a tag. We do this for the sandboxed processes.

Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?

thanks,

 - Joel
PS: I am planning to write a patch behind a CONFIG option that tags
all processes (default untrusted) so everything gets a cookie which
some folks said was how they wanted (have a whitelist instead of
blacklist).

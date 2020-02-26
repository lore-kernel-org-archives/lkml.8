Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA05C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A888921927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5S+NxMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgBZDNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:13:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46550 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZDNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:13:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so653558pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zbi7qmKEMcw9IOGhaG30ynmov8uYebQaedUD8WWaASQ=;
        b=J5S+NxMTjctIQPTtkmjG25TtM5/S9cJB5YSAvFcp4SUnBaod8ETHT0bvr0OMXWox7P
         zABB8gAuDjjTPOKKpingxrkK+yS+lRtuOZNGglpH9MAIk+kbeX0qJT5jAHXaag464irP
         Ezmhp1kwn8jtsiAYeyC7jZSP3XMi1feEonbjaq9dwkUV76/kVBar+bqTbc4qAf4zjYyu
         WvFTp6wliYXJt0obn5xSLtZ2da7wpYnAdkytA208ZfE6nSImkIvNNfre7QNfZ+6KyvS6
         yksymkE520lN/y1ZSKlCUsF3Z0s5HGaMDFIs/rVaJSPvrDELGHn0Egt8ydZI/say+RxX
         lGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zbi7qmKEMcw9IOGhaG30ynmov8uYebQaedUD8WWaASQ=;
        b=M3Z70/arMFSYMicQk7ZvJ6wvLPe36+1LjTiUvRMUPMIXl9Ye4zhG8gw1xpVDnqqe7x
         ghKpi1AHdnHE1r3VA52eK/AwR9w5qe9u5OiwVRrQOhWIZPTsVJF6jyrBvqTwXKS2DjFL
         CC04ffByapSUyGFc2qaIaQr8PzVCy5gHvunqtPqjvmmzSSX7+vXsI2hOquKamxS1lJX0
         NIN7b83OjRMJiAmcFv4NdxP4sKPRfUZRJnXYBW6gvXbpLnfsmQG+1/ZwTxPaUxJMlPdJ
         K5emLyyErrhxDlAbnC69KdwaSl0tuI0F8s2xS6oOo2XNb7oa8g0PDOCJD+2z8q0EKmD9
         EeKQ==
X-Gm-Message-State: APjAAAUvSxSpZWrQrObol/E5KS1Qg25+OBwvMIra+CH/LfBijzjyouqB
        3h4mT5tc0qgv/ZnvCk0um1o=
X-Google-Smtp-Source: APXvYqysiBwyxxLiIdGfzAjCzsMwPDd/vJSZ/BM6JHmKsJ36UGuGupZ1xIRmF6IxnI9xmtYZ9gleJQ==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr1877254pfm.261.1582686826411;
        Tue, 25 Feb 2020 19:13:46 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id r66sm533019pfc.74.2020.02.25.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 19:13:45 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:13:36 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200226031336.GA622976@ziqianlu-desktop.localdomain>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:51:37PM -0500, Vineeth Remanan Pillai wrote:
> Hi Aaron,
> We tried reproducing this with a sample script here:
> https://gist.github.com/vineethrp/4356e66694269d1525ff254d7f213aef

Nice script.

> But the set1 cgroup processes always get their share of cpu time in
> our test. Could you please verify if its the same test that you were
> also doing? The only difference is that we run on a 2 16core/32thread
> socket bare metal using only socket 0. We also tried threads instead of
> processes, but the results are the same.

Sorry for missing one detail: I always start the noise workload first,
and then start the real workload. This is critical for this test here
since only so, the noise workload can occupy all CPUs and presents a
challange for the load balancer to balance real workload's tasks. If
both workloads are started at the same time, the initial task placement
might mitigate the problem.

BTW, your script has given 12cores/24 CPUs to the workloads and cgA
spawned 16 tasks, cgB spawned 32. This is an even more complex scenario
to test since the real workload's task number is already more than the
available core number. Perhaps just starting 12 tasks for cgA and 24
tasks for cgB is enough for now. As for the start sequence, simply sleep
5 seconds after cgB workload is started, then start cgA. I have left a
comment on the script's gist page.

> 
> 
> On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> > threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> > into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> > socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> > cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> > the real workload).
> >
> > I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> 
> The expected behaviour could also be that 8 processes share 4 cores and
> 8 hw threads right? This is what we are seeing mostly
> 
> most of the time since it has way more weight than cgB, while cgB should
> > occupy almost no CPUs since:
> >  - when cgB's task is in the same CPU queue as cgA's task, then cgB's
> >    task is given very little CPU due to its small weight;
> >  - when cgB's task is in a CPU queue whose sibling's queue has cgA's
> >    task, cgB's task should be forced idle(again, due to its small weight).
> >
> We are seeing the cgA is taking half the cores and cgB taking rest half
> of the cores. Looks like the scheduler ultimately groups the tasks into
> its own cores.
> 
> 
> >
> > But testing shows cgA occupies only 2 cpus during the entire run while
> > cgB enjoys the remaining 14 cpus. As a comparison, when coresched is off,
> > cgA can occupy 8 cpus during its run.
> >
> > Not sure why we are not able to reproduce this. I have a quick patch
> which might fix this. The idea is that, we allow migration if p's
> hierarchical load or estimated utilization is more than dest_rq->curr.
> While thinking about this fix, I noticed that we are not holding the
> dest_rq lock for any of the migration patches. Migration patches would
> probably need a rework. Attaching my patch down, but it also does not
> take the dest_rq lock. I have also added a case of dest_core being
> forced_idle. I think that would be an opportunity to migrate. Ideally
> we should check if the forced idle task has the same cookie as p.
> 
> https://gist.github.com/vineethrp/887743608f42a6ce96bf7847b5b119ae

Is this on top of Aubrey's coresched_v4-v5.5.2 branch?

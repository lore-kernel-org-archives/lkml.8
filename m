Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D38C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745C320679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TKfwg3Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbgCQAz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:55:26 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39873 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbgCQAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:55:25 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so5968499qvf.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yl9dxTFwL6bMeDTeRSyxYeOib9EoGGCibEtunn5dYO8=;
        b=TKfwg3Gn3960PwwYrpSSMrM7b9vHKrL+ZVQyhRWDh694V3LMpkeffg33n1/NbI4K/o
         g0RuNt7Gg1DFMaeIRSoImtThkHx/RILdTyMzc67hm8FaML5GH41sV3iI6GLxE8NWCwtn
         aofk7ZIBiTtgLRyQeqIwsJDS1a8fDIQx6yXPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yl9dxTFwL6bMeDTeRSyxYeOib9EoGGCibEtunn5dYO8=;
        b=AjEqNtJaLlAEbujzicVPxegFkqKuLNNkVmtXVaNtUmUDOAqAFKd4McQEYK0poSEzp8
         T9RQLqsWsI1oB770wob5eH9zKssrKhaIR7p7HQJZDbWJouhYrK9sEJJ6qXlfakq4zGKR
         quGpttcYY2xvfiulmyJ1BuA0IB7Ok3ftuTP2BbsWuUTr9EwTuXL3hmYRuZa4x0Vlcybb
         Yc99itSJBRWZVj7OzfF1pk1cGsNZlUo8qMXCTOIOFukpg+tE71zMwHnLCNBOA28rnIgw
         vpUMWa68w1PsV0jdDLUyqDykSofz5zSKRrWvnykPeNgmCZ2N02Vjmew2GUDUNEfk0+t1
         dexw==
X-Gm-Message-State: ANhLgQ0YzT3Ni7XNIfRIFW6BIMQhgf0DsPYJIWL2OAhGIBId4HiFZWJy
        Lzjrmp2lSAofOjrH6nHTjkQYe+HJFtU=
X-Google-Smtp-Source: ADFU+vv4eCmWpKz5ddyluDknMowyWQv+N/X5RBfzaN1zNVoxJ7F3a9IocNbfwgVBQolBKdou7UHNcQ==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr2497254qvx.167.1584406522745;
        Mon, 16 Mar 2020 17:55:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a141sm944211qkb.50.2020.03.16.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 17:55:21 -0700 (PDT)
Date:   Mon, 16 Mar 2020 20:55:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200317005521.GA8244@google.com>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221232057.GA19671@sinkpad>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien, Peter, all,

On Fri, Feb 21, 2020 at 06:20:57PM -0500, Julien Desfossez wrote:
> On 18-Feb-2020 04:58:02 PM, Vineeth Remanan Pillai wrote:
> > > Yes, this makes sense, patch updated at here, I put your name there if
> > > you don't mind.
> > > https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2-rc2
> > >
> > > Thanks Aubrey!
> 
> Just a quick note, I ran a very cpu-intensive benchmark (9x12 vcpus VMs
> running linpack), all affined to an 18 cores NUMA node (36 hardware
> threads). Each VM is running in its own cgroup/tag with core scheduling
> enabled. We know it already performed much better than nosmt, so for
> this case, I measured various co-scheduling statistics:
> - how much time the process spends co-scheduled with idle, a compatible
>   or an incompatible task
> - how long does the process spends running in a inefficient
>   configuration (more than 1 thread running alone on a core)
> 
> And I am very happy to report than even though the 9 VMs were configured
> to float on the whole NUMA node, the scheduler / load-balancer did a
> very good job at keeping an efficient configuration:
> 
> Process 10667 (qemu-system-x86), 10 seconds trace:
>   - total runtime: 46451472309 ns,
>   - local neighbors (total: 45713285084 ns, 98.411 % of process runtime):
>   - idle neighbors (total: 484054061 ns, 1.042 % of process runtime):
>   - foreign neighbors (total: 4191002 ns, 0.009 % of process runtime):
>   - unknown neighbors  (total: 92042503 ns, 0.198 % of process runtime)
>   - inefficient periods (total: 464832 ns, 0.001 % of process runtime):
>     - number of periods: 48
>     - min period duration: 1424 ns
>     - max period duration: 116988 ns
>     - average period duration: 9684.000 ns
>     - stdev: 19282.130
> 
> I thought you would enjoy seeing this :-)

Looks quite interesting. We are trying apply this work to ChromeOS. What we
want to do is selectively marking tasks, instead of grouping sets of trusted
tasks. I have a patch that adds a prctl which a task can call, and it works
well (task calls prctl and gets a cookie which gives it a dedicated core).

However, I have the following questions, in particular there are 4 scenarios
where I feel the current patches do not resolve MDS/L1TF, would you guys
please share your thoughts?

1. HT1 is running either hostile guest or host code.
   HT2 is running an interrupt handler (victim).

   In this case I see there is a possible MDS issue between HT1 and HT2.

2. HT1 is executing hostile host code, and gets interrupted by a victim
   interrupt. HT2 is idle.

   In this case, I see there is a possible MDS issue between interrupt and
   the host code on the same HT1.

3. HT1 is executing hostile guest code, HT2 is executing a victim interrupt
   handler on the host.

   In this case, I see there is a possible L1TF issue between HT1 and HT2.
   This issue does not happen if HT1 is running host code, since the host
   kernel takes care of inverting PTE bits.

4. HT1 is idle, and HT2 is running a victim process. Now HT1 starts running
   hostile code on guest or host. HT2 is being forced idle. However, there is
   an overlap between HT1 starting to execute hostile code and HT2's victim
   process getting scheduled out.
   Speaking to Vineeth, we discussed an idea to monitor the core_sched_seq
   counter of the sibling being idled to detect that it is now idle.
   However we discussed today that looking at this data, it is not really an
   issue since it is such a small window.

My concern is now cases 1, 2 to which there does not seem a good solution,
short of disabling interrupts. For 3, we could still possibly do something on
the guest side, such as using shadow page tables. Any thoughts on all this?

thanks,

- Joel



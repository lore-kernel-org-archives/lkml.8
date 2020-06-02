Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6785420679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFBJiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:38:12 -0400
Received: from kernel.crashing.org ([76.164.61.194]:55208 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgFBJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:38:12 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0529bUKa025589
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Jun 2020 04:37:34 -0500
Message-ID: <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.8
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ingo Molnar <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Cc:     torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        akpm@linux-foundation.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de
Date:   Tue, 02 Jun 2020 19:37:29 +1000
In-Reply-To: <20200602073350.GA481221@gmail.com>
References: <20200601170102.GA1346815@gmail.com>
         <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
         <20200602073350.GA481221@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 09:33 +0200, Ingo Molnar wrote:
> Or rather, we should ask a higher level question as well, maybe we 
> should not do this feature at all?

Well, it does solve a real issue in some circumstances and there was a
reasonable discussion about this on the list that lead to it being
merged with Kees and Thomas (and others) agreeing :)

But yes, it is pointless with SMT and yes maybe we should make it
explicitly do nothing on SMT, but let's not throw the baby out with the
bath water shall we ?

> Typically cloud computing systems such as AWS will have SMT enabled, 
> because cloud computing pricing is essentially per vCPU, and they want 
> to sell the hyperthreads as vCPUs.

Not necessarily and not in every circumstances. Yes, VMs will typically
have SMT enabled. This isn't targeted at them though. One example that
was given during the discussions was containers pertaining to different
users. Now maybe we could discuss making the flush on changes of
cgroups or other similar things rather than individual process, but so
far that hasn't come up during the disucssion on the mailing list.

Another example would be a process that  handles more critical data
such as payment information, than the rest of the system and wants to
protect itself (or the admin wants that process protected) against
possible data leaks to less trusted processes.

>  So the safest solution, disabling 
> SMT on affected systems, is not actually done, because it's an 
> economic non-starter. (I'd like to note the security double standard 
> there: the most secure option, to disable SMT, is not actually used ...)

This has nothing to do about SMT, though yes maybe we should make the
patch do nothing on SMT but this isn't what this feature is about.

> BTW., I wonder how Amazon is solving the single-vCPU customer workload 
> problem on AWS: if the vast majority of AWS computing capacity is 
> running on a single vCPU, because it's the cheapest tier and because 
> it's more than enough capacity to run a website. Even core-scheduling 
> doesn't solve this fundamental SMT security problem: separate customer 
> workloads *cannot* share the same core - but this means that the 
> single-vCPU workloads will only be able to utilize 50% of all 
> available vCPUs if they are properly isolated.
> 
> Or if the majority of AWS EC2 etc. customer systems are using 2,4 or 
> more vCPUs, then both this feature and 'core-scheduling' is 
> effectively pointless from a security POV, because the cloud computing 
> systems are de-facto partitioned into cores already, with each core 
> accounted as 2 vCPUs.

AWS has more than just VMs for rent :-) There are a whole pile of
higher level "services" that our users can use and not all of them
necessarily run on VMs charged per vCPU.

> The hour-up-rounded way AWS (and many other cloud providers) account 
> system runtime costs suggests that they are doing relatively static 
> partitioning of customer workloads already, i.e. customer workloads 
> are mapped to actual physical hardware in an exclusive fashion, with 
> no overcommitting of physical resources and no sharing of cores 
> between customers.
> 
> If I look at the pricing and capabilities table of AWS:
> 
>   https://aws.amazon.com/ec2/pricing/on-demand/
> 
> Only the 't2' and 't3' On-Demand instances have 'Variable' pricing, 
> which is only 9% of the offered 228 configurations.
> 
> I.e. I strongly suspect that neither L1D flushing nor core-scheduling 
> is actually required on affected vulnerable CPUs to keep customer 
> workloads isolated from each other, on the majority of cloud computing 
> systems, because they are already isolated via semi-static 
> partitioning, using pricing that reflects static partitioning.

This isn't about that. These patches aren't trying to solve problems
happening inside of a customer VM running SMT not are they about
protecting VMs against other VMs on the same system.

Cheers,
Ben.


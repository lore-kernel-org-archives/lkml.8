Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC5C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE37A20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:52:27 -0400
Received: from foss.arm.com ([217.140.110.172]:35528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBKwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:52:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2B65D6E;
        Wed,  2 Sep 2020 03:52:19 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A36653F66F;
        Wed,  2 Sep 2020 03:52:18 -0700 (PDT)
References: <20200829130016.26106-1-valentin.schneider@arm.com> <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] arm64: topology: Stop using MPIDR for topology information
In-reply-to: <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
Date:   Wed, 02 Sep 2020 11:52:16 +0100
Message-ID: <jhja6y8o3hb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/09/20 04:24, B wrote:
> Hi Valentin:
>
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> Sent: Saturday, August 29, 2020 9:00 PM
>> To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Cc: Catalin Marinas; Will Deacon; Sudeep Holla; Robin Murphy; Jeremy
>> Linton; Dietmar Eggemann; Morten Rasmussen; Zengtao (B)
>> Subject: [PATCH] arm64: topology: Stop using MPIDR for topology
>> information
>>
>> In the absence of ACPI or DT topology data, we fallback to haphazardly
>> decoding *something* out of MPIDR. Sadly, the contents of that register
>> are
>> mostly unusable due to the implementation leniancy and things like Aff0
>> having to be capped to 15 (despite being encoded on 8 bits).
>>
>> Consider a simple system with a single package of 32 cores, all under the
>> same LLC. We ought to be shoving them in the same core_sibling mask,
>> but
>> MPIDR is going to look like:
>>
>>   | CPU  | 0 | ... | 15 | 16 | ... | 31 |
>>   |------+---+-----+----+----+-----+----+
>>   | Aff0 | 0 | ... | 15 |  0 | ... | 15 |
>>   | Aff1 | 0 | ... |  0 |  1 | ... |  1 |
>>   | Aff2 | 0 | ... |  0 |  0 | ... |  0 |
>>
>> Which will eventually yield
>>
>>   core_sibling(0-15)  == 0-15
>>   core_sibling(16-31) == 16-31
>>
>> NUMA woes
>> =========
>>
>> If we try to play games with this and set up NUMA boundaries within those
>> groups of 16 cores via e.g. QEMU:
>>
>>   # Node0: 0-9; Node1: 10-19
>>   $ qemu-system-aarch64 <blah> \
>>     -smp 20 -numa node,cpus=0-9,nodeid=0 -numa
>> node,cpus=10-19,nodeid=1
>>
>> The scheduler's MC domain (all CPUs with same LLC) is going to be built via
>>
>>   arch_topology.c::cpu_coregroup_mask()
>>
>> In there we try to figure out a sensible mask out of the topology
>> information we have. In short, here we'll pick the smallest of NUMA or
>> core sibling mask.
>>
>>   node_mask(CPU9)    == 0-9
>>   core_sibling(CPU9) == 0-15
>>
>> MC mask for CPU9 will thus be 0-9, not a problem.
>>
>>   node_mask(CPU10)    == 10-19
>>   core_sibling(CPU10) == 0-15
>>
>> MC mask for CPU10 will thus be 10-19, not a problem.
>>
>>   node_mask(CPU16)    == 10-19
>>   core_sibling(CPU16) == 16-19
>>
>> MC mask for CPU16 will thus be 16-19... Uh oh. CPUs 16-19 are in two
>> different unique MC spans, and the scheduler has no idea what to make of
>> that. That triggers the WARN_ON() added by commit
>>
>>   ccf74128d66c ("sched/topology: Assert non-NUMA topology masks
>> don't (partially) overlap")
>>
>> Fixing MPIDR-derived topology
>> =============================
>>
>> We could try to come up with some cleverer scheme to figure out which of
>> the available masks to pick, but really if one of those masks resulted from
>> MPIDR then it should be discarded because it's bound to be bogus.
>>
>> I was hoping to give MPIDR a chance for SMT, to figure out which threads
>> are
>> in the same core using Aff1-3 as core ID, but Sudeep and Robin pointed out
>> to me that there are systems out there where *all* cores have non-zero
>> values in their higher affinity fields (e.g. RK3288 has "5" in all of its
>> cores' MPIDR.Aff1), which would expose a bogus core ID to userspace.
>>
>> Stop using MPIDR for topology information. When no other source of
>> topology
>> information is available, mark each CPU as its own core and its NUMA
>> node
>> as its LLC domain.
>
> I agree with your idea to remove the topology functionality of MPIDR ,
> but I think we need also consider ARM32 and GIC.
>

Could you please elaborate? This change doesn't impact arch_topology, so
only arm64 is affected.

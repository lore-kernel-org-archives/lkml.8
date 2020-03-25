Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78725C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774920775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCYLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbgCYLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A1A31B;
        Wed, 25 Mar 2020 04:05:57 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1DC3F71F;
        Wed, 25 Mar 2020 04:05:55 -0700 (PDT)
Subject: Re: [PATCH] sched/topology: Fix overlapping sched_group build
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, mgorman@techsingularity.net
References: <20200324125533.17447-1-valentin.schneider@arm.com>
 <jhjmu85sm8b.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4aa814d5-abcd-23b3-323c-5a3503ae3d0a@arm.com>
Date:   Wed, 25 Mar 2020 12:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <jhjmu85sm8b.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 18:20, Valentin Schneider wrote:
> 
> On Tue, Mar 24 2020, Valentin Schneider wrote:
>> Fix
>> ===
>>
>> Sanitize the groups we get out of build_group_from_child_sched_domain()
>> with the span of the domain we're currently building - this ensures the
>> groups we build only contain CPUs that are the right distance away from the
>> base CPU. This also requires modifying build_balance_mask().
>>
> 
> I somehow missed that this triggers the WARN_ON_ONCE() in
> init_overlap_sched_group(). Gotta figure out why.

Cool, seems like qemu can emulate this!


qemu-system-aarch64 -kernel Image -hda ./qemu-image-aarch64.img -append
'root=/dev/vda console=ttyAMA0 loglevel=8 sched_debug' -smp cores=8
--nographic -m 512 -cpu cortex-a53 -machine virt -numa
node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1, -numa
node,cpus=4-5,nodeid=2, -numa node,cpus=6-7,nodeid=3, -numa
dist,src=0,dst=1,val=12, -numa dist,src=0,dst=2,val=20, -numa
dist,src=0,dst=3,val=22, -numa dist,src=1,dst=2,val=22, -numa
dist,src=1,dst=3,val=24, -numa dist,src=2,dst=3,val=12

...
[    0.711685]
[    0.711767]   10 12 20 22
[    0.711860]   12 10 22 24
[    0.711917]   20 22 10 12
[    0.711970]   22 24 12 10
[    0.712036]
[    0.718356] CPU0 attaching sched-domain(s):
[    0.718433]  domain-0: span=0-1 level=MC
[    0.718646]   groups: 0:{ span=0 cap=1006 }, 1:{ span=1 cap=1015 }
[    0.718865]   domain-1: span=0-3 level=NUMA
[    0.718906]    groups: 0:{ span=0-1 cap=2021 }, 2:{ span=2-3 cap=2014 }
[    0.719044]    domain-2: span=0-5 level=NUMA
[    0.719082]     groups: 0:{ span=0-3 cap=4035 }, 4:{ span=4-7 cap=3855 }
[    0.719164] ERROR: groups don't span domain->span
[    0.719191]     domain-3: span=0-7 level=NUMA
[    0.719228]      groups: 0:{ span=0-5 mask=0-1 cap=5974 }, 6:{
span=4-7 mask=6-7 cap=3964 }
[    0.719961] CPU1 attaching sched-domain(s):
...

cat /proc/sys/kernel/sched_domain/cpu0/domain*/{name,flags}
MC
NUMA
NUMA
NUMA
4655
25647
25647
25647

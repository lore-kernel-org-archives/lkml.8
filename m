Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F30C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750062176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgBSIxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:53:52 -0500
Received: from foss.arm.com ([217.140.110.172]:43928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgBSIxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:53:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8441FB;
        Wed, 19 Feb 2020 00:53:51 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D7DD3F68F;
        Wed, 19 Feb 2020 00:53:49 -0800 (PST)
Subject: Re: [RFC] Display the cpu of sched domain in procfs
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Tony Luck <tony.luck@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
References: <CADjb_WQ0wFgZWBo0Xo1Q+NWS6vF0BSs5H0ho+5FM82Mu-JVYoQ@mail.gmail.com>
 <787302f0-670f-fadf-14e6-ea0a73603d77@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <60febadb-df21-a44b-d282-e43c104d2497@arm.com>
Date:   Wed, 19 Feb 2020 09:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <787302f0-670f-fadf-14e6-ea0a73603d77@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 09:13, Valentin Schneider wrote:
> Hi,
> 
> On 19/02/2020 07:15, Chen Yu wrote:
>> Problem:
>> sched domain topology is not always consistent with the CPU topology exposed at
>> /sys/devices/system/cpu/cpuX/topology,  which makes it
>> hard for monitor tools to distinguish the CPUs among different sched domains.
>>
>> For example, on x86 if there are NUMA nodes within a package, say,
>> SNC(Sub-Numa-Cluster),
>> then there would be no die sched domain but only NUMA sched domains
>> created. As a result,
>> you don't know what the sched domain hierarchical is by only looking
>> at /sys/devices/system/cpu/cpuX/topology.
>>
>> Although by appending sched_debug in command line would show the sched
>> domain CPU topology,
>> it is only printed once during boot up, which makes it hard to track
>> at run-time.

What about /proc/schedstat?

E.g. on Intel Xeon CPU E5-2690 v2

$ cat /proc/schedstat | head
version 15
timestamp 4486170100
cpu0 0 0 0 0 0 0 59501267037720 16902762382193 1319621004
domain0 00,00100001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00,3ff003ff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

        ^^^^^^^^^^^

cpu1 0 0 0 0 0 0 56045879920164 16758983055410 1318489275
domain0 00,00200002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00,3ff003ff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
...


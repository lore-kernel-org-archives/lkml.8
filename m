Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF7DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751924670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:47:11 -0500
Received: from foss.arm.com ([217.140.110.172]:46116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:47:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53EFFEC;
        Wed, 19 Feb 2020 02:47:10 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235F63F6CF;
        Wed, 19 Feb 2020 02:47:09 -0800 (PST)
Subject: Re: [RFC] Display the cpu of sched domain in procfs
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <CADjb_WR+611uXfPjME4dTeLRPsKTYoR52X4KSuxhZts1SSnrWA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4fb2735a-4e2f-d913-a4ee-4a02f2b0c6b3@arm.com>
Date:   Wed, 19 Feb 2020 10:46:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CADjb_WR+611uXfPjME4dTeLRPsKTYoR52X4KSuxhZts1SSnrWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 10:00, Chen Yu wrote:
>> Now, if you have a userspace that tries to be clever and wants to use this
>> information then yes, this isn't ideal, but then that's a different matter.
> The dmesg might be lost if someone has once used dmesg -c to clear the log,
> and the /var/log/dmesg might not always there. And it is not common to trigger
> sched domain update once boot up in some environment.
> But anyway, this information printed by sched_debug is very fertile for knowing
> the topology.
>> I think exposing the NUMA boundaries is fair game - and they already are
>> via /sys/devices/system/node/node*/.
> It seems that the numa sysfs could not reflect the SNC topology, it just has the
> *leaf* numa node information. Say, node0 and node1 might form one sched_domain.

Right, but if you have leaves + distance table, then userspace can try to
be clever about it without being exposed to scheduler innards.


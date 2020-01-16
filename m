Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83702C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55134205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:30:58 -0500
Received: from foss.arm.com ([217.140.110.172]:51364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPPa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:30:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61B501396;
        Thu, 16 Jan 2020 07:30:57 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 781D53F68E;
        Thu, 16 Jan 2020 07:30:56 -0800 (PST)
Subject: Re: [PATCH] sched/topology: Assert non-NUMA topology masks don't
 (partially) overlap
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        prime.zeng@hisilicon.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, mingo@kernel.org
References: <20200115160915.22575-1-valentin.schneider@arm.com>
 <20200116104428.GP2827@hirez.programming.kicks-ass.net>
 <20200116151942.GW2871@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <09b2f817-fcd9-8697-38d7-12d141a47a48@arm.com>
Date:   Thu, 16 Jan 2020 15:30:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116151942.GW2871@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/01/2020 15:19, Peter Zijlstra wrote:
> On Thu, Jan 16, 2020 at 11:44:28AM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 15, 2020 at 04:09:15PM +0000, Valentin Schneider wrote:
>>> @@ -1975,6 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>>  				has_asym = true;
>>>  			}
>>>  
>>> +			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
>>> +				goto error;
>>> +
>>>  			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
>>>  
>>>  			if (tl == sched_domain_topology)
>>
>> This is O(nr_cpus), but then, that function already is, so I don't see a
>> problem with this.
> 
> Clearly I meant to write O(nr_cpus^2), there's a bunch of nested
> for_each_cpu() in there.
> 

Hm so the sanity check is O(topo_levels * nr_cpus²), and I think that
roughly matches the complexity of building the sched_groups (I say
roughly because you go over less CPUs as you go up the topo levels).

As you said the important bit is that we don't make build_sched_domains()
noticeably worse, which I think is the case...

>> I'll take it, thanks!

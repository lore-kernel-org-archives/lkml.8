Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FADC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369DF206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA3LGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:06:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3LGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:06:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935CB328;
        Thu, 30 Jan 2020 03:06:51 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909EF3F67D;
        Thu, 30 Jan 2020 03:06:50 -0800 (PST)
Subject: Re: [PATCH v3 2/3] sched/topology: Remove SD_BALANCE_WAKE on
 asymmetric capacity systems
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-3-valentin.schneider@arm.com>
 <92f38645-c6ae-0e15-fac9-8c6064b5d4cf@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <203f41b4-6fbe-2b69-0548-02ea326b704e@arm.com>
Date:   Thu, 30 Jan 2020 11:06:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92f38645-c6ae-0e15-fac9-8c6064b5d4cf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2020 16:27, Dietmar Eggemann wrote:
> On 26/01/2020 21:09, Valentin Schneider wrote:
>> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> [...]
> 
>> @@ -1374,18 +1374,9 @@ sd_init(struct sched_domain_topology_level *tl,
>>  	 * Convert topological properties into behaviour.
>>  	 */
>>  
>> -	if (sd->flags & SD_ASYM_CPUCAPACITY) {
>> -		struct sched_domain *t = sd;
>> -
>> -		/*
>> -		 * Don't attempt to spread across CPUs of different capacities.
>> -		 */
>> -		if (sd->child)
>> -			sd->child->flags &= ~SD_PREFER_SIBLING;
>> -
>> -		for_each_lower_domain(t)
> 
> It seems that with this goes the last use of for_each_lower_domain().
> 
> [...]
> 

Indeed, good catch. I see that was used at some point before the
select_idle_sibling() rework:

  10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings()")

and our asymmetry policy saved it. I'll remove it in v4.

Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A81C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5347320716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgA2MK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:10:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgA2MK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:10:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50041FB;
        Wed, 29 Jan 2020 04:10:56 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B747E3F67D;
        Wed, 29 Jan 2020 04:10:55 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <a2f9e7d1-08c6-2545-2088-e0226ffd79e0@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <40bfa77b-b695-5f53-848a-b72b67b33d69@arm.com>
Date:   Wed, 29 Jan 2020 12:10:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a2f9e7d1-08c6-2545-2088-e0226ffd79e0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2020 11:04, Dietmar Eggemann wrote:
>> +		/*
>> +		 * It would be silly to keep looping when we've found a CPU
>> +		 * of highest available capacity. Just check that it's not been
>> +		 * too pressured lately.
>> +		 */
>> +		if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) &&
> 
> There is a similar check in check_misfit_status(). Common helper function?

Mright, and check_misfit_status() is missing the READ_ONCE(). That said...

> 
>> +		    !check_cpu_capacity(rq, sd))
>> +			return cpu;
> 
> I wonder how this special treatment of a big CPU behaves in (LITTLE,
> medium, big) system like Pixel4 (Snapdragon 855):
> 
>  flame:/ $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> 261
> 261
> 261
> 261
> 871
> 871
> 871
> 1024
> 
> Or on legacy systems where the sd->imbalance_pct is 25% instead of 17%?
> 

... This is a very valid point. When I wrote this bit I had the good old
big.LITTLE split in mind where there are big differences between the capacity
values. As you point out, that's not so true with DynamIQ systems sporting
> 2 capacity values. The issue here is that we could bail early picking a
(slightly) pressured big (1024 capacity_orig) when there was a non-pressured
idle medium (871 capacity orig).

It's borderline in this example - the threshold for a big to be seen as
pressured by check_cpu_capacity(), assuming a flat topology with just an MC
domain, is ~ 875. If we have e.g. mediums at 900 and bigs at 1024, this
logic is broken.

So this is pretty much a case of my trying to be too clever for my own good,
I'll remove that "fastpath" in v4. Thanks for pointing it out!

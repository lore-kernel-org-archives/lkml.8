Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57964222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBMShX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:37:23 -0500
Received: from foss.arm.com ([217.140.110.172]:52104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgBMShW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:37:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E41328;
        Thu, 13 Feb 2020 10:37:21 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2953F68E;
        Thu, 13 Feb 2020 10:37:20 -0800 (PST)
Subject: Re: [RFC 4/4] sched/fair: Take into runnable_avg to classify group
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-5-vincent.guittot@linaro.org>
 <94eae44f-7608-936d-4fde-dcf93cfa6b9b@arm.com>
Message-ID: <e997556f-8adc-2165-2e76-ce9b0229c977@arm.com>
Date:   Thu, 13 Feb 2020 18:37:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <94eae44f-7608-936d-4fde-dcf93cfa6b9b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 6:32 PM, Valentin Schneider wrote:
>> @@ -7911,6 +7912,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>  	if (sgs->sum_nr_running < sgs->group_weight)
>>  		return true;
>>  
>> +	if ((sgs->group_capacity * imbalance_pct) <
>> +			(sgs->group_runnable * 100))
>> +		return false;
>> +
> 
> I haven't stared long enough at patch 2, but I'll ask anyway - with this new
> condition, do we still need the next one (based on util)? AIUI
> group_runnable is >= group_util, so if group_runnable is within the allowed
> margin then group_util has to be as well.
> 

Hmph, actually util_est breaks the runnable >= util assumption I think...

>>  	if ((sgs->group_capacity * 100) >
>>  			(sgs->group_util * imbalance_pct))
>>  		return true;

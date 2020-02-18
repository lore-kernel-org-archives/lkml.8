Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9046FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718EE24654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBRRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:54:44 -0500
Received: from foss.arm.com ([217.140.110.172]:57588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:54:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B3031B;
        Tue, 18 Feb 2020 09:54:43 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D683F68F;
        Tue, 18 Feb 2020 09:54:41 -0800 (PST)
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@suse.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
 <20200218153801.GF3420@suse.de>
 <e28bb567-dade-877b-f338-ce87e28cc02d@arm.com>
 <20200218174119.GG3420@suse.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e173d020-2650-d2db-1e23-7ad71fd49a6c@arm.com>
Date:   Tue, 18 Feb 2020 17:54:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218174119.GG3420@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 17:41, Mel Gorman wrote:
>>> I didn't merge that part of the first version of my series. I was
>>> waiting to see how the implementation for allowing a small degree of
>>> imbalance looks like. If it's entirely confined in adjust_numa_balance
>>                                                      ^^^^^^^^^^^^^^^^^^^
>> Apologies if that's a newbie question, but I'm not familiar with that one.
>> Would that be added in your reconciliation series? I've only had a brief
>> look at it yet (it's next on the chopping block).
>>
> 
> I should have wrote adjust_numa_imbalance but yes, it's part of the
> reconciled series so that NUMA balancing and the load balancer use the
> same helper.
> 

Okay, thanks, then I guess I'll forget about any reconciliation for now
and whinge about it when I'll get to your series ;)

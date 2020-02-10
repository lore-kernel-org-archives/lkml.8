Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED5C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFCE206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgBJPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:21:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgBJPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:21:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821611FB;
        Mon, 10 Feb 2020 07:21:01 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2533F68E;
        Mon, 10 Feb 2020 07:21:00 -0800 (PST)
Subject: Re: [PATCH] drivers base/arch_topology: Remove 'struct sched_domain'
 forward declaration
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200207114913.3052-1-dietmar.eggemann@arm.com>
 <20200207154855.GA5529@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e52903f6-4515-011e-b095-b30f347e3124@arm.com>
Date:   Mon, 10 Feb 2020 16:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207154855.GA5529@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 16:48, Sudeep Holla wrote:
> On Fri, Feb 07, 2020 at 12:49:13PM +0100, Dietmar Eggemann wrote:
>> The sched domain pointer argument from topology_get_freq_scale() and
>> topology_get_cpu_scale() got removed by commit 7673c8a4c75d
>> ("sched/cpufreq: Remove arch_scale_freq_capacity()'s 'sd' parameter")
>> and commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd' parameter
>> from arch_scale_cpu_capacity()").
>>
>> So the 'struct sched_domain' forward declaration is no longer needed.
>> Remove it.
>>
>> W/o the sched domain pointer argument the storage class and inline
>> definition as well as the return type, function name and parameter list
>> fit all into one line.
> 
> Looks simple and good to me. I don't want to ask you split the patch as
> $subject indicates only one of the 2 changes in the patch. I am fine with
> it as it but if anyone else shout for that, go for the split.
> 
> Either way,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> You have not added Greg who generally picks up the patch. Can you repost
> with him in cc and my reviewed-by so that he can pick it up.

Will do. I'll keep the patch like it is. Thanks for the review!

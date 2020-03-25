Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD271C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE2F2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JSA1Om7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:30:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9019 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:30:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7bcd4c0001>; Wed, 25 Mar 2020 14:29:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Mar 2020 14:30:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Mar 2020 14:30:01 -0700
Received: from [10.26.72.231] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 21:29:59 +0000
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-tip-commits@vger.kernel.org>, x86 <x86@kernel.org>,
        <liviu.dudau@arm.com>, <sudeep.holla@arm.com>,
        <lorenzo.pieralisi@arm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20200111052125.238212-1-saravanak@google.com>
 <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e75ae529-264c-9aa6-f711-2afe28ceec36@nvidia.com>
Date:   Wed, 25 Mar 2020 21:29:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324175955.GA16972@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585171788; bh=zwkSmPWYbRZk6Ce7Av1OcrGsQ4eYCwVvf0CQ6wsWw2k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JSA1Om7wkt2BSVOehQRgF4VAja1l6ZPtUcoB5fNOP5axn37rdw8iHeqRDUeY9L/iQ
         nk/M+2oIsXJLRXVgPxVFR5QlE6XIq/kA7lIUAlODiGazqSKNuiz9ciNW2EtMQlIiGP
         //f2D9hZFi2VB0LS3bQbDe0Cly6aIamiwer9Jw2SinXh+zKjbkq/SUjGczSs/IQPtR
         SCH0IGkbPh3ZA+STrjUmakR1w8aePJis960Bll5yPBt4b/VzAxArvgvjeXmzEjqzLA
         ZkAC+GIbN284VCaEVXisMQJ4e1n3z7dkyNyIkeSfPp1V2qIOuEenydPRbYIlYxEXOk
         X81Uxb7KVKFYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/03/2020 17:59, Ionela Voinescu wrote:
> Hi guys,
> 
> On Thursday 19 Mar 2020 at 08:47:46 (-0000), tip-bot2 for Saravana Kannan wrote:
>> The following commit has been merged into the timers/core branch of tip:
>>
>> Conommit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
>> Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
>> Author:        Saravana Kannan <saravanak@google.com>
>> AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
>> Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
>> CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00
>>
>> clocksource/drivers/timer-probe: Avoid creating dead devices
>>
>> Timer initialization is done during early boot way before the driver
>> core starts processing devices and drivers. Timers initialized during
>> this early boot period don't really need or use a struct device.
>>
>> However, for timers represented as device tree nodes, the struct devices
>> are still created and sit around unused and wasting memory. This change
>> avoid this by marking the device tree nodes as "populated" if the
>> corresponding timer is successfully initialized.
>>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
>> ---
>>  drivers/clocksource/timer-probe.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
>> index ee9574d..a10f28d 100644
>> --- a/drivers/clocksource/timer-probe.c
>> +++ b/drivers/clocksource/timer-probe.c
>> @@ -27,8 +27,10 @@ void __init timer_probe(void)
>>  
>>  		init_func_ret = match->data;
>>  
>> +		of_node_set_flag(np, OF_POPULATED);
>>  		ret = init_func_ret(np);
>>  		if (ret) {
>> +			of_node_clear_flag(np, OF_POPULATED);
>>  			if (ret != -EPROBE_DEFER)
>>  				pr_err("Failed to initialize '%pOF': %d\n", np,
>>  				       ret);
>>
> 
> This patch is creating problems on some vexpress platforms - ones that
> are using CLKSRC_VERSATILE (drivers/clocksource/timer-versatile.c).
> I noticed issues on TC2 and FVPs (fixed virtual platforms) starting with
> next-20200318 and still reproducible with next-20200323.

I am also seeing a regression on tegra30-cardhu-a04 when testing system
suspend on -next. Bisect is pointing to this commit and reverting on top
of -next fixes the problem. Unfortunately, there is no crash dump
observed, but the device hangs somewhere when testing suspend.

I have not looked into this any further but wanted to report the problem.

Cheers
Jon

-- 
nvpublic

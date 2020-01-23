Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7D2468C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAWLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:37:59 -0500
Received: from foss.arm.com ([217.140.110.172]:38148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgAWLh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:37:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13B1328;
        Thu, 23 Jan 2020 03:37:57 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA3513F6C4;
        Thu, 23 Jan 2020 03:37:56 -0800 (PST)
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus> <20200123103033.GA7511@bogus>
 <20200123112711.mggm7ayxcqnr54yf@vireshk-i7>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <6b614d90-6326-db81-12dc-a0b4a467400f@arm.com>
Date:   Thu, 23 Jan 2020 11:37:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123112711.mggm7ayxcqnr54yf@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2020 11:27, Viresh Kumar wrote:
> On 23-01-20, 10:30, Sudeep Holla wrote:
>> On Wed, Jan 22, 2020 at 12:15:38PM +0000, Sudeep Holla wrote:
>>> On Wed, Jan 22, 2020 at 08:06:23AM +0530, Viresh Kumar wrote:
>>>
>>
>> [...]
>>
>>>> Can you please help me getting this tested, now that I have rebased it
>>>> as well :) ?
>>>>
>>>
>>> Sure, I will give it a go on my Juno. Thanks for the rebase, makes it
>>> simpler.
>>>
>>
>> Sorry for the delay. I gave this a spin on my Juno. I am seeing below
>> warning once on boot but it continues and everything seem to work fine.
>> Also the warning is not related to this change I believe and this patch
>> is just helping to hit some corner case with deferred probe and devres.
>> I need to spend some time to debug it.
>>
>> Regards,
>> Sudeep
>>
>> --->8
>>
>> WARNING: CPU: 1 PID: 187 at drivers/base/dd.c:519 really_probe+0x11c/0x418
>> Modules linked in:
>> CPU: 1 PID: 187 Comm: kworker/1:2 Not tainted 5.5.0-rc7-00026-gf7231cd3108d-dirty #20
>> Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 16 2020
>> Workqueue: events deferred_probe_work_func
>> pstate: 80000005 (Nzcv daif -PAN -UAO)
>> pc : really_probe+0x11c/0x418
>> lr : really_probe+0x10c/0x418
>> Call trace:
>>  really_probe+0x11c/0x418
>>  driver_probe_device+0xe4/0x138
>>  __device_attach_driver+0x90/0x110
>>  bus_for_each_drv+0x80/0xd0
>>  __device_attach+0xdc/0x160
>>  device_initial_probe+0x18/0x20
>>  bus_probe_device+0x98/0xa0
>>  deferred_probe_work_func+0x90/0xe0
>>  process_one_work+0x1ec/0x4a8
>>  worker_thread+0x210/0x490
>>  kthread+0x110/0x118
>>  ret_from_fork+0x10/0x18
>> ---[ end trace 06f96d55ce6093a8 ]---
> 
> Still it looks strange that the warning comes only after my patch :)

In fact, got the same warning while testing your patch on JUNO at top of SCMI for-next.
But then everything worked fine as Sudeep said.

Thanks

Cristian

> 
> Should I send V5 (fixed few comments after reviews) now ?
> 


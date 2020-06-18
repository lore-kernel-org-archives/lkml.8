Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0834C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D002214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgFRIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:37:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgFRIhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:37:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 818F431B;
        Thu, 18 Jun 2020 01:37:11 -0700 (PDT)
Received: from [10.37.12.69] (unknown [10.37.12.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF343F6CF;
        Thu, 18 Jun 2020 01:37:09 -0700 (PDT)
Subject: Re: [PATCH v8 3/9] firmware: arm_scmi: Add notification dispatch and
 delivery
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        dave.martin@arm.com
References: <20200520081118.54897-1-cristian.marussi@arm.com>
 <20200520081118.54897-4-cristian.marussi@arm.com>
 <20200608170346.GD13622@bogus>
 <20200617233105.GB9236@e119603-lin.cambridge.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <20bf2b0b-c6bc-1010-0512-e970982f9e79@arm.com>
Date:   Thu, 18 Jun 2020 09:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200617233105.GB9236@e119603-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/20 12:31 AM, Cristian Marussi wrote:
> On Mon, Jun 08, 2020 at 06:03:46PM +0100, Sudeep Holla wrote:
>> On Wed, May 20, 2020 at 09:11:12AM +0100, Cristian Marussi wrote:
>>> Add core SCMI Notifications dispatch and delivery support logic which is
>>> able, at first, to dispatch well-known received events from the RX ISR to
>>> the dedicated deferred worker, and then, from there, to final deliver the
>>> events to the registered users' callbacks.
>>>
>>> Dispatch and delivery is just added here, still not enabled.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>   drivers/firmware/arm_scmi/notify.c | 354 ++++++++++++++++++++++++++++-
>>>   drivers/firmware/arm_scmi/notify.h |  10 +
>>>   2 files changed, 362 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
>>> index 7cf61dbe2a8e..d582f71fde5b 100644
>>> --- a/drivers/firmware/arm_scmi/notify.c
>>> +++ b/drivers/firmware/arm_scmi/notify.c
>>
>> [...]
>>
>>> @@ -1085,6 +1422,12 @@ int scmi_notification_init(struct scmi_handle *handle)
>>>   	ni->gid = gid;
>>>   	ni->handle = handle;
>>>   
>>> +	ni->notify_wq = alloc_workqueue("scmi_notify",
>>> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
>>> +					0);
>>
>> What's the use of WQ_SYSFS for SCMI notifications ? Do we need it ?
>>
> 
> Lukasz asked for it, when we were talking about workqueues' priorities configurability.
> (not implemented in this series)

I confirm, I've asked if we can have a mechanism to control these
workqueues. They will be running concurrently with other CFS
tasks which could cause delays for them. They could also be scheduled
on a random core: big or little (depends on its utilization) but maybe
we would like to pin them explicitly to some cores, i.e
little only. We have also discussed a possible mechanism based on RT
threads (which could avoid CFS delays), but that would require a lot of
changes, so this flag here gives us some control.
But if you decide to remove this flag, we would probably find a solution
using uclamp or similar when needed.

Regards,
Lukasz

> 
> Thanks
> 
> Cristian
>> -- 
>> Regards,
>> Sudeep

Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC1C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCWI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:28:05 -0400
Received: from foss.arm.com ([217.140.110.172]:45346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCWI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:28:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4477B31B;
        Mon, 23 Mar 2020 01:28:04 -0700 (PDT)
Received: from [10.57.24.152] (unknown [10.57.24.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2D03F792;
        Mon, 23 Mar 2020 01:28:03 -0700 (PDT)
Subject: Re: [PATCH v4 07/13] firmware: arm_scmi: Add notification dispatch
 and delivery
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-8-cristian.marussi@arm.com>
 <45d4aee9-57df-6be9-c176-cf0d03940c21@arm.com>
 <363cb1ba-76b5-cc1e-af45-454837fae788@arm.com>
 <484214b4-a71d-9c63-86fc-2e469cb1809b@arm.com>
 <20200313190224.GA5808@e120937-lin>
 <d600b3d5-056d-89ef-b8e2-df403285df8b@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <d37e86bb-3ddd-2c61-bbbe-ebb5cc4801dc@arm.com>
Date:   Mon, 23 Mar 2020 08:28:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d600b3d5-056d-89ef-b8e2-df403285df8b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/18/20 8:26 AM, Lukasz Luba wrote:
> Hi Cristian,
> 
> On 3/16/20 2:46 PM, Cristian Marussi wrote:
>> On Thu, Mar 12, 2020 at 09:43:31PM +0000, Lukasz Luba wrote:
>>>
>>>
>>> On 3/12/20 6:34 PM, Cristian Marussi wrote:
>>>> On 12/03/2020 13:51, Lukasz Luba wrote:
>>>>> Hi Cristian,
>>>>>
>> Hi Lukasz
>>
>>>>> just one comment below...
>> [snip]
>>>>>> +    eh.timestamp = ts;
>>>>>> +    eh.evt_id = evt_id;
>>>>>> +    eh.payld_sz = len;
>>>>>> +    kfifo_in(&r_evt->proto->equeue.kfifo, &eh, sizeof(eh));
>>>>>> +    kfifo_in(&r_evt->proto->equeue.kfifo, buf, len);
>>>>>> +    queue_work(r_evt->proto->equeue.wq,
>>>>>> +           &r_evt->proto->equeue.notify_work);
>>>>>
>>>>> Is it safe to ignore the return value from the queue_work here?
>>>>>
>>>>
[snip]

>> On the other side considering the impact of such scenario, I can imagine that
>> it's not simply that we could only have a delayed delivery, but we must consider
>> that if the delayed event is effectively the last one ever it would remain
>> undelivered forever; this is particularly worrying in a scenario in which such
>> last event is particularly important: imagine a system shutdown where a last
>> system-power-off remains undelivered.
> 
> Agree, another example could be a thermal notification for some critical
> trip point.
> 
>>
>> As a consequence I think this rare racy condition should be addressed somehow.
>>
>> Looking at this scenario, it seems the classic situation in which you want to
>> use some sort of completion to avoid missing out on events delivery, BUT in our
>> usecase:
>>
>> - placing the workers loaned from cmwq into an unbounded wait_for_completion()
>>    once the queue is empty seems not the best to use resources (and probably
>>    frowned upon)....using a few dedicated kernel threads to simply let them idle
>>    waiting most of the time seems equally frowned upon (I could be wrong...))
>> - the needed complete() in the ISR would introduce a spinlock_irqsave into the
>>    interrupt path (there's already one inside queue_work in fact) so it is not
>>    desirable, at least not if used on a regular base (for each event notified)
>>
>> So I was thinking to try to reduce sensibly the above race window, more
>> than eliminate it completely, by adding an early flag to be checked under
>> specific conditions in order to retry the queue_work a few times when the race
>> is hit, something like:
>>
>> ISR (core N)        |    WQ (core N+1)
>> -------------------------------------------------------------------------------
>>             | atomic_set(&exiting, 0);
>>             |
>>             | do {
>>             |    ...
>>             |     if (queue_is_empty)        - WORK_PENDING        0 events queued
>>             +          atomic_set(&exiting, 1)    - WORK_PENDING        0 events queued
>> static int cnt=3    |          --> breakout of while    - WORK_PENDING        0 events queued
>> kfifo_in()        |    ....
>>             | } while (scmi_process_event_payload);
>> kfifo_in()        |
>> exiting = atomic_read()    |     ...cmwq backing out        - WORK_PENDING        1 events queued
>> do {            |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>      ret = queue_work()     |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>      if (ret || !exiting)|     ...cmwq backing out        - WORK_PENDING        1 events queued
>>     break;        |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>      mdelay(5);        |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>      exiting =        |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>        atomic_read;    |     ...cmwq backing out        - WORK_PENDING        1 events queued
>> } while (--cnt);    |     ...cmwq backing out        - WORK_PENDING        1 events queued
>>             | ---- WORKER EXIT             - !WORK_PENDING        0 events queued
>>
>> like down below between the scissors.
>>
>> Not tested or tried....I could be missing something...and the mdelay is horrible (and not
>> the cleanest thing you've ever seen probably :D)...I'll have a chat with Sudeep too.
> 
> Indeed it looks more complicated. If you like I can join your offline
> discuss when Sudeep is back.
> 
Yes this is as of now my main remaining issue to address for v6.
I'll wait for Sudeep general review/feedback and raise this point.

Regards

Cristian

> Regards,
> Lukasz

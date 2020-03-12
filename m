Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3C7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97456206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCLU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:57:32 -0400
Received: from foss.arm.com ([217.140.110.172]:41538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCLU5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:57:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4463331B;
        Thu, 12 Mar 2020 13:57:31 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8F663F6CF;
        Thu, 12 Mar 2020 13:57:29 -0700 (PDT)
Subject: Re: [PATCH v4 07/13] firmware: arm_scmi: Add notification dispatch
 and delivery
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-8-cristian.marussi@arm.com>
 <45d4aee9-57df-6be9-c176-cf0d03940c21@arm.com>
 <ec3cc098-da70-f101-fe5c-29741c8f2a62@arm.com>
 <c9d64cad-3bde-602f-ab83-21c997fa472f@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cb4e38be-e8f7-483f-feda-94a19cad1ab1@arm.com>
Date:   Thu, 12 Mar 2020 20:57:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c9d64cad-3bde-602f-ab83-21c997fa472f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/20 7:24 PM, Cristian Marussi wrote:
> On 12/03/2020 14:06, Lukasz Luba wrote:
>>
>>
>> On 3/12/20 1:51 PM, Lukasz Luba wrote:
>>> Hi Cristian,
>>>
> 
> Hi Lukasz
> 
>>> just one comment below...
>>>
>>> On 3/4/20 4:25 PM, Cristian Marussi wrote:
>>>> Add core SCMI Notifications dispatch and delivery support logic which is
>>>> able, at first, to dispatch well-known received events from the RX ISR to
>>>> the dedicated deferred worker, and then, from there, to final deliver the
>>>> events to the registered users' callbacks.
>>>>
>>>> Dispatch and delivery is just added here, still not enabled.
>>>>
>>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>>> ---
>>>> V3 --> V4
>>>> - dispatcher now handles dequeuing of events in chunks (header+payload):
>>>>     handling of these in_flight events let us remove one unneeded memcpy
>>>>     on RX interrupt path (scmi_notify)
>>>> - deferred dispatcher now access their own per-protocol handlers' table
>>>>     reducing locking contention on the RX path
>>>> V2 --> V3
>>>> - exposing wq in sysfs via WQ_SYSFS
>>>> V1 --> V2
>>>> - splitted out of V1 patch 04
>>>> - moved from IDR maps to real HashTables to store event_handlers
>>>> - simplified delivery logic
>>>> ---
>>>>    drivers/firmware/arm_scmi/notify.c | 334 ++++++++++++++++++++++++++++-
>>>>    drivers/firmware/arm_scmi/notify.h |   9 +
>>>>    2 files changed, 342 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/arm_scmi/notify.c
>>>> b/drivers/firmware/arm_scmi/notify.c
>>>
>>> [snip]
>>>
>>>> +
>>>> +/**
>>>> + * scmi_notify  - Queues a notification for further deferred processing
>>>> + *
>>>> + * This is called in interrupt context to queue a received event for
>>>> + * deferred processing.
>>>> + *
>>>> + * @handle: The handle identifying the platform instance from which the
>>>> + *        dispatched event is generated
>>>> + * @proto_id: Protocol ID
>>>> + * @evt_id: Event ID (msgID)
>>>> + * @buf: Event Message Payload (without the header)
>>>> + * @len: Event Message Payload size
>>>> + * @ts: RX Timestamp in nanoseconds (boottime)
>>>> + *
>>>> + * Return: 0 on Success
>>>> + */
>>>> +int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8
>>>> evt_id,
>>>> +        const void *buf, size_t len, u64 ts)
>>>> +{
>>>> +    struct scmi_registered_event *r_evt;
>>>> +    struct scmi_event_header eh;
>>>> +    struct scmi_notify_instance *ni = handle->notify_priv;
>>>> +
>>>> +    /* Ensure atomic value is updated */
>>>> +    smp_mb__before_atomic();
>>>> +    if (unlikely(!atomic_read(&ni->enabled)))
>>>> +        return 0;
>>>> +
>>>> +    r_evt = SCMI_GET_REVT(ni, proto_id, evt_id);
>>>> +    if (unlikely(!r_evt))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (unlikely(len > r_evt->evt->max_payld_sz)) {
>>>> +        pr_err("SCMI Notifications: discard badly sized message\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +    if (unlikely(kfifo_avail(&r_evt->proto->equeue.kfifo) <
>>>> +             sizeof(eh) + len)) {
>>>> +        pr_warn("SCMI Notifications: queue full dropping proto_id:%d
>>>> evt_id:%d  ts:%lld\n",
>>>> +            proto_id, evt_id, ts);
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    eh.timestamp = ts;
>>>> +    eh.evt_id = evt_id;
>>>> +    eh.payld_sz = len;
>>>> +    kfifo_in(&r_evt->proto->equeue.kfifo, &eh, sizeof(eh));
>>>> +    kfifo_in(&r_evt->proto->equeue.kfifo, buf, len);
>>>> +    queue_work(r_evt->proto->equeue.wq,
>>>> +           &r_evt->proto->equeue.notify_work);
>>>
>>> Is it safe to ignore the return value from the queue_work here?
>>
>> and also from the kfifo_in
>>
> 
> kfifo_in returns the number of effectively written bytes (using __kfifo_in),
> possibly capped to the effectively maximum available space in the fifo, BUT since I
> absolutely cannot afford to write an incomplete/truncated event into the queue, I check
> that in advance and backout on queue full:
> 
> if (unlikely(kfifo_avail(&r_evt->proto->equeue.kfifo) < sizeof(eh) + len)) {
> 	return -ENOMEM;
> 
> and given that the ISR scmi_notify() is the only possible writer on this queue

Yes, your are right, no other IRQ will show up for this channel till
we exit mailbox rx callback and clean the bits.

> I can be sure that the kfifo_in() will succeed in writing the required number of
> bytes after the above check...so I don't need to check the return value.
> 
> Regards
> 
> Cristian
> 
>>>
>>> Regards,
>>> Lukasz
>>>
>>>
> 

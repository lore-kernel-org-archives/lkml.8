Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2627C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EC2206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCLSeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:34:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:34:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7418030E;
        Thu, 12 Mar 2020 11:34:05 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63313F67D;
        Thu, 12 Mar 2020 11:34:04 -0700 (PDT)
Subject: Re: [PATCH v4 07/13] firmware: arm_scmi: Add notification dispatch
 and delivery
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-8-cristian.marussi@arm.com>
 <45d4aee9-57df-6be9-c176-cf0d03940c21@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <363cb1ba-76b5-cc1e-af45-454837fae788@arm.com>
Date:   Thu, 12 Mar 2020 18:34:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <45d4aee9-57df-6be9-c176-cf0d03940c21@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 13:51, Lukasz Luba wrote:
> Hi Cristian,
> 
> just one comment below...

Hi Lukasz

Thanks for the review

> 
> On 3/4/20 4:25 PM, Cristian Marussi wrote:
>> Add core SCMI Notifications dispatch and delivery support logic which is
>> able, at first, to dispatch well-known received events from the RX ISR to
>> the dedicated deferred worker, and then, from there, to final deliver the
>> events to the registered users' callbacks.
>>
>> Dispatch and delivery is just added here, still not enabled.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> V3 --> V4
>> - dispatcher now handles dequeuing of events in chunks (header+payload):
>>    handling of these in_flight events let us remove one unneeded memcpy
>>    on RX interrupt path (scmi_notify)
>> - deferred dispatcher now access their own per-protocol handlers' table
>>    reducing locking contention on the RX path
>> V2 --> V3
>> - exposing wq in sysfs via WQ_SYSFS
>> V1 --> V2
>> - splitted out of V1 patch 04
>> - moved from IDR maps to real HashTables to store event_handlers
>> - simplified delivery logic
>> ---
>>   drivers/firmware/arm_scmi/notify.c | 334 ++++++++++++++++++++++++++++-
>>   drivers/firmware/arm_scmi/notify.h |   9 +
>>   2 files changed, 342 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> 
> [snip]
> 
>> +
>> +/**
>> + * scmi_notify  - Queues a notification for further deferred processing
>> + *
>> + * This is called in interrupt context to queue a received event for
>> + * deferred processing.
>> + *
>> + * @handle: The handle identifying the platform instance from which the
>> + *	    dispatched event is generated
>> + * @proto_id: Protocol ID
>> + * @evt_id: Event ID (msgID)
>> + * @buf: Event Message Payload (without the header)
>> + * @len: Event Message Payload size
>> + * @ts: RX Timestamp in nanoseconds (boottime)
>> + *
>> + * Return: 0 on Success
>> + */
>> +int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
>> +		const void *buf, size_t len, u64 ts)
>> +{
>> +	struct scmi_registered_event *r_evt;
>> +	struct scmi_event_header eh;
>> +	struct scmi_notify_instance *ni = handle->notify_priv;
>> +
>> +	/* Ensure atomic value is updated */
>> +	smp_mb__before_atomic();
>> +	if (unlikely(!atomic_read(&ni->enabled)))
>> +		return 0;
>> +
>> +	r_evt = SCMI_GET_REVT(ni, proto_id, evt_id);
>> +	if (unlikely(!r_evt))
>> +		return -EINVAL;
>> +
>> +	if (unlikely(len > r_evt->evt->max_payld_sz)) {
>> +		pr_err("SCMI Notifications: discard badly sized message\n");
>> +		return -EINVAL;
>> +	}
>> +	if (unlikely(kfifo_avail(&r_evt->proto->equeue.kfifo) <
>> +		     sizeof(eh) + len)) {
>> +		pr_warn("SCMI Notifications: queue full dropping proto_id:%d  evt_id:%d  ts:%lld\n",
>> +			proto_id, evt_id, ts);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	eh.timestamp = ts;
>> +	eh.evt_id = evt_id;
>> +	eh.payld_sz = len;
>> +	kfifo_in(&r_evt->proto->equeue.kfifo, &eh, sizeof(eh));
>> +	kfifo_in(&r_evt->proto->equeue.kfifo, buf, len);
>> +	queue_work(r_evt->proto->equeue.wq,
>> +		   &r_evt->proto->equeue.notify_work);
> 
> Is it safe to ignore the return value from the queue_work here?
> 

In fact yes, we do not want to care: it returns true or false depending on the
fact that the specific work was or not already queued, and we just rely on
this behavior to keep kicking the worker only when needed but never kick
more than one instance of it per-queue (so that there's only one reader
wq and one writer here in the scmi_notify)...explaining better:

1. we push an event (hdr+payld) to the protocol queue if we found that there was
enough space on the queue

2a. if at the time of the kfifo_in( ) the worker was already running
(queue not empty) it will process our new event sooner or later and here
the queue_work will return false, but we do not care in fact ... we
tried to kick it just in case

2b. if instead at the time of the kfifo_in() the queue was empty the worker would
have probably already gone to the sleep and this queue_work() will return true and
so this time it will effectively wake up the worker to process our items

The important thing here is that we are sure to wakeup the worker when needed
but we are equally sure we are never causing the scheduling of more than one worker
thread consuming from the same queue (because that would break the one reader/one writer
assumption which let us use the fifo in a lockless manner): this is possible because
queue_work checks if the required work item is already pending and in such a case backs
out returning false and we have one work_item (notify_work) defined per-protocol and
so per-queue.

Now probably I wrote too much of an explanation and confuse stuff more ... :D

Regards

Cristian

> Regards,
> Lukasz
> 
> 


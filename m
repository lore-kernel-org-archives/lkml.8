Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA05C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6015208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCIMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:04:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgCIMEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:04:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0964430E;
        Mon,  9 Mar 2020 05:04:22 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9B233F6CF;
        Mon,  9 Mar 2020 05:04:20 -0700 (PDT)
Subject: Re: [PATCH v4 05/13] firmware: arm_scmi: Add notification
 protocol-registration
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-6-cristian.marussi@arm.com>
 <20200309113325.0000108c@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <b324c193-d97e-ce29-7c70-ba340eba8bcd@arm.com>
Date:   Mon, 9 Mar 2020 12:04:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309113325.0000108c@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 09/03/2020 11:33, Jonathan Cameron wrote:
> On Wed, 4 Mar 2020 16:25:50 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> Add core SCMI Notifications protocol-registration support: allow protocols
>> to register their own set of supported events, during their initialization
>> phase. Notification core can track multiple platform instances by their
>> handles.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Hi.
> 
> A few minor things inline.  Fairly sure kernel-doc needs
> struct before the heading for each structure comment block.
> 
> Also, the events queue init looks like it could just be done with
> a kfifo_alloc call.  Perhaps that makes sense given later patches...
> 
> Thanks,
> 
> Jonathan

Thanks for the review first of all !

> 
>> ---
>> V3 --> V4
>> - removed scratch ISR buffer, move scratch BH buffer into protocol
>>   descriptor
>> - converted registered_protocols and registered_events from hashtables
>>   into bare fixed-sized arrays
>> - removed unregister protocols' routines (never called really)
>> V2 --> V3
>> - added scmi_notify_instance to track target platform instance
>> V1 --> V2
>> - splitted out of V1 patch 04
>> - moved from IDR maps to real HashTables to store events
>> - scmi_notifications_initialized is now an atomic_t
>> - reviewed protocol registration/unregistration to use devres
>> - fixed:
>>   drivers/firmware/arm_scmi/notify.c:483:18-23: ERROR:
>>   	reference preceded by free on line 482
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>> ---
[snip]
>> +
>> +/**
>> + * scmi_notify_instance  - Represents an instance of the notification core
>> + *
>> + * Each platform instance, represented by a handle, has its own instance of
>> + * the notification subsystem represented by this structure.
>> + *
>> + * @gid: GroupID used for devres
>> + * @handle: A reference to the platform instance
>> + * @initialized: A flag that indicates if the core resources have been allocated
>> + *		 and protocols are allowed to register their supported events
>> + * @enabled: A flag to indicate events can be enabled and start flowing
>> + * @registered_protocols: An statically allocated array containing pointers to
>> + *			  all the registered protocol-level specific information
>> + *			  related to events' handling
>> + */
>> +struct scmi_notify_instance {
>> +	void						*gid;
>> +	struct scmi_handle				*handle;
>> +	atomic_t					initialized;
>> +	atomic_t					enabled;
>> +	struct scmi_registered_protocol_events_desc	**registered_protocols;
>> +};
>> +
>> +/**
>> + * events_queue  - Describes a queue and its associated worker
> 
> I guess this might become clear later, but right now this just looks like
> we are open code what could be handled automatically by just using
> kfifo_alloc
> 

In fact I switched to this split alloc/init (as you guessed later) because of the lack
of devm_ flavour (and my ignorance about the usage of devm_add_action_or_reset ...)
I'll look into it.

>> + *
>> + * Each protocol has its own dedicated events_queue descriptor.
>> + *
>> + * @sz: Size in bytes of the related kfifo
>> + * @qbuf: Pre-allocated buffer of @sz bytes to be used by the kfifo
>> + * @kfifo: A dedicated Kernel kfifo descriptor
>> + */
>> +struct events_queue {
>> +	size_t				sz;
>> +	u8				*qbuf;
>> +	struct kfifo			kfifo;
>> +};
>> +
>> +/**
>> + * scmi_event_header  - A utility header
> 
> struct scmi...
> 

I'll fix all of these and test with kernel-doc.

>> + *
>> + * This header is prepended to each received event message payload before
>> + * queueing it on the related events_queue.
>> + *
>> + * @timestamp: The timestamp, in nanoseconds (boottime), which was associated
>> + *	       to this event as soon as it entered the SCMI RX ISR
>> + * @evt_id: Event ID (corresponds to the Event MsgID for this Protocol)
>> + * @payld_sz: Effective size of the embedded message payload which follows
>> + * @payld: A reference to the embedded event payload
>> + */
>> +struct scmi_event_header {
>> +	u64	timestamp;
>> +	u8	evt_id;
>> +	size_t	payld_sz;
>> +	u8	payld[];
>> +} __packed;
>> +
>> +struct scmi_registered_event;
>> +
>> +/**
>> + * scmi_registered_protocol_events_desc  - Protocol Specific information
>> + *
>> + * All protocols that registers at least one event have their protocol-specific
>> + * information stored here, together with the embedded allocated events_queue.
>> + * These descriptors are stored in the @registered_protocols array at protocol
>> + * registration time.
>> + *
>> + * Once these descriptors are successfully registered, they are NEVER again
>> + * removed or modified since protocols do not unregister ever, so that once we
>> + * safely grab a NON-NULL reference from the array we can keep it and use it.
>> + *
>> + * @id: Protocol ID
>> + * @ops: Protocol specific and event-related operations
>> + * @equeue: The embedded per-protocol events_queue
>> + * @ni: A reference to the initialized instance descriptor
>> + * @eh: A reference to pre-allocated buffer to be used as a scratch area by the
>> + *	deferred worker when fetching data from the kfifo
>> + * @eh_sz: Size of the pre-allocated buffer @eh
>> + * @in_flight: A reference to an in flight @scmi_registered_event
>> + * @num_events: Number of events in @registered_events
>> + * @registered_events: A dynamically allocated array holding all the registered
>> + *		       events' descriptors, whose fixed-size is determined at
>> + *		       compile time.
>> + */
>> +struct scmi_registered_protocol_events_desc {
>> +	u8					id;
>> +	const struct scmi_protocol_event_ops	*ops;
>> +	struct events_queue			equeue;
>> +	struct scmi_notify_instance		*ni;
>> +	struct scmi_event_header		*eh;
>> +	size_t					eh_sz;
>> +	void					*in_flight;
>> +	int					num_events;
>> +	struct scmi_registered_event		**registered_events;
>> +};
>> +
>> +/**
>> + * scmi_registered_event  - Event Specific Information
> 
> struct scmi_registered_event - Event...
> 
I'll fix
>> + *
>> + * All registered events are represented by one of these structures that are
>> + * stored in the @registered_events array at protocol registration time.
>> + *
>> + * Once these descriptors are successfully registered, they are NEVER again
>> + * removed or modified since protocols do not unregister ever, so that once we
>> + * safely grab a NON-NULL reference from the table we can keep it and use it.
>> + *
>> + * @proto: A reference to the associated protocol descriptor
>> + * @evt: A reference to the associated event descriptor (as provided at
>> + *       registration time)
>> + * @report: A pre-allocated buffer used by the deferred worker to fill a
>> + *	    customized event report
>> + * @num_sources: The number of possible sources for this event as stated at
>> + *		 events' registration time
>> + * @sources: A reference to a dynamically allocated array used to refcount the
>> + *	     events' enable requests for all the existing sources
>> + * @sources_mtx: A mutex to serialize the access to @sources
>> + */
>> +struct scmi_registered_event {
>> +	struct scmi_registered_protocol_events_desc	*proto;
>> +	const struct scmi_event				*evt;
>> +	void						*report;
>> +	u32						num_sources;
>> +	refcount_t					*sources;
>> +	struct mutex					sources_mtx;
>> +};
>> +
>> +/**
>> + * scmi_initialize_events_queue  - Allocate/Initialize a kfifo buffer
>> + *
>> + * Allocate a buffer for the kfifo and initialize it.
>> + *
>> + * @ni: A reference to the notification instance to use
>> + * @equeue: The events_queue to initialize
>> + * @sz: Size of the kfifo buffer to allocate
>> + *
>> + * Return: 0 on Success
>> + */
>> +static int scmi_initialize_events_queue(struct scmi_notify_instance *ni,
>> +					struct events_queue *equeue, size_t sz)
>> +{
>> +	equeue->qbuf = devm_kzalloc(ni->handle->dev, sz, GFP_KERNEL);
>> +	if (!equeue->qbuf)
>> +		return -ENOMEM;
>> +	equeue->sz = sz;
>> +
>> +	return kfifo_init(&equeue->kfifo, equeue->qbuf, equeue->sz);
> 
> This seems like a slightly odd dance.  Why not use kfifo_alloc?
> 
> If it's because of the lack of devm_kfifo_alloc, maybe use a devm_add_action_or_reset
> to handle that.
> 

As said above exactly for the lack of devm_ flavour
>> +}
>> +
>> +/**
>> + * scmi_allocate_registered_protocol_desc  - Allocate a registered protocol
>> + * events' descriptor
>> + *
>> + * It is supposed to be called only once for each protocol at protocol
>> + * initialization time, so it warns if the requested protocol is found
>> + * already registered.
>> + *
>> + * @ni: A reference to the notification instance to use
>> + * @proto_id: Protocol ID
>> + * @queue_sz: Size of the associated queue to allocate
>> + * @eh_sz: Size of the event header scratch area to pre-allocate
>> + * @num_events: Number of events to support (size of @registered_events)
>> + * @ops: Pointer to a struct holding references to protocol specific helpers
>> + *	 needed during events handling
>> + *
>> + * Returns the allocated and registered descriptor on Success
>> + */
>> +static struct scmi_registered_protocol_events_desc *

[snip]
>> + */
>> +void scmi_notification_exit(struct scmi_handle *handle)
>> +{
>> +	struct scmi_notify_instance *ni = handle->notify_priv;
>> +
>> +	if (unlikely(!ni || !atomic_read(&ni->initialized)))
>> +		return;
>> +
>> +	atomic_set(&ni->enabled, 0);
>> +	/* Ensure atomic values are updated */
>> +	smp_mb__after_atomic();
>> +
>> +	devres_release_group(ni->handle->dev, ni->gid);
>> +
>> +	pr_info("SCMI Notifications Core Shutdown.\n");
> 
> Is this actually useful?  Seems like noise to me, maybe pr_debug is more appopriate.
> 
No I think in general the verbosity of the printk is still to be 'tuned' in this series

>> +}
>> diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
>> new file mode 100644
>> index 000000000000..a7ece64e8842
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/notify.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * System Control and Management Interface (SCMI) Message Protocol
>> + * notification header file containing some definitions, structures
>> + * and function prototypes related to SCMI Notification handling.
>> + *
>> + * Copyright (C) 2019 ARM Ltd.
> 
> Update the dates given you are still changing this stuff?
> 

Missed that. I'll fix.

>> + */
>> +#ifndef _SCMI_NOTIFY_H
>> +#define _SCMI_NOTIFY_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +/**
>> + * scmi_event  - Describes an event to be supported
> 
> Fairly sure this isn't valid kernel-doc.
> 
>    * struct scmi_event - ...
> 
> Make sure to run the kernel-doc scripts over any files you've added kernel-doc to
> and tidy up the warnings.
> 
I'll do.
>> + *
>> + * Each SCMI protocol, during its initialization phase, can describe the events
>> + * it wishes to support in a few struct scmi_event and pass them to the core
>> + * using scmi_register_protocol_events().
>> + *
>> + * @id: Event ID
>> + * @max_payld_sz: Max possible size for the payload of a notif msg of this kind
>> + * @max_report_sz: Max possible size for the report of a notif msg of this kind
>> + */
>> +struct scmi_event {
>> +	u8	id;
>> +	size_t	max_payld_sz;
>> +	size_t	max_report_sz;
>> +
> 
> Nitpick: Blank line isn't adding anything
> 

Missed. I'll fix

As a general note, this morning I was going to reply to myself (O_o) on this patch
saying that I'm inclined to review a bit the current initialization phase of 
registered_protocols and registered_events in the sense of adding a few cpu barriers
which are probably lacking where I use mere compiler barriers (_ONCE).
I'll put those probably in v5

Thanks again

Cristian

>> +
>> +/**
>> + * scmi_protocol_event_ops  - Helpers called by notification core.
>> + *
>> + * These are called only in process context.
>> + *
>> + * @set_notify_enabled: Enable/disable the required evt_id/src_id notifications
>> + *			using the proper custom protocol commands.
>> + *			Return true if at least one the required src_id
>> + *			has been successfully enabled/disabled
>> + */
>> +struct scmi_protocol_event_ops {
>> +	bool (*set_notify_enabled)(const struct scmi_handle *handle,
>> +				   u8 evt_id, u32 src_id, bool enabled);
>> +};
>> +
>> +int scmi_notification_init(struct scmi_handle *handle);
>> +void scmi_notification_exit(struct scmi_handle *handle);
>> +
>> +int scmi_register_protocol_events(const struct scmi_handle *handle,
>> +				  u8 proto_id, size_t queue_sz,
>> +				  const struct scmi_protocol_event_ops *ops,
>> +				  const struct scmi_event *evt, int num_events,
>> +				  int num_sources);
>> +
>> +#endif /* _SCMI_NOTIFY_H */
>> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
>> index 5c873a59b387..0679f10ab05e 100644
>> --- a/include/linux/scmi_protocol.h
>> +++ b/include/linux/scmi_protocol.h
>> @@ -4,6 +4,10 @@
>>   *
>>   * Copyright (C) 2018 ARM Ltd.
>>   */
>> +
>> +#ifndef _LINUX_SCMI_PROTOCOL_H
>> +#define _LINUX_SCMI_PROTOCOL_H
>> +
>>  #include <linux/device.h>
>>  #include <linux/types.h>
>>  
>> @@ -227,6 +231,8 @@ struct scmi_reset_ops {
>>   *	protocol(for internal use only)
>>   * @reset_priv: pointer to private data structure specific to reset
>>   *	protocol(for internal use only)
>> + * @notify_priv: pointer to private data structure specific to notifications
>> + *	(for internal use only)
>>   */
>>  struct scmi_handle {
>>  	struct device *dev;
>> @@ -242,6 +248,7 @@ struct scmi_handle {
>>  	void *power_priv;
>>  	void *sensor_priv;
>>  	void *reset_priv;
>> +	void *notify_priv;
>>  };
>>  
>>  enum scmi_std_protocol {
>> @@ -319,3 +326,5 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
>>  typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
>>  int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
>>  void scmi_protocol_unregister(int protocol_id);
>> +
>> +#endif /* _LINUX_SCMI_PROTOCOL_H */
> 
> 


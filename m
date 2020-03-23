Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E6C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E432074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCWIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:54:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCWIyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:54:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B627631B;
        Mon, 23 Mar 2020 01:54:31 -0700 (PDT)
Received: from [10.57.24.152] (unknown [10.57.24.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41E63F792;
        Mon, 23 Mar 2020 01:54:30 -0700 (PDT)
Subject: Re: [PATCH v5 00/13] SCMI Notifications Core Support
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200316150334.47463-1-cristian.marussi@arm.com>
 <e51598b5-2c7b-56f2-4426-9cce3d5d3d52@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <00e588ec-9bc7-88e2-5e57-e0c223450693@arm.com>
Date:   Mon, 23 Mar 2020 08:54:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e51598b5-2c7b-56f2-4426-9cce3d5d3d52@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On 3/18/20 9:01 AM, Lukasz Luba wrote:
> Hi Cristian,
> 
> On 3/16/20 3:03 PM, Cristian Marussi wrote:
>> Hi all,
>>
>> this series wants to introduce SCMI Notification Support, built on top of
>> the standard Kernel notification chain subsystem.
>>
>> At initialization time each SCMI Protocol takes care to register with the
>> new SCMI notification core the set of its own events which it intends to
>> support.
>>
>> Using the API exposed via scmi_handle.notify_ops a Kernel user can register
>> its own notifier_t callback (via a notifier_block as usual) against any
>> registered event as identified by the tuple:
>>
>>         (proto_id, event_id, src_id)
>>
>> where src_id represents a generic source identifier which is protocol
>> dependent like domain_id, performance_id, sensor_id and so forth.
>> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>>   the existing (if any) src_id sources for that proto_id/evt_id combination)
>>
>> Each of the above tuple-specified event will be served on its own dedicated
>> blocking notification chain, dynamically allocated on-demand when at least
>> one user has shown interest on that event.
>>
>> Upon a notification delivery all the users' registered notifier_t callbacks
>> will be in turn invoked and fed with the event_id as @action param and a
>> generated custom per-event struct _report as @data param.
>> (as in include/linux/scmi_protocol.h)
>>
>> The final step of notification delivery via users' callback invocation is
>> instead delegated to a pool of deferred workers (Kernel cmwq): each
>> SCMI protocol has its own dedicated worker and dedicated queue to push
>> events from the rx ISR to the worker.
>>
> 
> Could you give an example how the notification would be delivered
> further to the upper layers, like hwmon driver, cpufreq or thermal?

Sure. I tested registering various callbacks against PERF events (since they're
what I have available on my platform implementation); I used probe() in scmi-genpd
and scmi-cpufreq to register generic testing callbacks like:

scmi_cpufrq_probe()

...
	src_id = 0x00;
	handle->notify_ops->register_event_notifier(handle, SCMI_PROTOCOL_PERF,
						    0x1, &src_id, &my_cpufreq_nb);

and removing similarly in remove().

I'll send you my debug patches that includes genpd/cpufreq callbacks registration and
an additional dummy driver that just registers perf callbacks so you can have a better idea
of the intended usage.

> For example, for sensor protocol which delivers event
> SENSOR_TRIP_POINT_EVENT indicating a trip point was crossed.
>

Regarding sensors it could be something like:


	sensor_id = 0x00;

	handle->notify_ops->register_event_notifier(handle, SCMI_PROTOCOL_SENSOR,
						    0x0, &sensor_id, &my_sensor_nb);

	handle->sensor_ops->trip_point_config(handle, sensor_id, 0, 10000);
  
Note that the notification core takes care on its own of enabling the specific events generation
when you register the first callback for a specific event as identified by (proto_id, event_id, src_id)
but in the case of the sensor protocol you'll need to explicitly setup the trip_point too.

As a result when the trip point is crossed you'll receive in your callback a sensor_report
(as in include/linux/scmi_protocol.h) as your data arg.

I just realized that being the notification enable method (trip_notify) also exposed by the ops directly,
I should probably add some sort of alert for a user...since it is not meant to be used directly when
the notification subsystem is being used....I'll think about this pitfall.

> Would it be possible for:
> drivers/hwmon/scmi-hwmon.c
> to get this temperature events like an interrupt?
> 

Sorry I did not get what you mean here.

Regards

Cristian

> I couldn't find it in the implementation of the registered handlers.
> 
> Regards,
> Lukasz

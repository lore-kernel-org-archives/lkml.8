Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDB520828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBXOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:40:36 -0500
Received: from foss.arm.com ([217.140.110.172]:38082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgBXOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:40:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3FE30E;
        Mon, 24 Feb 2020 06:40:35 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB8F3F534;
        Mon, 24 Feb 2020 06:40:34 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/13] SCMI Notifications Core Support
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Jonathan.Cameron@huawei.com
References: <20200214153535.32046-1-cristian.marussi@arm.com>
 <CA+-6iNyFYusJTfiFgCNoRrcT5Xo4nof4fc=d46GiPAUD4o2j+Q@mail.gmail.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <68cbc7a3-dfcd-99c9-c8be-c2dc15de09f4@arm.com>
Date:   Mon, 24 Feb 2020 14:40:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+-6iNyFYusJTfiFgCNoRrcT5Xo4nof4fc=d46GiPAUD4o2j+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim

On 18/02/2020 20:19, Jim Quinlan wrote:
> Hi Cristian,
> 
> This looks very robust and general but I'm wondering about the
> "notification -> user" latency.  It appears there are at least five or
> so memcpy()s of the notification message as it works its way to the
> user, and added to that is the work queue deferral latency.  Is there
> a concern on your end for low latency notifications, perhaps for
> emergency notifications or do you consider this to be quick enough?
> 
> Note that we (BrcmSTB) have implemented our own  SCMI notification
> system for a proprietary protocol and we designed it to deliver
> notifications as quickly as possible.  Our system is more or less a
> disposable hack and would not stand up to heavy or general usage.  We
> fully intend to move to the approved Linux notification system.  On
> that note,  I'm just wondering if you had any comment on the
> possibility of  "slimming down" your RFC, e.g. perhaps somehow
> collapsing some memcpy()s.

Besides other still open considerations on latency, I spotted one certainly
not strictly needed event-payload-sized memcpy that I'm going to remove so as
to have only the bare minimum bytes copied in and out the queues. (it will
complicate a bit the code in the worker but not dramatically)
I'll do that not in today v3 but in the next v4 (due anyway to solve some
residual initialization corner cases).

Thanks

Regards

Cristian

> 
> Thanks,
> Jim
> PS I'm going on vacation so I won't be able to email for a week.
> 
> 
> On Fri, Feb 14, 2020 at 10:36 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
>>
>> Hi all,
>>
>> this series wants to introduce SCMI Notification Support, built on top of
>> the standard Kernel notification chain subsystem.
>>
>> At initialization time each SCMI Protocol takes care to register with the
>> new SCMI notification core the set of its own events which it intends to
>> support.
>>
>> Using a possibly proposed API in include/linux/scmi_protocol.h (not
>> finalized though, NO EXPORTs_) a Kernel user can register its own
>> notifier_t callback (via a notifier_block as usual) against any registered
>> event as identified by the tuple:
>>
>>                 (proto_id, event_id, src_id)
>>
>> where src_id represents a generic source identifier which is protocol
>> dependent like domain_id, performance_id, sensor_id and so forth.
>> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>>  the existing (if any) src_id sources for that proto_id/evt_id combination)
>>
>> Each of the above tuple-specified event will be served on its own dedicated
>> blocking notification chain.
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
>> The series is marked as RFC mainly because:
>>
>> - the API as said is tentative and not EXPORTed; currently consisting of a
>>   generic interface like:
>>
>>          scmi_register_event_notifier(proto_id, evt_id, *src_id, *nb)
>>
>>   as found in scmi_protocol.h, or using the equivalent 'handle' operations
>>   in scmi_notify_ops if used by an scmi_driver.
>>
>>   It's open for discussion.
>>
>> - no Event priorization has been considered: each protocol has its own
>>   queue and deferred worker instance, so as to avoid that one protocol
>>   flood can overrun a single queue and influence other protocols'
>>   notifications' delivery.
>>   But that's it, all the workers are unbound, low_pri cmwq workers.
>>
>>   Should we enforce some sort of built-in prio amongst the events ?
>>   Should this priority instead be compile time configurable ?#git send-email --dry-run --suppress-cc=all --to=linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org --cc=sudeep.holla@arm.com,lukasz.luba@arm.com,james.quinlan@broadcom.com,Jonathan.Cameron@Huawei.com,cristian.marussi@arm.com patch_scmi_notif/ext_V1/final/
>>
>>   Again, open for discussion.
>>
>> - no configuration is possible: it can be imagined that on a real platform
>>   events' priority (if any) and events queues' depth could be something
>>   somehow compile-time configurable, but this is not addressed by this
>>   series at all.
>>
>> Based on scmi-next 5.6 [1], on top of:
>>
>> commit 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
>>                       the transport type")
>>
>> This series has been tested on JUNO with an experimental firmware only
>> supporting Perf Notifications.
>>
>> Any thoughts ?
>>
>> Thanks
>>
>> Cristian
>> ----
>>
>> v1 --> v2:
>> - dropped anti-tampering patch
>> - rebased on top of scmi-for-next-5.6, which includes Viresh series that
>>   make SCMI core independent of transport (5c8a47a5a91d)
>> - add a few new SCMI transport methods on top of Viresh patch to address
>>   needs of SCMI Notifications
>> - reviewed/renamed scmi_handle_xfer_delayed_resp()
>> - split main SCMI Notification core patch (~1k lines) into three chunks:
>>   protocol-registration / callbacks-registration / dispatch-and-delivery
>> - removed awkward usage of IDR maps in favour of pure hashtables
>> - added enable/disable refcounting in notification core (was broken in v1)
>> - removed per-protocol candidate API: a single generic API is now proposed
>>   instead of scmi_register_<proto>_event_notifier(evt_id, *src_id, *nb)
>> - added handle->notify_ops as an alternative notification API
>>   for scmi_driver
>> - moved ALL_SRCIDs enabled handling from protocol code to core code
>> - reviewed protocol registration/unregistration logic to use devres
>> - reviewed cleanup phase on shutdown
>> - fixed  ERROR: reference preceded by free as reported by kbuild test robot
>>
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
>>
>> Cristian Marussi (10):
>>   firmware: arm_scmi: Add notifications support in transport layer
>>   firmware: arm_scmi: Add notification protocol-registration
>>   firmware: arm_scmi: Add notification callbacks-registration
>>   firmware: arm_scmi: Add notification dispatch and delivery
>>   firmware: arm_scmi: Enable notification core
>>   firmware: arm_scmi: Add Power notifications support
>>   firmware: arm_scmi: Add Perf notifications support
>>   firmware: arm_scmi: Add Sensor notifications support
>>   firmware: arm_scmi: Add Reset notifications support
>>   firmware: arm_scmi: Add Base notifications support
>>
>> Sudeep Holla (3):
>>   firmware: arm_scmi: Add receive buffer support for notifications
>>   firmware: arm_scmi: Update protocol commands and notification list
>>   firmware: arm_scmi: Add support for notifications message processing
>>
>>  drivers/firmware/arm_scmi/Makefile  |    2 +-
>>  drivers/firmware/arm_scmi/base.c    |  121 +++
>>  drivers/firmware/arm_scmi/bus.c     |   11 +
>>  drivers/firmware/arm_scmi/common.h  |   12 +
>>  drivers/firmware/arm_scmi/driver.c  |  118 ++-
>>  drivers/firmware/arm_scmi/mailbox.c |   17 +
>>  drivers/firmware/arm_scmi/notify.c  | 1102 +++++++++++++++++++++++++++
>>  drivers/firmware/arm_scmi/notify.h  |   78 ++
>>  drivers/firmware/arm_scmi/perf.c    |  140 +++-
>>  drivers/firmware/arm_scmi/power.c   |  133 +++-
>>  drivers/firmware/arm_scmi/reset.c   |  100 ++-
>>  drivers/firmware/arm_scmi/sensors.c |   77 +-
>>  drivers/firmware/arm_scmi/shmem.c   |   15 +
>>  include/linux/scmi_protocol.h       |  114 +++
>>  14 files changed, 2009 insertions(+), 31 deletions(-)
>>  create mode 100644 drivers/firmware/arm_scmi/notify.c
>>  create mode 100644 drivers/firmware/arm_scmi/notify.h
>>
>> --
>> 2.17.1
>>


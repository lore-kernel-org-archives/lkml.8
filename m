Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2822072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCIMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:33:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2525 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgCIMdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:33:49 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 77A01C586794C001E969;
        Mon,  9 Mar 2020 12:33:48 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 12:33:47 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 12:33:47 +0000
Date:   Mon, 9 Mar 2020 12:33:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <lukasz.luba@arm.com>, <james.quinlan@broadcom.com>
Subject: Re: [PATCH v4 00/13] SCMI Notifications Core Support
Message-ID: <20200309123346.00007dfb@Huawei.com>
In-Reply-To: <20200304162558.48836-1-cristian.marussi@arm.com>
References: <20200304162558.48836-1-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 16:25:45 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Hi all,
> 
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
> 
> At initialization time each SCMI Protocol takes care to register with the
> new SCMI notification core the set of its own events which it intends to
> support.
> 
> Using the API exposed via scmi_handle.notify_ops a Kernel user can register
> its own notifier_t callback (via a notifier_block as usual) against any
> registered event as identified by the tuple:
> 
> 		(proto_id, event_id, src_id)
> 
> where src_id represents a generic source identifier which is protocol
> dependent like domain_id, performance_id, sensor_id and so forth.
> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>  the existing (if any) src_id sources for that proto_id/evt_id combination)
> 
> Each of the above tuple-specified event will be served on its own dedicated
> blocking notification chain, dynamically allocated on-demand when at least
> one user has shown interest on that event.
> 
> Upon a notification delivery all the users' registered notifier_t callbacks
> will be in turn invoked and fed with the event_id as @action param and a
> generated custom per-event struct _report as @data param.
> (as in include/linux/scmi_protocol.h)
> 
> The final step of notification delivery via users' callback invocation is
> instead delegated to a pool of deferred workers (Kernel cmwq): each
> SCMI protocol has its own dedicated worker and dedicated queue to push
> events from the rx ISR to the worker.
> 
> Based on scmi-next 5.6 [1], on top of:
> 
> commit 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
> 		      the transport type")
> 
> This series has been tested on JUNO with an experimental firmware only
> supporting Perf Notifications.

I've looked through all the patches.  A few of the comments go across
multiple patches, but once resolved feel free to add.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
to the ones I haven't specifically commented on.

Thanks,

Jonathan

> 
> Thanks
> 
> Cristian
> ----
> 
> v3 --> v4:
> - dropped RFC tag
> - avoid one unneeded evt payload memcpy on the ISR RC code path by
>   redesigning dispatcher to handle partial queue-reads (in_flight events,
>   only header)
> - fixed the initialization issue exposed by late SCMI modules loading by
>   reviewing the init process to support possible late events registrations
>   by protocols and early callbacks registrations by users (pending)
> - cleanup/simplification of exit path: SCMI protocols are generally never
>   de-initialized after the initial device creation, so do not deinit
>   notification core either (we do halt the delivery, stop the wq and empty
>   the queues though)
> - reduced contention on regustered_events_handler to the minimum during
>   delivery by splitting the common registered_events_handlers hashtable
>   into a number of per-protocol tables
> - converted registered_protocols and registered_events hastable to
>   fixed size arrays: simpler and lockless in our usage scenario
> 
> v2 --> v3:
> - added platform instance awareness to the notification core: a
>   notification instance is created for each known handle
> - reviewed notification core initialization and shutdown process
> - removed generic non-handle-rooted registration API
> - added WQ_SYSFS flag to workqueue instance
> 
> v1 --> v2:
> - dropped anti-tampering patch
> - rebased on top of scmi-for-next-5.6, which includes Viresh series that
>   make SCMI core independent of transport (5c8a47a5a91d)
> - add a few new SCMI transport methods on top of Viresh patch to address
>   needs of SCMI Notifications
> - reviewed/renamed scmi_handle_xfer_delayed_resp()
> - split main SCMI Notification core patch (~1k lines) into three chunks:
>   protocol-registration / callbacks-registration / dispatch-and-delivery
> - removed awkward usage of IDR maps in favour of pure hashtables
> - added enable/disable refcounting in notification core (was broken in v1)
> - removed per-protocol candidate API: a single generic API is now proposed
>   instead of scmi_register_<proto>_event_notifier(evt_id, *src_id, *nb)
> - added handle->notify_ops as an alternative notification API
>   for scmi_driver
> - moved ALL_SRCIDs enabled handling from protocol code to core code
> - reviewed protocol registration/unregistration logic to use devres
> - reviewed cleanup phase on shutdown
> - fixed  ERROR: reference preceded by free as reported by kbuild test robot
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> 
> 
> Cristian Marussi (10):
>   firmware: arm_scmi: Add notifications support in transport layer
>   firmware: arm_scmi: Add notification protocol-registration
>   firmware: arm_scmi: Add notification callbacks-registration
>   firmware: arm_scmi: Add notification dispatch and delivery
>   firmware: arm_scmi: Enable notification core
>   firmware: arm_scmi: Add Power notifications support
>   firmware: arm_scmi: Add Perf notifications support
>   firmware: arm_scmi: Add Sensor notifications support
>   firmware: arm_scmi: Add Reset notifications support
>   firmware: arm_scmi: Add Base notifications support
> 
> Sudeep Holla (3):
>   firmware: arm_scmi: Add receive buffer support for notifications
>   firmware: arm_scmi: Update protocol commands and notification list
>   firmware: arm_scmi: Add support for notifications message processing
> 
>  drivers/firmware/arm_scmi/Makefile  |    2 +-
>  drivers/firmware/arm_scmi/base.c    |  116 +++
>  drivers/firmware/arm_scmi/common.h  |   12 +
>  drivers/firmware/arm_scmi/driver.c  |  118 ++-
>  drivers/firmware/arm_scmi/mailbox.c |   17 +
>  drivers/firmware/arm_scmi/notify.c  | 1471 +++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/notify.h  |   78 ++
>  drivers/firmware/arm_scmi/perf.c    |  135 +++
>  drivers/firmware/arm_scmi/power.c   |  129 +++
>  drivers/firmware/arm_scmi/reset.c   |   96 ++
>  drivers/firmware/arm_scmi/sensors.c |   73 ++
>  drivers/firmware/arm_scmi/shmem.c   |   15 +
>  include/linux/scmi_protocol.h       |  110 ++
>  13 files changed, 2345 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/notify.c
>  create mode 100644 drivers/firmware/arm_scmi/notify.h
> 



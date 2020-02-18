Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA2C34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9862176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GTbwyqXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBRUTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:19:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37917 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgBRUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:19:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so4338354wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjd7JDIqMogS+ecAjflr/UQOm6NZ79xvDYhlsrLIVp8=;
        b=GTbwyqXSsALa3HKNnan9u6EmLpurUr35f2SvXSLcV5aMTSlz0e/VvVuBpRS3r8gTVr
         sgwK/1l7FK9/VCrgHmT9q92e8CyvVBFpDrcMR1UQ8CP1gkeDnmwnFSI2z3n+gjyVrpxO
         NWveKV/3TiBNAME8rv50/BSamKlvJc2OFLXLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjd7JDIqMogS+ecAjflr/UQOm6NZ79xvDYhlsrLIVp8=;
        b=nX4JeWbSeRcfiXw9tdQKCzdRS4aUsaakj8zoTOo6T/X3w9W4ntZv7x8qas9hKj4ZJb
         RQsXAu/lZgYoBNN78tC50vU/vn8sOHw27dpxTfaZFqpbMdyqbQ4OcFuIryeoi1KTlq6a
         Mj44fIUAFJNghm9435QKMU6TVW4eNFxFthDIA9qthxIpRCZqy7HzrDNJ0MRoO0YG4ir7
         jt218GJ4u1vSnrCLBSrYxaS7fvNCbv5eAI1OYpaPFobRuLINJb8JVq2BOZ8Hj/uqTfT1
         7IMLtAFuW14CvLh/5HFUvAfuJh/ZZOh3yM91i3GFfTwj3wJKsv0WYRZ4/Id1p809sUty
         4C2A==
X-Gm-Message-State: APjAAAU9Qgq50b0r2kP2X/GIoMhkFSVeCCwQb/zmZHzq4vi3tGDGXchq
        hUzIrkuUMfrbzkfuFw1dewLGdSLDwTpyPCCdwBUNRw==
X-Google-Smtp-Source: APXvYqwyT1Zl+Ukm4WyEu9LaH1ZAWp8D6b5xvv2uarrWNoLF2k+riF1MagTvM49bzlcQDPRxwbPI7wKPV+UhrpVk228=
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr4807130wmj.41.1582057161792;
 Tue, 18 Feb 2020 12:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20200214153535.32046-1-cristian.marussi@arm.com>
In-Reply-To: <20200214153535.32046-1-cristian.marussi@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 18 Feb 2020 15:19:10 -0500
Message-ID: <CA+-6iNyFYusJTfiFgCNoRrcT5Xo4nof4fc=d46GiPAUD4o2j+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] SCMI Notifications Core Support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

This looks very robust and general but I'm wondering about the
"notification -> user" latency.  It appears there are at least five or
so memcpy()s of the notification message as it works its way to the
user, and added to that is the work queue deferral latency.  Is there
a concern on your end for low latency notifications, perhaps for
emergency notifications or do you consider this to be quick enough?

Note that we (BrcmSTB) have implemented our own  SCMI notification
system for a proprietary protocol and we designed it to deliver
notifications as quickly as possible.  Our system is more or less a
disposable hack and would not stand up to heavy or general usage.  We
fully intend to move to the approved Linux notification system.  On
that note,  I'm just wondering if you had any comment on the
possibility of  "slimming down" your RFC, e.g. perhaps somehow
collapsing some memcpy()s.

Thanks,
Jim
PS I'm going on vacation so I won't be able to email for a week.


On Fri, Feb 14, 2020 at 10:36 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi all,
>
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
>
> At initialization time each SCMI Protocol takes care to register with the
> new SCMI notification core the set of its own events which it intends to
> support.
>
> Using a possibly proposed API in include/linux/scmi_protocol.h (not
> finalized though, NO EXPORTs_) a Kernel user can register its own
> notifier_t callback (via a notifier_block as usual) against any registered
> event as identified by the tuple:
>
>                 (proto_id, event_id, src_id)
>
> where src_id represents a generic source identifier which is protocol
> dependent like domain_id, performance_id, sensor_id and so forth.
> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>  the existing (if any) src_id sources for that proto_id/evt_id combination)
>
> Each of the above tuple-specified event will be served on its own dedicated
> blocking notification chain.
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
> The series is marked as RFC mainly because:
>
> - the API as said is tentative and not EXPORTed; currently consisting of a
>   generic interface like:
>
>          scmi_register_event_notifier(proto_id, evt_id, *src_id, *nb)
>
>   as found in scmi_protocol.h, or using the equivalent 'handle' operations
>   in scmi_notify_ops if used by an scmi_driver.
>
>   It's open for discussion.
>
> - no Event priorization has been considered: each protocol has its own
>   queue and deferred worker instance, so as to avoid that one protocol
>   flood can overrun a single queue and influence other protocols'
>   notifications' delivery.
>   But that's it, all the workers are unbound, low_pri cmwq workers.
>
>   Should we enforce some sort of built-in prio amongst the events ?
>   Should this priority instead be compile time configurable ?
>
>   Again, open for discussion.
>
> - no configuration is possible: it can be imagined that on a real platform
>   events' priority (if any) and events queues' depth could be something
>   somehow compile-time configurable, but this is not addressed by this
>   series at all.
>
> Based on scmi-next 5.6 [1], on top of:
>
> commit 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
>                       the transport type")
>
> This series has been tested on JUNO with an experimental firmware only
> supporting Perf Notifications.
>
> Any thoughts ?
>
> Thanks
>
> Cristian
> ----
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
>  drivers/firmware/arm_scmi/base.c    |  121 +++
>  drivers/firmware/arm_scmi/bus.c     |   11 +
>  drivers/firmware/arm_scmi/common.h  |   12 +
>  drivers/firmware/arm_scmi/driver.c  |  118 ++-
>  drivers/firmware/arm_scmi/mailbox.c |   17 +
>  drivers/firmware/arm_scmi/notify.c  | 1102 +++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/notify.h  |   78 ++
>  drivers/firmware/arm_scmi/perf.c    |  140 +++-
>  drivers/firmware/arm_scmi/power.c   |  133 +++-
>  drivers/firmware/arm_scmi/reset.c   |  100 ++-
>  drivers/firmware/arm_scmi/sensors.c |   77 +-
>  drivers/firmware/arm_scmi/shmem.c   |   15 +
>  include/linux/scmi_protocol.h       |  114 +++
>  14 files changed, 2009 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/notify.c
>  create mode 100644 drivers/firmware/arm_scmi/notify.h
>
> --
> 2.17.1
>

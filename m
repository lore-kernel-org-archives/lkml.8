Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A34C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2B2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgATMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:25:09 -0500
Received: from foss.arm.com ([217.140.110.172]:59476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgATMYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:24:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E6530E;
        Mon, 20 Jan 2020 04:24:24 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2E43F68E;
        Mon, 20 Jan 2020 04:24:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, cristian.marussi@arm.com
Subject: [RFC PATCH 00/11] SCMI Notifications Support
Date:   Mon, 20 Jan 2020 12:23:22 +0000
Message-Id: <20200120122333.46217-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series wants to introduce SCMI Notification Support, built on top of
the standard Kernel notification chain subsystem.

At initialization time each SCMI Protocol takes care to register with the
new SCMI notification core the set of its own events which it intends to
support.

Using a possibly proposed API in scmi_protocol.h (not finalized though,
NO EXPORTs_) a Kernel user can register its own notifier_t callback
(so via a notifier_block as usual) against any registered event as
identified by the tuple:

		(proto_id, event_id, src_id)

where src_id represents a generic source identifier which is protocol
dependent like domain_id, performance_id, sensor_id and so forth.
(users can anyway do NOT provide any src_id, and subscribe instead to ALL
 the existing (if any) src_id sources for that proto_id/evt_id combination)

Each of the above tuple-specified event will be served on its own dedicated
blocking notification chain; given the great number of possible events, and
the extensibility of the SCMI Protocol itself, all the underlying machinery
of notifications chains it is dynamically created and destroyed at run-time
on-demand, depending on the number of effective registered users: no users
no allocations at all.

Upon a notification delivery all the users' registered notifier_t callbacks
will be in turn invoked and fed with the event_id as @action param and a
generated custom per-event report struct as @data param.
Each event report carries also a timestamp, gathered when the notification
message had first entered the richOS world in the SCMI rx ISR.

The final step of notification delivery via users' callback invocation is
instead delegated to a pool of deferred workers (Kernel cmwq): each
SCMI protocol has its own dedicated worker and queue to push events from
the rx ISR to the worker.

Additionally, since the original Kernel notification chain mechanism does
not stop users' registered callbacks from interacting with the notification
delivery itself (like cutting the chain with a NOTIFY_STOP or mangling the
*data report struct along the way), it was thought that such behaviour was
generally undesirable for a notification delivery service, and a possible
'anti-tampering' solution is proposed in patch [02/11]

("firmware: arm_scmi: Add notifications anti-tampering")

but maybe this attempt is not worth the cost of the additional complication
or simply deemed not needed (being anyway in Kernel land), in such a case
the above anti-tampering commit can simply be dropped from the series.

The series is marked as RFC mainly because:

- the API as said is tentative and not EXPORTed; currently consisting of a
  per-protocol interface like:
 	 scmi_register_<proto>_event_notifier(evt_id, *src_id, *nb)

  but it could be simplified to one single simpler generic one like:

 	 scmi_register_event_notifier(proto_id, evt_id, *src_id, *nb)

  It's open for discussion.

- no Event priorization has been considered: each protocol has its own
  queue and deferred worker instance, so as to avoid that one protocol
  flooding can overrun a single queue and influence other protocols'
  notifications' delivery.
  But that's it, all the workers are unbound, low_pri cmwq workers.

  Should we enforce some sort of built-in prio amongst the events ?
  Should this priority instead be compile time configurable ?

  Again, open for discussion.

- no configuration is possible: it can be imagined that on a real platform
  events' priority (if any) and events queues' depth could be something
  somehow compile-time configurable, but this is not addressed by this
  series at all.

Based on scmi-next [1], on top of:

commit 257d0e20ec4f ("include: trace: Add SCMI header with trace events")

This series has been tested on JUNO with an experimental firmware only
supporting Perf Notifications.

Any thoughts ?

Thanks

Cristian
----

[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git

Cristian Marussi (8):
  firmware: arm_scmi: Add core notifications support
  firmware: arm_scmi: Add notifications anti-tampering
  firmware: arm_scmi: Enable core notifications
  firmware: arm_scmi: Add Power notifications support
  firmware: arm_scmi: Add Perf notifications support
  firmware: arm_scmi: Add Sensor notifications support
  firmware: arm_scmi: Add Reset notifications support
  firmware: arm_scmi: Add Base notifications support

Sudeep Holla (3):
  firmware: arm_scmi: Add receive buffer support for notifications
  firmware: arm_scmi: Update protocol commands and notification list
  firmware: arm_scmi: Add support for notifications message processing

 drivers/firmware/arm_scmi/Makefile  |    2 +-
 drivers/firmware/arm_scmi/base.c    |  132 ++++
 drivers/firmware/arm_scmi/bus.c     |    3 +
 drivers/firmware/arm_scmi/common.h  |    4 +
 drivers/firmware/arm_scmi/driver.c  |  121 +++-
 drivers/firmware/arm_scmi/notify.c  | 1047 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h  |   79 ++
 drivers/firmware/arm_scmi/perf.c    |  167 ++++-
 drivers/firmware/arm_scmi/power.c   |  161 +++-
 drivers/firmware/arm_scmi/reset.c   |  126 +++-
 drivers/firmware/arm_scmi/sensors.c |  105 ++-
 include/linux/scmi_protocol.h       |   82 +++
 12 files changed, 1991 insertions(+), 38 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/notify.c
 create mode 100644 drivers/firmware/arm_scmi/notify.h

-- 
2.17.1


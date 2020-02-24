Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3127C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2ED20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:42:07 -0500
Received: from foss.arm.com ([217.140.110.172]:38112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgBXOmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:42:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5563930E;
        Mon, 24 Feb 2020 06:42:06 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561A13F534;
        Mon, 24 Feb 2020 06:42:05 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v3 00/13] SCMI Notifications Core Support
Date:   Mon, 24 Feb 2020 14:41:11 +0000
Message-Id: <20200224144124.2008-1-cristian.marussi@arm.com>
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

Using the API exposed via scmi_handle.notify_ops a Kernel user can register
its own notifier_t callback (via a notifier_block as usual) against any
registered event as identified by the tuple:

		(proto_id, event_id, src_id)

where src_id represents a generic source identifier which is protocol
dependent like domain_id, performance_id, sensor_id and so forth.
(users can anyway do NOT provide any src_id, and subscribe instead to ALL
 the existing (if any) src_id sources for that proto_id/evt_id combination)

Each of the above tuple-specified event will be served on its own dedicated
blocking notification chain, dynamically allocated on-demand.

Upon a notification delivery all the users' registered notifier_t callbacks
will be in turn invoked and fed with the event_id as @action param and a
generated custom per-event struct _report as @data param.
(as in include/linux/scmi_protocol.h)

The final step of notification delivery via users' callback invocation is
instead delegated to a pool of deferred workers (Kernel cmwq): each
SCMI protocol has its own dedicated worker and dedicated queue to push
events from the rx ISR to the worker.

The series is still marked as RFC mainly because:

- no Event priorization has been considered: each protocol has its own
  queue and deferred worker instance, so as to avoid that one protocol
  flood can overrun a single queue and influence other protocols'
  notifications' delivery.
  But that's it, all the workers are unbound, low_pri cmwq workers.

  Should we enforce some sort of built-in prio amongst the events ?
  Should this priority instead be compile time configurable ?

  Open for discussion.

- not addressing possible low-latency delivery needs: users cannot opt for
  some sort of emergency fast-delivery track for some selection of their
  callbacks. All is handled by the deferred worker pool at its own pace.
  (and not configurable, configurability of the worker pool prios will be
   proposed as a futher devel on to pof this series)
  Is it worth ? Should be in this same series or built on top of it ?

- some KNOWN ISSUES to solve like:
  + reducing memcopied bytesload along the journey of the events from the
    ISR to the deferred workers
  + address some initialization corner case in case some of the basic SCMI
    protocols (defined in DT and imeplemented in FW) are modules that are
    lazily loaded or not loaded at all.

Based on scmi-next 5.6 [1], on top of:

commit 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
		      the transport type")

This series has been tested on JUNO with an experimental firmware only
supporting Perf Notifications.

Any thoughts ?

Thanks

Cristian
----

v2 --> v3:
- added platform instance awareness to the notification core: a
  notification instance is created for each known handle
- reviewed notification core initialization and shutdown process
- removed generic non-handle-rooted registration API
- added WQ_SYSFS flag to workqueue instance

v1 --> v2:
- dropped anti-tampering patch
- rebased on top of scmi-for-next-5.6, which includes Viresh series that
  make SCMI core independent of transport (5c8a47a5a91d)
- add a few new SCMI transport methods on top of Viresh patch to address
  needs of SCMI Notifications
- reviewed/renamed scmi_handle_xfer_delayed_resp()
- split main SCMI Notification core patch (~1k lines) into three chunks:
  protocol-registration / callbacks-registration / dispatch-and-delivery
- removed awkward usage of IDR maps in favour of pure hashtables
- added enable/disable refcounting in notification core (was broken in v1)
- removed per-protocol candidate API: a single generic API is now proposed
  instead of scmi_register_<proto>_event_notifier(evt_id, *src_id, *nb)
- added handle->notify_ops as an alternative notification API
  for scmi_driver
- moved ALL_SRCIDs enabled handling from protocol code to core code
- reviewed protocol registration/unregistration logic to use devres
- reviewed cleanup phase on shutdown
- fixed  ERROR: reference preceded by free as reported by kbuild test robot

[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git


Cristian Marussi (10):
  firmware: arm_scmi: Add notifications support in transport layer
  firmware: arm_scmi: Add notification protocol-registration
  firmware: arm_scmi: Add notification callbacks-registration
  firmware: arm_scmi: Add notification dispatch and delivery
  firmware: arm_scmi: Enable notification core
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
 drivers/firmware/arm_scmi/base.c    |  116 +++
 drivers/firmware/arm_scmi/bus.c     |   25 +-
 drivers/firmware/arm_scmi/common.h  |   12 +
 drivers/firmware/arm_scmi/driver.c  |  120 ++-
 drivers/firmware/arm_scmi/mailbox.c |   17 +
 drivers/firmware/arm_scmi/notify.c  | 1412 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h  |   87 ++
 drivers/firmware/arm_scmi/perf.c    |  135 +++
 drivers/firmware/arm_scmi/power.c   |  129 +++
 drivers/firmware/arm_scmi/reset.c   |   96 ++
 drivers/firmware/arm_scmi/sensors.c |   73 ++
 drivers/firmware/arm_scmi/shmem.c   |   15 +
 include/linux/scmi_protocol.h       |  110 +++
 14 files changed, 2312 insertions(+), 37 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/notify.c
 create mode 100644 drivers/firmware/arm_scmi/notify.h

-- 
2.17.1


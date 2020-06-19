Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F06C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20601208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgFSNi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:38:56 -0400
Received: from foss.arm.com ([217.140.110.172]:59468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbgFSNiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:38:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B222B;
        Fri, 19 Jun 2020 06:38:53 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8213F6CF;
        Fri, 19 Jun 2020 06:38:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v10 0/9] SCMI Notifications Core Support
Date:   Fri, 19 Jun 2020 14:38:25 +0100
Message-Id: <20200619133834.18497-1-cristian.marussi@arm.com>
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

Each of the above tuple-specified eventis will be served on its own
dedicated blocking notification chain, dynamically allocated on-demand when
at least one user has shown interest on that event.

Upon a notification delivery all the users' registered notifier_t callbacks
will be in turn invoked and fed with the event_id as @action param and a
generated custom per-event struct _report as @data param.
(as in include/linux/scmi_protocol.h)

The final step of notification delivery via users' callback invocation is
instead delegated to a pool of deferred workers (Kernel cmwq): each
SCMI protocol has its own dedicated worker and dedicated queue to push
events from the rx ISR to the worker.

Based on scmi-next/for-next/scmi 5.8-rc1 [1], on top of:

commit dad69804b03e ("cpufreq: arm_scmi: Set fast_switch_possible
		conditionally")

This series has been tested on JUNO with an experimental firmware only
supporting Perf Notifications.


Thanks

Cristian

----
v9 --> v10:
- rebased on top of scmi-next 5.8-rc1
- fixed a couple of Warnings (-Wtype-limit)

v8 --> v9:
- rebased on top of scmi-next 5.8
- moved some pr_info() to dev_dbg()
- moved around some macros definitions (using FIELD_PREPARE properly)
- introduced some meaningful define
- shrunk hashtables' sizes
- shortened the naming of some massively long data struct

v7 --> v8:
- removed unneeded initialized/enabled atomics, added proper barriers
- added a few comments about queueing work item and kfifos

v6 --> v7:
- rebased on top of scmi-next 5.7, dropped the initial 4 patches
  since now already queued on base scmi-next [1]
- fixed some events' proto initialization
- removed some notify_enabled explicit methods exposed in some protocol_ops
  since not supposed to be used directly when using this notification
  framework (and of no other known use)
- exposing SCMI_EVENT_ enums in scmi_protocol.h
- added agent_id field in RESET_ISSUED payload as per reviewed SCMI spec
- removed POWER_STATE_CHANGE_REQUESTED pre-notification definition and
  handling as per reviewedSCMI spec
- fixed report.timestamp field type

v5 --> v6:
- added handle argument to fill_custom_report() helper

v4 --> v5:
- fixed kernel-doc
- added proper barriers around registered protocols and events
  initialization
- reviewed queues allocation using devm_add_action_or_reset
- reviewed REVT_NOTIFY_ENABLE macro

v3 --> v4:
- dropped RFC tag
- avoid one unneeded evt payload memcpy on the ISR RC code path by
  redesigning dispatcher to handle partial queue-reads (in_flight events,
  only header)
- fixed the initialization issue exposed by late SCMI modules loading by
  reviewing the init process to support possible late events registrations
  by protocols and early callbacks registrations by users (pending)
- cleanup/simplification of exit path: SCMI protocols are generally never
  de-initialized after the initial device creation, so do not deinit
  notification core either (we do halt the delivery, stop the wq and empty
  the queues though)
- reduced contention on regustered_events_handler to the minimum during
  delivery by splitting the common registered_events_handlers hashtable
  into a number of per-protocol tables
- converted registered_protocols and registered_events hastable to
  fixed size arrays: simpler and lockless in our usage scenario

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


Cristian Marussi (9):
  firmware: arm_scmi: Add notification protocol-registration
  firmware: arm_scmi: Add notification callbacks-registration
  firmware: arm_scmi: Add notification dispatch and delivery
  firmware: arm_scmi: Enable notification core
  firmware: arm_scmi: Add Power notifications support
  firmware: arm_scmi: Add Perf notifications support
  firmware: arm_scmi: Add Sensor notifications support
  firmware: arm_scmi: Add Reset notifications support
  firmware: arm_scmi: Add Base notifications support

 drivers/firmware/arm_scmi/Makefile  |    2 +-
 drivers/firmware/arm_scmi/base.c    |  109 +-
 drivers/firmware/arm_scmi/common.h  |    4 +
 drivers/firmware/arm_scmi/driver.c  |   10 +
 drivers/firmware/arm_scmi/notify.c  | 1497 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h  |   67 ++
 drivers/firmware/arm_scmi/perf.c    |  139 ++-
 drivers/firmware/arm_scmi/power.c   |   92 +-
 drivers/firmware/arm_scmi/reset.c   |   96 +-
 drivers/firmware/arm_scmi/sensors.c |   69 +-
 include/linux/scmi_protocol.h       |  108 +-
 11 files changed, 2163 insertions(+), 30 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/notify.c
 create mode 100644 drivers/firmware/arm_scmi/notify.h

-- 
2.17.1


Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63282C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4452820897
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHSQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:11:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:10:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C6C1FB;
        Wed, 19 Aug 2020 09:10:57 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24AA3F8C6;
        Wed, 19 Aug 2020 09:10:55 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, cristian.marussi@arm.com
Subject: [PATCH v5 1/3] firmware: arm_scmi: Add System Power Protocol support
Date:   Wed, 19 Aug 2020 17:10:00 +0100
Message-Id: <20200819161002.26637-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819161002.26637-1-cristian.marussi@arm.com>
References: <20200819161002.26637-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bare protocol support for SCMI SystemPower as needed by an OSPM agent:
basic initialization and SYSTEM_POWER_STATE_NOTIFIER core notification
support.

No event-handling logic is attached to such notification by this commit.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- system notifications related fixes needed by v5.9-rc1 rebase
V3 --> V4
- fix alignment issues by checkpatch
V2 --> V3
- fixes related to SCMI Notifications core support V10
V1 --> V2
- use common event enums
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/system.c | 136 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  18 ++++
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/system.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6f9cbc4aef22..643f2320f976 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,5 +5,5 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
-scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
+scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
new file mode 100644
index 000000000000..aa1e74f066a0
--- /dev/null
+++ b/drivers/firmware/arm_scmi/system.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) System Power Protocol
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications SYSTEM - " fmt
+
+#include <linux/scmi_protocol.h>
+
+#include "common.h"
+#include "notify.h"
+
+#define SCMI_SYSTEM_NUM_SOURCES		1
+
+enum scmi_system_protocol_cmd {
+	SYSTEM_POWER_STATE_NOTIFY = 0x5,
+};
+
+struct scmi_system_power_state_notify {
+	__le32 notify_enable;
+};
+
+struct scmi_system_power_state_notifier_payld {
+	__le32 agent_id;
+	__le32 flags;
+	__le32 system_state;
+};
+
+struct scmi_system_info {
+	u32 version;
+};
+
+static int scmi_system_request_notify(const struct scmi_handle *handle,
+				      bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_system_power_state_notify *notify;
+
+	ret = scmi_xfer_get_init(handle, SYSTEM_POWER_STATE_NOTIFY,
+				 SCMI_PROTOCOL_SYSTEM, sizeof(*notify), 0, &t);
+	if (ret)
+		return ret;
+
+	notify = t->tx.buf;
+	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_system_set_notify_enabled(const struct scmi_handle *handle,
+					  u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_system_request_notify(handle, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLE - evt[%X] - ret:%d\n", evt_id, ret);
+
+	return ret;
+}
+
+static void *scmi_system_fill_custom_report(const struct scmi_handle *handle,
+					    u8 evt_id, ktime_t timestamp,
+					    const void *payld, size_t payld_sz,
+					    void *report, u32 *src_id)
+{
+	const struct scmi_system_power_state_notifier_payld *p = payld;
+	struct scmi_system_power_state_notifier_report *r = report;
+
+	if (evt_id != SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER ||
+	    sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->agent_id = le32_to_cpu(p->agent_id);
+	r->flags = le32_to_cpu(p->flags);
+	r->system_state = le32_to_cpu(p->system_state);
+	*src_id = 0;
+
+	return r;
+}
+
+static const struct scmi_event system_events[] = {
+	{
+		.id = SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
+		.max_payld_sz =
+			sizeof(struct scmi_system_power_state_notifier_payld),
+		.max_report_sz =
+			sizeof(struct scmi_system_power_state_notifier_report),
+	},
+};
+
+static const struct scmi_event_ops system_event_ops = {
+	.set_notify_enabled = scmi_system_set_notify_enabled,
+	.fill_custom_report = scmi_system_fill_custom_report,
+};
+
+static int scmi_system_protocol_init(struct scmi_handle *handle)
+{
+	u32 version;
+	struct scmi_system_info *pinfo;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_SYSTEM, &version);
+
+	dev_dbg(handle->dev, "System Power Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	scmi_register_protocol_events(handle,
+				      SCMI_PROTOCOL_SYSTEM, SCMI_PROTO_QUEUE_SZ,
+				      &system_event_ops,
+				      system_events,
+				      ARRAY_SIZE(system_events),
+				      SCMI_SYSTEM_NUM_SOURCES);
+
+	pinfo->version = version;
+	handle->system_priv = pinfo;
+
+	return 0;
+}
+
+static int __init scmi_system_init(void)
+{
+	return scmi_protocol_register(SCMI_PROTOCOL_SYSTEM,
+				      &scmi_system_protocol_init);
+}
+subsys_initcall(scmi_system_init);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7e5dd7d1e221..76fd0e24f3b6 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -292,6 +292,7 @@ struct scmi_handle {
 	void *sensor_priv;
 	void *reset_priv;
 	void *notify_priv;
+	void *system_priv;
 };
 
 enum scmi_std_protocol {
@@ -304,6 +305,15 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 };
 
+enum scmi_system_events {
+	SCMI_SYSTEM_SHUTDOWN,
+	SCMI_SYSTEM_COLDRESET,
+	SCMI_SYSTEM_WARMRESET,
+	SCMI_SYSTEM_POWERUP,
+	SCMI_SYSTEM_SUSPEND,
+	SCMI_SYSTEM_MAX
+};
+
 struct scmi_device {
 	u32 id;
 	u8 protocol_id;
@@ -378,6 +388,7 @@ enum scmi_notification_events {
 	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
 	SCMI_EVENT_RESET_ISSUED = 0x0,
 	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
+	SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER = 0x0,
 };
 
 struct scmi_power_state_changed_report {
@@ -387,6 +398,13 @@ struct scmi_power_state_changed_report {
 	unsigned int	power_state;
 };
 
+struct scmi_system_power_state_notifier_report {
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	flags;
+	unsigned int	system_state;
+};
+
 struct scmi_perf_limits_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
-- 
2.17.1


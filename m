Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BAAC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A32F206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD0VIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:08:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0VIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DA5C14;
        Mon, 27 Apr 2020 14:08:37 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AEB53F305;
        Mon, 27 Apr 2020 14:08:36 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH 1/3] firmware: arm_scmi: Add System Power Protocol support
Date:   Mon, 27 Apr 2020 22:08:04 +0100
Message-Id: <20200427210806.37422-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427210806.37422-1-cristian.marussi@arm.com>
References: <20200427210806.37422-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bare protocol support for SCMI SystemPower as needed by an OSPM agent:
basic initialization and SYSTEM_POWER_STATE_NOTIFIER core notification
support. No event-handling logic is attached to such notification by this
commit.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/system.c | 146 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  17 ++++
 3 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/system.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index d55612362d65..e01b67bc74b4 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,5 +5,5 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC) += smc.o
-scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
+scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
new file mode 100644
index 000000000000..9b43d9a873f3
--- /dev/null
+++ b/drivers/firmware/arm_scmi/system.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) System Power Protocol
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
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
+enum scmi_system_protocol_notify {
+	SYSTEM_POWER_STATE_NOTIFIER = 0x0,
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
+static bool scmi_system_set_notify_enabled(const struct scmi_handle *handle,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_system_request_notify(handle, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLE - evt[%X] - ret:%d\n",
+				SCMI_PROTOCOL_SYSTEM, evt_id, ret);
+
+	return !ret;
+}
+
+static void *scmi_system_fill_custom_report(const struct scmi_handle *handle,
+					    u8 evt_id, u64 timestamp,
+					    const void *payld, size_t payld_sz,
+					    void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SYSTEM_POWER_STATE_NOTIFIER:
+	{
+		const struct scmi_system_power_state_notifier_payld *p = payld;
+		struct scmi_system_power_state_notifier_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->flags = le32_to_cpu(p->flags);
+		r->system_state = le32_to_cpu(p->system_state);
+		*src_id = 0;
+		rep = r;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rep;
+}
+
+static const struct scmi_event system_events[] = {
+	{
+		.id = SYSTEM_POWER_STATE_NOTIFIER,
+		.max_payld_sz = 12,
+		.max_report_sz =
+			sizeof(struct scmi_system_power_state_notifier_report),
+	},
+};
+
+static const struct scmi_protocol_event_ops system_event_ops = {
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
+				      SCMI_PROTOCOL_SYSTEM, PAGE_SIZE,
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
index 1ee6f0502565..fc9f0105e6cc 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -295,6 +295,7 @@ struct scmi_handle {
 	void *sensor_priv;
 	void *reset_priv;
 	void *notify_priv;
+	void *system_priv;
 };
 
 enum scmi_std_protocol {
@@ -307,6 +308,15 @@ enum scmi_std_protocol {
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
@@ -388,6 +398,13 @@ struct scmi_power_state_change_requested_report {
 	u32 power_state;
 };
 
+struct scmi_system_power_state_notifier_report {
+	u64 timestamp;
+	u32 agent_id;
+	u32 flags;
+	u32 system_state;
+};
+
 struct scmi_perf_limits_report {
 	u64 timestamp;
 	u32 agent_id;
-- 
2.17.1


Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D69C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EAE2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETIMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:12:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgETIMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:12:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7608930E;
        Wed, 20 May 2020 01:12:06 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52D263F52E;
        Wed, 20 May 2020 01:12:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, dave.martin@arm.com
Subject: [PATCH v8 9/9] firmware: arm_scmi: Add Base notifications support
Date:   Wed, 20 May 2020 09:11:18 +0100
Message-Id: <20200520081118.54897-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520081118.54897-1-cristian.marussi@arm.com>
References: <20200520081118.54897-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Base protocol register with the notification core.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V6 --> V7
- fixed report.timestamp type
- fix max_payld_sz initialization
- fix report layout and initialization
- expose SCMI_EVENT_ in linux/scmi_protocol.h
V5 --> V6
- added handle argument to fill_custom_report()
V4 --> V5
- fixed unsual return construct
V3 --> V4
- scmi_event field renamed
V2 --> V3
- added handle awareness
V1 --> V2
- simplified .set_notify_enabled() implementation moving the ALL_SRCIDs
  logic out of protocol. ALL_SRCIDs logic is now in charge of the
  notification core, together with proper reference counting of enables
- switched to devres protocol-registration
---
 drivers/firmware/arm_scmi/base.c | 118 +++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h    |   9 +++
 2 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index ce7d9203e41b..dcb098d8d823 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -5,7 +5,13 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#include <linux/scmi_protocol.h>
+
 #include "common.h"
+#include "notify.h"
+
+#define SCMI_BASE_NUM_SOURCES		1
+#define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
 
 enum scmi_base_protocol_cmd {
 	BASE_DISCOVER_VENDOR = 0x3,
@@ -19,16 +25,25 @@ enum scmi_base_protocol_cmd {
 	BASE_RESET_AGENT_CONFIGURATION = 0xb,
 };
 
-enum scmi_base_protocol_notify {
-	BASE_ERROR_EVENT = 0x0,
-};
-
 struct scmi_msg_resp_base_attributes {
 	u8 num_protocols;
 	u8 num_agents;
 	__le16 reserved;
 };
 
+struct scmi_msg_base_error_notify {
+	__le32 event_control;
+#define BASE_TP_NOTIFY_ALL	BIT(0)
+};
+
+struct scmi_base_error_notify_payld {
+	__le32 agent_id;
+	__le32 error_status;
+#define IS_FATAL_ERROR(x)	((x) & BIT(31))
+#define ERROR_CMD_COUNT(x)	FIELD_GET(GENMASK(9, 0), (x))
+	__le64 msg_reports[SCMI_BASE_MAX_CMD_ERR_COUNT];
+};
+
 /**
  * scmi_base_attributes_get() - gets the implementation details
  *	that are associated with the base protocol.
@@ -222,6 +237,95 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
 	return ret;
 }
 
+static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
+{
+	int ret;
+	u32 evt_cntl = enable ? BASE_TP_NOTIFY_ALL : 0;
+	struct scmi_xfer *t;
+	struct scmi_msg_base_error_notify *cfg;
+
+	ret = scmi_xfer_get_init(handle, BASE_NOTIFY_ERRORS,
+				 SCMI_PROTOCOL_BASE, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->event_control = cpu_to_le32(evt_cntl);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static bool scmi_base_set_notify_enabled(const struct scmi_handle *handle,
+					 u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_base_error_notify(handle, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLED - evt[%X] ret:%d\n",
+			SCMI_PROTOCOL_BASE, evt_id, ret);
+
+	return !ret;
+}
+
+static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
+					  u8 evt_id, u64 timestamp,
+					  const void *payld, size_t payld_sz,
+					  void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SCMI_EVENT_BASE_ERROR_EVENT:
+	{
+		int i;
+		const struct scmi_base_error_notify_payld *p = payld;
+		struct scmi_base_error_report *r = report;
+
+		/*
+		 * BaseError notification payload is variable in size but
+		 * up to a maximum length determined by the struct ponted by p.
+		 * Instead payld_sz is the effective length of this notification
+		 * payload so cannot be greater of the maximum allowed size as
+		 * pointed by p.
+		 */
+		if (sizeof(*p) < payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->fatal = IS_FATAL_ERROR(le32_to_cpu(p->error_status));
+		r->cmd_count = ERROR_CMD_COUNT(le32_to_cpu(p->error_status));
+		for (i = 0; i < r->cmd_count; i++)
+			r->reports[i] = le64_to_cpu(p->msg_reports[i]);
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
+static const struct scmi_event base_events[] = {
+	{
+		.id = SCMI_EVENT_BASE_ERROR_EVENT,
+		.max_payld_sz = sizeof(struct scmi_base_error_notify_payld),
+		.max_report_sz = sizeof(struct scmi_base_error_report) +
+				  SCMI_BASE_MAX_CMD_ERR_COUNT * sizeof(u64),
+	},
+};
+
+static const struct scmi_protocol_event_ops base_event_ops = {
+	.set_notify_enabled = scmi_base_set_notify_enabled,
+	.fill_custom_report = scmi_base_fill_custom_report,
+};
+
 int scmi_base_protocol_init(struct scmi_handle *h)
 {
 	int id, ret;
@@ -256,6 +360,12 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 	dev_dbg(dev, "Found %d protocol(s) %d agent(s)\n", rev->num_protocols,
 		rev->num_agents);
 
+	scmi_register_protocol_events(handle,
+				      SCMI_PROTOCOL_BASE, (4 * PAGE_SIZE),
+				      &base_event_ops, base_events,
+				      ARRAY_SIZE(base_events),
+				      SCMI_BASE_NUM_SOURCES);
+
 	for (id = 0; id < rev->num_agents; id++) {
 		scmi_base_discover_agent_get(handle, id, name);
 		dev_dbg(dev, "Agent %d: %s\n", id, name);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 091263aa5733..bb858d329dae 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -375,6 +375,7 @@ enum scmi_notification_events {
 	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
 	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
 	SCMI_EVENT_RESET_ISSUED = 0x0,
+	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
 };
 
 struct scmi_power_state_changed_report {
@@ -413,4 +414,12 @@ struct scmi_reset_issued_report {
 	u32 reset_state;
 };
 
+struct scmi_base_error_report {
+	u64 timestamp;
+	u32 agent_id;
+	bool fatal;
+	u16 cmd_count;
+	u64 reports[0];
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


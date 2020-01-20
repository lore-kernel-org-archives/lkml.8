Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8177C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D7208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgATMYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:24:43 -0500
Received: from foss.arm.com ([217.140.110.172]:59562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgATMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:24:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B581424;
        Mon, 20 Jan 2020 04:24:36 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE55E3F68E;
        Mon, 20 Jan 2020 04:24:35 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, cristian.marussi@arm.com
Subject: [RFC PATCH 11/11] firmware: arm_scmi: Add Base notifications support
Date:   Mon, 20 Jan 2020 12:23:33 +0000
Message-Id: <20200120122333.46217-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120122333.46217-1-cristian.marussi@arm.com>
References: <20200120122333.46217-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Base protocol register with the notification core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c | 125 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h    |  13 ++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index ce7d9203e41b..ea28b05d5af6 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -6,6 +6,7 @@
  */
 
 #include "common.h"
+#include "notify.h"
 
 enum scmi_base_protocol_cmd {
 	BASE_DISCOVER_VENDOR = 0x3,
@@ -29,6 +30,21 @@ struct scmi_msg_resp_base_attributes {
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
+	__le64 msg_reports[8192];
+};
+
+static const struct scmi_handle *protocol_handle;
+
 /**
  * scmi_base_attributes_get() - gets the implementation details
  *	that are associated with the base protocol.
@@ -222,6 +238,96 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
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
+static bool scmi_base_set_notify_enabled(u8 evt_id, const u32 *src_id,
+					 bool enable)
+{
+	int ret;
+
+	if (!protocol_handle)
+		return false;
+
+	ret = scmi_base_error_notify(protocol_handle, enable);
+	if (ret)
+		pr_warn("Failed enabling SCMI Notifications - Base - evt[%X] ret:%d\n",
+			evt_id, ret);
+
+	return !ret ? true : false;
+}
+
+static void *scmi_base_fill_custom_report(u8 evt_id, u64 timestamp,
+					  const void *payld, size_t payld_sz,
+					  void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case BASE_ERROR_EVENT:
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
+		*src_id = SCMI_ALL_SRC_IDS;
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
+		.evt_id = BASE_ERROR_EVENT,
+		.max_payld_sz = 8192,
+		.max_report_sz = sizeof(struct scmi_base_error_report),
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
@@ -256,10 +362,29 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 	dev_dbg(dev, "Found %d protocol(s) %d agent(s)\n", rev->num_protocols,
 		rev->num_agents);
 
+	scmi_register_protocol_events(SCMI_PROTOCOL_BASE, (4 * PAGE_SIZE),
+				      &base_event_ops, base_events,
+				      ARRAY_SIZE(base_events));
+
 	for (id = 0; id < rev->num_agents; id++) {
 		scmi_base_discover_agent_get(handle, id, name);
 		dev_dbg(dev, "Agent %d: %s\n", id, name);
 	}
+	protocol_handle = handle;
 
 	return 0;
 }
+
+int scmi_register_base_event_notifier(u8 evt_id, u32 *src_id,
+				      struct notifier_block *nb)
+{
+	return scmi_register_event_notifier(SCMI_PROTOCOL_BASE, evt_id,
+					    src_id, nb);
+}
+
+int scmi_unregister_base_event_notifier(u8 evt_id, u32 *src_id,
+					struct notifier_block *nb)
+{
+	return scmi_unregister_event_notifier(SCMI_PROTOCOL_BASE, evt_id,
+					      src_id, nb);
+}
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 4af258f07c1e..24a64e9ba616 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -387,4 +387,17 @@ int scmi_register_reset_event_notifier(u8 evt_id, u32 *dom_id,
 int scmi_unregister_reset_event_notifier(u8 evt_id, u32 *dom_id,
 					 struct notifier_block *nb);
 
+struct scmi_base_error_report {
+	ktime_t	timestamp;
+	u32	agent_id;
+	bool	fatal;
+	u16	cmd_count;
+	u64	reports[8192];
+};
+
+int scmi_register_base_event_notifier(u8 evt_id, u32 *src_id,
+				      struct notifier_block *nb);
+int scmi_unregister_base_event_notifier(u8 evt_id, u32 *src_id,
+					struct notifier_block *nb);
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


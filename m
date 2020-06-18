Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA5320890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgFRR1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:27:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732208AbgFRR1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:27:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E238A1396;
        Thu, 18 Jun 2020 10:27:18 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC343F6CF;
        Thu, 18 Jun 2020 10:27:17 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, dave.martin@arm.com
Subject: [PATCH v9 5/9] firmware: arm_scmi: Add Power notifications support
Date:   Thu, 18 Jun 2020 18:26:28 +0100
Message-Id: <20200618172632.42842-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618172632.42842-1-cristian.marussi@arm.com>
References: <20200618172632.42842-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Power protocol register with the notification core.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V8 --> V9
- moved pr_info to pr_debug
- removed switch()
- use SCMI_PROTO_QUEUE_SZ
V6 --> V7
- fixed report.timestamp type
- removed POWER_STATE_CHANGE_REQUESTED motification handling (deprecated)
- fixed max_payld_sz initialization
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
 drivers/firmware/arm_scmi/power.c | 92 +++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     | 12 ++++
 2 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index cf7f0312381b..b9714755a320 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -5,19 +5,18 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
+
+#include <linux/scmi_protocol.h>
+
 #include "common.h"
+#include "notify.h"
 
 enum scmi_power_protocol_cmd {
 	POWER_DOMAIN_ATTRIBUTES = 0x3,
 	POWER_STATE_SET = 0x4,
 	POWER_STATE_GET = 0x5,
 	POWER_STATE_NOTIFY = 0x6,
-	POWER_STATE_CHANGE_REQUESTED_NOTIFY = 0x7,
-};
-
-enum scmi_power_protocol_notify {
-	POWER_STATE_CHANGED = 0x0,
-	POWER_STATE_CHANGE_REQUESTED = 0x1,
 };
 
 struct scmi_msg_resp_power_attributes {
@@ -48,6 +47,12 @@ struct scmi_power_state_notify {
 	__le32 notify_enable;
 };
 
+struct scmi_power_state_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 power_state;
+};
+
 struct power_dom_info {
 	bool state_set_sync;
 	bool state_set_async;
@@ -186,6 +191,75 @@ static struct scmi_power_ops power_ops = {
 	.state_get = scmi_power_state_get,
 };
 
+static int scmi_power_request_notify(const struct scmi_handle *handle,
+				     u32 domain, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_power_state_notify *notify;
+
+	ret = scmi_xfer_get_init(handle, POWER_STATE_NOTIFY,
+				 SCMI_PROTOCOL_POWER, sizeof(*notify), 0, &t);
+	if (ret)
+		return ret;
+
+	notify = t->tx.buf;
+	notify->domain = cpu_to_le32(domain);
+	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static bool scmi_power_set_notify_enabled(const struct scmi_handle *handle,
+					  u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_power_request_notify(handle, src_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return !ret;
+}
+
+static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
+					   u8 evt_id, u64 timestamp,
+					   const void *payld, size_t payld_sz,
+					   void *report, u32 *src_id)
+{
+	const struct scmi_power_state_notify_payld *p = payld;
+	struct scmi_power_state_changed_report *r = report;
+
+	if (evt_id != SCMI_EVENT_POWER_STATE_CHANGED || sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->agent_id = le32_to_cpu(p->agent_id);
+	r->domain_id = le32_to_cpu(p->domain_id);
+	r->power_state = le32_to_cpu(p->power_state);
+	*src_id = r->domain_id;
+
+	return r;
+}
+
+static const struct scmi_event power_events[] = {
+	{
+		.id = SCMI_EVENT_POWER_STATE_CHANGED,
+		.max_payld_sz = sizeof(struct scmi_power_state_notify_payld),
+		.max_report_sz =
+			sizeof(struct scmi_power_state_changed_report),
+	},
+};
+
+static const struct scmi_event_ops power_event_ops = {
+	.set_notify_enabled = scmi_power_set_notify_enabled,
+	.fill_custom_report = scmi_power_fill_custom_report,
+};
+
 static int scmi_power_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
@@ -214,6 +288,12 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}
 
+	scmi_register_protocol_events(handle,
+				      SCMI_PROTOCOL_POWER, SCMI_PROTO_QUEUE_SZ,
+				      &power_event_ops, power_events,
+				      ARRAY_SIZE(power_events),
+				      pinfo->num_domains);
+
 	pinfo->version = version;
 	handle->power_ops = &power_ops;
 	handle->power_priv = pinfo;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0fb97a589b30..b2fe3bb9871d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -373,4 +373,16 @@ typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
 void scmi_protocol_unregister(int protocol_id);
 
+/* SCMI Notification API - Custom Event Reports */
+enum scmi_notification_events {
+	SCMI_EVENT_POWER_STATE_CHANGED = 0x0,
+};
+
+struct scmi_power_state_changed_report {
+	u64 timestamp;
+	u32 agent_id;
+	u32 domain_id;
+	u32 power_state;
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


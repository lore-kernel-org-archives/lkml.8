Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89741C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD452065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgETIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:12:13 -0400
Received: from foss.arm.com ([217.140.110.172]:49976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgETIMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:12:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A7311B3;
        Wed, 20 May 2020 01:12:02 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4013C3F52E;
        Wed, 20 May 2020 01:12:01 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, dave.martin@arm.com
Subject: [PATCH v8 6/9] firmware: arm_scmi: Add Perf notifications support
Date:   Wed, 20 May 2020 09:11:15 +0100
Message-Id: <20200520081118.54897-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520081118.54897-1-cristian.marussi@arm.com>
References: <20200520081118.54897-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Perf protocol register with the notification core.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V6 --> V7
- fixed report.timestamp type
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
 drivers/firmware/arm_scmi/perf.c | 137 +++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h    |  17 ++++
 2 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index eadc171e254b..72b0fcb5e40b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -11,9 +11,11 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/scmi_protocol.h>
 #include <linux/sort.h>
 
 #include "common.h"
+#include "notify.h"
 
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
@@ -27,11 +29,6 @@ enum scmi_performance_protocol_cmd {
 	PERF_DESCRIBE_FASTCHANNEL = 0xb,
 };
 
-enum scmi_performance_protocol_notify {
-	PERFORMANCE_LIMITS_CHANGED = 0x0,
-	PERFORMANCE_LEVEL_CHANGED = 0x1,
-};
-
 struct scmi_opp {
 	u32 perf;
 	u32 power;
@@ -86,6 +83,19 @@ struct scmi_perf_notify_level_or_limits {
 	__le32 notify_enable;
 };
 
+struct scmi_perf_limits_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 range_max;
+	__le32 range_min;
+};
+
+struct scmi_perf_level_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 performance_level;
+};
+
 struct scmi_msg_resp_perf_describe_levels {
 	__le16 num_returned;
 	__le16 num_remaining;
@@ -158,6 +168,11 @@ struct scmi_perf_info {
 	struct perf_dom_info *dom_info;
 };
 
+static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
+	PERF_NOTIFY_LIMITS,
+	PERF_NOTIFY_LEVEL,
+};
+
 static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 				    struct scmi_perf_info *pi)
 {
@@ -488,6 +503,29 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 	return scmi_perf_mb_level_get(handle, domain, level, poll);
 }
 
+static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
+					 u32 domain, int message_id,
+					 bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_perf_notify_level_or_limits *notify;
+
+	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_PERF,
+				 sizeof(*notify), 0, &t);
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
 static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
 {
 	if ((msg == PERF_LEVEL_GET || msg == PERF_LEVEL_SET) && size == 4)
@@ -710,6 +748,89 @@ static struct scmi_perf_ops perf_ops = {
 	.est_power_get = scmi_dvfs_est_power_get,
 };
 
+static bool scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
+					 u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	cmd_id = MAP_EVT_TO_ENABLE_CMD(evt_id, evt_2_cmd);
+	if (cmd_id < 0)
+		return false;
+
+	ret = scmi_perf_level_limits_notify(handle, src_id, cmd_id, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+				SCMI_PROTOCOL_PERF, evt_id, src_id, ret);
+
+	return !ret;
+}
+
+static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
+					  u8 evt_id, u64 timestamp,
+					  const void *payld, size_t payld_sz,
+					  void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED:
+	{
+		const struct scmi_perf_limits_notify_payld *p = payld;
+		struct scmi_perf_limits_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->range_max = le32_to_cpu(p->range_max);
+		r->range_min = le32_to_cpu(p->range_min);
+		*src_id = r->domain_id;
+		rep = r;
+		break;
+	}
+	case SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED:
+	{
+		const struct scmi_perf_level_notify_payld *p = payld;
+		struct scmi_perf_level_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->performance_level = le32_to_cpu(p->performance_level);
+		*src_id = r->domain_id;
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
+static const struct scmi_event perf_events[] = {
+	{
+		.id = SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+		.max_payld_sz = sizeof(struct scmi_perf_limits_notify_payld),
+		.max_report_sz = sizeof(struct scmi_perf_limits_report),
+	},
+	{
+		.id = SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED,
+		.max_payld_sz = sizeof(struct scmi_perf_level_notify_payld),
+		.max_report_sz = sizeof(struct scmi_perf_level_report),
+	},
+};
+
+static const struct scmi_protocol_event_ops perf_event_ops = {
+	.set_notify_enabled = scmi_perf_set_notify_enabled,
+	.fill_custom_report = scmi_perf_fill_custom_report,
+};
+
 static int scmi_perf_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
@@ -742,6 +863,12 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
 	}
 
+	scmi_register_protocol_events(handle,
+				      SCMI_PROTOCOL_PERF, PAGE_SIZE,
+				      &perf_event_ops, perf_events,
+				      ARRAY_SIZE(perf_events),
+				      pinfo->num_domains);
+
 	pinfo->version = version;
 	handle->perf_ops = &perf_ops;
 	handle->perf_priv = pinfo;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b2fe3bb9871d..832b03ef37c7 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -376,6 +376,8 @@ void scmi_protocol_unregister(int protocol_id);
 /* SCMI Notification API - Custom Event Reports */
 enum scmi_notification_events {
 	SCMI_EVENT_POWER_STATE_CHANGED = 0x0,
+	SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED = 0x0,
+	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
 };
 
 struct scmi_power_state_changed_report {
@@ -385,4 +387,19 @@ struct scmi_power_state_changed_report {
 	u32 power_state;
 };
 
+struct scmi_perf_limits_report {
+	u64 timestamp;
+	u32 agent_id;
+	u32 domain_id;
+	u32 range_max;
+	u32 range_min;
+};
+
+struct scmi_perf_level_report {
+	u64 timestamp;
+	u32 agent_id;
+	u32 domain_id;
+	u32 performance_level;
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


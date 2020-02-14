Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359FC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DCD24682
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbgBNPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:36:51 -0500
Received: from foss.arm.com ([217.140.110.172]:34820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387433AbgBNPgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:36:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1692811FB;
        Fri, 14 Feb 2020 07:36:39 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1741B3F68E;
        Fri, 14 Feb 2020 07:36:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v2 11/13] firmware: arm_scmi: Add Sensor notifications support
Date:   Fri, 14 Feb 2020 15:35:33 +0000
Message-Id: <20200214153535.32046-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214153535.32046-1-cristian.marussi@arm.com>
References: <20200214153535.32046-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Sensor protocol register with the notification core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V1 --> V2
- simplified .set_notify_enabled() implementation moving the ALL_SRCIDs
  logic out of protocol. ALL_SRCIDs logic is now in charge of the
  notification core, together with proper reference counting of enables
- switched to devres protocol-registration
---
 drivers/firmware/arm_scmi/sensors.c | 73 ++++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h       |  7 +++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index db1b1ab303da..99c5c67a9b6d 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -6,6 +6,7 @@
  */
 
 #include "common.h"
+#include "notify.h"
 
 enum scmi_sensor_protocol_cmd {
 	SENSOR_DESCRIPTION_GET = 0x3,
@@ -71,6 +72,12 @@ struct scmi_msg_sensor_reading_get {
 #define SENSOR_READ_ASYNC	BIT(0)
 };
 
+struct scmi_sensor_trip_notify_payld {
+	__le32 agent_id;
+	__le32 sensor_id;
+	__le32 trip_point_desc;
+};
+
 struct sensors_info {
 	u32 version;
 	int num_sensors;
@@ -78,8 +85,11 @@ struct sensors_info {
 	u64 reg_addr;
 	u32 reg_size;
 	struct scmi_sensor_info *sensors;
+	const struct scmi_handle *handle;
 };
 
+static struct sensors_info *sinfo;
+
 static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 				      struct sensors_info *si)
 {
@@ -276,10 +286,64 @@ static struct scmi_sensor_ops sensor_ops = {
 	.reading_get = scmi_sensor_reading_get,
 };
 
+static bool scmi_sensor_set_notify_enabled(u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_sensor_trip_point_notify(sinfo->handle, src_id, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			SCMI_PROTOCOL_SENSOR, evt_id, src_id, ret);
+
+	return !ret ? true : false;
+}
+
+static void *scmi_sensor_fill_custom_report(u8 evt_id, u64 timestamp,
+					   const void *payld, size_t payld_sz,
+					   void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SENSOR_TRIP_POINT_EVENT:
+	{
+		const struct scmi_sensor_trip_notify_payld *p = payld;
+		struct scmi_sensor_trip_point_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->sensor_id = le32_to_cpu(p->sensor_id);
+		r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
+		*src_id = r->sensor_id;
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
+static const struct scmi_event sensor_events[] = {
+	{
+		.evt_id = SENSOR_TRIP_POINT_EVENT,
+		.max_payld_sz = 12,
+		.max_report_sz = sizeof(struct scmi_sensor_trip_point_report),
+	},
+};
+
+static const struct scmi_protocol_event_ops sensor_event_ops = {
+	.set_notify_enabled = scmi_sensor_set_notify_enabled,
+	.fill_custom_report = scmi_sensor_fill_custom_report,
+};
+
 static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 {
 	u32 version;
-	struct sensors_info *sinfo;
 
 	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
 
@@ -299,7 +363,14 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	scmi_sensor_description_get(handle, sinfo);
 
+	scmi_register_protocol_events(handle->dev,
+				      SCMI_PROTOCOL_SENSOR, PAGE_SIZE,
+				      &sensor_event_ops, sensor_events,
+				      ARRAY_SIZE(sensor_events),
+				      sinfo->num_sensors);
+
 	sinfo->version = version;
+	sinfo->handle = handle;
 	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index da4f8bfda168..77cf107a7391 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -411,4 +411,11 @@ struct scmi_perf_level_report {
 	u32	performance_level;
 };
 
+struct scmi_sensor_trip_point_report {
+	ktime_t	timestamp;
+	u32	agent_id;
+	u32	sensor_id;
+	u32	trip_point_desc;
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


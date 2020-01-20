Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA1208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgATMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:24:48 -0500
Received: from foss.arm.com ([217.140.110.172]:59552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgATMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:24:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D4CFEC;
        Mon, 20 Jan 2020 04:24:34 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3273F68E;
        Mon, 20 Jan 2020 04:24:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, cristian.marussi@arm.com
Subject: [RFC PATCH 09/11] firmware: arm_scmi: Add Sensor notifications support
Date:   Mon, 20 Jan 2020 12:23:31 +0000
Message-Id: <20200120122333.46217-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120122333.46217-1-cristian.marussi@arm.com>
References: <20200120122333.46217-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Sensor protocol register with the notification core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 101 +++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h       |  12 ++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index db1b1ab303da..1f2f60516810 100644
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
@@ -276,10 +286,80 @@ static struct scmi_sensor_ops sensor_ops = {
 	.reading_get = scmi_sensor_reading_get,
 };
 
+static bool scmi_sensor_set_notify_enabled(u8 evt_id, const u32 *src_id,
+					   bool enable)
+{
+	int ret;
+
+	if (src_id) {
+		ret = scmi_sensor_trip_point_notify(sinfo->handle,
+						    *src_id, enable);
+		if (ret)
+			pr_warn("Failed enabling SCMI Notifications - Sensor - evt[%X] dom[%d] - ret:%d\n",
+				evt_id, *src_id, ret);
+	} else {
+		int r, sens;
+
+		ret = 1;
+		for (sens = 0; sens < sinfo->num_sensors; sens++) {
+			r = scmi_sensor_trip_point_notify(sinfo->handle, sens,
+							  enable);
+			if (r)
+				pr_warn("Failed enabling SCMI Notifications - Sensor - evt[%X] dom[%d] - ret:%d\n",
+					evt_id, sens, r);
+			ret *= r;
+		}
+	}
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
 
@@ -299,7 +379,12 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	scmi_sensor_description_get(handle, sinfo);
 
+	scmi_register_protocol_events(SCMI_PROTOCOL_SENSOR, PAGE_SIZE,
+				      &sensor_event_ops, sensor_events,
+				      ARRAY_SIZE(sensor_events));
+
 	sinfo->version = version;
+	sinfo->handle = handle;
 	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
 
@@ -312,3 +397,17 @@ static int __init scmi_sensors_init(void)
 				      &scmi_sensors_protocol_init);
 }
 subsys_initcall(scmi_sensors_init);
+
+int scmi_register_sensor_event_notifier(u8 evt_id, u32 *sens_id,
+					struct notifier_block *nb)
+{
+	return scmi_register_event_notifier(SCMI_PROTOCOL_SENSOR, evt_id,
+					    sens_id, nb);
+}
+
+int scmi_unregister_sensor_event_notifier(u8 evt_id, u32 *sens_id,
+					  struct notifier_block *nb)
+{
+	return scmi_unregister_event_notifier(SCMI_PROTOCOL_SENSOR, evt_id,
+					      sens_id, nb);
+}
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a719f3cd394b..833e21af52fe 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -364,4 +364,16 @@ int scmi_register_perf_event_notifier(u8 evt_id, u32 *dom_id,
 int scmi_unregister_perf_event_notifier(u8 evt_id, u32 *dom_id,
 					struct notifier_block *nb);
 
+struct scmi_sensor_trip_point_report {
+	ktime_t	timestamp;
+	u32	agent_id;
+	u32	sensor_id;
+	u32	trip_point_desc;
+};
+
+int scmi_register_sensor_event_notifier(u8 evt_id, u32 *sens_id,
+				      struct notifier_block *nb);
+int scmi_unregister_sensor_event_notifier(u8 evt_id, u32 *sens_id,
+					struct notifier_block *nb);
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


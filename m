Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E5FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4580B20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGJNj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:39:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgGJNjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2F3E11B3;
        Fri, 10 Jul 2020 06:39:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F19C23F8C6;
        Fri, 10 Jul 2020 06:39:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, arnd@arndb.de
Subject: [PATCH 3/3] firmware: arm_scmi: Remove fixed size fields from reports/scmi_event_header
Date:   Fri, 10 Jul 2020 14:39:19 +0100
Message-Id: <20200710133919.39792-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710133919.39792-1-cristian.marussi@arm.com>
References: <20200710133919.39792-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event reports are used to convey information describing events to the
registered user-callbacks: they are necessarily derived from the underlying
raw SCMI events' messages but they are not meant to expose or directly
mirror any of those messages data layout, which belong to the protocol
layer.
Using fixed size types for report fields, mirroring messages structure,
is at odd with this: get rid of them using more generic, equivalent,
typing.

Substitute scmi_event_header fixed size fields with generic types too and
shuffle around fields definitions to minimize implicit padding while
adapting involved functions.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  2 +-
 drivers/firmware/arm_scmi/driver.c  |  4 +--
 drivers/firmware/arm_scmi/notify.c  | 15 +++++----
 drivers/firmware/arm_scmi/notify.h  |  8 +++--
 drivers/firmware/arm_scmi/perf.c    |  2 +-
 drivers/firmware/arm_scmi/power.c   |  2 +-
 drivers/firmware/arm_scmi/reset.c   |  2 +-
 drivers/firmware/arm_scmi/sensors.c |  2 +-
 include/linux/scmi_protocol.h       | 52 ++++++++++++++---------------
 9 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 54f378e946f1..9853bd3c4d45 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -273,7 +273,7 @@ static int scmi_base_set_notify_enabled(const struct scmi_handle *handle,
 }
 
 static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
-					  u8 evt_id, u64 timestamp,
+					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
 {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 19a4287fc0f7..03ec74242c14 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -205,13 +205,13 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
-	u64 ts;
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->rx_minfo;
+	ktime_t ts;
 
-	ts = ktime_get_boottime_ns();
+	ts = ktime_get_boottime();
 	xfer = scmi_xfer_get(cinfo->handle, minfo);
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 752415367305..4731daaacd19 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -80,6 +80,7 @@
 #include <linux/err.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -246,18 +247,18 @@ struct events_queue {
  * struct scmi_event_header  - A utility header
  * @timestamp: The timestamp, in nanoseconds (boottime), which was associated
  *	       to this event as soon as it entered the SCMI RX ISR
- * @evt_id: Event ID (corresponds to the Event MsgID for this Protocol)
  * @payld_sz: Effective size of the embedded message payload which follows
+ * @evt_id: Event ID (corresponds to the Event MsgID for this Protocol)
  * @payld: A reference to the embedded event payload
  *
  * This header is prepended to each received event message payload before
  * queueing it on the related &struct events_queue.
  */
 struct scmi_event_header {
-	u64	timestamp;
-	u8	evt_id;
-	size_t	payld_sz;
-	u8	payld[];
+	ktime_t timestamp;
+	size_t payld_sz;
+	unsigned char evt_id;
+	unsigned char payld[];
 };
 
 struct scmi_registered_event;
@@ -572,7 +573,7 @@ static void scmi_events_dispatcher(struct work_struct *work)
  * Return: 0 on Success
  */
 int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
-		const void *buf, size_t len, u64 ts)
+		const void *buf, size_t len, ktime_t ts)
 {
 	struct scmi_registered_event *r_evt;
 	struct scmi_event_header eh;
@@ -595,7 +596,7 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 	if (kfifo_avail(&r_evt->proto->equeue.kfifo) < sizeof(eh) + len) {
 		dev_warn(handle->dev,
 			 "queue full, dropping proto_id:%d  evt_id:%d  ts:%lld\n",
-			 proto_id, evt_id, ts);
+			 proto_id, evt_id, ktime_to_ns(ts));
 		return -ENOMEM;
 	}
 
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 3791bb7aa79b..3485f20fa70e 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -10,6 +10,7 @@
 #define _SCMI_NOTIFY_H
 
 #include <linux/device.h>
+#include <linux/ktime.h>
 #include <linux/types.h>
 
 #define SCMI_PROTO_QUEUE_SZ	4096
@@ -48,8 +49,9 @@ struct scmi_event_ops {
 	int (*set_notify_enabled)(const struct scmi_handle *handle,
 				  u8 evt_id, u32 src_id, bool enabled);
 	void *(*fill_custom_report)(const struct scmi_handle *handle,
-				    u8 evt_id, u64 timestamp, const void *payld,
-				    size_t payld_sz, void *report, u32 *src_id);
+				    u8 evt_id, ktime_t timestamp,
+				    const void *payld, size_t payld_sz,
+				    void *report, u32 *src_id);
 };
 
 int scmi_notification_init(struct scmi_handle *handle);
@@ -61,6 +63,6 @@ int scmi_register_protocol_events(const struct scmi_handle *handle,
 				  const struct scmi_event *evt, int num_events,
 				  int num_sources);
 int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
-		const void *buf, size_t len, u64 ts);
+		const void *buf, size_t len, ktime_t ts);
 
 #endif /* _SCMI_NOTIFY_H */
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8bcad96e06ca..3e1e87012c95 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -780,7 +780,7 @@ static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
 }
 
 static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
-					  u8 evt_id, u64 timestamp,
+					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
 {
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 4f6757980739..46f213644c49 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -227,7 +227,7 @@ static int scmi_power_set_notify_enabled(const struct scmi_handle *handle,
 }
 
 static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
-					   u8 evt_id, u64 timestamp,
+					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
 {
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index fb7cb517900b..3691bafca057 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -240,7 +240,7 @@ static int scmi_reset_set_notify_enabled(const struct scmi_handle *handle,
 }
 
 static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
-					   u8 evt_id, u64 timestamp,
+					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
 {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 2120ac4787c9..1af0ad362e82 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -296,7 +296,7 @@ static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
 }
 
 static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
-					    u8 evt_id, u64 timestamp,
+					    u8 evt_id, ktime_t timestamp,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
 {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7d4348fb7330..7e5dd7d1e221 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -381,47 +381,47 @@ enum scmi_notification_events {
 };
 
 struct scmi_power_state_changed_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 power_state;
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	power_state;
 };
 
 struct scmi_perf_limits_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 range_max;
-	u32 range_min;
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	range_max;
+	unsigned int	range_min;
 };
 
 struct scmi_perf_level_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 performance_level;
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	performance_level;
 };
 
 struct scmi_sensor_trip_point_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 sensor_id;
-	u32 trip_point_desc;
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	sensor_id;
+	unsigned int	trip_point_desc;
 };
 
 struct scmi_reset_issued_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 reset_state;
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	reset_state;
 };
 
 struct scmi_base_error_report {
-	u64 timestamp;
-	u32 agent_id;
-	bool fatal;
-	u16 cmd_count;
-	u64 reports[];
+	ktime_t			timestamp;
+	unsigned int		agent_id;
+	bool			fatal;
+	unsigned int		cmd_count;
+	unsigned long long	reports[];
 };
 
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


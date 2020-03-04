Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B602721775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgCDQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:26:40 -0500
Received: from foss.arm.com ([217.140.110.172]:36548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgCDQ0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:26:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6FD11045;
        Wed,  4 Mar 2020 08:26:38 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D85233F6CF;
        Wed,  4 Mar 2020 08:26:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 02/13] firmware: arm_scmi: Update protocol commands and notification list
Date:   Wed,  4 Mar 2020 16:25:47 +0000
Message-Id: <20200304162558.48836-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304162558.48836-1-cristian.marussi@arm.com>
References: <20200304162558.48836-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add commands' enumerations and messages definitions for all existing
notify-enable commands across all protocols.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 7 +++++++
 drivers/firmware/arm_scmi/perf.c    | 5 +++++
 drivers/firmware/arm_scmi/power.c   | 6 ++++++
 drivers/firmware/arm_scmi/sensors.c | 4 ++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f804e8af6521..ce7d9203e41b 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -14,6 +14,13 @@ enum scmi_base_protocol_cmd {
 	BASE_DISCOVER_LIST_PROTOCOLS = 0x6,
 	BASE_DISCOVER_AGENT = 0x7,
 	BASE_NOTIFY_ERRORS = 0x8,
+	BASE_SET_DEVICE_PERMISSIONS = 0x9,
+	BASE_SET_PROTOCOL_PERMISSIONS = 0xa,
+	BASE_RESET_AGENT_CONFIGURATION = 0xb,
+};
+
+enum scmi_base_protocol_notify {
+	BASE_ERROR_EVENT = 0x0,
 };
 
 struct scmi_msg_resp_base_attributes {
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ec81e6f7e7a4..88509ec637d0 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -27,6 +27,11 @@ enum scmi_performance_protocol_cmd {
 	PERF_DESCRIBE_FASTCHANNEL = 0xb,
 };
 
+enum scmi_performance_protocol_notify {
+	PERFORMANCE_LIMITS_CHANGED = 0x0,
+	PERFORMANCE_LEVEL_CHANGED = 0x1,
+};
+
 struct scmi_opp {
 	u32 perf;
 	u32 power;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 214886ce84f1..cf7f0312381b 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -12,6 +12,12 @@ enum scmi_power_protocol_cmd {
 	POWER_STATE_SET = 0x4,
 	POWER_STATE_GET = 0x5,
 	POWER_STATE_NOTIFY = 0x6,
+	POWER_STATE_CHANGE_REQUESTED_NOTIFY = 0x7,
+};
+
+enum scmi_power_protocol_notify {
+	POWER_STATE_CHANGED = 0x0,
+	POWER_STATE_CHANGE_REQUESTED = 0x1,
 };
 
 struct scmi_msg_resp_power_attributes {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index eba61b9c1f53..db1b1ab303da 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -14,6 +14,10 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_READING_GET = 0x6,
 };
 
+enum scmi_sensor_protocol_notify {
+	SENSOR_TRIP_POINT_EVENT = 0x0,
+};
+
 struct scmi_msg_resp_sensor_attributes {
 	__le16 num_sensors;
 	u8 max_requests;
-- 
2.17.1


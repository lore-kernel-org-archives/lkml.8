Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D3D20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGHMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:23:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728952AbgGHMXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9F70106F;
        Wed,  8 Jul 2020 05:23:07 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEAEF3F68F;
        Wed,  8 Jul 2020 05:23:06 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 4/4] firmware: arm_scmi: Remove fixed size typing from event reports
Date:   Wed,  8 Jul 2020 13:22:48 +0100
Message-Id: <20200708122248.52771-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708122248.52771-1-cristian.marussi@arm.com>
References: <20200708122248.52771-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event reports are used to convey information describing events to the
registered user-callbacks: they are necessarily derived from the underlying
raw SCMI events' messages but they are not meant to expose or directly
mirror any of those messages data layout, which belong to the protocol
layer.

Using fixed size fields mirroring messages structure is at odd with this:
get rid of them using more generic, equivalent, typing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/linux/scmi_protocol.h | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7d4348fb7330..e51f392f464b 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -381,47 +381,47 @@ enum scmi_notification_events {
 };
 
 struct scmi_power_state_changed_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 power_state;
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	unsigned int		domain_id;
+	unsigned int		power_state;
 };
 
 struct scmi_perf_limits_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 range_max;
-	u32 range_min;
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	unsigned int		domain_id;
+	unsigned int		range_max;
+	unsigned int		range_min;
 };
 
 struct scmi_perf_level_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 performance_level;
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	unsigned int		domain_id;
+	unsigned int		performance_level;
 };
 
 struct scmi_sensor_trip_point_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 sensor_id;
-	u32 trip_point_desc;
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	unsigned int		sensor_id;
+	unsigned int		trip_point_desc;
 };
 
 struct scmi_reset_issued_report {
-	u64 timestamp;
-	u32 agent_id;
-	u32 domain_id;
-	u32 reset_state;
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	unsigned int		domain_id;
+	unsigned int		reset_state;
 };
 
 struct scmi_base_error_report {
-	u64 timestamp;
-	u32 agent_id;
-	bool fatal;
-	u16 cmd_count;
-	u64 reports[];
+	unsigned long long	timestamp;
+	unsigned int		agent_id;
+	bool			fatal;
+	unsigned int		cmd_count;
+	unsigned long long	reports[];
 };
 
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1


Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB0214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:43:42 -0400
Received: from foss.arm.com ([217.140.110.172]:51022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgGCQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:43:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7C1131B;
        Fri,  3 Jul 2020 09:43:41 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BD9A3F73C;
        Fri,  3 Jul 2020 09:43:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH] hwmon: scmi: fix potential buffer overflow in scmi_hwmon_probe()
Date:   Fri,  3 Jul 2020 17:43:29 +0100
Message-Id: <20200703164329.3170-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMATCH detected a potential buffer overflow in the manipulation of
hwmon_attributes array inside the scmi_hwmon_probe function:

drivers/hwmon/scmi-hwmon.c:226
 scmi_hwmon_probe() error: buffer overflow 'hwmon_attributes' 6 <= 9

Fix it by statically declaring the size of the array as the maximum
possible as defined by hwmon_max define.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 281454c5c5b1..758f66fc9afe 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -149,7 +149,7 @@ static enum hwmon_sensor_types scmi_types[] = {
 	[ENERGY] = hwmon_energy,
 };
 
-static u32 hwmon_attributes[] = {
+static u32 hwmon_attributes[hwmon_max] = {
 	[hwmon_chip] = HWMON_C_REGISTER_TZ,
 	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
 	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
-- 
2.17.1


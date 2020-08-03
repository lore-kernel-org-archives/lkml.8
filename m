Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC542C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8F5206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8g/zuT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHCObY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:31:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:31:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so34405378wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2kviffhQpyWDETYjhFA03IjjKlp6zqYMUxZqK+9AO8=;
        b=P8g/zuT7lns/ELOxpJWMA5IhEac6jL7hYl4+iY4YMPJaR7OIxFVMZVPq3258LMlmpG
         NJ6se1VRDsCZeJ9hG0yub6KR/P8Ht44V0A18acBANtBcbo3Zc83JXcnwKeD75J6emF9l
         4QHzgLu4diglhSlgQ9a7um1CgY4aTW/M12sbeF6WYZyZOnrP5w4fGJr/G9+GZww2QzN0
         KyLh6NDyH4+EYml/wMsRQjjcTDWSu2zoFEiXOxpIrM3bnav0TLdCc8B7/0SO/a1hHmnt
         It5OmGA6qz2nlWnQXk5Qfd+PUGtRjnC3OnLevpGa06GZTEkECSf5JWhGnQCcQtnoc8jt
         qyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2kviffhQpyWDETYjhFA03IjjKlp6zqYMUxZqK+9AO8=;
        b=GndceOQM1EXirJKsgQOuA6oTW/NbyGHpjgHzz5hJFmcn9CYJQtWAGGDZMpH3l4LFkR
         RTKCjy799tHzEXZZiMCj+kaZgEZBUYa7LUU79cEQrt5+G6gzkrH6Cr9C0i8LAxXrNlCz
         DusKW8lbVZR0cWDnHnyGhq4xVEy9BwiZ/o7+jzHby6Z0zD69ejtdEZg27hA671j6d6zb
         lJhRGIsD/rWB7PG9DYVKwojohqf3Je3oWHGXRUXuOjrcWyiFzNZuQIzBZUnG9TDnDz0G
         XfBBo6IC9e66U1ErQ+MN2WitfsfY0XcDGeV82QXJ8wlwdJrO/iqKuJ20082ZBvsaNhi7
         Toig==
X-Gm-Message-State: AOAM530KxiF6GkSr/q3yAltHBwrLeLkNwcpGfl6eidGbO/3BwL4oupy7
        5shGXBhkOA/4jD3LEcm+7TiBEqIW
X-Google-Smtp-Source: ABdhPJwM+IxSgvRo/WQiT0sDzyAfhsiRUHkDwaz8a1YTPGZp+j3ky5fTOMZIJE0ej4efnNWOWASlww==
X-Received: by 2002:adf:e290:: with SMTP id v16mr15210366wri.259.1596465080714;
        Mon, 03 Aug 2020 07:31:20 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id f9sm24529072wru.47.2020.08.03.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:31:17 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: expose sync manager resources allocation in INFO IOCTL
Date:   Mon,  3 Aug 2020 17:31:14 +0300
Message-Id: <20200803143114.32035-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Although the driver defines the first user-available sync manager object
and monitor in habanalabs.h, we would like to also expose this information
via the INFO IOCTL so the runtime can get this information dynamically.
This is because in future ASICs we won't need to define it statically.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h   |  6 ++++
 .../misc/habanalabs/common/habanalabs_ioctl.c | 30 ++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  7 +++++
 include/uapi/misc/habanalabs.h                | 23 ++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8b5b4afe42c7..52a07c8d7d7c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -65,6 +65,8 @@
 
 #define HL_PCI_NUM_BARS			6
 
+#define HL_MAX_DCORES			4
+
 /**
  * struct pgt_info - MMU hop page info.
  * @node: hash linked-list node for the pgts shadow hash of pgts.
@@ -291,6 +293,8 @@ struct hl_mmu_properties {
  * @max_queues: maximum amount of queues in the system
  * @sync_stream_first_sob: first sync object available for sync stream use
  * @sync_stream_first_mon: first monitor available for sync stream use
+ * @first_available_user_sob: first sob available for the user
+ * @first_available_user_mon: first monitor available for the user
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  */
@@ -337,6 +341,8 @@ struct asic_fixed_properties {
 	u32				max_queues;
 	u16				sync_stream_first_sob;
 	u16				sync_stream_first_mon;
+	u16				first_available_user_sob[HL_MAX_DCORES];
+	u16				first_available_user_mon[HL_MAX_DCORES];
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 };
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 4d838b1a3bbe..fe6c5534d378 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -8,6 +8,7 @@
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 
+#include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
@@ -314,7 +315,7 @@ static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_info_cs_counters cs_counters = {0};
+	struct hl_info_cs_counters cs_counters = { {0} };
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -332,6 +333,30 @@ static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(cs_counters))) ? -EFAULT : 0;
 }
 
+static int sync_manager_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_info_sync_manager sm_info = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	if (args->dcore_id >= HL_MAX_DCORES)
+		return -EINVAL;
+
+	sm_info.first_available_sync_object =
+			prop->first_available_user_sob[args->dcore_id];
+	sm_info.first_available_monitor =
+			prop->first_available_user_mon[args->dcore_id];
+
+
+	return copy_to_user(out, &sm_info, min_t(size_t, (size_t) max_size,
+			sizeof(sm_info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -401,6 +426,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_CLK_THROTTLE_REASON:
 		return clk_throttle_info(hpriv, args);
 
+	case HL_INFO_SYNC_MANAGER:
+		return sync_manager_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 41d55a5f7f83..437219985327 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -344,6 +344,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid);
 static int gaudi_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 num_sync_stream_queues = 0;
 	int i;
 
 	prop->max_queues = GAUDI_QUEUE_ID_SIZE;
@@ -360,6 +361,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->hw_queues_props[i].driver_only = 0;
 			prop->hw_queues_props[i].requires_kernel_cb = 1;
 			prop->hw_queues_props[i].supports_sync_stream = 1;
+			num_sync_stream_queues++;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_CPU) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
 			prop->hw_queues_props[i].driver_only = 1;
@@ -446,6 +448,11 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 
 	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
 
+	prop->first_available_user_sob[HL_GAUDI_WS_DCORE] =
+			num_sync_stream_queues * HL_RSVD_SOBS;
+	prop->first_available_user_mon[HL_GAUDI_WS_DCORE] =
+			num_sync_stream_queues * HL_RSVD_MONS;
+
 	return 0;
 }
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ee13b919db35..ca6dc1fc250e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -266,6 +266,7 @@ enum hl_device_status {
  * HL_INFO_CS_COUNTERS   - Retrieve command submission counters
  * HL_INFO_PCI_COUNTERS  - Retrieve PCI counters
  * HL_INFO_CLK_THROTTLE_REASON - Retrieve clock throttling reason
+ * HL_INFO_SYNC_MANAGER  - Retrieve sync manager info per dcore
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -280,6 +281,7 @@ enum hl_device_status {
 #define HL_INFO_CS_COUNTERS		11
 #define HL_INFO_PCI_COUNTERS		12
 #define HL_INFO_CLK_THROTTLE_REASON	13
+#define HL_INFO_SYNC_MANAGER		14
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -367,6 +369,16 @@ struct hl_info_clk_throttle {
 	__u32 clk_throttling_reason;
 };
 
+/**
+ * struct hl_info_sync_manager - sync manager information
+ * @first_available_sync_object: first available sob
+ * @first_available_monitor: first available monitor
+ */
+struct hl_info_sync_manager {
+	__u32 first_available_sync_object;
+	__u32 first_available_monitor;
+};
+
 /**
  * struct hl_info_cs_counters - command submission counters
  * @out_of_mem_drop_cnt: dropped due to memory allocation issue
@@ -386,6 +398,13 @@ struct hl_info_cs_counters {
 	struct hl_cs_counters ctx_cs_counters;
 };
 
+enum gaudi_dcores {
+	HL_GAUDI_WS_DCORE,
+	HL_GAUDI_WN_DCORE,
+	HL_GAUDI_EN_DCORE,
+	HL_GAUDI_ES_DCORE
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
@@ -402,6 +421,10 @@ struct hl_info_args {
 	__u32 op;
 
 	union {
+		/* Dcore id for which the information is relevant.
+		 * For Gaudi refer to 'enum gaudi_dcores'
+		 */
+		__u32 dcore_id;
 		/* Context ID - Currently not in use */
 		__u32 ctx_id;
 		/* Period value for utilization rate (100ms - 1000ms, in 100ms
-- 
2.17.1


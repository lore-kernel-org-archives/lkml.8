Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D2EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596F520717
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1fop/lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1RwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:52:03 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54560 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 13:52:02 -0400
Received: by mail-wm1-f43.google.com with SMTP id c81so15003164wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ftm92ZR7oTW0PwVqWCy4L1jjNlWwPl21GDwU+9zStfE=;
        b=F1fop/lStF2alQhaMJfpJWhSRIoodJQaeOKy+xYUEPB6KgbmOol5KlHaC3BFDoc7ak
         fch8TfUf7gGinBAAkt11rVwpJBArTbfgcy9KoPRwGLRzEuPE3arbYv9GctAFSSNljWk9
         sN9tlawb4SexQdmydywsMdDxu/uz+yPlctxhffMy6iZCwbHBbSv0IZdxdYQmvvcOg1Xt
         NNMsKgEpsOiY68s9JCiCmvIGBVZYpk+HHrQPDBqFBVpAoi93f5FrzdyBSQiS3F/VeEC+
         JKA+hPAT4xStGNXqbMZAxw2N+wQJ1+Gqes0H0/fFMh0xPbrdgxD5o73VUVXaOrb7cMxp
         AV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ftm92ZR7oTW0PwVqWCy4L1jjNlWwPl21GDwU+9zStfE=;
        b=KPxKQX4vlV6wyYeQNrye9+/B5VOG5H1JAT6vfOFuVgYSYmr4SS/3ViyFZpZo87Eitx
         VBfFAmKfe1ffmpsoY/6uk1/Yflf7zK+5pvkgvNvfDpPZdN9jZpcvlOVMghS3RAPWhRLm
         dRYpYy7P8vovjsNMBz9aG38ZBFAq+HfzT6nTHw9H6W2SyC2blBq8QpJjWTduh8UoRjU3
         tuFPRipbOVbryIKkIIPxcfdPDk+OqMis29LW5cj5vpWHKU3kHrFWFAcM0EMODHQWsGMe
         7cjOM6GUpGDZyX758uPAfN98LPyE0rrujQNt9Zwynfhw3OLVQsTUSONO6nYQBfp8svhy
         Fgkw==
X-Gm-Message-State: ANhLgQ2J6wILNQ8mdn6EISSknWTYXrCHL+Rr3ZSRwab3cbNABfwZQJYy
        1DTBwSllGOL5RXzs5acHF3QxtuK5iDc=
X-Google-Smtp-Source: ADFU+vtYQlm/It/G6+k4KWDgW2p5i4u1bElkT4MuJm7DqfvxL9NF+dTRYj49uyf+KvTYwTw8Xu1jcA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr4499150wml.120.1585417919606;
        Sat, 28 Mar 2020 10:51:59 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id a186sm13043789wmh.33.2020.03.28.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 10:51:58 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: update firmware definitions
Date:   Sat, 28 Mar 2020 20:51:57 +0300
Message-Id: <20200328175157.29308-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for the various errors and states of the firmware during boot.
Add a mapping of a new register that will tell the driver whether the
firmware executed the request from the driver or if it has encountered an
error.
Add a new enum for the possible values of this register.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../habanalabs/include/goya/goya_reg_map.h    |  1 +
 drivers/misc/habanalabs/include/hl_boot_if.h  | 51 +++++++++++++++++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
index 08061282cd9c..844a6ff5929a 100644
--- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -22,6 +22,7 @@
 #define mmCPU_CQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
 #define mmCPU_CQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
 #define mmCPU_CQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
+#define mmCPU_CMD_STATUS_TO_HOST		mmPSOC_GLOBAL_CONF_SCRATCHPAD_23
 #define mmCPU_BOOT_ERR0				mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
 #define mmCPU_BOOT_ERR1				mmPSOC_GLOBAL_CONF_SCRATCHPAD_25
 #define mmUPD_STS				mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 107482fb45a4..660550604362 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2018 HabanaLabs, Ltd.
+ * Copyright 2018-2020 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -10,7 +10,43 @@
 
 #define LKD_HARD_RESET_MAGIC		0xED7BD694
 
-/* CPU error bits in BOOT_ERROR registers */
+/*
+ * CPU error bits in BOOT_ERROR registers
+ *
+ * CPU_BOOT_ERR0_DRAM_INIT_FAIL		DRAM initialization failed.
+ *					DRAM is not reliable to use.
+ *
+ * CPU_BOOT_ERR0_FIT_CORRUPTED		FIT data integrity verification of the
+ *					image provided by the host has failed.
+ *
+ * CPU_BOOT_ERR0_TS_INIT_FAIL		Thermal Sensor initialization failed.
+ *					Boot continues as usual, but keep in
+ *					mind this is a warning.
+ *
+ * CPU_BOOT_ERR0_DRAM_SKIPPED		DRAM initialization has been skipped.
+ *					Skipping DRAM initialization has been
+ *					requested (e.g. strap, command, etc.)
+ *					and FW skipped the DRAM initialization.
+ *					Host can initialize the DRAM.
+ *
+ * CPU_BOOT_ERR0_BMC_WAIT_SKIPPED	Waiting for BMC data will be skipped.
+ *					Meaning the BMC data might not be
+ *					available until reset.
+ *
+ * CPU_BOOT_ERR0_NIC_DATA_NOT_RDY	NIC data from BMC is not ready.
+ *					BMC has not provided the NIC data yet.
+ *					Once provided this bit will be cleared.
+ *
+ * CPU_BOOT_ERR0_NIC_FW_FAIL		NIC FW loading failed.
+ *					The NIC FW loading and initialization
+ *					failed. This means NICs are not usable.
+ *
+ * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
+ *					This is a main indication that the
+ *					running FW populates the error
+ *					registers. Meaning the error bits are
+ *					not garbage, but actual error statuses.
+ */
 #define CPU_BOOT_ERR0_DRAM_INIT_FAIL		(1 << 0)
 #define CPU_BOOT_ERR0_FIT_CORRUPTED		(1 << 1)
 #define CPU_BOOT_ERR0_TS_INIT_FAIL		(1 << 2)
@@ -27,15 +63,18 @@ enum cpu_boot_status {
 	CPU_BOOT_STATUS_SRAM_AVAIL = 3,
 	CPU_BOOT_STATUS_IN_BTL = 4,	/* BTL is H/W FSM */
 	CPU_BOOT_STATUS_IN_PREBOOT = 5,
-	CPU_BOOT_STATUS_IN_SPL = 6,
+	CPU_BOOT_STATUS_IN_SPL,		/* deprecated - not reported */
 	CPU_BOOT_STATUS_IN_UBOOT = 7,
 	CPU_BOOT_STATUS_DRAM_INIT_FAIL,	/* deprecated - will be removed */
 	CPU_BOOT_STATUS_FIT_CORRUPTED,	/* deprecated - will be removed */
+	/* U-Boot console prompt activated, commands are not processed */
 	CPU_BOOT_STATUS_UBOOT_NOT_READY = 10,
+	/* Finished NICs init, reported after DRAM and NICs */
 	CPU_BOOT_STATUS_NIC_FW_RDY = 11,
 	CPU_BOOT_STATUS_TS_INIT_FAIL,	/* deprecated - will be removed */
 	CPU_BOOT_STATUS_DRAM_SKIPPED,	/* deprecated - will be removed */
 	CPU_BOOT_STATUS_BMC_WAITING_SKIPPED, /* deprecated - will be removed */
+	/* Last boot loader progress status, ready to receive commands */
 	CPU_BOOT_STATUS_READY_TO_BOOT = 15,
 };
 
@@ -46,4 +85,10 @@ enum kmd_msg {
 	KMD_MSG_SKIP_BMC,
 };
 
+enum cpu_msg_status {
+	CPU_MSG_CLR = 0,
+	CPU_MSG_OK,
+	CPU_MSG_ERR,
+};
+
 #endif /* HL_BOOT_IF_H */
-- 
2.17.1


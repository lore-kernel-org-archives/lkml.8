Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C64AC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A8206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXlvBqnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCHNIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:08:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35605 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:08:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so7746155wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n46UAyOkxJoQbd1R8lWV5eNFph6CfsPNR1BB51d5B9M=;
        b=SXlvBqnp/LhmDqgu0nbJ4ENF0sERL4kiShlEVN/n43LUG6WzuoMjm+coDm2u0cYDwj
         LNzWN4OyLs6zxIEpFtVUbt/s/PIJEhlBJqZ9YKesL9Z2JwVNcWXTf5Nn6XtXDSBIOpt6
         V0XrWevPQeZaMwGRyM8ZXd24hHWX75N0QcCwFTJorYOKRyjVd6XmlgWw0iylcajBGm3w
         CtqPAtnmc2ZMpRvEQgfpPugUxEeAfnbrQYuu2MFRFksUGCl0Jr1gVEHtXd10M3NVIvC2
         F4FCpbONY8kqvvZ9Szsl9RFpMzLE3qNuG8RryXcSX3o0ykeouJfcYM+9R18zpdfrtOwO
         +pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n46UAyOkxJoQbd1R8lWV5eNFph6CfsPNR1BB51d5B9M=;
        b=Nvpuf9opFweKzy4XYrE4tEChlQXr4MucKWyr4oIoS11jSToVkhjXb1e9rXEgE0Fnq9
         a7NNGrrg7dJi8ZMct9biLJk+Jdc/m5wt9fZjmjl23odq/W61GmvOeiAABHm2SAJVK6GC
         2aWVwo6wg/pmegafILRoHZP+H6a5Wr6nxw1lA47JUuPqhzK9qDmT5DetAOKXKGQ7+UlT
         rS03Ok9VPDBuS3OggcMuDaLRExnPgAsGXhNEfq6PKh+bxx+wGs8GZd77Yg+rSOaO4vrG
         W14gH8HpF/bSxKKbH/9Xgmk9xwCi4NfowutOzm+05Kn4OXGhaaunGpvY/9VtGraDqxxO
         PxDA==
X-Gm-Message-State: ANhLgQ1YPZVTlj8h4iQU6qiqN5/sTeAnPGb1v4mFjf9Dv3cGzIq1Sl1+
        QcfoT1+PVy6YsNAT7KEL9f7C2Kbg
X-Google-Smtp-Source: ADFU+vu0auJSCiaEbNYP7tzTilScoB7LfnB7N8Okcndm6rILYKGp1tw/auPFD5moJekcUXsTzlqtLQ==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr16045621wrx.25.1583672923972;
        Sun, 08 Mar 2020 06:08:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z11sm21313341wmd.47.2020.03.08.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 06:08:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: update goya firmware register map
Date:   Sun,  8 Mar 2020 15:08:40 +0200
Message-Id: <20200308130840.24492-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific values in enum of register map to be able to deprecate old
values.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../habanalabs/include/goya/goya_reg_map.h    | 39 ++++++++++---------
 drivers/misc/habanalabs/include/hl_boot_if.h  | 35 +++++++++++------
 2 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
index cd89723c7f61..08061282cd9c 100644
--- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -11,24 +11,27 @@
 /*
  * PSOC scratch-pad registers
  */
-#define mmCPU_PQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
-#define mmCPU_PQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
-#define mmCPU_EQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
-#define mmCPU_EQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
-#define mmCPU_EQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
-#define mmCPU_PQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
-#define mmCPU_EQ_CI		mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
-#define mmCPU_PQ_INIT_STATUS	mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
-#define mmCPU_CQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
-#define mmCPU_CQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
-#define mmCPU_CQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
-#define mmUPD_STS		mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
-#define mmUPD_CMD		mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
-#define mmPREBOOT_VER_OFFSET	mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
-#define mmUBOOT_VER_OFFSET	mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
-#define mmUBOOT_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
-#define mmBTL_ID		mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
+#define mmCPU_PQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+#define mmCPU_PQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
+#define mmCPU_EQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
+#define mmCPU_EQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
+#define mmCPU_EQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
+#define mmCPU_PQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
+#define mmCPU_EQ_CI				mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
+#define mmCPU_PQ_INIT_STATUS			mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
+#define mmCPU_CQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
+#define mmCPU_CQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
+#define mmCPU_CQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
+#define mmCPU_BOOT_ERR0				mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
+#define mmCPU_BOOT_ERR1				mmPSOC_GLOBAL_CONF_SCRATCHPAD_25
+#define mmUPD_STS				mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
+#define mmUPD_CMD				mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
+#define mmPREBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
+#define mmUBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
+#define mmRDWR_TEST				mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
+#define mmBTL_ID				mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
 
-#define mmHW_STATE		mmPSOC_GLOBAL_CONF_APP_STATUS
+#define mmHW_STATE				mmPSOC_GLOBAL_CONF_APP_STATUS
+#define mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS	mmPSOC_GLOBAL_CONF_WARM_REBOOT
 
 #endif /* GOYA_REG_MAP_H_ */
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 2853a2de8cf6..14227b38d80e 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -8,20 +8,31 @@
 #ifndef HL_BOOT_IF_H
 #define HL_BOOT_IF_H
 
+#define LKD_HARD_RESET_MAGIC		0xED7BD694
+
+/* CPU error bits in BOOT_ERROR registers */
+#define CPU_BOOT_ERR0_DRAM_INIT_FAIL		(1 << 0)
+#define CPU_BOOT_ERR0_FIT_CORRUPTED		(1 << 1)
+#define CPU_BOOT_ERR0_TS_INIT_FAIL		(1 << 2)
+#define CPU_BOOT_ERR0_DRAM_SKIPPED		(1 << 3)
+#define CPU_BOOT_ERR0_BMC_WAIT_SKIPPED		(1 << 4)
+
 enum cpu_boot_status {
 	CPU_BOOT_STATUS_NA = 0,		/* Default value after reset of chip */
-	CPU_BOOT_STATUS_IN_WFE,
-	CPU_BOOT_STATUS_DRAM_RDY,
-	CPU_BOOT_STATUS_SRAM_AVAIL,
-	CPU_BOOT_STATUS_IN_BTL,		/* BTL is H/W FSM */
-	CPU_BOOT_STATUS_IN_PREBOOT,
-	CPU_BOOT_STATUS_IN_SPL,
-	CPU_BOOT_STATUS_IN_UBOOT,
-	CPU_BOOT_STATUS_DRAM_INIT_FAIL,
-	CPU_BOOT_STATUS_FIT_CORRUPTED,
-	CPU_BOOT_STATUS_UBOOT_NOT_READY,
-	CPU_BOOT_STATUS_RESERVED,
-	CPU_BOOT_STATUS_TS_INIT_FAIL,
+	CPU_BOOT_STATUS_IN_WFE = 1,
+	CPU_BOOT_STATUS_DRAM_RDY = 2,
+	CPU_BOOT_STATUS_SRAM_AVAIL = 3,
+	CPU_BOOT_STATUS_IN_BTL = 4,	/* BTL is H/W FSM */
+	CPU_BOOT_STATUS_IN_PREBOOT = 5,
+	CPU_BOOT_STATUS_IN_SPL = 6,
+	CPU_BOOT_STATUS_IN_UBOOT = 7,
+	CPU_BOOT_STATUS_DRAM_INIT_FAIL,	/* deprecated - will be removed */
+	CPU_BOOT_STATUS_FIT_CORRUPTED,	/* deprecated - will be removed */
+	CPU_BOOT_STATUS_UBOOT_NOT_READY = 10,
+	CPU_BOOT_STATUS_NIC_FW_RDY = 11,
+	CPU_BOOT_STATUS_TS_INIT_FAIL,	/* deprecated - will be removed */
+	CPU_BOOT_STATUS_DRAM_SKIPPED,	/* deprecated - will be removed */
+	CPU_BOOT_STATUS_BMC_WAITING_SKIPPED, /* deprecated - will be removed */
 };
 
 enum kmd_msg {
-- 
2.17.1


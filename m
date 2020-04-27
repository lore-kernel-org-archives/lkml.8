Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A5C81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2263B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzlwk2EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD0WfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgD0WfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:35:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D077DC03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:35:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so20803042wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tUma/eCevMjqFnqZendvJTl9iansQ/Bv8Vro/J8oVo8=;
        b=Xzlwk2ECG6eQU5iiHfNJ8uQVaIRQCgDNyDlrNct1Oer0OMQwkwrJANZIeEqDg2cCjY
         DVCr3gekpjqhWjPNUQlXtcMIgB7PVwcnwOITRHb0lNJb+/wbsygaoCcCHE8QWE15Thmw
         4+gh56SLD71qAof3emN1wPIqHQ6OxH0aNp/xUPrI528wDongKT8goQ3+Hr7TEC+ADEit
         9Olt0fq9wMVzycT8EvLS/LLpudd25ByeVbTBJXeKPS0IdkyVyEnK7hP5B3dhJZ7I7pBr
         ZTuAEHr5G5xi1YRmUM5C+pEfP9cYPRcf7UK4QBAfWYd8x3uD3DAW/rmzepFlLBY0v818
         Aj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tUma/eCevMjqFnqZendvJTl9iansQ/Bv8Vro/J8oVo8=;
        b=KJJ9cYO/MZ/KhLwGECInZvMkpKuRGfDfdkwV2pl7AJi6eGW+jEzHzSOZ8BMJxOGILa
         MT0YWVTT+ALUUTodDoLXJlackYnTdPc0YxCH+WRCkiGHUeayygxVwhvJh3nUXj4oIAqK
         l8gAaZap/O9P7hicEKQ4dPgx+A+GiVONkwWna/tTg+I9Y2YT72/voV/oV1qpplRObi2a
         dy+fJoOy+7JhBGUFz/8rbDYpAEwGydmi4HJR5IPo3tjmf9EKJkuZmrdRNg4DB5ZfTGnl
         mfsT0W8ECsz6TRydcGEdsJYE7/NJ93ehGtFy/NuzfkFGurx/Ep+vPxN8MmSbSieTUFeL
         IjJg==
X-Gm-Message-State: AGi0PuYBkyHuZ9qKIfkrzHLGX7KlwhATrPW2dL8z2eAbiSVNy13SOxff
        QThXv8c+LvXpqAo4YelB+tzKCAwm
X-Google-Smtp-Source: APiQypI7CBmZ+FSGwa7dKJj1EfPxVTH/lPvimLcvLzXpBwAEtDMp8eEGF/kB4Oxr9KAb8qF4J2o5bQ==
X-Received: by 2002:adf:fcc6:: with SMTP id f6mr26769822wrs.388.1588026907984;
        Mon, 27 Apr 2020 15:35:07 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s30sm22999162wrb.67.2020.04.27.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 15:35:06 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: update F/W register map
Date:   Tue, 28 Apr 2020 02:40:47 +0300
Message-Id: <20200427234047.13249-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427234047.13249-1-oded.gabbay@gmail.com>
References: <20200427234047.13249-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the mapping to the latest one used by the Firmware. No impact on the
driver in this update.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../habanalabs/include/goya/goya_reg_map.h    | 44 ++++++++++---------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
index 844a6ff5929a..0195f62d7254 100644
--- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -11,28 +11,30 @@
 /*
  * PSOC scratch-pad registers
  */
-#define mmCPU_PQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
-#define mmCPU_PQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
-#define mmCPU_EQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
-#define mmCPU_EQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
-#define mmCPU_EQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
-#define mmCPU_PQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
-#define mmCPU_EQ_CI				mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
-#define mmCPU_PQ_INIT_STATUS			mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
-#define mmCPU_CQ_BASE_ADDR_LOW			mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
-#define mmCPU_CQ_BASE_ADDR_HIGH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
-#define mmCPU_CQ_LENGTH				mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
-#define mmCPU_CMD_STATUS_TO_HOST		mmPSOC_GLOBAL_CONF_SCRATCHPAD_23
-#define mmCPU_BOOT_ERR0				mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
-#define mmCPU_BOOT_ERR1				mmPSOC_GLOBAL_CONF_SCRATCHPAD_25
-#define mmUPD_STS				mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
-#define mmUPD_CMD				mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
-#define mmPREBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
-#define mmUBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
-#define mmRDWR_TEST				mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
-#define mmBTL_ID				mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
+#define mmCPU_PQ_BASE_ADDR_LOW		mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+#define mmCPU_PQ_BASE_ADDR_HIGH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
+#define mmCPU_EQ_BASE_ADDR_LOW		mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
+#define mmCPU_EQ_BASE_ADDR_HIGH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
+#define mmCPU_EQ_LENGTH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
+#define mmCPU_PQ_LENGTH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
+#define mmCPU_EQ_CI			mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
+#define mmCPU_PQ_INIT_STATUS		mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
+#define mmCPU_CQ_BASE_ADDR_LOW		mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
+#define mmCPU_CQ_BASE_ADDR_HIGH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
+#define mmCPU_CQ_LENGTH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
+#define mmCPU_CMD_STATUS_TO_HOST	mmPSOC_GLOBAL_CONF_SCRATCHPAD_23
+#define mmCPU_BOOT_ERR0			mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
+#define mmCPU_BOOT_ERR1			mmPSOC_GLOBAL_CONF_SCRATCHPAD_25
+#define mmUPD_STS			mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
+#define mmUPD_CMD			mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
+#define mmPREBOOT_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
+#define mmUBOOT_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
+#define mmRDWR_TEST			mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
+#define mmBTL_ID			mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
 
-#define mmHW_STATE				mmPSOC_GLOBAL_CONF_APP_STATUS
+#define mmHW_STATE			mmPSOC_GLOBAL_CONF_APP_STATUS
 #define mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS	mmPSOC_GLOBAL_CONF_WARM_REBOOT
+#define mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU	mmPSOC_GLOBAL_CONF_UBOOT_MAGIC
+#define mmUPD_PENDING_STS		mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_3
 
 #endif /* GOYA_REG_MAP_H_ */
-- 
2.17.1


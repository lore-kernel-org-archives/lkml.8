Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D0C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7255020736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI6uKkjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgEKLcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbgEKLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C914C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so10498494wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7quqNdDTuxFulCCRXmbHp6rJn11ErKotz+iQwjvyQ9I=;
        b=EI6uKkjhHrE4og+O5Sw1IYdGXhXw1eJX9OWef2e5bfemeLzRwKw60e3wilCxakx9s5
         H6kJc5/KKwtjytzN3JoInMTUjZpODcZHvSw7sFELsM3IRpbPeQZduQte6RMraj6QTM6L
         Ay19ay5eYm/jW9PSYvUU3Tt9DImelbec1m6/pZYlrPtzazPTFVOKEi2JIzdrE2CVD09J
         7hFl5PBLXwtmVf+dDHcJRJpSiUzDwsSWAB+0cpoxIHEEHamARbFMEhjZs/VwKOyov8UZ
         G5jftqkAi/9RS+u2lpLLS6+pTITVGVU4RVa965FN6dUoYG7aR5QGMMElDF+3DrhH529w
         f+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7quqNdDTuxFulCCRXmbHp6rJn11ErKotz+iQwjvyQ9I=;
        b=O4jTOPGgg31+srK3O5h51dtEG23tgORVJZXiNUqgmJbpIAEEDKBDp8fi+9LWAq6sOe
         PWJw2iBxDtcYSAoDyqv+Keqxqjd2h0406xW0VjSFek+X/R7WZE2lWURsHzJOjPrUse4f
         EQypYAJS0ueRQZtHatF8sxCiybMfJtZREUp+mJa2fIrdG1z2Osc3gg+sbgtPVJ29MPPu
         E6p6YDIg8MSaHpsdMqf5lTGQa2e/a/TRTOEnOJek84BWn53ARJ+15m4ugAUk09L8dMCj
         9aJcRo5SbSp/oxXtlki3xYmG3YgVvD5VSVR7wPCs9rdX26HSXEouvyh8WWxIavKnw8Ho
         DKyA==
X-Gm-Message-State: AGi0PuZVpfkrXi0N33cEfRZ1iNx+Lx/xVR1R0tq0wHxjdXgBUX8TEuiE
        E0QtsCRxHEQFFB9Qpp7GjOB+SNpK
X-Google-Smtp-Source: APiQypKi9YTNiz/ylt6KWamDrRD3ObSpuJo59qAmS0BiemktMEowX2Z2fqBMdDtjSO8ti23MnuZWCQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr14690740wrq.205.1589196769549;
        Mon, 11 May 2020 04:32:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 06/11] uapi: habanalabs: add gaudi defines
Date:   Mon, 11 May 2020 14:32:27 +0300
Message-Id: <20200511113232.5771-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new defines for GAUDI uapi interface. It includes the queue IDs,
the engine IDs, SRAM reserved space and Sync Manager reserved resources.

There is no new IOCTL or additional operations in existing IOCTLs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 164 ++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 079613dd7aae..f6267a8d7416 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -15,10 +15,13 @@
  * Defines that are asic-specific but constitutes as ABI between kernel driver
  * and userspace
  */
-#define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START	0x8000	/* 32KB */
+#define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START		0x8000	/* 32KB */
+#define GAUDI_DRIVER_SRAM_RESERVED_SIZE_FROM_START	0x80	/* 128 bytes */
 
+#define GAUDI_FIRST_AVAILABLE_W_S_SYNC_OBJECT		48
+#define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		24
 /*
- * Queue Numbering
+ * Goya queue Numbering
  *
  * The external queues (PCI DMA channels) MUST be before the internal queues
  * and each group (PCI DMA channels and internal) must be contiguous inside
@@ -45,6 +48,129 @@ enum goya_queue_id {
 	GOYA_QUEUE_ID_SIZE
 };
 
+/*
+ * Gaudi queue Numbering
+ * External queues (PCI DMA channels) are DMA_0_*, DMA_1_* and DMA_5_*.
+ * Except one CPU queue, all the rest are internal queues.
+ */
+
+enum gaudi_queue_id {
+	GAUDI_QUEUE_ID_DMA_0_0 = 0,	/* external */
+	GAUDI_QUEUE_ID_DMA_0_1 = 1,	/* external */
+	GAUDI_QUEUE_ID_DMA_0_2 = 2,	/* external */
+	GAUDI_QUEUE_ID_DMA_0_3 = 3,	/* external */
+	GAUDI_QUEUE_ID_DMA_1_0 = 4,	/* external */
+	GAUDI_QUEUE_ID_DMA_1_1 = 5,	/* external */
+	GAUDI_QUEUE_ID_DMA_1_2 = 6,	/* external */
+	GAUDI_QUEUE_ID_DMA_1_3 = 7,	/* external */
+	GAUDI_QUEUE_ID_CPU_PQ = 8,	/* CPU */
+	GAUDI_QUEUE_ID_DMA_2_0 = 9,	/* internal */
+	GAUDI_QUEUE_ID_DMA_2_1 = 10,	/* internal */
+	GAUDI_QUEUE_ID_DMA_2_2 = 11,	/* internal */
+	GAUDI_QUEUE_ID_DMA_2_3 = 12,	/* internal */
+	GAUDI_QUEUE_ID_DMA_3_0 = 13,	/* internal */
+	GAUDI_QUEUE_ID_DMA_3_1 = 14,	/* internal */
+	GAUDI_QUEUE_ID_DMA_3_2 = 15,	/* internal */
+	GAUDI_QUEUE_ID_DMA_3_3 = 16,	/* internal */
+	GAUDI_QUEUE_ID_DMA_4_0 = 17,	/* internal */
+	GAUDI_QUEUE_ID_DMA_4_1 = 18,	/* internal */
+	GAUDI_QUEUE_ID_DMA_4_2 = 19,	/* internal */
+	GAUDI_QUEUE_ID_DMA_4_3 = 20,	/* internal */
+	GAUDI_QUEUE_ID_DMA_5_0 = 21,	/* external */
+	GAUDI_QUEUE_ID_DMA_5_1 = 22,	/* external */
+	GAUDI_QUEUE_ID_DMA_5_2 = 23,	/* external */
+	GAUDI_QUEUE_ID_DMA_5_3 = 24,	/* external */
+	GAUDI_QUEUE_ID_DMA_6_0 = 25,	/* internal */
+	GAUDI_QUEUE_ID_DMA_6_1 = 26,	/* internal */
+	GAUDI_QUEUE_ID_DMA_6_2 = 27,	/* internal */
+	GAUDI_QUEUE_ID_DMA_6_3 = 28,	/* internal */
+	GAUDI_QUEUE_ID_DMA_7_0 = 29,	/* internal */
+	GAUDI_QUEUE_ID_DMA_7_1 = 30,	/* internal */
+	GAUDI_QUEUE_ID_DMA_7_2 = 31,	/* internal */
+	GAUDI_QUEUE_ID_DMA_7_3 = 32,	/* internal */
+	GAUDI_QUEUE_ID_MME_0_0 = 33,	/* internal */
+	GAUDI_QUEUE_ID_MME_0_1 = 34,	/* internal */
+	GAUDI_QUEUE_ID_MME_0_2 = 35,	/* internal */
+	GAUDI_QUEUE_ID_MME_0_3 = 36,	/* internal */
+	GAUDI_QUEUE_ID_MME_1_0 = 37,	/* internal */
+	GAUDI_QUEUE_ID_MME_1_1 = 38,	/* internal */
+	GAUDI_QUEUE_ID_MME_1_2 = 39,	/* internal */
+	GAUDI_QUEUE_ID_MME_1_3 = 40,	/* internal */
+	GAUDI_QUEUE_ID_TPC_0_0 = 41,	/* internal */
+	GAUDI_QUEUE_ID_TPC_0_1 = 42,	/* internal */
+	GAUDI_QUEUE_ID_TPC_0_2 = 43,	/* internal */
+	GAUDI_QUEUE_ID_TPC_0_3 = 44,	/* internal */
+	GAUDI_QUEUE_ID_TPC_1_0 = 45,	/* internal */
+	GAUDI_QUEUE_ID_TPC_1_1 = 46,	/* internal */
+	GAUDI_QUEUE_ID_TPC_1_2 = 47,	/* internal */
+	GAUDI_QUEUE_ID_TPC_1_3 = 48,	/* internal */
+	GAUDI_QUEUE_ID_TPC_2_0 = 49,	/* internal */
+	GAUDI_QUEUE_ID_TPC_2_1 = 50,	/* internal */
+	GAUDI_QUEUE_ID_TPC_2_2 = 51,	/* internal */
+	GAUDI_QUEUE_ID_TPC_2_3 = 52,	/* internal */
+	GAUDI_QUEUE_ID_TPC_3_0 = 53,	/* internal */
+	GAUDI_QUEUE_ID_TPC_3_1 = 54,	/* internal */
+	GAUDI_QUEUE_ID_TPC_3_2 = 55,	/* internal */
+	GAUDI_QUEUE_ID_TPC_3_3 = 56,	/* internal */
+	GAUDI_QUEUE_ID_TPC_4_0 = 57,	/* internal */
+	GAUDI_QUEUE_ID_TPC_4_1 = 58,	/* internal */
+	GAUDI_QUEUE_ID_TPC_4_2 = 59,	/* internal */
+	GAUDI_QUEUE_ID_TPC_4_3 = 60,	/* internal */
+	GAUDI_QUEUE_ID_TPC_5_0 = 61,	/* internal */
+	GAUDI_QUEUE_ID_TPC_5_1 = 62,	/* internal */
+	GAUDI_QUEUE_ID_TPC_5_2 = 63,	/* internal */
+	GAUDI_QUEUE_ID_TPC_5_3 = 64,	/* internal */
+	GAUDI_QUEUE_ID_TPC_6_0 = 65,	/* internal */
+	GAUDI_QUEUE_ID_TPC_6_1 = 66,	/* internal */
+	GAUDI_QUEUE_ID_TPC_6_2 = 67,	/* internal */
+	GAUDI_QUEUE_ID_TPC_6_3 = 68,	/* internal */
+	GAUDI_QUEUE_ID_TPC_7_0 = 69,	/* internal */
+	GAUDI_QUEUE_ID_TPC_7_1 = 70,	/* internal */
+	GAUDI_QUEUE_ID_TPC_7_2 = 71,	/* internal */
+	GAUDI_QUEUE_ID_TPC_7_3 = 72,	/* internal */
+	GAUDI_QUEUE_ID_NIC_0_0 = 73,	/* internal */
+	GAUDI_QUEUE_ID_NIC_0_1 = 74,	/* internal */
+	GAUDI_QUEUE_ID_NIC_0_2 = 75,	/* internal */
+	GAUDI_QUEUE_ID_NIC_0_3 = 76,	/* internal */
+	GAUDI_QUEUE_ID_NIC_1_0 = 77,	/* internal */
+	GAUDI_QUEUE_ID_NIC_1_1 = 78,	/* internal */
+	GAUDI_QUEUE_ID_NIC_1_2 = 79,	/* internal */
+	GAUDI_QUEUE_ID_NIC_1_3 = 80,	/* internal */
+	GAUDI_QUEUE_ID_NIC_2_0 = 81,	/* internal */
+	GAUDI_QUEUE_ID_NIC_2_1 = 82,	/* internal */
+	GAUDI_QUEUE_ID_NIC_2_2 = 83,	/* internal */
+	GAUDI_QUEUE_ID_NIC_2_3 = 84,	/* internal */
+	GAUDI_QUEUE_ID_NIC_3_0 = 85,	/* internal */
+	GAUDI_QUEUE_ID_NIC_3_1 = 86,	/* internal */
+	GAUDI_QUEUE_ID_NIC_3_2 = 87,	/* internal */
+	GAUDI_QUEUE_ID_NIC_3_3 = 88,	/* internal */
+	GAUDI_QUEUE_ID_NIC_4_0 = 89,	/* internal */
+	GAUDI_QUEUE_ID_NIC_4_1 = 90,	/* internal */
+	GAUDI_QUEUE_ID_NIC_4_2 = 91,	/* internal */
+	GAUDI_QUEUE_ID_NIC_4_3 = 92,	/* internal */
+	GAUDI_QUEUE_ID_NIC_5_0 = 93,	/* internal */
+	GAUDI_QUEUE_ID_NIC_5_1 = 94,	/* internal */
+	GAUDI_QUEUE_ID_NIC_5_2 = 95,	/* internal */
+	GAUDI_QUEUE_ID_NIC_5_3 = 96,	/* internal */
+	GAUDI_QUEUE_ID_NIC_6_0 = 97,	/* internal */
+	GAUDI_QUEUE_ID_NIC_6_1 = 98,	/* internal */
+	GAUDI_QUEUE_ID_NIC_6_2 = 99,	/* internal */
+	GAUDI_QUEUE_ID_NIC_6_3 = 100,	/* internal */
+	GAUDI_QUEUE_ID_NIC_7_0 = 101,	/* internal */
+	GAUDI_QUEUE_ID_NIC_7_1 = 102,	/* internal */
+	GAUDI_QUEUE_ID_NIC_7_2 = 103,	/* internal */
+	GAUDI_QUEUE_ID_NIC_7_3 = 104,	/* internal */
+	GAUDI_QUEUE_ID_NIC_8_0 = 105,	/* internal */
+	GAUDI_QUEUE_ID_NIC_8_1 = 106,	/* internal */
+	GAUDI_QUEUE_ID_NIC_8_2 = 107,	/* internal */
+	GAUDI_QUEUE_ID_NIC_8_3 = 108,	/* internal */
+	GAUDI_QUEUE_ID_NIC_9_0 = 109,	/* internal */
+	GAUDI_QUEUE_ID_NIC_9_1 = 110,	/* internal */
+	GAUDI_QUEUE_ID_NIC_9_2 = 111,	/* internal */
+	GAUDI_QUEUE_ID_NIC_9_3 = 112,	/* internal */
+	GAUDI_QUEUE_ID_SIZE
+};
+
 /*
  * Engine Numbering
  *
@@ -69,6 +195,40 @@ enum goya_engine_id {
 	GOYA_ENGINE_ID_SIZE
 };
 
+enum gaudi_engine_id {
+	GAUDI_ENGINE_ID_DMA_0 = 0,
+	GAUDI_ENGINE_ID_DMA_1,
+	GAUDI_ENGINE_ID_DMA_2,
+	GAUDI_ENGINE_ID_DMA_3,
+	GAUDI_ENGINE_ID_DMA_4,
+	GAUDI_ENGINE_ID_DMA_5,
+	GAUDI_ENGINE_ID_DMA_6,
+	GAUDI_ENGINE_ID_DMA_7,
+	GAUDI_ENGINE_ID_MME_0,
+	GAUDI_ENGINE_ID_MME_1,
+	GAUDI_ENGINE_ID_MME_2,
+	GAUDI_ENGINE_ID_MME_3,
+	GAUDI_ENGINE_ID_TPC_0,
+	GAUDI_ENGINE_ID_TPC_1,
+	GAUDI_ENGINE_ID_TPC_2,
+	GAUDI_ENGINE_ID_TPC_3,
+	GAUDI_ENGINE_ID_TPC_4,
+	GAUDI_ENGINE_ID_TPC_5,
+	GAUDI_ENGINE_ID_TPC_6,
+	GAUDI_ENGINE_ID_TPC_7,
+	GAUDI_ENGINE_ID_NIC_0,
+	GAUDI_ENGINE_ID_NIC_1,
+	GAUDI_ENGINE_ID_NIC_2,
+	GAUDI_ENGINE_ID_NIC_3,
+	GAUDI_ENGINE_ID_NIC_4,
+	GAUDI_ENGINE_ID_NIC_5,
+	GAUDI_ENGINE_ID_NIC_6,
+	GAUDI_ENGINE_ID_NIC_7,
+	GAUDI_ENGINE_ID_NIC_8,
+	GAUDI_ENGINE_ID_NIC_9,
+	GAUDI_ENGINE_ID_SIZE
+};
+
 enum hl_device_status {
 	HL_DEVICE_STATUS_OPERATIONAL,
 	HL_DEVICE_STATUS_IN_RESET,
-- 
2.17.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B1AC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4784A20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it/1mWwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgEKLdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729825AbgEKLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:33:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so1602882wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dcCagHXVLs8gCZ3y8+ZKzywnVhOIrV+OEHxuB8kKWH8=;
        b=it/1mWwh+9nfGbEFOXrsl2QRsOOAj05qkalwXWH/Xx0lG0qh6HWEX8nU+Y7y77mMZN
         sTiYy6sn4DmxWkOyR6Vgy6v9cgnkJkBDLi0JYnlDW4sZDxOkZ0C6v81wPB2KV94b+OWV
         QqlKqvqoMFKXozENKwslNXdnrGolVh4AEmAKl3k7PhTUx/jLgHsaw+ddCsYZh1hXFxUQ
         Zb9o+G8usRlqawC24TRkl1Cuitj6SxTWEvv5cTzVIcYiDDRbpujwPiYDWuUZT5daAW3c
         TdblhScj0yTd5FQGdB+u5AGLDQMd3OS/RGutVsI+CN2ybtSZenXDPA4FMrCB5WuU0Prx
         4o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=dcCagHXVLs8gCZ3y8+ZKzywnVhOIrV+OEHxuB8kKWH8=;
        b=BO9DrbmV7nPgncrNgy2F53e4hLFDs3uvmDwLTKQuf06rt80eCAHTwgdoFvJGRPEfte
         4cW7V+/BEQLPGZB3cVFfm3tgQV0rDN2kTQDKZqrQLaahZK3FsGpMpAKIs3J8zf73DLVF
         E6wi+1v9Vw5qYdgviarxcRHTddwlFj1OU58BIg//wXRvIZTLE/DH/wbmLntuXavvbFH7
         F1SapCyP8ecQjRkLD1hyOzpcNF2CQKzc+TZjV/2qBdXcJWMiJsdAeiudrZ8/NR8l64Z6
         tGGpTx6s0cgeNULf0CAw5WAcjLSzU+lp8RnmleiSQ4wYk3Gr7U1QEBv25BVy+T2jDMyA
         iLRg==
X-Gm-Message-State: AGi0PuYP12pbq3hZL/cMzwxlRxJ64MHSu6/HeaY9klCYRxvRkGTJmoMO
        9wnpMthjp76xVEja0/ba1oRxQVTE
X-Google-Smtp-Source: APiQypJbD5A7gDXfLt8Ns13ed1N4hUAcYAWtrxTUTI5FvpwOL7UDZWEHZG1s05PkMvcNzSAktMKZrw==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr18208487wrw.78.1589196777077;
        Mon, 11 May 2020 04:32:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 09/11] habanalabs: add gaudi security module
Date:   Mon, 11 May 2020 14:32:30 +0300
Message-Id: <20200511113232.5771-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add the code to initialize the security module of GAUDI. Similar to Goya,
we have two dedicated mechanisms for security: Range Registers and
Protection bits. Those mechanisms protect sensitive memory and
configuration areas inside the device.

In addition, in Gaudi we moved to a 3-level security scheme, where the F/W
runs with the highest security level (Privileged), the driver runs with a
less secured level (Secured) and the user is neither privileged nor
secured. The security module in the driver configures the Secured parts so
the user won't be able to access them. The Privileged parts are configured
by the F/W.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/Makefile        |    2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |    2 +
 drivers/misc/habanalabs/gaudi/gaudiP.h        |    1 +
 .../misc/habanalabs/gaudi/gaudi_security.c    | 9114 +++++++++++++++++
 4 files changed, 9118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_security.c

diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index a7b5be449de3..1fe4ed625f47 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 subdir-ccflags-y += -I$(src)
 
-HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o
\ No newline at end of file
+HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o
\ No newline at end of file
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 624c1f907e79..96f533a2cf82 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3263,6 +3263,8 @@ static int gaudi_hw_init(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
+	gaudi_init_security(hdev);
+
 	gaudi_init_mme_qmans(hdev);
 
 	gaudi_init_tpc_qmans(hdev);
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index f48f4647fbed..a311f3106b0a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -248,6 +248,7 @@ struct gaudi_device {
 	u8				ext_queue_idx;
 };
 
+void gaudi_init_security(struct hl_device *hdev);
 void gaudi_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
new file mode 100644
index 000000000000..82be3433dc9e
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -0,0 +1,9114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "gaudiP.h"
+#include "include/gaudi/asic_reg/gaudi_regs.h"
+
+#define GAUDI_NUMBER_OF_RR_REGS		24
+#define GAUDI_NUMBER_OF_LBW_RANGES	12
+
+static u64 gaudi_rr_lbw_hit_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_HIT_WPROT,
+	mmDMA_IF_W_S_DMA1_HIT_WPROT,
+	mmDMA_IF_E_S_DMA0_HIT_WPROT,
+	mmDMA_IF_E_S_DMA1_HIT_WPROT,
+	mmDMA_IF_W_N_DMA0_HIT_WPROT,
+	mmDMA_IF_W_N_DMA1_HIT_WPROT,
+	mmDMA_IF_E_N_DMA0_HIT_WPROT,
+	mmDMA_IF_E_N_DMA1_HIT_WPROT,
+	mmSIF_RTR_0_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_1_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_2_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_3_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_4_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_5_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_6_LBW_RANGE_PROT_HIT_AW,
+	mmSIF_RTR_7_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_0_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_1_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_2_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_3_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_4_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_5_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_6_LBW_RANGE_PROT_HIT_AW,
+	mmNIF_RTR_7_LBW_RANGE_PROT_HIT_AW,
+};
+
+static u64 gaudi_rr_lbw_hit_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_HIT_RPROT,
+	mmDMA_IF_W_S_DMA1_HIT_RPROT,
+	mmDMA_IF_E_S_DMA0_HIT_RPROT,
+	mmDMA_IF_E_S_DMA1_HIT_RPROT,
+	mmDMA_IF_W_N_DMA0_HIT_RPROT,
+	mmDMA_IF_W_N_DMA1_HIT_RPROT,
+	mmDMA_IF_E_N_DMA0_HIT_RPROT,
+	mmDMA_IF_E_N_DMA1_HIT_RPROT,
+	mmSIF_RTR_0_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_1_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_2_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_3_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_4_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_5_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_6_LBW_RANGE_PROT_HIT_AR,
+	mmSIF_RTR_7_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_0_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_1_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_2_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_3_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_4_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_5_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_6_LBW_RANGE_PROT_HIT_AR,
+	mmNIF_RTR_7_LBW_RANGE_PROT_HIT_AR,
+};
+
+static u64 gaudi_rr_lbw_min_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_MIN_WPROT_0,
+	mmDMA_IF_W_S_DMA1_MIN_WPROT_0,
+	mmDMA_IF_E_S_DMA0_MIN_WPROT_0,
+	mmDMA_IF_E_S_DMA1_MIN_WPROT_0,
+	mmDMA_IF_W_N_DMA0_MIN_WPROT_0,
+	mmDMA_IF_W_N_DMA1_MIN_WPROT_0,
+	mmDMA_IF_E_N_DMA0_MIN_WPROT_0,
+	mmDMA_IF_E_N_DMA1_MIN_WPROT_0,
+	mmSIF_RTR_0_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_1_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_2_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_3_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_4_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_5_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_6_LBW_RANGE_PROT_MIN_AW_0,
+	mmSIF_RTR_7_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_0_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_1_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_2_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_3_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_4_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_5_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_6_LBW_RANGE_PROT_MIN_AW_0,
+	mmNIF_RTR_7_LBW_RANGE_PROT_MIN_AW_0,
+};
+
+static u64 gaudi_rr_lbw_max_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_MAX_WPROT_0,
+	mmDMA_IF_W_S_DMA1_MAX_WPROT_0,
+	mmDMA_IF_E_S_DMA0_MAX_WPROT_0,
+	mmDMA_IF_E_S_DMA1_MAX_WPROT_0,
+	mmDMA_IF_W_N_DMA0_MAX_WPROT_0,
+	mmDMA_IF_W_N_DMA1_MAX_WPROT_0,
+	mmDMA_IF_E_N_DMA0_MAX_WPROT_0,
+	mmDMA_IF_E_N_DMA1_MAX_WPROT_0,
+	mmSIF_RTR_0_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_1_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_2_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_3_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_4_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_5_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_6_LBW_RANGE_PROT_MAX_AW_0,
+	mmSIF_RTR_7_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_0_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_1_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_2_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_3_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_4_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_5_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_6_LBW_RANGE_PROT_MAX_AW_0,
+	mmNIF_RTR_7_LBW_RANGE_PROT_MAX_AW_0,
+};
+
+static u64 gaudi_rr_lbw_min_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_MIN_RPROT_0,
+	mmDMA_IF_W_S_DMA1_MIN_RPROT_0,
+	mmDMA_IF_E_S_DMA0_MIN_RPROT_0,
+	mmDMA_IF_E_S_DMA1_MIN_RPROT_0,
+	mmDMA_IF_W_N_DMA0_MIN_RPROT_0,
+	mmDMA_IF_W_N_DMA1_MIN_RPROT_0,
+	mmDMA_IF_E_N_DMA0_MIN_RPROT_0,
+	mmDMA_IF_E_N_DMA1_MIN_RPROT_0,
+	mmSIF_RTR_0_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_1_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_2_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_3_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_4_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_5_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_6_LBW_RANGE_PROT_MIN_AR_0,
+	mmSIF_RTR_7_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_0_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_1_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_2_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_3_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_4_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_5_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_6_LBW_RANGE_PROT_MIN_AR_0,
+	mmNIF_RTR_7_LBW_RANGE_PROT_MIN_AR_0,
+};
+
+static u64 gaudi_rr_lbw_max_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DMA0_MAX_RPROT_0,
+	mmDMA_IF_W_S_DMA1_MAX_RPROT_0,
+	mmDMA_IF_E_S_DMA0_MAX_RPROT_0,
+	mmDMA_IF_E_S_DMA1_MAX_RPROT_0,
+	mmDMA_IF_W_N_DMA0_MAX_RPROT_0,
+	mmDMA_IF_W_N_DMA1_MAX_RPROT_0,
+	mmDMA_IF_E_N_DMA0_MAX_RPROT_0,
+	mmDMA_IF_E_N_DMA1_MAX_RPROT_0,
+	mmSIF_RTR_0_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_1_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_2_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_3_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_4_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_5_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_6_LBW_RANGE_PROT_MAX_AR_0,
+	mmSIF_RTR_7_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_0_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_1_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_2_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_3_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_4_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_5_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_6_LBW_RANGE_PROT_MAX_AR_0,
+	mmNIF_RTR_7_LBW_RANGE_PROT_MAX_AR_0,
+};
+
+static u64 gaudi_rr_hbw_hit_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_HIT_AW,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_HIT_AW,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_HIT_AW,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_HIT_AW,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_HIT_AW,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_HIT_AW,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_HIT_AW,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_HIT_AW,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_HIT_AW,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_HIT_AW
+};
+
+static u64 gaudi_rr_hbw_hit_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_HIT_AR,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_HIT_AR,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_HIT_AR,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_HIT_AR,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_HIT_AR,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_HIT_AR,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_HIT_AR,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_HIT_AR,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_HIT_AR,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_HIT_AR
+};
+
+static u64 gaudi_rr_hbw_base_low_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_BASE_LOW_AW_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_BASE_LOW_AW_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_BASE_LOW_AW_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_BASE_LOW_AW_0
+};
+
+static u64 gaudi_rr_hbw_base_high_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_BASE_HIGH_AW_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_BASE_HIGH_AW_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_BASE_HIGH_AW_0
+};
+
+static u64 gaudi_rr_hbw_mask_low_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_MASK_LOW_AW_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_MASK_LOW_AW_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_MASK_LOW_AW_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_MASK_LOW_AW_0
+};
+
+static u64 gaudi_rr_hbw_mask_high_aw_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_MASK_HIGH_AW_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_MASK_HIGH_AW_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_MASK_HIGH_AW_0
+};
+
+static u64 gaudi_rr_hbw_base_low_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_BASE_LOW_AR_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_BASE_LOW_AR_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_BASE_LOW_AR_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_BASE_LOW_AR_0
+};
+
+static u64 gaudi_rr_hbw_base_high_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_BASE_HIGH_AR_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_BASE_HIGH_AR_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_BASE_HIGH_AR_0
+};
+
+static u64 gaudi_rr_hbw_mask_low_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_MASK_LOW_AR_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_MASK_LOW_AR_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_MASK_LOW_AR_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_MASK_LOW_AR_0
+};
+
+static u64 gaudi_rr_hbw_mask_high_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
+	mmDMA_IF_W_S_DOWN_CH0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_W_S_DOWN_CH1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_E_S_DOWN_CH0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_E_S_DOWN_CH1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_W_N_DOWN_CH0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_W_N_DOWN_CH1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_E_N_DOWN_CH0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmDMA_IF_E_N_DOWN_CH1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_2_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_3_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_4_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_5_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_6_RANGE_SEC_MASK_HIGH_AR_0,
+	mmSIF_RTR_CTRL_7_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_0_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_1_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_2_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_3_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_4_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_5_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_6_RANGE_SEC_MASK_HIGH_AR_0,
+	mmNIF_RTR_CTRL_7_RANGE_SEC_MASK_HIGH_AR_0
+};
+
+/**
+ * gaudi_set_block_as_protected - set the given block as protected
+ *
+ * @hdev: pointer to hl_device structure
+ * @block: block base address
+ *
+ */
+static void gaudi_pb_set_block(struct hl_device *hdev, u64 base)
+{
+	u32 pb_addr = base - CFG_BASE + PROT_BITS_OFFS;
+
+	while (pb_addr & 0xFFF) {
+		WREG32(pb_addr, 0);
+		pb_addr += 4;
+	}
+}
+
+static void gaudi_init_mme_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	gaudi_pb_set_block(hdev, mmMME0_ACC_BASE);
+	gaudi_pb_set_block(hdev, mmMME0_SBAB_BASE);
+	gaudi_pb_set_block(hdev, mmMME0_PRTN_BASE);
+	gaudi_pb_set_block(hdev, mmMME1_ACC_BASE);
+	gaudi_pb_set_block(hdev, mmMME1_SBAB_BASE);
+	gaudi_pb_set_block(hdev, mmMME1_PRTN_BASE);
+	gaudi_pb_set_block(hdev, mmMME2_ACC_BASE);
+	gaudi_pb_set_block(hdev, mmMME2_SBAB_BASE);
+	gaudi_pb_set_block(hdev, mmMME2_PRTN_BASE);
+	gaudi_pb_set_block(hdev, mmMME3_ACC_BASE);
+	gaudi_pb_set_block(hdev, mmMME3_SBAB_BASE);
+	gaudi_pb_set_block(hdev, mmMME3_PRTN_BASE);
+
+	WREG32(mmMME0_CTRL_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmMME1_CTRL_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmMME2_CTRL_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmMME3_CTRL_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	WREG32(mmMME0_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmMME2_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmMME0_CTRL_RESET & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_CTRL_RESET & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_CTRL_RESET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_QM_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_SYNC_OBJECT_FIFO_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_EUS_ROLLUP_CNT_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_LOG_SHADOW & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_DESC0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_TOKEN_UPDATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_MIN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_CTRL_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_HISTORY_LOG_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_A_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_B_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_A_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_A_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_B_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_DUMMY_B_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_EU_POWER_SAVE_DISABLE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_CS_DBG_BLOCK_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_CS_DBG_STATUS_DROP_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_TE_CLOSE_CGATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_AGU_SM_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_AGU_SM_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_EZSYNC_OUT_CREDIT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_PCU_RL_SAT_SEC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_AGU_SYNC_MSG_AXI_USER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_CTRL_SHADOW_0_STATUS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_CTRL_SHADOW_0_STATUS & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME0_CTRL_SHADOW_0_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_ARB_MST_CHOISE_PUSH_OFST_23 &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME0_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME0_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME0_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME0_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME0_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME0_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME1_CTRL_RESET & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME1_CTRL_RESET & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME1_CTRL_RESET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_QM_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_SYNC_OBJECT_FIFO_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_EUS_ROLLUP_CNT_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_LOG_SHADOW & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_DESC0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_TOKEN_UPDATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_MIN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_CTRL_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_HISTORY_LOG_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_A_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_B_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_A_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_A_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_B_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_DUMMY_B_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_EU_POWER_SAVE_DISABLE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_CS_DBG_BLOCK_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_CS_DBG_STATUS_DROP_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_TE_CLOSE_CGATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_AGU_SM_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_AGU_SM_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_EZSYNC_OUT_CREDIT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_PCU_RL_SAT_SEC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_AGU_SYNC_MSG_AXI_USER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME1_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME1_CTRL_SHADOW_0_STATUS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME1_CTRL_SHADOW_0_STATUS & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME1_CTRL_SHADOW_0_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	/* MME 1 is slave, hence its whole QM block is protected (with RR) */
+
+	pb_addr = (mmMME2_CTRL_RESET & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_CTRL_RESET & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_CTRL_RESET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_QM_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_SYNC_OBJECT_FIFO_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_EUS_ROLLUP_CNT_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_LOG_SHADOW & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_DESC0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_TOKEN_UPDATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_MIN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_CTRL_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_HISTORY_LOG_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_A_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_B_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_A_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_A_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_B_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_DUMMY_B_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_EU_POWER_SAVE_DISABLE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_CS_DBG_BLOCK_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_CS_DBG_STATUS_DROP_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_TE_CLOSE_CGATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_AGU_SM_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_AGU_SM_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_EZSYNC_OUT_CREDIT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_PCU_RL_SAT_SEC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_AGU_SYNC_MSG_AXI_USER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_CTRL_SHADOW_0_STATUS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_CTRL_SHADOW_0_STATUS & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME2_CTRL_SHADOW_0_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+			>> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_ARB_MST_CHOISE_PUSH_OFST_23 &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME2_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME2_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME2_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME2_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME2_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME2_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME3_CTRL_RESET & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME3_CTRL_RESET & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME3_CTRL_RESET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_QM_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_SYNC_OBJECT_FIFO_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_EUS_ROLLUP_CNT_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_LOG_SHADOW & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_DESC0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_TOKEN_UPDATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_TH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_MIN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_CTRL_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_HISTORY_LOG_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_A_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_B_BF16 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_A_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_A_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_B_FP32_ODD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_DUMMY_B_FP32_EVEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_EU_POWER_SAVE_DISABLE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_CS_DBG_BLOCK_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_CS_DBG_STATUS_DROP_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_TE_CLOSE_CGATE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_AGU_SM_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_AGU_SM_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_EZSYNC_OUT_CREDIT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_PCU_RL_SAT_SEC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_AGU_SYNC_MSG_AXI_USER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME3_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME3_CTRL_SHADOW_0_STATUS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME3_CTRL_SHADOW_0_STATUS & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME3_CTRL_SHADOW_0_STATUS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	/* MME 3 is slave, hence its whole QM block is protected (with RR) */
+
+	dev_dbg(hdev->dev, "Configure protection bits MME finished\n");
+}
+
+static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH0_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH1_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_E_PLL_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_BASE);
+
+	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH0_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH1_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_BASE);
+
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH0_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH1_BASE);
+	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_BASE);
+
+	WREG32(mmDMA0_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA1_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA2_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA3_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA4_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA5_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA6_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA7_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	WREG32(mmDMA0_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA1_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA2_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA3_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA4_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA5_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA6_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmDMA7_CORE_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmDMA0_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA0_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA1_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA1_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA2_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA3_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA3_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA4_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA4_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA5_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA5_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA6_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA6_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset =
+		((mmDMA7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS) >> 7)
+		<< 2;
+	mask = 1 << ((mmDMA7_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA7_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA0_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA0_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA0_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA0_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA0_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA0 CORE finished\n");
+
+	pb_addr = (mmDMA1_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA1_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA1_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA1_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA1_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA1_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA1 CORE finished\n");
+
+	pb_addr = (mmDMA2_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA2_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA2_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA2_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA2_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA2_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA2 CORE finished\n");
+
+	pb_addr = (mmDMA3_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA3_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA3_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA3_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA3_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA3_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA3 CORE finished\n");
+
+	pb_addr = (mmDMA4_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA4_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA4_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA4_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA4_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA4_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA4 CORE finished\n");
+
+	pb_addr = (mmDMA5_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA5_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA5_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA5_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA5_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA5_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA5 CORE finished\n");
+
+	pb_addr = (mmDMA6_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA6_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA6_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA6_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA6_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA6_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA6 CORE finished\n");
+
+	pb_addr = (mmDMA7_CORE_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_CORE_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_CORE_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_LBW_MAX_OUTSTAND & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_CORE_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_CORE_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_CORE_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_NON_SECURE_PROPS & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_CORE_RD_MAX_OUTSTAND & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_CORE_RD_MAX_OUTSTAND & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmDMA7_CORE_RD_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_ARCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_ARUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_MAX_OUTSTAND & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_MAX_AWID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_AWCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_INFLIGHTS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_ERRMSG_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_ERRMSG_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_ERRMSG_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_CORE_STS0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_CORE_STS0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_CORE_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA7_CORE_RD_DBGMEM_ADD & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA7_CORE_RD_DBGMEM_ADD & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA7_CORE_RD_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_RD_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_HBW_AXI_AR_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_HBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_LBW_AXI_AW_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_DESC_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_RD_DESC_ID & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA7_CORE_DBG_WR_DESC_ID & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits DMA finished\n");
+}
+
+static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	gaudi_pb_set_block(hdev, mmTPC0_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC1_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC2_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC3_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC4_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC5_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC6_E2E_CRED_BASE);
+	gaudi_pb_set_block(hdev, mmTPC7_E2E_CRED_BASE);
+
+	WREG32(mmTPC0_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC0_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC0_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+
+	word_offset = ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+
+	mask = 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+
+	word_offset = ((mmTPC0_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC0_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC0_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC1_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC1_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC1_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+
+	word_offset = ((mmTPC1_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC1_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC1_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC2_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC2_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC2_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC2_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+								<< 2;
+	mask = 1 << ((mmTPC2_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC3_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC3_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC3_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC3_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC3_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC4_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC4_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC4_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC4_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC4_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC5_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC5_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC5_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC5_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC5_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC6_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC6_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC6_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+								PROT_BITS_OFFS;
+
+	word_offset = ((mmTPC6_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+
+	mask = 1 << ((mmTPC6_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC6_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	WREG32(mmTPC7_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+	WREG32(mmTPC7_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
+
+	pb_addr = (mmTPC7_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_MSG_EN_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_MSG_EN_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_MSG_EN_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_MSG_EN_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_MSG_EN_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_PQ_BASE_HI_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_PQ_BASE_HI_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_PQ_BASE_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_SIZE_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_SIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_SIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_SIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS0_3 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_PQ_STS1_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_PQ_STS1_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_PQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS0_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS1_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS1_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS1_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS1_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_0 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CQ_CTL_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CQ_CTL_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CQ_CTL_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CQ_CTL_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CQ_CTL_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CQ_CTL_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_IFIFO_CNT_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_IFIFO_CNT_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_IFIFO_CNT_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_IFIFO_CNT_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_IFIFO_CNT_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_2 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & ~0xFFF) +
+								PROT_BITS_OFFS;
+
+	word_offset = ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & PROT_BITS_OFFS)
+								>> 7) << 2;
+
+	mask = 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CP_STS_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CP_STS_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CP_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_LO_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_LO_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_LO_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_LO_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_LO_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_HI_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_HI_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_HI_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_HI_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_CURRENT_INST_HI_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_BARRIER_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_BARRIER_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CP_BARRIER_CFG_3 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CP_BARRIER_CFG_3 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CP_BARRIER_CFG_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_BARRIER_CFG_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_DBG_0_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_DBG_0_1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CP_DBG_0_2 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CP_DBG_0_2 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CP_DBG_0_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_DBG_0_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_DBG_0_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_ARUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_ARUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_ARUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_ARUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_ARUSER_31_11_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_AWUSER_31_11_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_AWUSER_31_11_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_AWUSER_31_11_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_AWUSER_31_11_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_AWUSER_31_11_4 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_ARB_CFG_0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_ARB_CFG_0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_ARB_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_19 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_ARB_MST_AVAIL_CRED_24 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_ARB_MST_AVAIL_CRED_24 & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_AVAIL_CRED_31 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & ~0xFFF) +
+			PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_ARB_MST_CHOISE_PUSH_OFST_23 & PROT_BITS_OFFS)
+								>> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_ARB_MST_QUIET_PER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_SLV_CHOISE_WDT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MSG_MAX_INFLIGHT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MSG_AWUSER_31_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MSG_AWUSER_SEC_PROP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MSG_AWUSER_NON_SEC_PROP & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_ARB_STATE_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_ARB_STATE_STS & PROT_BITS_OFFS) >> 7)	<< 2;
+	mask = 1 << ((mmTPC7_QM_ARB_STATE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_CHOISE_FULLNESS_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MSG_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_SLV_CHOISE_Q_HEAD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_ERR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_ERR_MSG_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_ERR_STS_DRP & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_9 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_10 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_11 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_12 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_13 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_14 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_15 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_16 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_17 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_18 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_ARB_MST_CRED_STS_20 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_ARB_MST_CRED_STS_20 & PROT_BITS_OFFS)	>> 7)
+									<< 2;
+	mask = 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_20 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_21 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_22 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_23 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_24 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_25 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_26 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_27 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_28 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_29 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_30 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_ARB_MST_CRED_STS_31 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CGM_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CGM_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CGM_CFG1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_LOCAL_RANGE_BASE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_LOCAL_RANGE_BASE & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_LOCAL_RANGE_BASE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_LOCAL_RANGE_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CSMR_STRICT_PRIO_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_HBW_RD_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_LBW_WR_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_LBW_WR_RATE_LIM_CFG_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_HBW_RD_RATE_LIM_CFG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_AXCACHE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_IND_GW_APB_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_IND_GW_APB_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_IND_GW_APB_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_IND_GW_APB_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_GLBL_MEM_INIT_BUSY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_GLBL_MEM_INIT_BUSY & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC7_QM_GLBL_MEM_INIT_BUSY & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CFG_ROUND_CSR & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_ROUND_CSR & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CFG_ROUND_CSR & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CFG_PROT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_PROT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CFG_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_VFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_SFLAGS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_MSS_CONFIG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_INTR_CAUSE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TPC_INTR_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_WQ_CREDITS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_ARUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_ARUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_AWUSER_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_AWUSER_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_OPCODE_EXEC & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CFG_TSB_CFG_MAX_SIZE & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_TSB_CFG_MAX_SIZE & PROT_BITS_OFFS) >> 7)
+									<< 2;
+	mask = 1 << ((mmTPC7_CFG_TSB_CFG_MAX_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_TSB_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_WQ_INFLIGHT_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_WQ_LBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_WQ_HBW_TOTAL_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_IRQ_OCCOUPY_CNTR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	dev_dbg(hdev->dev, "Configure protection bits TCP finished\n");
+}
+
+/**
+ * gaudi_init_protection_bits - Initialize protection bits of specific registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * All protection bits are 1 by default, means not protected. Need to set to 0
+ * each bit that belongs to a protected register.
+ *
+ */
+static void gaudi_init_protection_bits(struct hl_device *hdev)
+{
+	/*
+	 * In each 4K block of registers, the last 128 bytes are protection
+	 * bits - total of 1024 bits, one for each register. Each bit is related
+	 * to a specific register, by the order of the registers.
+	 * So in order to calculate the bit that is related to a given register,
+	 * we need to calculate its word offset and then the exact bit inside
+	 * the word (which is 4 bytes).
+	 *
+	 * Register address:
+	 *
+	 * 31                 12 11           7   6             2  1      0
+	 * -----------------------------------------------------------------
+	 * |      Don't         |    word       |  bit location  |    0    |
+	 * |      care          |   offset      |  inside word   |         |
+	 * -----------------------------------------------------------------
+	 *
+	 * Bits 7-11 represents the word offset inside the 128 bytes.
+	 * Bits 2-6 represents the bit location inside the word.
+	 *
+	 * When a bit is cleared, it means the register it represents can only
+	 * be accessed by a secured entity. When the bit is set, any entity can
+	 * access the register.
+	 *
+	 * The last 4 bytes in the block of the PBs control the security of
+	 * the PBs themselves, so they always need to be configured to be
+	 * secured
+	 */
+
+	dev_dbg(hdev->dev, "Configure protection bits\n");
+
+	gaudi_pb_set_block(hdev, mmIF_E_PLL_BASE);
+	gaudi_pb_set_block(hdev, mmMESH_W_PLL_BASE);
+	gaudi_pb_set_block(hdev, mmSRAM_W_PLL_BASE);
+	gaudi_pb_set_block(hdev, mmMESH_E_PLL_BASE);
+	gaudi_pb_set_block(hdev, mmSRAM_E_PLL_BASE);
+
+	gaudi_init_dma_protection_bits(hdev);
+
+	gaudi_init_mme_protection_bits(hdev);
+
+	gaudi_init_tpc_protection_bits(hdev);
+
+	dev_dbg(hdev->dev, "Configure protection bits finished\n");
+}
+
+static void gaudi_init_range_registers_lbw(struct hl_device *hdev)
+{
+	u32 lbw_rng_start[GAUDI_NUMBER_OF_LBW_RANGES];
+	u32 lbw_rng_end[GAUDI_NUMBER_OF_LBW_RANGES];
+	int i, j;
+
+	lbw_rng_start[0]  = (0xFBFE0000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[0]    = (0xFBFFF000 & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[1]  = (0xFC0E8000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[1]    = (0xFC120000 & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[2]  = (0xFC1E8000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[2]    = (0xFC48FFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[3]  = (0xFC600000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[3]    = (0xFCC48FFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[4]  = (0xFCC4A000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[4]    = (0xFCCDFFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[5]  = (0xFCCE4000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[5]    = (0xFCD1FFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[6]  = (0xFCD24000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[6]    = (0xFCD5FFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[7]  = (0xFCD64000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[7]    = (0xFCD9FFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[8]  = (0xFCDA4000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[8]    = (0xFCDDFFFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[9]  = (0xFCDE4000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[9]    = (0xFCE05FFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[10]  = (0xFEC43000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[10]    = (0xFEC43FFF & 0x3FFFFFF) + 1;
+
+	lbw_rng_start[11] = (0xFE484000 & 0x3FFFFFF) - 1;
+	lbw_rng_end[11]   = (0xFE484FFF & 0x3FFFFFF) + 1;
+
+	for (i = 0 ; i < GAUDI_NUMBER_OF_RR_REGS ; i++) {
+		WREG32(gaudi_rr_lbw_hit_aw_regs[i],
+				(1 << GAUDI_NUMBER_OF_LBW_RANGES) - 1);
+		WREG32(gaudi_rr_lbw_hit_ar_regs[i],
+				(1 << GAUDI_NUMBER_OF_LBW_RANGES) - 1);
+	}
+
+	for (i = 0 ; i < GAUDI_NUMBER_OF_RR_REGS ; i++)
+		for (j = 0 ; j < GAUDI_NUMBER_OF_LBW_RANGES ; j++) {
+			WREG32(gaudi_rr_lbw_min_aw_regs[i] + (j << 2),
+							lbw_rng_start[j]);
+
+			WREG32(gaudi_rr_lbw_min_ar_regs[i] + (j << 2),
+							lbw_rng_start[j]);
+
+			WREG32(gaudi_rr_lbw_max_aw_regs[i] + (j << 2),
+							lbw_rng_end[j]);
+
+			WREG32(gaudi_rr_lbw_max_ar_regs[i] + (j << 2),
+							lbw_rng_end[j]);
+		}
+}
+
+static void gaudi_init_range_registers_hbw(struct hl_device *hdev)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
+	u32 dram_addr_lo = lower_32_bits(DRAM_PHYS_BASE);
+	u32 dram_addr_hi = upper_32_bits(DRAM_PHYS_BASE);
+
+	u32 sram_addr_lo = lower_32_bits(SRAM_BASE_ADDR);
+	u32 sram_addr_hi = upper_32_bits(SRAM_BASE_ADDR);
+
+	u32 scratch_addr_lo = lower_32_bits(PSOC_SCRATCHPAD_ADDR);
+	u32 scratch_addr_hi = upper_32_bits(PSOC_SCRATCHPAD_ADDR);
+
+	u32 pcie_fw_addr_lo = lower_32_bits(PCIE_FW_SRAM_ADDR);
+	u32 pcie_fw_addr_hi = upper_32_bits(PCIE_FW_SRAM_ADDR);
+
+	u32 spi_addr_lo = lower_32_bits(SPI_FLASH_BASE_ADDR);
+	u32 spi_addr_hi = upper_32_bits(SPI_FLASH_BASE_ADDR);
+
+	int i;
+
+	/* Configure HBW RR:
+	 * 1st range is the DRAM (first 512MB)
+	 * 2nd range is the 1st 128 bytes in SRAM (for tensor DMA). This area
+	 * is defined as read-only for user
+	 * 3rd range is the PSOC scratch-pad
+	 * 4th range is the PCIe F/W SRAM area
+	 * 5th range is the SPI FLASH area
+	 * 6th range is the host
+	 */
+
+	for (i = 0 ; i < GAUDI_NUMBER_OF_RR_REGS ; i++) {
+		WREG32(gaudi_rr_hbw_hit_aw_regs[i], 0x1F);
+		WREG32(gaudi_rr_hbw_hit_ar_regs[i], 0x1D);
+	}
+
+	for (i = 0 ; i < GAUDI_NUMBER_OF_RR_REGS ; i++) {
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i], dram_addr_lo);
+		WREG32(gaudi_rr_hbw_base_low_ar_regs[i], dram_addr_lo);
+
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i], dram_addr_hi);
+		WREG32(gaudi_rr_hbw_base_high_ar_regs[i], dram_addr_hi);
+
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i], 0xE0000000);
+		WREG32(gaudi_rr_hbw_mask_low_ar_regs[i], 0xE0000000);
+
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i], 0x3FFFF);
+		WREG32(gaudi_rr_hbw_mask_high_ar_regs[i], 0x3FFFF);
+
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i] + 4, sram_addr_lo);
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i] + 4, sram_addr_hi);
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i] + 4, 0xFFFFFF80);
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i] + 4, 0x3FFFF);
+
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i] + 8, scratch_addr_lo);
+		WREG32(gaudi_rr_hbw_base_low_ar_regs[i] + 8, scratch_addr_lo);
+
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i] + 8, scratch_addr_hi);
+		WREG32(gaudi_rr_hbw_base_high_ar_regs[i] + 8, scratch_addr_hi);
+
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i] + 8, 0xFFFF0000);
+		WREG32(gaudi_rr_hbw_mask_low_ar_regs[i] + 8, 0xFFFF0000);
+
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i] + 8, 0x3FFFF);
+		WREG32(gaudi_rr_hbw_mask_high_ar_regs[i] + 8, 0x3FFFF);
+
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i] + 12, pcie_fw_addr_lo);
+		WREG32(gaudi_rr_hbw_base_low_ar_regs[i] + 12, pcie_fw_addr_lo);
+
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i] + 12, pcie_fw_addr_hi);
+		WREG32(gaudi_rr_hbw_base_high_ar_regs[i] + 12, pcie_fw_addr_hi);
+
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i] + 12, 0xFFFF8000);
+		WREG32(gaudi_rr_hbw_mask_low_ar_regs[i] + 12, 0xFFFF8000);
+
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i] + 12, 0x3FFFF);
+		WREG32(gaudi_rr_hbw_mask_high_ar_regs[i] + 12, 0x3FFFF);
+
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i] + 16, spi_addr_lo);
+		WREG32(gaudi_rr_hbw_base_low_ar_regs[i] + 16, spi_addr_lo);
+
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i] + 16, spi_addr_hi);
+		WREG32(gaudi_rr_hbw_base_high_ar_regs[i] + 16, spi_addr_hi);
+
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i] + 16, 0xFE000000);
+		WREG32(gaudi_rr_hbw_mask_low_ar_regs[i] + 16, 0xFE000000);
+
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i] + 16, 0x3FFFF);
+		WREG32(gaudi_rr_hbw_mask_high_ar_regs[i] + 16, 0x3FFFF);
+
+		if (gaudi->hw_cap_initialized & HW_CAP_MMU)
+			continue;
+
+		/* Protect HOST */
+		WREG32(gaudi_rr_hbw_base_low_aw_regs[i] + 20, 0);
+		WREG32(gaudi_rr_hbw_base_low_ar_regs[i] + 20, 0);
+
+		WREG32(gaudi_rr_hbw_base_high_aw_regs[i] + 20, 0);
+		WREG32(gaudi_rr_hbw_base_high_ar_regs[i] + 20, 0);
+
+		WREG32(gaudi_rr_hbw_mask_low_aw_regs[i] + 20, 0);
+		WREG32(gaudi_rr_hbw_mask_low_ar_regs[i] + 20, 0);
+
+		WREG32(gaudi_rr_hbw_mask_high_aw_regs[i] + 20, 0xFFF80);
+		WREG32(gaudi_rr_hbw_mask_high_ar_regs[i] + 20, 0xFFF80);
+	}
+}
+
+/**
+ * gaudi_init_security - Initialize security model
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Initialize the security model of the device
+ * That includes range registers and protection bit per register
+ *
+ */
+void gaudi_init_security(struct hl_device *hdev)
+{
+	/* Due to H/W errata GAUDI0500, need to override default security
+	 * property configuration of MME SBAB and ACC to be non-privileged and
+	 * non-secured
+	 */
+	WREG32(mmMME0_SBAB_PROT, 0x2);
+	WREG32(mmMME0_ACC_PROT, 0x2);
+	WREG32(mmMME1_SBAB_PROT, 0x2);
+	WREG32(mmMME1_ACC_PROT, 0x2);
+	WREG32(mmMME2_SBAB_PROT, 0x2);
+	WREG32(mmMME2_ACC_PROT, 0x2);
+	WREG32(mmMME3_SBAB_PROT, 0x2);
+	WREG32(mmMME3_ACC_PROT, 0x2);
+
+	/* On RAZWI, 0 will be returned from RR and 0xBABA0BAD from PB */
+	WREG32(0xC01B28, 0x1);
+
+	gaudi_init_range_registers_lbw(hdev);
+
+	gaudi_init_range_registers_hbw(hdev);
+
+	gaudi_init_protection_bits(hdev);
+}
-- 
2.17.1


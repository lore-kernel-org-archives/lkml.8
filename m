Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB86C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84992074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKop8COr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFPGOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFPGNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC7CC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so19441598wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QzwpjUlStGFh9vQc8qqG1fW1x83wdzxqePQHAKluHfs=;
        b=YKop8COrLC3QBJhHb3LzsX6BbngMzMP4UXvwC5YpuLvt3tW09DefuruU1Kkc2+oOMk
         kbJZr7r0KcpGAyA3tx+fhwm5ppaMdof9EtvtE/OMWxhLaQzZco3ORiRro7mti16KK9yb
         D7dMN1TDNDZvEljyEchn+IAuSO6/tMpX0fAe3fNXNsoPLP+nqn/133j2yxR/kYrtnSt2
         a8V1KsbiVkGk1rwtV76gVZGG9cBeTyodqqUJRH0kccCrPjTnIhCTp5EgiXsMPytNtxG6
         VznSA+PADgVzB4lTw292KHalK4sdhWbooIdUBSNJYdwlHTsL+hUR9Icq5Bc3ka2iOutr
         HIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QzwpjUlStGFh9vQc8qqG1fW1x83wdzxqePQHAKluHfs=;
        b=rpy6yGjh+b0nC4ahBaKhFbdYF4HRdUcyEbrJTfeBMVY0/UvEflOLIiiyXggJCsPGNB
         Qcaoqtz2a08Kn1sbn6s9EKC1guC9KRm/aNbT4xTCFnyJnQtNZeZSTx2b2w8GVmwHIf4s
         y571TR/RPMp7QZ1T5rKLDVZk74v/RR/gAfj3Z1NGmbr5iK/3Dd9OwKlGw1W3Xo1A/mLO
         UoI5KK412Eev5y8oY0jVn9aUYfg2ajybGmfNmGIvI+12wNj7e5tISmUAC0qNffeSPAxl
         LqIKJ4aNCkH9bLylgP6YiSD06Sht9fCc7djCKCjJtdEzVCSJ9aaPnMm2sZgrQw5V/3bw
         hBlQ==
X-Gm-Message-State: AOAM530Psw98hG7zoAextslN04FrcOb/OVgD/t9cL21XBjUpjkVSd8RP
        nAYUnNRW51Xhl9EnqUoKDDIz192BK08=
X-Google-Smtp-Source: ABdhPJzLHbPAOJG10FLI30D96d3W/rgLvQxGAY0iytHxAdaE5wGf8j4+t30zkT0YNO7tKPmznSjZAA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr1271193wrw.203.1592288019977;
        Mon, 15 Jun 2020 23:13:39 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/7] habanalabs: Use mask instead of shift in sync stream registers
Date:   Tue, 16 Jun 2020 09:13:24 +0300
Message-Id: <20200616061327.12006-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Use proper bitfield masks instead of shifting values when configuring
packets sent to device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 70 ++++++++++---------
 .../habanalabs/include/gaudi/gaudi_packets.h  |  4 +-
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9ce032466243..1ac7eb2498ef 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -21,6 +21,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iommu.h>
 #include <linux/seq_file.h>
+#include <linux/bitfield.h>
 
 /*
  * Gaudi security scheme:
@@ -6289,16 +6290,17 @@ static void gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id)
 	pkt = (struct packet_msg_short *) (uintptr_t) cb->kernel_address;
 	memset(pkt, 0, sizeof(*pkt));
 
-	value = 1 << GAUDI_PKT_SHORT_VAL_SOB_SYNC_VAL_SHIFT; /* inc by 1 */
-	value |= 1 << GAUDI_PKT_SHORT_VAL_SOB_MOD_SHIFT; /* add mode */
+	/* Inc by 1, Mode ADD */
+	value = FIELD_PREP(GAUDI_PKT_SHORT_VAL_SOB_SYNC_VAL_MASK, 1);
+	value |= FIELD_PREP(GAUDI_PKT_SHORT_VAL_SOB_MOD_MASK, 1);
 
-	ctl = (sob_id * 4) << GAUDI_PKT_SHORT_CTL_ADDR_SHIFT; /* SOB id */
-	ctl |= 0 << GAUDI_PKT_SHORT_CTL_OP_SHIFT; /* write the value */
-	ctl |= 3 << GAUDI_PKT_SHORT_CTL_BASE_SHIFT; /* W_S SOB base */
-	ctl |= PACKET_MSG_SHORT << GAUDI_PKT_SHORT_CTL_OPCODE_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_EB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_RB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_MB_SHIFT;
+	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, sob_id * 4);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OP_MASK, 0); /* write the value */
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 3); /* W_S SOB base */
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -6311,12 +6313,12 @@ static u32 gaudi_add_mon_msg_short(struct packet_msg_short *pkt, u32 value,
 
 	memset(pkt, 0, pkt_size);
 
-	ctl = addr << GAUDI_PKT_SHORT_CTL_ADDR_SHIFT;
-	ctl |= 2 << GAUDI_PKT_SHORT_CTL_BASE_SHIFT; /* W_S MON base */
-	ctl |= PACKET_MSG_SHORT << GAUDI_PKT_SHORT_CTL_OPCODE_SHIFT;
-	ctl |= 0 << GAUDI_PKT_SHORT_CTL_EB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_RB_SHIFT;
-	ctl |= 0 << GAUDI_PKT_SHORT_CTL_MB_SHIFT; /* only last pkt needs MB */
+	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, addr);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 2);  /* W_S MON base */
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 0); /* last pkt MB */
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -6332,18 +6334,19 @@ static u32 gaudi_add_arm_monitor_pkt(struct packet_msg_short *pkt, u16 sob_id,
 
 	memset(pkt, 0, pkt_size);
 
-	value = (sob_id / 8) << GAUDI_PKT_SHORT_VAL_MON_SYNC_GID_SHIFT;
-	value |= sob_val << GAUDI_PKT_SHORT_VAL_MON_SYNC_VAL_SHIFT;
-	value |= 0 << GAUDI_PKT_SHORT_VAL_MON_MODE_SHIFT; /* GREATER_OR_EQUAL */
-	value |= mask << GAUDI_PKT_SHORT_VAL_MON_MASK_SHIFT;
+	value = FIELD_PREP(GAUDI_PKT_SHORT_VAL_MON_SYNC_GID_MASK, sob_id / 8);
+	value |= FIELD_PREP(GAUDI_PKT_SHORT_VAL_MON_SYNC_VAL_MASK, sob_val);
+	value |= FIELD_PREP(GAUDI_PKT_SHORT_VAL_MON_MODE_MASK,
+			0); /* GREATER OR EQUAL*/
+	value |= FIELD_PREP(GAUDI_PKT_SHORT_VAL_MON_MASK_MASK, mask);
 
-	ctl = addr << GAUDI_PKT_SHORT_CTL_ADDR_SHIFT;
-	ctl |= 0 << GAUDI_PKT_SHORT_CTL_OP_SHIFT; /* write the value */
-	ctl |= 2 << GAUDI_PKT_SHORT_CTL_BASE_SHIFT; /* W_S MON base */
-	ctl |= PACKET_MSG_SHORT << GAUDI_PKT_SHORT_CTL_OPCODE_SHIFT;
-	ctl |= 0 << GAUDI_PKT_SHORT_CTL_EB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_RB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_SHORT_CTL_MB_SHIFT;
+	ctl = FIELD_PREP(GAUDI_PKT_SHORT_CTL_ADDR_MASK, addr);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OP_MASK, 0); /* write the value */
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 2); /* W_S MON base */
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
 
 	pkt->value = cpu_to_le32(value);
 	pkt->ctl = cpu_to_le32(ctl);
@@ -6357,15 +6360,14 @@ static u32 gaudi_add_fence_pkt(struct packet_fence *pkt)
 
 	memset(pkt, 0, pkt_size);
 
-	cfg = 1 << GAUDI_PKT_FENCE_CFG_DEC_VAL_SHIFT;
-	cfg |= 1 << GAUDI_PKT_FENCE_CFG_TARGET_VAL_SHIFT;
-	cfg |= 2 << GAUDI_PKT_FENCE_CFG_ID_SHIFT;
+	cfg = FIELD_PREP(GAUDI_PKT_FENCE_CFG_DEC_VAL_MASK, 1);
+	cfg |= FIELD_PREP(GAUDI_PKT_FENCE_CFG_TARGET_VAL_MASK, 1);
+	cfg |= FIELD_PREP(GAUDI_PKT_FENCE_CFG_ID_MASK, 2);
 
-	ctl = 0 << GAUDI_PKT_FENCE_CTL_PRED_SHIFT;
-	ctl |= PACKET_FENCE << GAUDI_PKT_FENCE_CTL_OPCODE_SHIFT;
-	ctl |= 0 << GAUDI_PKT_FENCE_CTL_EB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_FENCE_CTL_RB_SHIFT;
-	ctl |= 1 << GAUDI_PKT_FENCE_CTL_MB_SHIFT;
+	ctl = FIELD_PREP(GAUDI_PKT_FENCE_CTL_OPCODE_MASK, PACKET_FENCE);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 0);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
 
 	pkt->cfg = cpu_to_le32(cfg);
 	pkt->ctl = cpu_to_le32(ctl);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
index 9a5800b0086b..02d62bc53f7f 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
@@ -85,7 +85,7 @@ struct packet_msg_long {
 };
 
 #define GAUDI_PKT_SHORT_VAL_SOB_SYNC_VAL_SHIFT	0
-#define GAUDI_PKT_SHORT_VAL_SOB_SYNC_VAL_MASK	0x0000EFFF
+#define GAUDI_PKT_SHORT_VAL_SOB_SYNC_VAL_MASK	0x00007FFF
 
 #define GAUDI_PKT_SHORT_VAL_SOB_MOD_SHIFT	31
 #define GAUDI_PKT_SHORT_VAL_SOB_MOD_MASK	0x80000000
@@ -141,7 +141,7 @@ struct packet_msg_prot {
 #define GAUDI_PKT_FENCE_CFG_TARGET_VAL_MASK	0x00FF0000
 
 #define GAUDI_PKT_FENCE_CFG_ID_SHIFT		30
-#define GAUDI_PKT_FENCE_CFG_ID_MASK		0xC000000
+#define GAUDI_PKT_FENCE_CFG_ID_MASK		0xC0000000
 
 #define GAUDI_PKT_FENCE_CTL_PRED_SHIFT		0
 #define GAUDI_PKT_FENCE_CTL_PRED_MASK		0x0000001F
-- 
2.17.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8896C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F9620781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV7EuoIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHCL7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:59:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABCAC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:59:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so33392861wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7E6kNf/GoMf1QvODFmLt/+N8nb2EhZiIcfSmrao2/Wk=;
        b=ZV7EuoIxpI8grDOo2zv3rxFTMoDUgn9lPs+CePScWlq+xFzLu8BKmOO/gnsAzvwtrG
         esKX/BUs2N2VLqAb3GAScNqiooJFX4ID1ygZTJd9ez9sKeSvUxa7lRUYCSmC0rAqHxBn
         gPBIWpk/0yMqtwLcNSN6iLbFa9rGKvzU6ID6Y7yyd/jXJjvMHlByJOAHYD2Wr2X8Aypx
         jXfarZSbiPwU2MlYqI6kqexyUA1xE9zpUrgsFZv82iJrLji4W5hUbbl7URUJCKWkMUOd
         u1TXPS7+AMCR54RvaxKkYJsq9d8FTuCAgfaGxUP2G+Skgx3UhMo7nHG/uNkG9H81WoFg
         4ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7E6kNf/GoMf1QvODFmLt/+N8nb2EhZiIcfSmrao2/Wk=;
        b=BkORDL/kMrjgwyo+UaJmkP+xA9/0oWeI0JWA90xfolK4yo6NcormGJDDCxnLV4Y4E+
         P6aHJWDcqfUbFRjkmpS45hBVlkB9EM0FG86ZHqXA4OCmYmgUP4kuGLGmibL9mjP736m7
         OJPo4TklKG/5Z35kI9pGpR+Dq+RsJGodbyBadFo0OHgmHizXvSyXy/jCDMNTe1iMXB5c
         tX2ED6WU93R27XBFJNDjF7PH7Ys5mGqvDe5HRehbr996hauxcjJDEm+OVVutT6M5cOZo
         Wvj3cy/EYSQIwNP7WzLbHrPYKCAbkrOQJpMceycAJSdeMr4m2sPg4JJAIe7XMxPj5FDE
         /1yg==
X-Gm-Message-State: AOAM533f8ne0jAfW3RKfQ9wFV9X2/hPn7dnlFwkBroZkZuwk86Nm8Lzn
        DkQJ1Urjw96KOu9FKuEtjGIGh7p4
X-Google-Smtp-Source: ABdhPJwJhz9vo6Ic/bWLopIeaSCOXAkcqaT+L0Xlm8ThYW8CHby3wDNtRSNOQfAXbJi7iKbyQ97tuw==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr15166884wrq.117.1596455970414;
        Mon, 03 Aug 2020 04:59:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id j24sm26693444wrb.49.2020.08.03.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:59:29 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs: validate packet id during CB parse
Date:   Mon,  3 Aug 2020 14:59:25 +0300
Message-Id: <20200803115925.4908-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803115925.4908-1-oded.gabbay@gmail.com>
References: <20200803115925.4908-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

During command buffer parsing, driver extracts packet id
from user buffer. Driver must validate this packet id, since it is
being used in order to extract information from internal structures.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 35 +++++++++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c   | 31 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 00a0a7238d81..9ed4989b6fd4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -154,6 +154,29 @@ static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_LOAD_AND_EXE]	= sizeof(struct packet_load_and_exe)
 };
 
+static inline bool validate_packet_id(enum packet_id id)
+{
+	switch (id) {
+	case PACKET_WREG_32:
+	case PACKET_WREG_BULK:
+	case PACKET_MSG_LONG:
+	case PACKET_MSG_SHORT:
+	case PACKET_CP_DMA:
+	case PACKET_REPEAT:
+	case PACKET_MSG_PROT:
+	case PACKET_FENCE:
+	case PACKET_LIN_DMA:
+	case PACKET_NOP:
+	case PACKET_STOP:
+	case PACKET_ARB_POINT:
+	case PACKET_WAIT:
+	case PACKET_LOAD_AND_EXE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const char * const
 gaudi_tpc_interrupts_cause[GAUDI_NUM_OF_TPC_INTR_CAUSE] = {
 	"tpc_address_exceed_slm",
@@ -3772,6 +3795,12 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = gaudi_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
@@ -3995,6 +4024,12 @@ static int gaudi_patch_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = gaudi_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 85030759b2af..33cd2ae653d2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -139,6 +139,25 @@ static u16 goya_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_STOP]		= sizeof(struct packet_stop)
 };
 
+static inline bool validate_packet_id(enum packet_id id)
+{
+	switch (id) {
+	case PACKET_WREG_32:
+	case PACKET_WREG_BULK:
+	case PACKET_MSG_LONG:
+	case PACKET_MSG_SHORT:
+	case PACKET_CP_DMA:
+	case PACKET_MSG_PROT:
+	case PACKET_FENCE:
+	case PACKET_LIN_DMA:
+	case PACKET_NOP:
+	case PACKET_STOP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
 	mmDMA_QM_0_GLBL_NON_SECURE_PROPS,
 	mmDMA_QM_1_GLBL_NON_SECURE_PROPS,
@@ -3455,6 +3474,12 @@ static int goya_validate_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = goya_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
@@ -3690,6 +3715,12 @@ static int goya_patch_cb(struct hl_device *hdev,
 				PACKET_HEADER_PACKET_ID_MASK) >>
 					PACKET_HEADER_PACKET_ID_SHIFT);
 
+		if (!validate_packet_id(pkt_id)) {
+			dev_err(hdev->dev, "Invalid packet id %u\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
 		pkt_size = goya_packet_sizes[pkt_id];
 		cb_parsed_length += pkt_size;
 		if (cb_parsed_length > parser->user_cb_size) {
-- 
2.17.1


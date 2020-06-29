Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D787C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B3B20780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eqm3Ws9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgF2VuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404377AbgF2Vt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:49:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B9C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so18756664iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6Es3pTicfd51NnmXVOTn4bo+Yv9sluHPfJcIe1Ma9M=;
        b=Eqm3Ws9n6dNnTj+CvwZCE1N6WSOlh2Uq/8yZUOhb743tdn2HgzOK8LffMjdaAgFprl
         2ZJ0pBIixzjLSSbsaca041j7ijEAE7sAApKKz5hqIJruMGibCRB+GgD4gnydcTuulug+
         6SRM+KU+ipQO1kzIdJdGVckJ4sj4H70e+dE/E+gnbaSaPC24rPLGlHU/U8nlcLlzWTtV
         IsiZhStwyC4QOdkT4eYAP0OsiC78ohuXyokass1krWLkwLZeDe/C3R64bJvE5OSmRMlI
         1UiiGESQTCUxfHT2huMP0S2VKQJ2vGxNyRNDW7hil4KayHgUWt87A3N5EmKAiLojmqqA
         As7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6Es3pTicfd51NnmXVOTn4bo+Yv9sluHPfJcIe1Ma9M=;
        b=Zwwa3izZVk1jVR2XdyVV5HeqFh9jPkOd8UboK5B3p7oZxjlDRXMP/TL7LF5bajjC2E
         8jBisJ/qxWLuLmhDLnG/NbU6nAYIPVmc63Eek4qyJ+yntfKBuPbDpF9/J3md3SyG79b1
         VQrV0OIpAL+Gi7AHhyJxIvmRIf1x/r0O7gi4o8dUhlbB/6nnvbZsjDGhZxeRWWncDhqk
         /JZGwspj99jKyrcwk+K6O/Ymao26zPhRLGGXtX+Xaezl68j4h6LiDahRgHEpbo/MYhGp
         o7uz4LU/kxPoUAIHMHrDRd3auo9Aqy6ZY+UubhPNwAvr/hI3jXC4kZ+jqx1HDWkqiLlB
         nryA==
X-Gm-Message-State: AOAM531IiXSwXu2FwuudL9dy7cOPsLXPiDUzEbbHacktgXcGz0LhWoQs
        drk591Z7zt3SXXOV5UyAI6hgzw==
X-Google-Smtp-Source: ABdhPJyVG6c+WeuLVJGtggJ9p3UEMQzjs9DFqGSO8FJ59ADo455POFzscfEslxqAAXgnusPBLYXooQ==
X-Received: by 2002:a02:844d:: with SMTP id l13mr20005309jah.105.1593467366214;
        Mon, 29 Jun 2020 14:49:26 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u10sm555500iow.38.2020.06.29.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:49:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: ipa: mode register is TX only
Date:   Mon, 29 Jun 2020 16:49:17 -0500
Message-Id: <20200629214919.1196017-4-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629214919.1196017-1-elder@linaro.org>
References: <20200629214919.1196017-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_MODE endpoint configuration register is only valid for TX
endpoints.  Rather than writing a zero to that register for RX
endpoints, avoid writing the register at all.

Add assertion comments communicating that TX endpoints are assumed
for the DEAGGR and SEQ endpoint configuration registers to be
consistent.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 0c2bec166066..ee8fc22c3abc 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -543,7 +543,9 @@ static void ipa_endpoint_init_mode(struct ipa_endpoint *endpoint)
 	u32 offset = IPA_REG_ENDP_INIT_MODE_N_OFFSET(endpoint->endpoint_id);
 	u32 val;
 
-	if (endpoint->toward_ipa && endpoint->data->dma_mode) {
+	/* assert(endpoint->toward_ipa); */
+
+	if (endpoint->data->dma_mode) {
 		enum ipa_endpoint_name name = endpoint->data->dma_endpoint;
 		u32 dma_endpoint_id;
 
@@ -554,7 +556,7 @@ static void ipa_endpoint_init_mode(struct ipa_endpoint *endpoint)
 	} else {
 		val = u32_encode_bits(IPA_BASIC, MODE_FMASK);
 	}
-	/* Other bitfields unspecified (and 0) */
+	/* All other bits unspecified (and 0) */
 
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
@@ -702,6 +704,8 @@ static void ipa_endpoint_init_deaggr(struct ipa_endpoint *endpoint)
 	u32 offset = IPA_REG_ENDP_INIT_DEAGGR_N_OFFSET(endpoint->endpoint_id);
 	u32 val = 0;
 
+	/* assert(endpoint->toward_ipa); */
+
 	/* DEAGGR_HDR_LEN is 0 */
 	/* PACKET_OFFSET_VALID is 0 */
 	/* PACKET_OFFSET_LOCATION is ignored (not valid) */
@@ -716,6 +720,8 @@ static void ipa_endpoint_init_seq(struct ipa_endpoint *endpoint)
 	u32 seq_type = endpoint->seq_type;
 	u32 val = 0;
 
+	/* assert(endpoint->toward_ipa); */
+
 	/* Sequencer type is made up of four nibbles */
 	val |= u32_encode_bits(seq_type & 0xf, HPS_SEQ_TYPE_FMASK);
 	val |= u32_encode_bits((seq_type >> 4) & 0xf, DPS_SEQ_TYPE_FMASK);
@@ -1303,6 +1309,7 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 		ipa_endpoint_init_aggr(endpoint);
 		ipa_endpoint_init_deaggr(endpoint);
 		ipa_endpoint_init_seq(endpoint);
+		ipa_endpoint_init_mode(endpoint);
 	} else {
 		if (endpoint->ipa->version == IPA_VERSION_3_5_1)
 			(void)ipa_endpoint_program_suspend(endpoint, false);
@@ -1312,7 +1319,6 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 	}
 	ipa_endpoint_init_cfg(endpoint);
 	ipa_endpoint_init_hdr(endpoint);
-	ipa_endpoint_init_mode(endpoint);
 	ipa_endpoint_status(endpoint);
 }
 
-- 
2.25.1


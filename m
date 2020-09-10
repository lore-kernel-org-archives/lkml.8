Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62332C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D0721D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vg/4pLcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIJSXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgIJSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C9C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so10122983eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2X3523c2xGexaMKBgtpqmDTM7GKAD6d7uDj7gHVSq4=;
        b=vg/4pLcPWigT31tmFeRgHp5urFFETxmFFjsmotRJ5jMM7cBpBrsBixL3WfpqTFoLic
         SZTOpTNtf9U/DAYf6m9969zh8Mgtdk6gF8Ulw/hrT3wgMoEcSq3YVL8+1Vw7gjqhY5rV
         6srd+LIvcIGNDqR8l99tkIVYFJIy06Dyc5V4gqlYwedKHrZ/AUo72MJNRgtfolwbFu+D
         Zl0pap0/ULg9fSbMdhh6rRq7Vd9tPR1dtHBSzocdXArwau3XdKEewmwFmIAD4SijjF9r
         bRxHHO9BbKg+bzIAJ3A4eZbKlDs+Na0g9/RTxwK69jzLx8uq3Eh40yi/zwYYjoqiCRW5
         JUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2X3523c2xGexaMKBgtpqmDTM7GKAD6d7uDj7gHVSq4=;
        b=QAnwfeT9EGEkWj63rxaYWS0ATkouCFmU8HUi+nUWrnFQSdXYrGjBQ3a2LeJGlHabTi
         RlWzA/cI+KY9YVCMo6b7Uh3qvp8BTcefXH38+ZKCyfTJ4NrtkweOyFVFbrU6icvZlQMu
         OtBepTQQgWacqGFOI3m7IqXAjZaLpKDXv5/J0D2Tgh4v5S2A9fmiXpbhiYeQLOufPLQT
         tSie9F/wWZztaxNYhLxykm8kwmsuo4+MO7WxAqoAbk1qLAqejV49ckalF1TH8amiyyfh
         6BwEPl21zlVG5a6Iik0ZA7W/bF3bEKEt81IEo99ySZQPY9MrOKnUiN/IEZOrk8nA2JqK
         LsIA==
X-Gm-Message-State: AOAM532aP+0eLYaKPBqJj7Xj73JKCmUPdpE5SeRhdmyyNJy+LzEq9EE1
        xqyzOZWVxuzXdAxzuntmqyDVqeZH/9I=
X-Google-Smtp-Source: ABdhPJyJ2TcVyvP/54jCt/oSmr7B2cEp0ZjS46TIn6eYlz0DKURc16cGSuR2GOO5Bv2uy6ZBz579GQ==
X-Received: by 2002:a17:906:4bd7:: with SMTP id x23mr9925346ejv.92.1599761751147;
        Thu, 10 Sep 2020 11:15:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:49 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 11/11] habanalabs: update firmware interface file
Date:   Thu, 10 Sep 2020 21:15:24 +0300
Message-Id: <20200910181524.21460-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new packet to fetch PLL information from firmware. This will be needed
in the future when the driver won't be able to access the PLL registers
directly

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/include/common/cpucp_if.h | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index dcde440427b4..2a5c9cb3d505 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -213,6 +213,12 @@ enum pq_init_status {
  *       Trigger the reset_history property of a specified current sensor.
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
+ *
+ * CPUCP_PACKET_PLL_REG_GET
+ *       Fetch register of PLL from the required PLL IP.
+ *       The packet's arguments specify the PLL IP and the register to get.
+ *       Each register is 32-bit value which is returned in result field.
+ *
  */
 
 enum cpucp_packet_id {
@@ -245,6 +251,7 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_PCIE_THROUGHPUT_GET,		/* internal */
 	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,		/* internal */
 	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
+	CPUCP_PACKET_PLL_REG_GET,		/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -279,6 +286,11 @@ struct cpucp_packet {
 			__u8 pad; /* unused */
 		};
 
+		struct {/* For PLL register fetch */
+			__le16 pll_type;
+			__le16 pll_reg;
+		};
+
 		/* For any general request */
 		__le32 index;
 
@@ -354,6 +366,19 @@ enum cpucp_pcie_throughput_attributes {
 	cpucp_pcie_throughput_rx
 };
 
+enum cpucp_pll_reg_attributes {
+	cpucp_pll_nr_reg,
+	cpucp_pll_nf_reg,
+	cpucp_pll_od_reg,
+	cpucp_pll_div_factor_reg,
+	cpucp_pll_div_sel_reg
+};
+
+enum cpucp_pll_type_attributes {
+	cpucp_pll_cpu,
+	cpucp_pll_pci,
+};
+
 /* Event Queue Packets */
 
 struct eq_generic_event {
-- 
2.17.1


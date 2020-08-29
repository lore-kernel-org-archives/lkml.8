Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C92C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5003F2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls5hVNcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH2IEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2ID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:03:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A31C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 01:03:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i7so1168398wre.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsQt4f25Pw0VoUJQAo0LFQgcDr0azlBMVpWU3TjCzcc=;
        b=ls5hVNcQf2sxVhsuNKTW3VTKNPcLejHR9FLkRjXKzFPEIYPBY5Z04yb0RDO8dbXp8X
         vqyBFNoROH0m0tvFMUeFLmLZnsikx4yYa5+YhAoVIAkezpXf/OZuB0JckuHNB+B4x0Zq
         +wQuuxQsie7NU5PJMMtDIzfh6DMrmChVQgMvKpHsS83+1a8zjlX1yL+ukUlYNJjHxbX5
         katgXzi+rKjjmAYWWBdfObQ732Dqr6DWgSGkKdLAeQO0RxMq1Q8BzP22LG+jBGGxDVbl
         dlPDT8l2xiH/RNfASzbNZbfu0UQ5vZu3OHkBondo+3iIFBVBlgroG4vW7XvRTfJmfO6D
         +zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsQt4f25Pw0VoUJQAo0LFQgcDr0azlBMVpWU3TjCzcc=;
        b=s6rWX+0/mVJyLCKzX3s70iDnd0PUuhCveWGe5wfgSvT5+AXzgpIySruSqBEhZnBJ+g
         epvreR7VJlmAnuY5Vz62WYqkcx9mvK1YKI6cxWH/dpJvaLNGxU58bqst1zqU2PtwIpZk
         dh22DBmcqkr3ClOLEaR+/rg0ta9BFfsGhzXSIYp2dvzm0gnhCgUK4yll0N0Y9Y81Th/+
         xt7z+aAoFBXdgwWzGSL4arIS0kRZ5fkVrO36EH/fPnqpvAuhlSJc6JgQfz0+UzeQirzY
         0KP5c0/Tw7lTwS+ZqgT+wA6exfGaawMnsjawOwckULqz1f665b/k2j+IE9Li/GzyXpeK
         qldQ==
X-Gm-Message-State: AOAM531LM2YYrkYKOILg1y7MEBFrw88dMf2um8lNuODtUUemafpjU5gK
        x2yh0285EWF24rxUwu4SwpDeHyo2xiw=
X-Google-Smtp-Source: ABdhPJzUxju0tn7BRpQaPBgj2EF0QzWCSBXT1PFKPOU0yLLMfEGMaS6URDjiuksd6CL8QRaQ9ACLWQ==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr2365220wrq.381.1598688233126;
        Sat, 29 Aug 2020 01:03:53 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id g15sm2632631wrx.66.2020.08.29.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:03:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs: fix report of RAZWI initiator coordinates
Date:   Sat, 29 Aug 2020 11:03:47 +0300
Message-Id: <20200829080347.26050-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080347.26050-1-oded.gabbay@gmail.com>
References: <20200829080347.26050-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

All initiator coordinates received upon an 'MMU page fault RAZWI
event' should be the routers coordinates, the only exception is the
DMA initiators for which the reported coordinates correspond to
their actual location.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../habanalabs/include/gaudi/gaudi_masks.h    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index 13ef6b2887fd..3510c42d24e3 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -378,15 +378,15 @@ enum axi_id {
 	((((y) & RAZWI_INITIATOR_Y_MASK) << RAZWI_INITIATOR_Y_SHIFT) | \
 		(((x) & RAZWI_INITIATOR_X_MASK) << RAZWI_INITIATOR_X_SHIFT))
 
-#define RAZWI_INITIATOR_ID_X_Y_TPC0_NIC0	RAZWI_INITIATOR_ID_X_Y(1, 0)
-#define RAZWI_INITIATOR_ID_X_Y_TPC1		RAZWI_INITIATOR_ID_X_Y(2, 0)
-#define RAZWI_INITIATOR_ID_X_Y_MME0_0		RAZWI_INITIATOR_ID_X_Y(3, 0)
-#define RAZWI_INITIATOR_ID_X_Y_MME0_1		RAZWI_INITIATOR_ID_X_Y(4, 0)
-#define RAZWI_INITIATOR_ID_X_Y_MME1_0		RAZWI_INITIATOR_ID_X_Y(5, 0)
-#define RAZWI_INITIATOR_ID_X_Y_MME1_1		RAZWI_INITIATOR_ID_X_Y(6, 0)
-#define RAZWI_INITIATOR_ID_X_Y_TPC2		RAZWI_INITIATOR_ID_X_Y(7, 0)
+#define RAZWI_INITIATOR_ID_X_Y_TPC0_NIC0	RAZWI_INITIATOR_ID_X_Y(1, 1)
+#define RAZWI_INITIATOR_ID_X_Y_TPC1		RAZWI_INITIATOR_ID_X_Y(2, 1)
+#define RAZWI_INITIATOR_ID_X_Y_MME0_0		RAZWI_INITIATOR_ID_X_Y(3, 1)
+#define RAZWI_INITIATOR_ID_X_Y_MME0_1		RAZWI_INITIATOR_ID_X_Y(4, 1)
+#define RAZWI_INITIATOR_ID_X_Y_MME1_0		RAZWI_INITIATOR_ID_X_Y(5, 1)
+#define RAZWI_INITIATOR_ID_X_Y_MME1_1		RAZWI_INITIATOR_ID_X_Y(6, 1)
+#define RAZWI_INITIATOR_ID_X_Y_TPC2		RAZWI_INITIATOR_ID_X_Y(7, 1)
 #define RAZWI_INITIATOR_ID_X_Y_TPC3_PCI_CPU_PSOC \
-						RAZWI_INITIATOR_ID_X_Y(8, 0)
+						RAZWI_INITIATOR_ID_X_Y(8, 1)
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_S_0	RAZWI_INITIATOR_ID_X_Y(0, 1)
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_S_0	RAZWI_INITIATOR_ID_X_Y(9, 1)
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_S_1	RAZWI_INITIATOR_ID_X_Y(0, 2)
@@ -395,14 +395,14 @@ enum axi_id {
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_0	RAZWI_INITIATOR_ID_X_Y(9, 3)
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_N_1	RAZWI_INITIATOR_ID_X_Y(0, 4)
 #define RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_1	RAZWI_INITIATOR_ID_X_Y(9, 4)
-#define RAZWI_INITIATOR_ID_X_Y_TPC4_NIC1_NIC2	RAZWI_INITIATOR_ID_X_Y(1, 5)
-#define RAZWI_INITIATOR_ID_X_Y_TPC5		RAZWI_INITIATOR_ID_X_Y(2, 5)
-#define RAZWI_INITIATOR_ID_X_Y_MME2_0		RAZWI_INITIATOR_ID_X_Y(3, 5)
-#define RAZWI_INITIATOR_ID_X_Y_MME2_1		RAZWI_INITIATOR_ID_X_Y(4, 5)
-#define RAZWI_INITIATOR_ID_X_Y_MME3_0		RAZWI_INITIATOR_ID_X_Y(5, 5)
-#define RAZWI_INITIATOR_ID_X_Y_MME3_1		RAZWI_INITIATOR_ID_X_Y(6, 5)
-#define RAZWI_INITIATOR_ID_X_Y_TPC6		RAZWI_INITIATOR_ID_X_Y(7, 5)
-#define RAZWI_INITIATOR_ID_X_Y_TPC7_NIC4_NIC5	RAZWI_INITIATOR_ID_X_Y(8, 5)
+#define RAZWI_INITIATOR_ID_X_Y_TPC4_NIC1_NIC2	RAZWI_INITIATOR_ID_X_Y(1, 6)
+#define RAZWI_INITIATOR_ID_X_Y_TPC5		RAZWI_INITIATOR_ID_X_Y(2, 6)
+#define RAZWI_INITIATOR_ID_X_Y_MME2_0		RAZWI_INITIATOR_ID_X_Y(3, 6)
+#define RAZWI_INITIATOR_ID_X_Y_MME2_1		RAZWI_INITIATOR_ID_X_Y(4, 6)
+#define RAZWI_INITIATOR_ID_X_Y_MME3_0		RAZWI_INITIATOR_ID_X_Y(5, 6)
+#define RAZWI_INITIATOR_ID_X_Y_MME3_1		RAZWI_INITIATOR_ID_X_Y(6, 6)
+#define RAZWI_INITIATOR_ID_X_Y_TPC6		RAZWI_INITIATOR_ID_X_Y(7, 6)
+#define RAZWI_INITIATOR_ID_X_Y_TPC7_NIC4_NIC5	RAZWI_INITIATOR_ID_X_Y(8, 6)
 
 #define PSOC_ETR_AXICTL_PROTCTRLBIT1_SHIFT                           1
 
-- 
2.17.1


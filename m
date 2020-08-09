Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD35206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz3p4+ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHILyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgHILxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:53:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE359C061A28
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:53:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so5649952wrm.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ranOmfKvA0UCx8cFpSE0Kczh9xYhwTPE7alzBhurSMc=;
        b=Pz3p4+ri+9QFchtoox5np/OE9p+5h+B/oWdXErN+OxPYB38bcVv4d3bLoP3qzCBSYM
         pc/Wt63C44L6eB24Zw/4FwmJSLi7w57Uu/b8xlMyEA5x0lb9FCPTp7eVCVTermrW09nr
         okkdNE8JoepI2epkr+7m6wYeeHnsh679cOoFqAT3TAiNJ+GviWacBPSI1OQkwwpg8/UW
         CcI3KuSt7Yq3vxRCrGl3rSVJVDML+2/cQsmD26iLQdygxJeEA/92dRQtNtxCdAj/Ieh1
         AsOgirTTIJPILouFr9xbzD6vj0MIgrZvO1IC7DbC0m1teUrl1RUV6VMAnkm0BezbVXcT
         priA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ranOmfKvA0UCx8cFpSE0Kczh9xYhwTPE7alzBhurSMc=;
        b=YIH514QaR+utSIn6is9vFsLeJMjWC/qNzZRjsppIUCHyKzJpC3iSOMTqRy0sGsjQOt
         skTqa4EMbNi/ePpYSMhreAfSn7RRUJZhpFm0UD53P9ASl3cDeVambxM7sDx/swfFgGm9
         jzLTLYg7I7NOIkSESiu44QL2ly59RJ2G8oc2NY6NMji8MyVloBikiGDO31WgaBHMAwY3
         w0JtYnUXR2060x5uSbiEXWii8lqaDpEwI2QTqKuVKhdkqti7SRpPRIR7H3fYg+DIHJcC
         xE4FlLm9A+m/qdEkm4xFLzvgoziJ2WvgbJhxABd6D9bXZgNvVzAKz3CU3EPF4U+XJza6
         YtTw==
X-Gm-Message-State: AOAM532ULE7M6LsFlZ1o25s2Afycnj1bb+7huh0OkJcIB7MoKGAsgwdu
        3XG2Hh0boj5kKMBPykd8qaq+Hbdn
X-Google-Smtp-Source: ABdhPJzvIKlq61lEN+2GfEstqMRvjjNG/uvvH81KEc2XvMkCGDgb5RFZDQNJbGaKHPZ/sfxx85Xt2w==
X-Received: by 2002:adf:ec08:: with SMTP id x8mr18432698wrn.235.1596974024326;
        Sun, 09 Aug 2020 04:53:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id f12sm17376932wmc.46.2020.08.09.04.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:53:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs: proper handling of alloc size in coresight
Date:   Sun,  9 Aug 2020 14:53:36 +0300
Message-Id: <20200809115337.23402-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200809115337.23402-1-oded.gabbay@gmail.com>
References: <20200809115337.23402-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Allocation size can go up to 64bit but truncated to 32bit,
we should make sure it is not truncated and validate no address
overflow.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h     | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c | 8 +++++++-
 drivers/misc/habanalabs/goya/goya_coresight.c   | 8 +++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 018d9d67e8e6..13c18f3d9a9b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1651,7 +1651,7 @@ struct hl_ioctl_desc {
  *
  * Return: true if the area is inside the valid range, false otherwise.
  */
-static inline bool hl_mem_area_inside_range(u64 address, u32 size,
+static inline bool hl_mem_area_inside_range(u64 address, u64 size,
 				u64 range_start_address, u64 range_end_address)
 {
 	u64 end_address = address + size;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 5673ee49819e..881531d4d9da 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -527,7 +527,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 }
 
 static bool gaudi_etr_validate_address(struct hl_device *hdev, u64 addr,
-					u32 size, bool *is_host)
+					u64 size, bool *is_host)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -539,6 +539,12 @@ static bool gaudi_etr_validate_address(struct hl_device *hdev, u64 addr,
 		return false;
 	}
 
+	if (addr > (addr + size)) {
+		dev_err(hdev->dev,
+			"ETR buffer size %llu overflow\n", size);
+		return false;
+	}
+
 	/* PMMU and HPMMU addresses are equal, check only one of them */
 	if ((gaudi->hw_cap_initialized & HW_CAP_MMU) &&
 		hl_mem_area_inside_range(addr, size,
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index b03912483de0..4027a6a334d7 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -362,11 +362,17 @@ static int goya_config_etf(struct hl_device *hdev,
 }
 
 static int goya_etr_validate_address(struct hl_device *hdev, u64 addr,
-		u32 size)
+		u64 size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 range_start, range_end;
 
+	if (addr > (addr + size)) {
+		dev_err(hdev->dev,
+			"ETR buffer size %llu overflow\n", size);
+		return false;
+	}
+
 	if (hdev->mmu_enable) {
 		range_start = prop->dmmu.start_addr;
 		range_end = prop->dmmu.end_addr;
-- 
2.17.1


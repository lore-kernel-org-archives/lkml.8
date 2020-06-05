Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9657C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95849206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUbf9r64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgFEUWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgFEUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:22:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB032C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:22:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so2544381wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uTMAaxncG+Me0xx+KCoU1ptabFLLTGeceHoPa9bDApo=;
        b=VUbf9r64iToIMgEegbDS0vWvfQ56a0ra9l+fmE4LWl17RkpbyYfvJRMRnwfCtj0KGA
         MtnssM4pJs5/skbUQ3XYyRQ7usJteJubtTi5prGACcPswHfsvYmMe/AiH6GKrryvpAqg
         bg8nZAraljSnLaE7SK10caET+CZ7UiVmxfOHa4yzff6YKHlOIQ9VFZ/0zSBkYbZbQ+VR
         0i4oVUVkqQivr1QnGnkiaNq7jb4MHOhS0te/hmT+vf/SNyFPfQhU7DfUvdfNHtxDWUGJ
         gH5bp49kujyl6tQMkeAU+E9kRTh0I/Y4QlRMwq8rzH4cEuY7S2gCkco9xlTMXoWLSJJt
         8O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uTMAaxncG+Me0xx+KCoU1ptabFLLTGeceHoPa9bDApo=;
        b=n+p4H3wvTiNVWJvdAdGvI07QvtZZ6drsfZ4yDy1KNgYGSuPBo9X3fYkOnJxb+OLs4B
         1gdH6utmeJ1NZiVawqZn+q8Xnh7gpn6M19QlaW5yQrBPPt1LMuuRvtOSl0Mo7AvC493S
         FyAKNXktIvvNJk/dmRTAhd8mcxW+rqBUZbq1btY9Z9yKE0lUAYmAZfZ0w3tp8d46YO97
         cFPsLUJA6dohg6cJdSs8dAJKS4utH1LkrcRWO/4B2SGWfF89sENXjuHZPKlbchd8iYHq
         PV/a43xvl33V2hkH69m2xlrIpRjzbugJTfbKmTCpCX9IsoH5Swp9J8Ksj8IseA/QiDdJ
         Wl3Q==
X-Gm-Message-State: AOAM532qdy9an4V4VeVuqBdGqkmZOWMZ7dXzngKgI4puAYUvU50g/HRL
        e7XCBkaIoG+/2DDW5m1vXVHDvIbU
X-Google-Smtp-Source: ABdhPJwnl2YmA+JRklXnIxSuQbiP1/Dt0sCvyx8Aj5PrHZSEKO6CmbREPkbAqnKWeUzH+ywKLRABCg==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr4439361wmi.165.1591388565321;
        Fri, 05 Jun 2020 13:22:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i10sm13160993wrw.51.2020.06.05.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:22:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/2] habanalabs: use PI in MMU cache invalidation
Date:   Sat,  6 Jun 2020 00:28:42 +0300
Message-Id: <20200605212842.18424-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605212842.18424-1-oded.gabbay@gmail.com>
References: <20200605212842.18424-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

The PS flow for MMU cache invalidation caused timeouts in stress tests.
Use PS + PI flow so no timeouts should happen whatsoever.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 8 ++++++++
 drivers/misc/habanalabs/gaudi/gaudiP.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f34ac8d35a14..211547d4f8a7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2725,6 +2725,12 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	WREG32(mmSTLB_HOP_CONFIGURATION,
 			hdev->mmu_huge_page_opt ? 0x30440 : 0x40440);
 
+	/*
+	 * The H/W expects the first PI after init to be 1. After wraparound
+	 * we'll write 0.
+	 */
+	gaudi->mmu_cache_inv_pi = 1;
+
 	gaudi->hw_cap_initialized |= HW_CAP_MMU;
 
 	return 0;
@@ -6017,6 +6023,8 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	mutex_lock(&hdev->mmu_cache_lock);
 
 	/* L0 & L1 invalidation */
+	WREG32(mmSTLB_INV_PS, 3);
+	WREG32(mmSTLB_CACHE_INV, gaudi->mmu_cache_inv_pi++);
 	WREG32(mmSTLB_INV_PS, 2);
 
 	rc = hl_poll_timeout(
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index a46530d375fa..41a8d9bff6bf 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -229,6 +229,8 @@ struct gaudi_internal_qman_info {
  * @multi_msi_mode: whether we are working in multi MSI single MSI mode.
  *                  Multi MSI is possible only with IOMMU enabled.
  * @ext_queue_idx: helper index for external queues initialization.
+ * @mmu_cache_inv_pi: PI for MMU cache invalidation flow. The H/W expects an
+ *                    8-bit value so use u8.
  */
 struct gaudi_device {
 	int (*armcp_info_get)(struct hl_device *hdev);
@@ -248,6 +250,7 @@ struct gaudi_device {
 	u32				hw_cap_initialized;
 	u8				multi_msi_mode;
 	u8				ext_queue_idx;
+	u8				mmu_cache_inv_pi;
 };
 
 void gaudi_init_security(struct hl_device *hdev);
-- 
2.17.1


Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1867C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC77205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVUfc64E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHOWDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgHOVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B6C0F26E8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:01:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so9982957wmk.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Byd6JX0u9CVtv0y1zEzjrWKsILPjQocwhfVDqHvQpP8=;
        b=RVUfc64EUrpOjS0uUeTj6CnoZaKgjhY9NRue/r+GIWwLxpaMr05j6TAHIRiyjnTGX7
         UbpcJsKG1QLGUzPBUG+YdAvLlEJMobaUe/Kmmq2AOU8lSBuGCqJdCuUnWWcP8DuBGKf2
         bH5LrNBJz/IFgFvkTyUPEtTzx1GhVBbHiv1bWjQ7D6mmyuEJwbQNUyJbBe4OCp9/DFag
         7wgSdzD3dZmzBzQw8Hdop39zn0CljLo1IS9VSSdazcq7tqnTCQDV6GhDVfFO30RGovqJ
         EMA3GXBGH8kTkcIcmQ0WlZrydWr2UpbWYvcJB7zlbiF7JE6b+DtYhME52O+ao10oo1xE
         gRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Byd6JX0u9CVtv0y1zEzjrWKsILPjQocwhfVDqHvQpP8=;
        b=hkNsYP40EtvNG5KowLSKL8XZTNKDbh5m7rqtlvD0YGTOTT/BgD/oiawtfGY+lOeD+F
         hFYs4dB7NycIiEIgZsKTQkIYNZycsW/pFf1tUQpmCQ4VOO3Qe7bpjAHNlNIkobWOaksF
         flqPAFBbRRzMqcGc072hlVfSb1ApynjNXiV4uLuxfX3nvtrSTwjyPezn9u0tRNNAJafG
         sDGIgeT9AESAtuSqDgupSbXWZnKcL5yI0gK7rjt9jLYX9w2mrsJJInBrwhBZClZ4tXV3
         Lu25YkkAhYehVBcxL5q8fpiLkhNDfpOE6ISlc6rnrc9jfjeeSW0MRqkpA18blju3USUq
         wf7Q==
X-Gm-Message-State: AOAM533DvAXCrQw1+wgSP3Q0PTfY206C6UnlhgUdiWL+SDJFq/cNY0Oi
        WFTeVouIHbE7UAgFwxjPBsKZ7Hu6ZqU=
X-Google-Smtp-Source: ABdhPJxvFWoKTIJTQ4+D7HIXsGygz+/zUrJnihc+8gD094by7boTdo6kCAo3SaCOlnhiG3x6WOh7fw==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr8201129wmc.117.1597514479589;
        Sat, 15 Aug 2020 11:01:19 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:01:18 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 9/9] habanalabs: extend busy engines mask to 64 bits
Date:   Sat, 15 Aug 2020 20:59:38 +0300
Message-Id: <20200815175938.16619-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

change busy engines bitmask to 64 bits in order to represent
more engines, needed for future ASIC support.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h       | 2 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c             | 2 +-
 drivers/misc/habanalabs/goya/goya.c               | 2 +-
 include/uapi/misc/habanalabs.h                    | 6 ++++++
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2decf7be3e08..dbf214421ae1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -754,7 +754,7 @@ struct hl_asic_funcs {
 	void (*set_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
-	bool (*is_device_idle)(struct hl_device *hdev, u32 *mask,
+	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask,
 				struct seq_file *s);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index fe6c5534d378..a94800014243 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -132,7 +132,7 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 		return -EINVAL;
 
 	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev,
-					&hw_idle.busy_engines_mask, NULL);
+					&hw_idle.busy_engines_mask_ext, NULL);
 
 	return copy_to_user(out, &hw_idle,
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3360c3c207a9..e56f95e6c741 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6041,7 +6041,7 @@ static int gaudi_armcp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static bool gaudi_is_device_idle(struct hl_device *hdev, u32 *mask,
+static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 					struct seq_file *s)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 77a5963a4d10..021cd26fb018 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5117,7 +5117,7 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
 	/* clock gating not supported in Goya */
 }
 
-static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
+static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 				struct seq_file *s)
 {
 	const char *fmt = "%-5d%-9s%#-14x%#-16x%#x\n";
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ca6dc1fc250e..693081728ef3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -319,6 +319,12 @@ struct hl_info_hw_idle {
 	 * Bits definition is according to `enum <chip>_enging_id'.
 	 */
 	__u32 busy_engines_mask;
+
+	/*
+	 * Extended Bitmask of busy engines.
+	 * Bits definition is according to `enum <chip>_enging_id'.
+	 */
+	__u64 busy_engines_mask_ext;
 };
 
 struct hl_info_device_status {
-- 
2.17.1


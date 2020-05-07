Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ADEC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D152073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROGrRGuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEGOh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgEGOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:37:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E546C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:37:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so6719048wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtbLV99k7TcIhG9ot/elTDrTvZyxlbX0LhoeRI3dMJQ=;
        b=ROGrRGuQbv1ezHkVZIx64NllWTBgL153FVe39Ip61c3DS2H58HlSW61e0cVlbqnGoR
         wsx0oheAGkitiEY9de3wdfVdrkTAfOjgqJcaPaq5qSa2KOwmhcf/Gd8CLavoqHBSZXVj
         5W+4/25YjkUIGcufTRFQxi3M6yX+BzoxXL52g9KcjZLkyb19GslPhTkIISF/X81jmi9v
         36ICtNRwEGVTquSuIyZn5oZnjucJLK4wUmlbUt2xxNYqyRyVLRcg4aFAIWPX/xADOPwZ
         3HSl9BBe2VeN/+rxN9a0HpSYYV3nudvx9r36QeA61BrWan2tKIaiSsSDVLWslNTDcc0v
         ggMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtbLV99k7TcIhG9ot/elTDrTvZyxlbX0LhoeRI3dMJQ=;
        b=VDI5tBWJVyAPr95dBIIffrxZGQuLWt6jZZs6Az8fwgaL0RRC06POrlryX2KDyG1aD9
         T0E3gwqBl/ipCtIvl/wVYKhsmIWY5Cx6ZNnWMTHmUvXERxkqVVPuMs0rNOI4vTpt4fVM
         P9ApRyFJSYdO5Xs/56sM1AFFDF6tdtKXIioey5D7m2b5o+SZid/6DdZYkPGJ0XUL52uE
         X3zqD8QChZtcbsfrvYaVFGbT4ERu/JbxG70U1XU5nyZbpxZvzc0cMkvaS3uUEsT8vcyo
         S96zQA34+UimnhYcTB4yORDfDAWq6mqt06No3CUfEth1ApHeRIU8i6/F3tojxUhxeSPw
         W8Yg==
X-Gm-Message-State: AGi0PuYfI3+ymMVk1IXOF2jiLdkjC7ODOtR4Kn0YJpoNl9KrOVcrkjGM
        D0jiosC0yJnRbbXk8m4iTzqfTCMj
X-Google-Smtp-Source: APiQypLvVynFDLP/3lRmrHqHdus/jAmNy9Zd3fOg/lsg+ZG1pWGxp2rc1ajQR0TvmCHb1dRZxka2yw==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr17105593wro.116.1588862229858;
        Thu, 07 May 2020 07:37:09 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm8808095wrw.63.2020.05.07.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:37:08 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/4] habanalabs: define ASIC-dependent interface for signal/wait
Date:   Thu,  7 May 2020 17:36:59 +0300
Message-Id: <20200507143701.32456-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507143701.32456-1-oded.gabbay@gmail.com>
References: <20200507143701.32456-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This feature requires handling h/w resources which are a bit different from
one ASIC to the other. Therefore, we need to define a set of interfaces the
ASIC code provides to the common code to signal, wait, reset sync object
and to reset and init a queue.

As this feature is not supported in Goya, provide an empty implementation
of those functions.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 43 ++++++++++++++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h | 15 ++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 70fe00264f4a..b3e2354aaca2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5137,6 +5137,42 @@ u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 	return cq_idx;
 }
 
+static void goya_ext_queue_init(struct hl_device *hdev, u32 q_idx)
+{
+
+}
+
+static void goya_ext_queue_reset(struct hl_device *hdev, u32 q_idx)
+{
+
+}
+
+static u32 goya_get_signal_cb_size(struct hl_device *hdev)
+{
+	return 0;
+}
+
+static u32 goya_get_wait_cb_size(struct hl_device *hdev)
+{
+	return 0;
+}
+
+static void goya_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id)
+{
+
+}
+
+static void goya_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
+			u16 sob_val, u16 mon_id, u32 q_idx)
+{
+
+}
+
+static void goya_reset_sob(struct hl_device *hdev, void *data)
+{
+
+}
+
 static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
 {
 	if (RREG32(mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_0) ==
@@ -5222,6 +5258,13 @@ static const struct hl_asic_funcs goya_funcs = {
 	.read_device_fw_version = goya_read_device_fw_version,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
+	.ext_queue_init = goya_ext_queue_init,
+	.ext_queue_reset = goya_ext_queue_reset,
+	.get_signal_cb_size = goya_get_signal_cb_size,
+	.get_wait_cb_size = goya_get_wait_cb_size,
+	.gen_signal_cb = goya_gen_signal_cb,
+	.gen_wait_cb = goya_gen_wait_cb,
+	.reset_sob = goya_reset_sob,
 	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
 	.get_device_time = goya_get_device_time
 };
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 7cd9a8d72451..dd93cd903f91 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -553,6 +553,13 @@ enum hl_pll_frequency {
  *                          contained in registers
  * @load_firmware_to_device: load the firmware to the device's memory
  * @load_boot_fit_to_device: load boot fit to device's memory
+ * @ext_queue_init: Initialize the given external queue.
+ * @ext_queue_reset: Reset the given external queue.
+ * @get_signal_cb_size: Get signal CB size.
+ * @get_wait_cb_size: Get wait CB size.
+ * @gen_signal_cb: Generate a signal CB.
+ * @gen_wait_cb: Generate a wait CB.
+ * @reset_sob: Reset a SOB.
  * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
  *                        firmware configuration
  * @get_device_time: Get the device time.
@@ -648,6 +655,14 @@ struct hl_asic_funcs {
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
+	void (*ext_queue_init)(struct hl_device *hdev, u32 hw_queue_id);
+	void (*ext_queue_reset)(struct hl_device *hdev, u32 hw_queue_id);
+	u32 (*get_signal_cb_size)(struct hl_device *hdev);
+	u32 (*get_wait_cb_size)(struct hl_device *hdev);
+	void (*gen_signal_cb)(struct hl_device *hdev, void *data, u16 sob_id);
+	void (*gen_wait_cb)(struct hl_device *hdev, void *data, u16 sob_id,
+				u16 sob_val, u16 mon_id, u32 q_idx);
+	void (*reset_sob)(struct hl_device *hdev, void *data);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
 };
-- 
2.17.1


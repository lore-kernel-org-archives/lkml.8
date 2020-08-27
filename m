Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9D12177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cv41kRwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgH0JZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgH0JZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:25:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17841C061236
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y8so3317164wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGj1U+RHEgRBo72Z19HJA/GgC9Z8W3lKprGNOAt6O6Y=;
        b=cv41kRwcoHdV3sWpRs7mbvUjJRVliv/pz4A/l0BMxj2coUR0fsCcb99/qXgJ1rLRfc
         spDcdNghukbbUcGVCIS+FWZbMgLtoe3bfOjJMkgH/1X94cXUiqqBXYG6wx/sVf8SGs0G
         AxLPdokqciOf2YJguunK9y4a6EovAvpAIMJZVjL29IvjCICbsNngK10o37zVqvuXpDMh
         TCHocPyVEJn21Po4p9Yo3JJrtE8Mqe04O4P4vBZaSIUTpdsCOopVvwmGLlxNjkC9PiTP
         iGZWmJs1ecDRV4FV4+Pyr21lKPRZYOGvwAAsoAgxnuJ/VItPqBj1o1B6OIqqyntRoULi
         dhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGj1U+RHEgRBo72Z19HJA/GgC9Z8W3lKprGNOAt6O6Y=;
        b=GOHgNuVd59DhZhO6O5bXQURUn+iJpyMnUXpujR8D+4lwop1D6cNltuR+O0WLv9gV2a
         9jReSryeG0bQTvt3M1bmmseN8KT5oAk95bnyvBzsaHDHPBz3zeZMV+5YjJ+Hz60Wc7K5
         KO/WUL9tBcpSKEzuo0GTEmQ/tgPLpv+uLKMDcO3BEVuW7JFAs5fOqKn0f6bmiv5p9/YC
         hTKlzl3vwSrefNREmLI9YBsNO8aldRIIv3nVIYfRb52kacMSqdet53hy3j2pFAAa0sPT
         ol3FvaAoXlmqLAc5Kpk80axvHrUaYHnOigYcydlVaNq87L0BC6IkuwUF8Sf4IndsUb3T
         Wlpg==
X-Gm-Message-State: AOAM530KUj6Xi+8ZDwC/6HB5xMUlaZmYnIpeIKqFW6RsQ59iUU6M8jtI
        2U5xDH+I7pqPlqzU5W7rXDKXGw1+TRCOxhY2
X-Google-Smtp-Source: ABdhPJw2zK/hE/ZHif/IfxVKntH0dfkmFqbVbtqhH2TIXKyoVR3Cs0kqEMJ/xYzP3kFX7ZE0+heEtQ==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr10386181wmj.112.1598520314503;
        Thu, 27 Aug 2020 02:25:14 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id z203sm4357330wmc.31.2020.08.27.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:25:14 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 09/13] venus: hfi_plat: Add hfi platform buffers ops
Date:   Thu, 27 Aug 2020 12:24:13 +0300
Message-Id: <20200827092417.16040-10-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
References: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Venus v6 and beyond the buffer size and count have to be
calculated in the v4l2 driver instead of getting them from
firmware.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/platform/qcom/venus/hfi_plat_bufs.h | 35 +++++++++++++++++++
 .../media/platform/qcom/venus/hfi_platform.h  |  3 ++
 2 files changed, 38 insertions(+)
 create mode 100644 drivers/media/platform/qcom/venus/hfi_plat_bufs.h

diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
new file mode 100644
index 000000000000..6dfecaf5b0bd
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __HFI_PLATFORM_BUFFERS_H__
+#define __HFI_PLATFORM_BUFFERS_H__
+
+#include <linux/types.h>
+#include "hfi_helper.h"
+
+struct hfi_plat_buffers_params {
+	u32 width;
+	u32 height;
+	u32 codec;
+	u32 hfi_color_fmt;
+	enum hfi_version version;
+	u32 num_vpp_pipes;
+	union {
+		struct {
+			u32 max_mbs_per_frame;
+			u32 buffer_size_limit;
+			bool is_secondary_output;
+			bool is_interlaced;
+		} dec;
+		struct {
+			u32 work_mode;
+			u32 rc_type;
+			u32 num_b_frames;
+			bool is_tenbit;
+		} enc;
+	};
+};
+
+#endif
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
index f5f019282eab..692152f2075d 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.h
+++ b/drivers/media/platform/qcom/venus/hfi_platform.h
@@ -10,6 +10,7 @@
 #include <linux/videodev2.h>
 
 #include "hfi.h"
+#include "hfi_plat_bufs.h"
 #include "hfi_helper.h"
 
 #define MAX_PLANES		4
@@ -49,6 +50,8 @@ struct hfi_platform {
 	void (*codecs)(u32 *enc_codecs, u32 *dec_codecs, u32 *count);
 	const struct hfi_plat_caps *(*capabilities)(unsigned int *entries);
 	u8 (*num_vpp_pipes)(void);
+	int (*bufreq)(struct hfi_plat_buffers_params *params, u32 session_type,
+		      u32 buftype, struct hfi_buffer_requirements *bufreq);
 };
 
 extern const struct hfi_platform hfi_plat_v4;
-- 
2.17.1


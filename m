Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A58C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425212075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4rwEj+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHXSmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:42:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6CEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:42:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t185so2198818pfd.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWycSi8/0OaxvdZxdOTDCmrk2sU9rNWY5PuqZqeV1sg=;
        b=r4rwEj+O6r+DxrTANoYOTdX6LhhgVZHiSCccBdDNrSo/wyXwo/qLbSGybpJlYchNd5
         4uOMmCRIPb7QG89OgxnkzeqEVvSF2yB5lmk/APS0miJQKs9fum30PA1zKedNQavescci
         xe5Nre1Am+p4ugxF3qjbckrlCuRi2P0G1Tlb3c1pPTB3Jb3P0Q78YwYpqGMP2vfc8y4t
         AvvzPQAPjg/i4PeS2hoYNW1/yea+iAvEmxVJ94Ut+BrYPvwyY18/m97KL01DRCIR3bem
         Dt6thI9Vb6rWe6np9yy9FsKsIF24vLoL4hlTvLYcX8T8+n2RIO6OJlhaT6QXcHNovGry
         OsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWycSi8/0OaxvdZxdOTDCmrk2sU9rNWY5PuqZqeV1sg=;
        b=eh7RE6wwHOmQHgw+nhM0Rztiltmz6Ewi3GRTOkCGN/iSDmM6CW6HMQjMqlO0v5WChH
         Y4UomiyyUkMzofALYEt6o7xFfcE3ktrzToJv964durATrgaDfwXWOrxKV2Gn9tYs9pGK
         B9T1dr9X9kUGwd0CI/CJoy5xtLhaDfZUUuoLxWcYwaNev5KfZ+5hBd0lZE69ulyZynA9
         HUPhz91cGVHS6FlXpDWKth5YSRzIunV/z5o5flocN0u76YZlZvA++26XgyJrPfe0YI/8
         0ynm9tWgYk1HHoTci9GDHZcuu0yVhvCEjnbc/tWQQMxIbufRwkiSeMzVhyfASUoyLqEM
         AWjw==
X-Gm-Message-State: AOAM533A5JEuXmNM4VjYK9KMOK4AfVrHHOF+ISAIWCsVYdJC6ApZ5BxY
        YXWZAmT3f69e0Rup9v6hzQM=
X-Google-Smtp-Source: ABdhPJy1K46vS/XLW2Rghqha2/afjikWJYTKXUJdYFsRFmeCGtgIpOYe82nrsWdZjXAh0X0rM2Gd/A==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr4620642plc.284.1598294530939;
        Mon, 24 Aug 2020 11:42:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id c15sm12191543pfo.115.2020.08.24.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:42:09 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Brian Masney <masneyb@onstation.org>,
        Eric Anholt <eric@anholt.net>, Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/20] iommu: add private interface for adreno-smmu
Date:   Mon, 24 Aug 2020 11:37:39 -0700
Message-Id: <20200824183825.1778810-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This interface will be used for drm/msm to coordinate with the
qcom_adreno_smmu_impl to enable/disable TTBR0 translation.

Once TTBR0 translation is enabled, the GPU's CP (Command Processor)
will directly switch TTBR0 pgtables (and do the necessary TLB inv)
synchronized to the GPU's operation.  But help from the SMMU driver
is needed to initially bootstrap TTBR0 translation, which cannot be
done from the GPU.

Since this is a very special case, a private interface is used to
avoid adding highly driver specific things to the public iommu
interface.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 include/linux/adreno-smmu-priv.h | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/linux/adreno-smmu-priv.h

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
new file mode 100644
index 000000000000..a889f28afb42
--- /dev/null
+++ b/include/linux/adreno-smmu-priv.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google, Inc
+ */
+
+#ifndef __ADRENO_SMMU_PRIV_H
+#define __ADRENO_SMMU_PRIV_H
+
+#include <linux/io-pgtable.h>
+
+/**
+ * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
+ *
+ * @cookie:        An opque token provided by adreno-smmu and passed
+ *                 back into the callbacks
+ * @get_ttbr1_cfg: Get the TTBR1 config for the GPUs context-bank
+ * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
+ *                 NULL config disables TTBR0 translation, otherwise
+ *                 TTBR0 translation is enabled with the specified cfg
+ *
+ * The GPU driver (drm/msm) and adreno-smmu work together for controlling
+ * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
+ * updating the SMMU for context switches, while on the other hand we do
+ * not want to duplicate all of the initial setup logic from arm-smmu.
+ *
+ * This private interface is used for the two drivers to coordinate.  The
+ * cookie and callback functions are populated when the GPU driver attaches
+ * it's domain.
+ */
+struct adreno_smmu_priv {
+    const void *cookie;
+    const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
+    int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
+};
+
+#endif /* __ADRENO_SMMU_PRIV_H */
\ No newline at end of file
-- 
2.26.2


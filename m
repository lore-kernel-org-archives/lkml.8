Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C59B21582
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InCwqcJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIAPdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgIAPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF6C061244;
        Tue,  1 Sep 2020 08:32:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so2241288ejt.13;
        Tue, 01 Sep 2020 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEPKP0AU97R+PVYnTVD02jf9E8X+9qMRm9ouiwdoWWA=;
        b=InCwqcJTR/4A4+EuZFsM5xaKx0nFq9NH/7wDwaCpNHNzYmfW1s67o66afdrgjeT+42
         3/IBsOzuQmvbcTIMqzeilMo8jynJopsDvJ04YORoFPrNoteMPeOR9CGnYRn5sTCTx/F8
         MExLqETfRiiBnfdt5p4S8Fw+UhsQjMtDLGVO+SktivIJKL0jgOtiulaSQfPNJxhuvalA
         YnMxjXkFrVLYsf7Q9rHbGANzrB4pQCOFOXTTolGhIm/OgJ1H1t2modzQdKwRXUsADB8L
         Wr95PT8IW7Kyqe+GrX2iD2azK1Ul6M6Ln7WgHWIYOkYGFRrhvMpSiRjMe9w0F1HwAjjO
         5qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEPKP0AU97R+PVYnTVD02jf9E8X+9qMRm9ouiwdoWWA=;
        b=kZZAjUtuN3hiPdfltUcr+jhnrz7c9rru5yMEq/CkI9aBm/ETez84EH3hV1B78K5P7L
         hNmGrJSHJ5IWuxDnUZQfaEPySWbcOwFUhahKgCeHLV/pbdTdosT0dhbnN1YfuCqO0dzc
         iPOvOI7WM/A19xKHKPCspaPpluPkBiUabwFLCWWVb06ZBUUNgVhy/7Dx7Ju8GP3kNUaA
         Pt0XvSw/Mp/rm2gKvnuDO9QKteP66lw5hvCUTUEIh76d8jMRMY8378JiysKz2wdaz8Fd
         BYHMvMGbdRy6TAA/Uez3CT9nV1OyhEST03ttXC1lJTpyHbNiA34oKyeRtqCxxOXza5yA
         k22g==
X-Gm-Message-State: AOAM5312YM/x/KVL6Su0HEVLMkmVlAUpCOSazQK4PIdtRtPsaThSHihn
        RPsOkzFPKcz36DsW5eZOFaE=
X-Google-Smtp-Source: ABdhPJx8pgbFxwX4+nQIkeKINcUC4+itTbYvBBHcPVcN6ZtaYmSEFVcT5J21t8xvkFqrlVQX3t3VOg==
X-Received: by 2002:a17:907:9c3:: with SMTP id bx3mr2005039ejc.164.1598974373583;
        Tue, 01 Sep 2020 08:32:53 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r23sm1371455edt.57.2020.09.01.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:32:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matias Zuniga <matias.nicolas.zc@gmail.com>
Subject: [PATCH] memory: tegra: Remove GPU from DRM IOMMU group
Date:   Tue,  1 Sep 2020 17:32:48 +0200
Message-Id: <20200901153248.1831263-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 63a613fdb16c ("memory: tegra: Add gr2d and gr3d to DRM IOMMU
group") added the GPU to the DRM IOMMU group, which doesn't make any
sense. This causes problems when Nouveau tries to attach to the SMMU
and causes it to fall back to using the DMA API.

Remove the GPU from the DRM groups to restore the old behaviour. The
GPU should always have its own IOMMU domain to make sure it can map
buffers into contiguous chunks (for big page support) without getting
in the way of mappings from the DRM group.

Fixes: 63a613fdb16c ("memory: tegra: Add gr2d and gr3d to DRM IOMMU group")
Reported-by: Matias Zuniga <matias.nicolas.zc@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra124.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 493b5dc3a4b3..0cede24479bf 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -957,7 +957,6 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 static const unsigned int tegra124_group_drm[] = {
 	TEGRA_SWGROUP_DC,
 	TEGRA_SWGROUP_DCB,
-	TEGRA_SWGROUP_GPU,
 	TEGRA_SWGROUP_VIC,
 };
 
-- 
2.28.0


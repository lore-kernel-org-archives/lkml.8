Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C817420702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQGVEx2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgGAMrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbgGAMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDCC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so23670523wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnLoeRbMIPawtLY45ADcQqoBmyPKvpQnROp2LZuEcEU=;
        b=eQGVEx2G9CgwJoaRiyytD3bAeayvmzMigNnaekh5vAFlUA245DSA0g6cw2hlGXXkTW
         TyXV6XLQMx3AoT3HoWGV2eQt8JGbxSJYRGy6qwhA2IgBrXDA/cdo4z/50HewPsSMFm+t
         JNWVg4jGv5mg5JOQlU238F13Xkb08XZScJTD9CM0tJUIW02s5q2Pa9EyJBJCNoOzGJiq
         loqHBKaYCEOPdf0wmPEJH9cCl3zy09Dj/BryXCfKdY6ysjjer/LebryJb+oYNAb90VPR
         6BCSlv5KNWiLYdSwH7TWohviN3hVdnIN4oyA3MgHfAW1epC7QosHmfSpUQCYffrkdL7P
         10LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnLoeRbMIPawtLY45ADcQqoBmyPKvpQnROp2LZuEcEU=;
        b=CaF4BdlgGaCgf/8a0MsKSWKyPtoORtjlIiwxyFN62UkJQr9A1ICgCfBituukM7arvv
         0dC8F6RZX71Shz5SdOD/CxEVaoP7XWUREugH5+KlfrTJzK3Z2b5IavlAxQ4VCcDm8y8R
         zGZm88ga5BjzhBH6przBkBluMEyT6IibgXmBOY76OA3YInyCQcpSE+mmm3QjLwm0rg2f
         dL/B509MYs+mM3u0tZmkk3Y+DUimIydK51FXU4Uhl2ALk5viGsUkdRLax30F/v3mpkPc
         F8M3TGamy31w6oyQUHFdCGeY/T8zQa1hIeoYL3M3Qas/WDLj+lDdrnJ2Dmvkn0yLeqtv
         CSqg==
X-Gm-Message-State: AOAM532AyETqxBOre8qfs7X7WnqiRJQhbh3FJyaKtTs0T/nTG/9BnsxL
        AWUW4wmRdL7EDrXwuQN+DczyzQ==
X-Google-Smtp-Source: ABdhPJx5ZJux5WyOu9icq74PEEkDq20mynj0osGwxVYFvb5SgcZMFB2L8zQjL3GioB4vEN4RkmzRwA==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr26837602wro.154.1593607644283;
        Wed, 01 Jul 2020 05:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 15/15] mmc: host: sdhci-iproc: Tell the compiler that ACPI functions may not be used
Date:   Wed,  1 Jul 2020 13:47:02 +0100
Message-Id: <20200701124702.908713-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.

Fixes the following W=1 kernel build warning:

 mmc/host/sdhci-iproc.c:297:36: warning: ‘sdhci_iproc_acpi_ids’ defined but not used [-Wunused-const-variable=]

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/sdhci-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 225603148d7de..9c7d130205edd 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -294,7 +294,7 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 
-static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
+static const struct acpi_device_id __maybe_unused sdhci_iproc_acpi_ids[] = {
 	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
 	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
 	{ /* sentinel */ }
-- 
2.25.1


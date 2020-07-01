Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3907720702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjiRPFC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgGAMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbgGAMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE028C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so23654998wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbNGlX0G5Ov7FT75iCw50EDu+qwZ/8J7t3LRBNdlSbA=;
        b=PjiRPFC2+ne1JlGgsc0KpJefm6lvkyRsu+EM+8TXu7yFTsA+q9615YF7ZDoGByGVaA
         QzIJ0Ny5ocQIQXGLjETMjLTXZkb0S0RYf8k4sh/YGGanFkW1YH7EXKpJ4wCv3GyyvwNp
         XUZBH+7325vbu6YVK2DFMOYYKnRpozd4ENmvm8mBXAsd/18hWr5L+b/wmMtI/EfBHx0C
         WK4UMad91alCJ1Eu6G47jzTP96yrOF93Z7YUPcBkS49rzZ4sybvwiHpB8j/7ulafXijB
         SfEcPSCU1uRCLW8yJj6ouzi6dHUy3dXkwlrEUs3oeOmnnu2UgjKGe6FRs/JWurPC4fNo
         T4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbNGlX0G5Ov7FT75iCw50EDu+qwZ/8J7t3LRBNdlSbA=;
        b=J6K3nRqWdxNqjJQzPQmqDcewbAUoxgkV9evteXDihensgInjgbIfnEWgZTj4giDDm5
         AuLnTnrCpCd94gSvf6kyLCC1CKTV8QPvqn2rYS+9WLY1P24J8+GO+DaX0JAsiDAbDpyn
         cvpr19L9NJi9gEwfiNdBhGUY9IFE81IIjZu7qIm/z684FLju7Sg1HCbeCn6AmVw+Q0Ug
         V2TD803bAoq7nzAGpuQmrRANJ5szpw99tsaPs/nJCLYyeWBdnL9UwQFpeLAUbE5MTMWp
         iwiWOI5b118Cav7dnEVwlgit2rK5i/TTquOvD6rO6fSZV3zuIiBOwxi5LNqpxnWJsmt/
         pDng==
X-Gm-Message-State: AOAM533VfMAE7VSI6hw3T3hH9Sw+9MG0HZs1xpqit410v5vAktHQyTU1
        3NpXacCvBn7Dt8jNR+zYbgDbqQ==
X-Google-Smtp-Source: ABdhPJyR/yX50DpfFq9R2u3R16L2+L4q61pYf7cMIGM739hqYmJOThTTybjRR20yzg25Z+WZLrDNYA==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr23624823wrs.306.1593607631728;
        Wed, 01 Jul 2020 05:47:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 04/15] mmc: host: sdhci-s3c: Provide documentation for missing struct properties
Date:   Wed,  1 Jul 2020 13:46:51 +0100
Message-Id: <20200701124702.908713-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe properties; ext_cd_irq, clk_rates and no_divider (x2).

Squashes the following W=1 kernel build warnings:

 drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'ext_cd_irq' not described in 'sdhci_s3c'
 drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'clk_rates' not described in 'sdhci_s3c'
 drivers/mmc/host/sdhci-s3c.c:126: warning: Function parameter or member 'no_divider' not described in 'sdhci_s3c'
 drivers/mmc/host/sdhci-s3c.c:139: warning: Function parameter or member 'no_divider' not described in 'sdhci_s3c_drv_data'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 64200c78e90dc..9194bb73e601b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -107,8 +107,11 @@
  * @ioarea: The resource created when we claimed the IO area.
  * @pdata: The platform data for this controller.
  * @cur_clk: The index of the current bus clock.
+ * @ext_cd_irq: External card detect interrupt.
  * @clk_io: The clock for the internal bus interface.
+ * @clk_rates: Clock frequencies.
  * @clk_bus: The clocks that are available for the SD/MMC bus clock.
+ * @no_divider: No or non-standard internal clock divider.
  */
 struct sdhci_s3c {
 	struct sdhci_host	*host;
@@ -128,6 +131,7 @@ struct sdhci_s3c {
 /**
  * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
  * @sdhci_quirks: sdhci host specific quirks.
+ * @no_divider: no or non-standard internal clock divider.
  *
  * Specifies platform specific configuration of sdhci controller.
  * Note: A structure for driver specific platform data is used for future
-- 
2.25.1


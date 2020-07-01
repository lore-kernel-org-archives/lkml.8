Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F754C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D58F20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ/om3la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgGAMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgGAMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E68C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so23680673wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hbNAtKSwUso7F6/Zo5X4haYX63XDsD/59rYslLWqBM=;
        b=HJ/om3laTlqrN4tbJ+hATe0qObMhqatwVBMmZnGQmvTJIYTLVQz8MxOl73Hvp4WjqF
         xqUHLf7YHf1hvrtoxKkTPx5vx4baewW61qxzhFuZVeIya9axCarl7l2dViHxrkwleodH
         dqRvX57EYA4mWlnOc3UXl84JE1fw1eqzsYGqhZglttgGNgeyeTENotbaLBbM3ZJAO6RO
         W6wL7H1TlNKqrdzCh8F+/x99y+cE9x8koVt002NOvQeOPt78Usfk5Y/7tdSB2HeTaHRe
         5DHEEFclRVMMEY0UmZNQW+FvRnf4tsOiigh1L7ZLqnBfpOrsVbnL6LlOLwWrq5rZCYS4
         IJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hbNAtKSwUso7F6/Zo5X4haYX63XDsD/59rYslLWqBM=;
        b=NBA993f8mkteJMd/w1eLzKuKoljPeD0Wh6B5LljeOuDPmrEobX1Rh9/EVRbQVdSSNu
         8xjBfMp4WmX8aqDjXntkpYqfqw72/+qxsFeQpr3Kyl5+15basqUlPFDQJqPWf/lpmMs3
         ZAKHCUT7CYN2R0AoZ7xpLIRJObuauR1pN/SsKBDmzpmZnuYEa/2pEcDHrbIf/H++JkBC
         +/OkarHe2FVI2oQkCie+P616KuLGhYyooal6XZosr8JNc1Gk9dSI+TpC+db4lMCstymJ
         pHRn5wW5E3uiExGB00WWBinaj2kd/xpxFqzRYOjnrOSQRPU3DWFBmi0Cin6C9LiZR32H
         LfIw==
X-Gm-Message-State: AOAM5319FSHZdyiDOhk20YriTRor952M55KpY5mJMcs4TR2pdjO89aer
        FTL3vLum8RSyx8cqu1QL57CJuA==
X-Google-Smtp-Source: ABdhPJxaxL/KUxiM37mz4pmYxkZ8JcArmoV2r74oObuQZwBjWSDWoMwdJUFYimiGE/2fmaa9tY0rNA==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr27094488wru.324.1593607640839;
        Wed, 01 Jul 2020 05:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 12/15] mmc: host: sdhci-msm: Staticify local function sdhci_msm_dump_vendor_regs()
Date:   Wed,  1 Jul 2020 13:46:59 +0100
Message-Id: <20200701124702.908713-13-lee.jones@linaro.org>
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

sdhci_msm_dump_vendor_regs() is only used via the .dump_vendor_regs()
call-back.  It is never exported nor used externally, so it can be static.

Squashes the following W=1 kernel build warning:

 drivers/mmc/host/sdhci-msm.c:1887:6: warning: no previous prototype for ‘sdhci_msm_dump_vendor_regs’ [-Wmissing-prototypes]
 1887 | void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b277dd7fbdb5d..0c02f8a2d11ab 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1884,7 +1884,7 @@ static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
 #define SDHCI_MSM_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
-void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
+static void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-- 
2.25.1


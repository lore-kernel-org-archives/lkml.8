Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8597206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBJ4B47p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635738AbgDOIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635729AbgDOIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:16:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34CC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:16:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r7so2625021ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0qOETrZoEuB/v/v2DIKaf1AzjYUQKI4o/HWYtk5Q1I=;
        b=BBJ4B47pV461JB8hafdD1HSs9rFcq4u/CFI1vxC2XLf+nY9DxQMFZCO0wkA8fnwRzV
         z5EByMRPSpTtdRUAtlJVw/h/Veuw28jcYkYxdKA7e+qhX7RysmAnOB+Pbp2bt3qxX6oK
         KusrlgqE90QTNG5/FaUlh8qhzaZG/XVFCYE+7Y7ZPpwMUmRneVlBQDGvPIAOm/4MxaA0
         h4xwXWCkU2z8N1Bp2mKuTmugUO5q4BcMEHynKVTeNOBL8/9FYNqHYsntP548HpyRZ5sx
         cTQVxQLrF510PYD//23HZ4zPqP5UT1RohIHiwBj8iyugPb6xjWcaS4vbdQAfs7UPNS5C
         qOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0qOETrZoEuB/v/v2DIKaf1AzjYUQKI4o/HWYtk5Q1I=;
        b=YScgoVqS0kIuKw+7njLUnMd375Fggz5fRKHf3SJYg6gigydTmji90JbxBa8banpq60
         mGYEBKNGeaNr6O81oscSsUZ652Uu7uaQj3bpmk+e4Ju8a3qPLPc15ka3ORyZWj3Y4DcY
         fUdLnviX0MVbLqdI7Cvws6y48Wqs5I7k0Wdv/pzwnblowFLO1pGPpTbm81WLax35tZ4I
         M2MPHMOYK3daOCReg7oQGjb9ntSe/nCt6BLYelbOKOaecPBhLgzcnsDOyihG4kVsluTR
         D3vtwlMU788ZUbVucpwTJp7CtuELR8OZuQ12zXd9HLraNjjlCEdK6mQrCGGAqIx5EJ4x
         9B1Q==
X-Gm-Message-State: AGi0PuYuxzkUX8gqOy7HphkfLFwWBx0yscxrTceSkfFPLa+bdkgPZRuK
        9yvagPz/M1edQwanxbQsiYkUGw==
X-Google-Smtp-Source: APiQypKK2eFrxitYeiW5ZObqNZGRMQRvh8bM+g566NNhmNjDwnVsifl7LxVz7UJKIboEFl0ITTAVoQ==
X-Received: by 2002:a2e:914c:: with SMTP id q12mr2538316ljg.124.1586938575988;
        Wed, 15 Apr 2020 01:16:15 -0700 (PDT)
Received: from localhost (c-c33270d5.07-21-73746f28.bbcust.telenor.se. [213.112.50.195])
        by smtp.gmail.com with ESMTPSA id f21sm12066627lfk.94.2020.04.15.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 01:16:15 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] cpufreq: omap: Build driver by default for ARCH_OMAP2PLUS
Date:   Wed, 15 Apr 2020 10:15:59 +0200
Message-Id: <20200415081600.29904-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the mult_v7_defconfig, ARM_TI_CPUFREQ doesn't get enabled
evenwhen ARCH_OMAP(3|4) is selected. Build ARM_TI_CPUFREQ by default for
ARCH_OMAP2PLUS.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 15c1a1231516..9481292981f0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -317,6 +317,7 @@ config ARM_TEGRA186_CPUFREQ
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS
+	default ARCH_OMAP2PLUS
 	help
 	  This driver enables valid OPPs on the running platform based on
 	  values contained within the SoC in use. Enable this in order to
-- 
2.20.1


Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D784C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2564720738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xel1cwvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXSV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgHXSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:21:52 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA47C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:21:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w20so6375335iom.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjirmPfX4W9rT73jPThF+9JniX1tKDNgMG3YqTPfGnQ=;
        b=Xel1cwvSauFvptddlfCWFjPiT+nfKjtTlIw++H3xgXBm/8BlDlV/BI22VoNvMKSLRP
         N4p/p0RAziv1t0uzkiA/iVnY67oVae0zrG/8aiJBgCu7MPgYywo30f7J5Uld7P7mvCVs
         goYgjQHTwTHxbZPOz3AKNqmV+QwhRf6VNt0qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjirmPfX4W9rT73jPThF+9JniX1tKDNgMG3YqTPfGnQ=;
        b=QXgyl2FeMoSNg+TVHiMT97YeGmyneCkwLI7b7pbvzohnvBVPM1B4FkYJaBeSIOhfy5
         zvV/wVcspZFf4Aw+t2KUtZB0G8zyHOZ8Hvl/DaRkUBU+Tdg2mAifd/FyI9s/Rf6Mm+2f
         Wpqgq4gCtK+Nae9rGLIl5fIGMfQFf+/F/9U9Je2V9+dwDczeT93HaQ6HTXkq2mShG0mY
         QEsIYs55g8O4J6UIBbBHbiSRqqbrDuHC6AAjz9h2aOKlPAaU+Hj4eIj1ngaU3TEhzNCN
         uvHda6WyGqY6NBXxxtnVRqU+EufjIqjswBNn5aag+72bbHgr7I6Vz1THmCLbQyN4gUiL
         5ckg==
X-Gm-Message-State: AOAM5333sRhyGYpKQnd8cgz87mjQ+NV8AzTfWF4tpAC1FCxzdoGhbHQ9
        H5y2t8JBe1ha7ejb0nbEzRhLxQ==
X-Google-Smtp-Source: ABdhPJzjxsIBY+edXGA4/GBDOSm8NXcQcVVet4cTReIMCb1qJ2qFJd+u78d2mm6coFLEhAYEEcXRRA==
X-Received: by 2002:a05:6638:530:: with SMTP id j16mr6729905jar.55.1598293311632;
        Mon, 24 Aug 2020 11:21:51 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id a16sm7507469ilc.7.2020.08.24.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:21:51 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci: Don't enable presets while tuning
Date:   Mon, 24 Aug 2020 12:21:48 -0600
Message-Id: <20200824122131.v2.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
used for DDR52. The HS400 retuning sequence is:

    HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400

This means that when HS400 tuning happens, we transition through DDR52
for a very brief period. This causes presets to be enabled
unintentionally and stay enabled when transitioning back to HS200 or
HS400.

This patch prevents enabling presets while tuning is in progress.

Fixes: 0dafa60eb2506 ("mmc: sdhci: also get preset value and driver type for MMC_DDR52")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
The indentation changed because I ran clang-format

Changes in v2:
- Fixed commit message. Patman didn't properly strip off the TEST= line.

 drivers/mmc/host/sdhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b1158c1c0c9..fd702c436c165 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2360,12 +2360,13 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->timing = ios->timing;
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
-				((ios->timing == MMC_TIMING_UHS_SDR12) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
-				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
-				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
+		    !mmc_doing_retune(mmc) &&
+		    ((ios->timing == MMC_TIMING_UHS_SDR12) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR25) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR50) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR104) ||
+		     (ios->timing == MMC_TIMING_UHS_DDR50) ||
+		     (ios->timing == MMC_TIMING_MMC_DDR52))) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
-- 
2.28.0.297.g1956fa8f8d-goog


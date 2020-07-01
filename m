Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC5D20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvlv+tX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgGAMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgGAMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41AC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so1402933wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N515jYO+XViE4rxUKT5HCQLZtJJRT/LcfFcciYDmBeM=;
        b=hvlv+tX5KbtfpPHuAr/9nPcfbWbt2OM+cAiArO7rBU+Y2+hvUnLaSo0jEyJTSCNtqf
         /BDU4lYL9oLCcqTop/giUBCPoSMdBObVhCbOzDajIg7Xy6OW+ZanytcIK27fFPUGoSVU
         2HU2a9hqOlOZrJOszUR6SdV2AyaDNo6lSEkB+ew6DMnwFNMd/BNLqTiFAHq1aJUyK533
         vZApsJFvDH9s4cvNsik/dIsdQTNB9Xgck4l+CjFOQg+hSyhnw/3cQ4TbqOVFFZ9q5zuU
         Hx3f33mBeGd2YAWoPZsDHGAAQN8Ba5WzdLuFqKRs0IHGKbASYvKxZqTge82v1stAPd6T
         vuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N515jYO+XViE4rxUKT5HCQLZtJJRT/LcfFcciYDmBeM=;
        b=NmMe37MpYalPfVjEFuvuJhxcoqz3G/frUYCaLfZvImwXtFsaqbL1j8Nfj75HQXovck
         IzHj2WBZrblBDQ8YIejrFD4CidOhR58rUJefW3vWrPY9utNig6HNFDcxNvqhGSORuXyu
         HSkc2j54SabVLmy/O64Qjh+FXaF2Tt62rttT/07Q9R0BUdumsySkh9H+ycT5roMGs416
         qSf5yZR0MwMRknSOWUNPI/2It/PQhOf6/5rLZMMp5onGv1M7Ex4yAZGu+yQJGpjf9aFm
         /wA7SSjT8cfjfCyRVz+152F2sufp4Cuifjkr2Ex5ZuLWYQXM+dycuHsyKL0ldSXo6YOx
         iroQ==
X-Gm-Message-State: AOAM5339xqGC9PiRqTu+Tr18h+sdhSa0U2Vd4YYIdPaS+zYWdZoZjM+O
        BS5OqM/eHRTQhmyHE2BhMJlygw==
X-Google-Smtp-Source: ABdhPJzwL6sUJakVeaCCVt1EjUi0Pfn7s08Z72vAPl3BEm+TB/R6hwjCzAdHY66m8bbVha8qFfoZlg==
X-Received: by 2002:adf:8168:: with SMTP id 95mr27049461wrm.104.1593607637328;
        Wed, 01 Jul 2020 05:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wei WANG <wei_wang@realsil.com.cn>
Subject: [PATCH 09/15] mmc: host: rtsx_pci_sdmmc: Remove set but unused variable 'err'
Date:   Wed,  1 Jul 2020 13:46:56 +0100
Message-Id: <20200701124702.908713-10-lee.jones@linaro.org>
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

Seeing as sd_wait_data_idle() returns void and only a very specific
read value is checked, there doesn't seem to be a good reason to
check the return value of rtsx_pci_read_register().  So remove
the assignment and definition of 'err'.

Squashes the following W=1 kernel build warning:

 drivers/mmc/host/rtsx_pci_sdmmc.c: In function ‘sd_wait_data_idle’:
 drivers/mmc/host/rtsx_pci_sdmmc.c:678:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
 678 | int err, i;
 | ^~~

Cc: Wei WANG <wei_wang@realsil.com.cn>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 5a71f6678fd3a..dc0dbd64a2a78 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -675,11 +675,11 @@ static u8 sd_search_final_phase(struct realtek_pci_sdmmc *host, u32 phase_map)
 
 static void sd_wait_data_idle(struct realtek_pci_sdmmc *host)
 {
-	int err, i;
+	int i;
 	u8 val = 0;
 
 	for (i = 0; i < 100; i++) {
-		err = rtsx_pci_read_register(host->pcr, SD_DATA_STATE, &val);
+		rtsx_pci_read_register(host->pcr, SD_DATA_STATE, &val);
 		if (val & SD_DATA_IDLE)
 			return;
 
-- 
2.25.1


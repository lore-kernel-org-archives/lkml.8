Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C9520702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vmuk3iCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgGAMrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgGAMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E29C03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so10635248wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBwifa0ZuoxuR9zanjCi/SQC3HxVrP+0TUYJWPy9rp0=;
        b=Vmuk3iCY78/WlEtcAdEexKWZcshcQ4CAc2QtQlIooAG1Sjzo7f922rZ5uu3Btw42mG
         pof4skzNtKjDAQ2V7hlvDc8qTUDRiAuUwOspjGY68c8ASAmQJZzYuw1DqpPM8TI+tbYk
         GA04r/sV9cy1DJ0+stgXKyLbOfzThikzkPVRIvV6m9L9IDgbCUeUCf5TPNOjaSYqNQDt
         /gJn0pdOlKPAceJRAr9sgb4pG0FQSmGa7l9+UIMmmI63BXVj+eiObd+MyXCYC2uFsXEb
         eSkxfH1EoY2oa1tfhAac2VmwXB4gICM7NLjLUlvi4MHodiQa5hiCYFQ+KVUpjcjAR7OV
         YM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBwifa0ZuoxuR9zanjCi/SQC3HxVrP+0TUYJWPy9rp0=;
        b=HK69b2FQaniqnO+QcwNi7gs/u50BDdqv1BUoUra8H58kOpJfrKN/tLWkih+Mu0sff+
         oi6kOkrNOFh1EtmgymgxpI3HAQPeeaZ9eTVW/vBkSGUnNm3lPUJo3Du6pQkAzncFwSie
         IQaZnwhTOAvOFLhjZ5LNTx25nXxW+K0JNyd6WjZ8yDVkohpE+ceCYRudt+5wFrwTlFdx
         79tT98SGft+EBcJluEFlqrvi1eQ2YCXh/d/HOA5ejivrXF5L12y/8FHF/koyIieHcX1g
         JRy40QhfIYjCj9HgJ8JgyBhyHbLzrZV220Hvu0LhAlatO65AaJiNTNRnbtl11cKdzX4A
         ZMoA==
X-Gm-Message-State: AOAM531xE6Ix3qwEMO6zvwH7DuxEQ5sud2++HzRjVq1IqEOI7ko462AV
        xjKdGu1Oe2ZI6o6JeRQ9vn8vFw==
X-Google-Smtp-Source: ABdhPJyRlpTGWtkkPDEX2Kbq6J1uY8YesgkaBwFXFyeaq+IHUPNxOc1d79VYpEMGSjz+hU5Plde7oA==
X-Received: by 2002:a1c:f301:: with SMTP id q1mr26418165wmq.110.1593607638527;
        Wed, 01 Jul 2020 05:47:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Roger Tseng <rogerable@realtek.com>
Subject: [PATCH 10/15] mmc: host: rtsx_usb_sdmmc: Remove set but unused variable 'err'
Date:   Wed,  1 Jul 2020 13:46:57 +0100
Message-Id: <20200701124702.908713-11-lee.jones@linaro.org>
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

 drivers/mmc/host/rtsx_usb_sdmmc.c: In function ‘sd_wait_data_idle’:
 drivers/mmc/host/rtsx_usb_sdmmc.c:657:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
 657 | int err, i;
 | ^~~

Cc: Roger Tseng <rogerable@realtek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index a7084c50ad65f..7225d9312af8c 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -654,12 +654,11 @@ static u8 sd_search_final_phase(struct rtsx_usb_sdmmc *host, u32 phase_map)
 
 static void sd_wait_data_idle(struct rtsx_usb_sdmmc *host)
 {
-	int err, i;
+	int i;
 	u8 val = 0;
 
 	for (i = 0; i < 100; i++) {
-		err = rtsx_usb_ep0_read_register(host->ucr,
-				SD_DATA_STATE, &val);
+		rtsx_usb_ep0_read_register(host->ucr, SD_DATA_STATE, &val);
 		if (val & SD_DATA_IDLE)
 			return;
 
-- 
2.25.1


Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8038F20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjsfYuTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgESGCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgESGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:02:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:02:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so891614pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=phw+ielG3h+twIh3+qC+uo7yVbqWNCPg00mlIiD4UHs=;
        b=gjsfYuTu8PAT+FvT1/83g1h42fMsJePfLqLBnkLkj0T9JkS9Z69yuMASMs4XFZ6aRZ
         VWraKaQS4fXUFWkbCKKLA6S7cYa5ZFfhJd6dEaYOrB7uxth9GpaeNzO/kgJjmJINUED4
         4+FmCdDnz2NjHnGdMwG2WDHaKDwUgGMzSZmFaMsbnKItpGZonzv0c3FUFFlLN9FjTQ67
         CGYe7lcQv8yCKbdswXtcPL3FgUg6yZxr+d6OeVFVno5w9gTRNB2giB9hRyUuZrEqYedI
         bpPcPLTcAeDyFqDROev80HriN6ME9WGn8j9+JWEbHJZOpF8qOqbcC78EX+tyVmhJbDkv
         0LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=phw+ielG3h+twIh3+qC+uo7yVbqWNCPg00mlIiD4UHs=;
        b=kRE4qafvztJgET5zkGRvh/2SOvT7rDhMF5nzjLxqp47ah4gwi4iAvj3C7mb4dp9Rv8
         BIt20UgACWIcYlUJNV4Uzs8t6+Q1zyPT2pBr2QYGkEzfCl473FYoL5iCxkjUOrlqCwla
         +bWCE8gzpKOxFAmR9ii9MLGsOW0Y+nRAzZyOy/GrodSBFB7wPLqvLyYQ1qD8QVrTfafN
         rFCneEvFIRljhK4YQFprdaWRLHhOCrrM2xHeOXOtZLbT3kZlXd6vKRIXDwPITEgcSUGa
         cmmceXvd/qRj5pPsHHdFmmtr2kyvr7qDkNo/W9X6LwYfzPwOa4Oa9sKZucU/yTCa9q7R
         +/0Q==
X-Gm-Message-State: AOAM531LK6nTcdNKFBtaJIhz8XMKPvSEApyokVe79wz4Nl5lPbxJcvx7
        STfqMYrSvriXcL25HOn7KmWr6aDhB0Y=
X-Google-Smtp-Source: ABdhPJyzQ2VvmOCBqhr8snFJgOcvnVL3Uvm9uz3bv/va427vuT/JWSbCDVgucf/Vlf0BFjwLeZCOuQ==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr19440179plr.265.1589868137670;
        Mon, 18 May 2020 23:02:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id ce21sm1112650pjb.51.2020.05.18.23.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:02:17 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [RESEND][PATCH] sound: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
Date:   Tue, 19 May 2020 06:02:11 +0000
Message-Id: <20200519060211.83491-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CROS_EC isn't strictly required for audio to work
on other SDM845 platforms (like the Dragonboard 845c).

So lets remove the dependency and select the related
CROS_EC options if CROS_EC is already enabled.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index f51b28d1b94d..0434f2c7d746 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -99,12 +99,12 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
+	depends on QCOM_APR && I2C && SOUNDWIRE
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
-	select SND_SOC_CROS_EC_CODEC
+	select SND_SOC_CROS_EC_CODEC if CROS_EC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.17.1


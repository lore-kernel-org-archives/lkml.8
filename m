Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED67C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC4D206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQmypwTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFPGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPGeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:34:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6DC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:34:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so9027665pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=phw+ielG3h+twIh3+qC+uo7yVbqWNCPg00mlIiD4UHs=;
        b=vQmypwTz1N5KmBRHLqcs8qJQ06YTIDRJr7maPiBvnEkOWhJZPp0zfiqeL6HOEpqQNf
         1MJU4hciQzY2ovFdqGaxK8Fa/WqTYmMtL9BjmVzoZZNnugzjFkItw2zkqBKT62ano/sO
         oaCFtSuqV5ocWkJDIe0fNdo2lsPR6W3Y8+SoC00l/zqH5fcO7weVu5CtBH/FAq8p1tkr
         EvT1tw68stOx22zgily2gFfuLzXKHq1yx6w0onzrEiGDLjnNhldCrORr5aWea9Bq+Wzh
         IoIKUEgazeEDMHJDVFUbmDvQADRoFLKNetJ2/YIq9HA2Hiaeqhxp3Rq/ai0t3+m7eQFJ
         /LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=phw+ielG3h+twIh3+qC+uo7yVbqWNCPg00mlIiD4UHs=;
        b=jb8VJObMnbkrpUBhkpVE8BdaRWDv/LSqBwLnfJu3H3H9wEmgv07K+2/rdIgp0J8tD+
         ySvq7gVbJXtW4Lrn6YG9Lq1xbmfF7YspSOvWpgkX04T7bu6PnuKQ1lhaAhTakgEUtMdl
         t/NJYaWDGTQwliZBtJ1dKmPNCjgr/nMUmFm0HVmwbIfL5gJmtR4z1DPu5LPloIOkhYCa
         PTnfULKyyWgRLIdbKGhyuzv///i0mE0RxBqvv6shFJKm887wbYcHlfgQxJmYiCrLFPfl
         cCmxZR3LhJnGVlq+pdSJF/f92Z3ILPTHGSfX/vsmt1Lx6a9NqRVcUIA5BDELiTkYv28P
         BTSQ==
X-Gm-Message-State: AOAM532KwsqYrX5k4PO2Ya58/Y1l1bgnYVdznIeUQhazB9IS4xRhMVtB
        c7OKDJg/XL3MT2hNhRMUW/x320xdDQQ=
X-Google-Smtp-Source: ABdhPJwJBjn1wnHCWxLt8DOUjJGyDw0cq4C6RGxPSk5rHOAL1keX+nJqqTHahQfFmugYWCjhrUTPtQ==
X-Received: by 2002:a63:e804:: with SMTP id s4mr1010573pgh.260.1592289260811;
        Mon, 15 Jun 2020 23:34:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 140sm15669950pfy.95.2020.06.15.23.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:34:20 -0700 (PDT)
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
Subject: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
Date:   Tue, 16 Jun 2020 06:34:17 +0000
Message-Id: <20200616063417.110263-1-john.stultz@linaro.org>
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


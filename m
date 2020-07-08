Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB282067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xg5+rbjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGHHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgGHHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:53:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D198C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:53:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so20382338pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y55nygfLWId4LN/DVfidqEEz07PpT+kE/Of591U6tQ4=;
        b=Xg5+rbjB4NptqIoHOkzJD8CBC9CdjUtEiqL6VhBe9weMoDUPG2r3x3/raQHvb+DQfw
         z7VO288nlBCiFbODbJrcXUvNxl2qAwJp4QuldqLdXN6AMj9eMqdOkVyiYG/91TWuIuvC
         j2L0f69XENjZEe26MlLnqG0lemBcCDxqqFoXWxYq6Vcy5lINlm18YvOPVR8Di4PnIh3w
         DJQrNXwsbvEfzAHgFVkBFtkpJ6X2qFDCiaI7z4xK1T6JmywW7ZFzl2rjwFOH6RRVBDhl
         pvQSyELHn9KwzfgDJx0yo6LGJuLYdqg+du4ZiHgZ7nXmznz2YYghQY1oVwn3oMgzzGss
         IkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y55nygfLWId4LN/DVfidqEEz07PpT+kE/Of591U6tQ4=;
        b=XqrK8dkeMwa99E1JCDzJLDRlyEFBC91qweUXAI4b0X4luURSUxoWFo09s/4yKteJHx
         P6QJlrmkUmX5Otl08YWXLwcveORr77ZKI0IOXEaj+KGRGO+ssRPaRDm2pntQG/JslxK8
         LJqn5+WRf6c5AKIbbyGfCopq0oBI02C84Cwbqh4zHTeiJD5tyxKW/ZeOgW3injG021wz
         MAluPq9GaLZcOr/7Rf2xekOKOpv+4/RHyE3AfjxJ5c+8jBkE2k+BySvKSmBV1v9U+bc3
         aV2H1UUsE+TYz+DxRJnhBtPNWXzQMqVSa2mASuxeu7+rUCeUx/T51jZ8gw+fpZf5pUmX
         dbsQ==
X-Gm-Message-State: AOAM5303FkqHLRJbLeWywM4rcf7+7M9z8eUXBaoMY3Hh0MO1hZgoDhoj
        bqYh1lnG6A+zKPeEqLR4UMC6/bAB3to=
X-Google-Smtp-Source: ABdhPJwC7Vm1dEppffoA5E0fBMvPfXspEZc6nlyiGFReMPLoTylbUyWvT/PUDl6HviV+8iyvh8H8Gg==
X-Received: by 2002:a62:178e:: with SMTP id 136mr51909249pfx.180.1594194837422;
        Wed, 08 Jul 2020 00:53:57 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id m68sm4672626pje.24.2020.07.08.00.53.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:53:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     stable@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [For-STABLE] thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from power
Date:   Wed,  8 Jul 2020 13:23:43 +0530
Message-Id: <bc3978d0b7472c140e4d87f61138168a2a7b995c.1594194577.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

commit 371a3bc79c11b707d7a1b7a2c938dc3cc042fffb upstream.

The function cpu_power_to_freq is used to find a frequency and set the
cooling device to consume at most the power to be converted. For example,
if the power to be converted is 80mW, and the em table is as follow.
struct em_cap_state table[] = {
	/* KHz     mW */
	{ 1008000, 36, 0 },
	{ 1200000, 49, 0 },
	{ 1296000, 59, 0 },
	{ 1416000, 72, 0 },
	{ 1512000, 86, 0 },
};
The target frequency should be 1416000KHz, not 1512000KHz.

Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200619090825.32747-1-finley.xiao@rock-chips.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Greg,

I am resending this as I got your emails of this failing on 4.14, 4.19
and 5.4. This should be applied to all three of them.

@Finley: I hope I have done it correctly, please do check it as this
required me to rewrite the code to adapt to previous kernels.

 drivers/thermal/cpu_cooling.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 908a8014cf76..1f4387a5ceae 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -280,11 +280,11 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	int i;
 	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 
-	for (i = 1; i <= cpufreq_cdev->max_level; i++)
-		if (power > freq_table[i].power)
+	for (i = 0; i < cpufreq_cdev->max_level; i++)
+		if (power >= freq_table[i].power)
 			break;
 
-	return freq_table[i - 1].frequency;
+	return freq_table[i].frequency;
 }
 
 /**
-- 
2.25.0.rc1.19.g042ed3e048af


Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C463206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMGyaf2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbgFXPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404367AbgFXPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5142AC061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so2865544wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCGt1BLBXUDbnvT6cymu5MVAxH+kTuMsl5c+6aP/lLY=;
        b=jMGyaf2YOvnwdGALr7/G0emGXXMlzRVlYnFPWVRjaQMIqVwugRAnJc3hlq5hiW8h5c
         UlNYM5fXvpEjkCbgvKcR0hRU6Z7v6cS74QrqdBYQQwaf72KYCZRj32ckrnmu0aG5wzCh
         oQv/67iegU98VlySub1xjGVNx32ddSLk55uKDXkUIrvbzXltQVC60J2oVznaWMR03k3X
         c88NZ/cwdn2lcyWwoIaMvjTZKlgnZ3OueIPy8vYEViLHA8IFnXW05jOkLP4xaKWjAreX
         6dOPEbwj+fmCGzpLHvYH0loVrVQGULW0wojhwots1TLiid7Psoh58sITpdd5KWwWa8ll
         /faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCGt1BLBXUDbnvT6cymu5MVAxH+kTuMsl5c+6aP/lLY=;
        b=Ab23LcRAcrk/I1ghsL5Nkv54ke6OTO6xkTPr6fRvKHqm4qbDyMzXkoMGw3+cWayKl7
         L3919TtJ2ci6yjg9/zJNdQ0YD45VE258krky1sfoUkeBbJ3ygcWcAT8V9rsaofQLGMMo
         9AAT+hDUMPc4j3GQcNuyX7gLIrql/UsHbfVxgRQRf1ojBza5dyuzdoq5HMurL8gNBZFL
         fx0zBPhrqsVOT9KyAmpQKQ4Td/ef3oFHgw9AfjhiKH0x6uH3sgxFCek8KnbHmxT87xbB
         IfoTdMfzNDDPenloJRXQycE2KOpu2oMTjgvVyTO3FiCLa99lbf/OHkjz5s+rtfpBFKro
         kH2Q==
X-Gm-Message-State: AOAM5318b1RNtvh0s8F1RBnZbgT9uZEz7K+IyXaJXLOKmZApFBs96hvV
        hbwvnFm/3rAaUAQZW27CWrkf0w==
X-Google-Smtp-Source: ABdhPJwGu9kMwIGOcSohIfYJ+NIxZfevAbg2JhUjdK0aeG9zHaTGKntdmr01NhaUWdU13TxN2I2yTw==
X-Received: by 2002:a1c:a5d6:: with SMTP id o205mr20552487wme.125.1593011091041;
        Wed, 24 Jun 2020 08:04:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 8/8] backlight: qcom-wled: Remove unused configs for LED3 and LED4
Date:   Wed, 24 Jun 2020 15:57:21 +0100
Message-Id: <20200624145721.2590327-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes W=1 warnings:

 drivers/video/backlight/qcom-wled.c:1294:34: warning: ‘wled4_string_cfg’ defined but not used [-Wunused-const-variable=]
 1294 | static const struct wled_var_cfg wled4_string_cfg = {
 | ^~~~~~~~~~~~~~~~
 drivers/video/backlight/qcom-wled.c:1290:34: warning: ‘wled3_string_cfg’ defined but not used [-Wunused-const-variable=]
 1290 | static const struct wled_var_cfg wled3_string_cfg = {
 | ^~~~~~~~~~~~~~~~

Cc: <stable@vger.kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 4c8c34b994414..c25c31199952c 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1287,14 +1287,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
 	.size = ARRAY_SIZE(wled4_string_i_limit_values),
 };
 
-static const struct wled_var_cfg wled3_string_cfg = {
-	.size = 8,
-};
-
-static const struct wled_var_cfg wled4_string_cfg = {
-	.size = 16,
-};
-
 static const struct wled_var_cfg wled5_mod_sel_cfg = {
 	.size = 2,
 };
-- 
2.25.1


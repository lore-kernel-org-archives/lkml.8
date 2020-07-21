Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A01B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNZscceQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGUHj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGUHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:39:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8377FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:39:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so1788599wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJUflLSxHtf/sa8csoJgmFcN71WVeF/7yJM+R1zANs4=;
        b=aNZscceQn1Dl45cuBWyWTUy4PJD9d6KTGqmPfZ+4chPoR4Dl6+IMEpbgutX90tTDCc
         mYqm3dJZd9xCJyxoJoxg5iduHcWbg1nRZeRTkz9BQ1UE9HaSElwDMcKE0VImX+gSk+VS
         vSBnvljYJV7ZTwM6AZK4VCDxCZsECTxSXV19qEfiW4lrKi5/l0z2egPui2rS7FKf11Vp
         qx1SZBu4DpSYMnU+8tjOFzSp3GUzE7hjMnY1iZ3FUzp35hGe+UJqmvnx9pR2kauU2KoT
         U9zlJHrAt4LtfWmnsPtkuFq7jea/Q4E6zhR1ZS0owhTslgy0AZM2+CUsjA7beEUURO4i
         l1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJUflLSxHtf/sa8csoJgmFcN71WVeF/7yJM+R1zANs4=;
        b=AulcHpemXKInr72lqqfT0KjFHhzBb2ABuf/vN+5B5YThVamRrd5jBW7JyIItUjZBsT
         6Qdqx56ub9wgBThiCPpUH4wRsrRvECX/npP9Dc7KinBkrpWzp3KkpOFeE87Ffgh78Q6n
         K1EKwZ9s4tJtVGHkC7Z21UePriSaAY1+RAEwse7ajE6pmAVtRWHxXQBkG+dhs/4Q+twn
         8+XM/xByYKXXSOS4zkQtju5inHoSntEzRTcCQ3e3+No4qDwhD1a31Dep3EZYDEfLeta9
         sBgjRaquCz6ba7qwwuJD4nexZznhMIa1CxihFNHMXUHGJAY4nIdaHQmNvzRmMF++SsRZ
         RHlw==
X-Gm-Message-State: AOAM530EZ1KrZQIOS9Qfi43xmKc9PzWjlbg52EGsrLiifa/5fhOHwbw2
        2zGNbQu87mbW9+utCjpcixsPiA==
X-Google-Smtp-Source: ABdhPJzbYVjXuGfCryUzJsjd1CTsxTUcEGzi8mFH5cZrwPDVBk6/y6QpO5ShaXYOJYxZo542tq2TKg==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr2752246wmg.123.1595317166220;
        Tue, 21 Jul 2020 00:39:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id a123sm2484009wmd.28.2020.07.21.00.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:39:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/1] video: backlight: cr_bllcd: Remove unused variable 'intensity'
Date:   Tue, 21 Jul 2020 08:39:19 +0100
Message-Id: <20200721073919.925935-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following kernel build warning:

 drivers/video/backlight/cr_bllcd.c: In function ‘cr_backlight_set_intensity’:
 drivers/video/backlight/cr_bllcd.c:62:6: warning: unused variable ‘intensity’ [-Wunused-variable]
 62 | int intensity = bd->props.brightness;
 | ^~~~~~~~~

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/cr_bllcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index a24d42e1ea3cd..4ad0a72531fe2 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -59,7 +59,6 @@ struct cr_panel {
 
 static int cr_backlight_set_intensity(struct backlight_device *bd)
 {
-	int intensity = bd->props.brightness;
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
-- 
2.25.1


Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9631B20658
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCsupB04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGHNEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:04:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED41C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:04:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so2984536wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxFZ0mM04Szq9whPZ3GL7Mk7ZTkZD0uYPWryvuVTQqY=;
        b=mCsupB04au9clciRuxVrDhmV/yk5CdYxDbfWAKUEqRFL8HrNjxFEsv0/7Obek98xVH
         /9C4GfH+bCFayzILNsMztA+i5/rN8b5+s5217riicElmsJIMnYAmrpNECDTTV1EJEGor
         RwJSHj/wSTRE7zJHK2gqKcQRa5Yhfx6rW08a5khnZoy4ho2Xzam1QjcFS00BOQTZaxUO
         4vKDnfegwxZ1ETmjpXWpWweTk/LamA34ohy6W9sjJbj4OaWfS4Le/aKq+AaVDRqTO+V6
         r9xd0hmcqJMy385gyxHt/uj3aCq5gsCEdnvXK67fNvjI9eELE1VwBOvQXWC6Rrag8PI3
         d2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxFZ0mM04Szq9whPZ3GL7Mk7ZTkZD0uYPWryvuVTQqY=;
        b=XpQ9o5nu+VrE26oUHoPYVjluFXH1zt6i3mHyzY3HXwCxs7fzVbWofY1ThwcLaR/CYb
         arhvQAA8LkfznGCZUALSJyoFedljuiKJjtmbJiYvENwla67W8KUDaCiPd+JTu/8YCms+
         wcc9ssSEj5LeXMxOui5NNUm8YKKRvLGhmzTNMXGNva8LUXZC0F+HXClPhbavzpODC2oJ
         8I5l14oLmcP2WhRNqqkDORXKiXELsCVx08vilpkwFvWz+fpBulnQoXZQWTM9T+3jtzs2
         pPLTGOYvpcLOQezJunMHiKtyPayS2P7lvcP27lYWUnOJJAGpaC96sgiWpL3zV2BaJagu
         yQFg==
X-Gm-Message-State: AOAM533FdjruS18sRaYIvJGYRoH3AjZrDK6rciqhQh1GS3Ti0NG1d4Tn
        e/GntZi9Rcj2QZZjvzdEuQGqFA==
X-Google-Smtp-Source: ABdhPJwkcRNPg0c+ui6qXxBzepuHHCjRwvrxhO3Qpq0Zdau5H9yd/UNhobH+cvwIzFKwffnbfXPm2A==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr9078596wmb.60.1594213462831;
        Wed, 08 Jul 2020 06:04:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id q3sm5767129wmq.22.2020.07.08.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:04:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/1] video: backlight: sky81452-backlight: Fix some kerneldoc issues
Date:   Wed,  8 Jul 2020 14:04:19 +0100
Message-Id: <20200708130419.3445042-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, all lines must begin with a '*'.  Secondly, arg descriptions
must be spelt correctly, so fix misspelling of 'gpioD_enable' and
'short_detecTion_threshold'

Fixes the following W=1 kernel build warning(s):

 drivers/video/backlight/sky81452-backlight.c:46: warning: bad line:                 If it is not defined, default name is lcd-backlight.
 drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'gpiod_enable' not described in 'sky81452_bl_platform_data'
 drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'short_detection_threshold' not described in 'sky81452_bl_platform_data'

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Gyungoh Yoo <jack.yoo@skyworksinc.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/sky81452-backlight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 83ccb3d940fae..0ce1815850080 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -43,13 +43,13 @@
 /**
  * struct sky81452_platform_data
  * @name:	backlight driver name.
-		If it is not defined, default name is lcd-backlight.
- * @gpios_enable:GPIO descriptor which control EN pin
+ *		If it is not defined, default name is lcd-backlight.
+ * @gpiod_enable:GPIO descriptor which control EN pin
  * @enable:	Enable mask for current sink channel 1, 2, 3, 4, 5 and 6.
  * @ignore_pwm:	true if DPWMI should be ignored.
  * @dpwm_mode:	true is DPWM dimming mode, otherwise Analog dimming mode.
  * @phase_shift:true is phase shift mode.
- * @short_detecion_threshold:	It should be one of 4, 5, 6 and 7V.
+ * @short_detection_threshold:	It should be one of 4, 5, 6 and 7V.
  * @boost_current_limit:	It should be one of 2300, 2750mA.
  */
 struct sky81452_bl_platform_data {
-- 
2.25.1


Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C05C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E201D22B51
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/dp9Ioq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGUE11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgGUE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:27:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:27:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so11331534pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5DIRukwkI98RYm4Qg9DISHCAkP2l2iEddWUuvGqnjI=;
        b=N/dp9Ioq7OLVcCOwash9KSFssj8jIbJUFR6b8tP8e+vEJwiLmWFgkAsVB9nOd0if4D
         P3ZLOqJgVpdVgZ347tBVo6nFNCBHouz4wA3H96fDyiMLb1tysqPqlqkrdGyFLbVqJtj2
         NKTnsjColGrhQmU4O9/Vhs4VscuviZPH175ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5DIRukwkI98RYm4Qg9DISHCAkP2l2iEddWUuvGqnjI=;
        b=uEewLq4PXsEfF3QxqF5dZYpLMNjlZUQ+KceTL5TRUxv+ZTEaDJYyxBMiIusTK2SXRF
         KB4nZgXCibUpoVS/mxcf4fafPiRGJtFIEiQv9nRhf/mN3KYA596dQ5FGP8wykyzdDQOB
         uew4YkCxad3ECDSplGdDTVj6TLgVpMcAi/2xTshHBNi6PnwsJMWM8I64tO9kSkBTMSGC
         CIFvQD3Ktl8H3i3sJwn+Oog3ScYQQI8M5kkrBdboAZBYea0CGn7ry8qiz2iLvc9HNsZf
         yTXHbbrDOmWWAuf0RW5KgeYVbbMyPElQhCbFEvV/6KSAD6BQf1cg9MMsILoWEXE2C+z6
         UpOg==
X-Gm-Message-State: AOAM53158OSNSPgbsVTfb+bmM6mcpbh+sQBrCqvwSXcbBuSLxcCzE8ll
        JkWhe+VtuuwA/mH1LjBhmO4fjQ==
X-Google-Smtp-Source: ABdhPJysPuat1sQO+DzVyz8AlUl5gUkPbkn8rHbNtm3EfbnoGtqhvO3PEyZiKFezujfJ6TOP2pe3oA==
X-Received: by 2002:a63:b956:: with SMTP id v22mr21098040pgo.242.1595305644265;
        Mon, 20 Jul 2020 21:27:24 -0700 (PDT)
Received: from alex-desktop.lan (c-73-63-253-164.hsd1.ca.comcast.net. [73.63.253.164])
        by smtp.gmail.com with ESMTPSA id o8sm1207075pjf.37.2020.07.20.21.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:27:23 -0700 (PDT)
From:   Alexandru Stan <amstan@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru Stan <amstan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: rockchip: Remove 0 point in backlight
Date:   Mon, 20 Jul 2020 21:25:22 -0700
Message-Id: <20200720212502.3.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721042522.2403410-1-amstan@chromium.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the "PWM backlight interpolation adjustments" patches, the
backlight interpolation works a little differently. The way these
dts files were working before was relying on a bug (IMHO).

Remove the 0-3 range since otherwise we would have a 252 long
interpolation that would slowly go between 0 and 3, looking really bad
in userspace.

We'll still have the 0% point available to userspace, "backlight:
pwm_bl: Artificially add 0% during interpolation" takes care of that.

Signed-off-by: Alexandru Stan <amstan@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 171ba6185b6d..af4b21636c08 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -20,7 +20,7 @@ / {
 
 &backlight {
 	/* Jaq panel PWM must be >= 3%, so start non-zero brightness at 8 */
-	brightness-levels = <0 8 255>;
+	brightness-levels = <8 255>;
 	num-interpolated-steps = <247>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 383fad1a88a1..b25aa2f3cbee 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -39,7 +39,7 @@ volum_up {
 
 &backlight {
 	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <0 3 255>;
+	brightness-levels = <3 255>;
 	num-interpolated-steps = <252>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
index 069f0c2c1fdf..52a84cbe7a90 100644
--- a/arch/arm/boot/dts/rk3288-veyron-tiger.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
@@ -23,7 +23,7 @@ / {
 
 &backlight {
 	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <0 3 255>;
+	brightness-levels = <3 255>;
 	num-interpolated-steps = <252>;
 };
 
-- 
2.27.0


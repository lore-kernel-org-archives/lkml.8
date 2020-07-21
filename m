Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31200C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0391D2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WvDaw8DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGUE1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGUE1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:27:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B03C0619D7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:27:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so11331273pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIb2rFOZN8gwoOlXTkxPZa6eyeZDpgkSyS7W8wCzIJg=;
        b=WvDaw8DXxILkRr/NoclGFf0Rt0bm/iie3CNU3ZYfRBxlZ3lZovpsXOcdh3xgFByHih
         aU4ABPVp2FzRKAoUX9PQtPZU5+8n8XyIuUFBWdNFPjrloSZ1wwtOW85Gx+3KkNcwxMY4
         AVxsqdoadhQc1+eyMrH2gYFo6d/D2sDR6TXHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIb2rFOZN8gwoOlXTkxPZa6eyeZDpgkSyS7W8wCzIJg=;
        b=AD6kJXor/qz3gIUg+ndW37mQ4ReqPSMn3H/Mz3CrtlGJH2Ztx+1wWXEXy4TlCK54A7
         KI5varzxPVcNWbqcoSytgVLuFb1Tsbx/RkIir/h/GWQTLg5OsxqwFhhWIG5X3bOtqc6Y
         PvPhVXF0yrpemFUBCdChMQVg5kv1OBHYC05XBWYWYi575V3k/gWvU3YVa9uqjU3pJykS
         JRoRgiGffsm93FEj9KHv3R9KUW61fZ1CWp28CRgZeKYqFY0+CPU/IzCe1RsG0LkTkg38
         dEt6O/TcaD1toTij4Ee6VkuQZq39Ln8qx1Xxu9D6bddZ52C72eVX9Qsoutrj6lelmCmx
         C1mg==
X-Gm-Message-State: AOAM530+fscRF4BUpPWsQPf6ZL04nBHCqxroiL6IGFVyaYLPRXOYQG0+
        FUKFU1V7pAeJzQC7O+I43t9C7g==
X-Google-Smtp-Source: ABdhPJz9Vh2IOS/1uRlQ2nI9iXmkt0IM/J22K0/Kq13gyoo2noXO6h6x9nUFPTbwdyISrFtDedLw5w==
X-Received: by 2002:a63:395:: with SMTP id 143mr21310754pgd.57.1595305627807;
        Mon, 20 Jul 2020 21:27:07 -0700 (PDT)
Received: from alex-desktop.lan (c-73-63-253-164.hsd1.ca.comcast.net. [73.63.253.164])
        by smtp.gmail.com with ESMTPSA id o8sm1207075pjf.37.2020.07.20.21.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:27:06 -0700 (PDT)
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/3] PWM backlight interpolation adjustments
Date:   Mon, 20 Jul 2020 21:25:19 -0700
Message-Id: <20200721042522.2403410-1-amstan@chromium.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to adjust the brightness for a new chromebook:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
Like a lot of panels, the low end needs to be cropped,
and now that we have the interpolation stuff I wanted to make use of it
and bake in even the curve.

I found the behavior a little unintuitive and non-linear. See patch 1
for a suggested fix for this.

Unfortunatelly a few veyron dts files were relying on this
(perhaps weird) behavior. Those devices also want a minimum brightness.
The issue is that they also want the 0% point for turning off the
display.
https://github.com/torvalds/linux/commit/6233269bce47bd450196a671ab28eb1ec5eb88d9#diff-e401ae20091bbfb311a062c464f4f47fL23

So the idea here is to change those dts files to only say <3 255> (patch
3), and add in a virtual 0% point at the bottom of the scale (patch 2).

We have to do this conditionally because it seems some devices like to
have the scale inverted:
  % git grep "brightness-levels\s*=\s*<\s*[1-9]"|cat
  arch/arm/boot/dts/tegra124-apalis-eval.dts:             brightness-levels = <255 231 223 207 191 159 127 0>;


Alexandru Stan (3):
  backlight: pwm_bl: Fix interpolation
  backlight: pwm_bl: Artificially add 0% during interpolation
  ARM: dts: rockchip: Remove 0 point in backlight

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  |  2 +-
 drivers/video/backlight/pwm_bl.c           | 78 +++++++++++-----------
 4 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.27.0


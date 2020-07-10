Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E04C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCBD20775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMRQJYeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGJJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGJJy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09DC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l17so5489362wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGrB4C2EapNRMSvNvzwinnqh7atFRSmJOU/XyLZhEhE=;
        b=MMRQJYehw8ZQxxFT5CqPiRrGsbm364F4MVV/yZWQp1C+52h+7xpyjj46Xj+tgW0zyU
         AvB0zj5LduZikGya+Y2tPRfS2wzszgBc/5FP/xJQgtR0qrzyJYzBXJ3zhmUKmCSSQ0Mg
         Y0oowsdZX17mt+QREO7oYdJeLf4sN3ajCGwcQR9vhnpOvRKZ6mnWeEyUPTdSCUlHBhhb
         huZCxkWq6OVL3sipFjWcoIjtzlhr8ERlCkfkZRBSfRbtTriB1PwTZarV8WgMt+66xYfv
         d5u6NhGC1UyZrHSPqECxrYoXk4r5KMUVDkjlfni0Q15OzKegnU8jihN9CkckWWFLSTeM
         kRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGrB4C2EapNRMSvNvzwinnqh7atFRSmJOU/XyLZhEhE=;
        b=pigyUaB9cYItaUvh1QnViTTimgZn31YLn64tcrItkcNawjNCPL1bMa+aGzln4XYXcf
         y6fF0Y4BDHvggeWV8EpjEMD4h4iVjaS8IbAXDQmtD8YSsCx3/97Bk7Frsx0sjJA6C+1y
         BKGe9FhzmVvnP9i5ZE0psJ73+kT9mL8XM/cEAl/x5ujM/lzIx84mgT3PmaHFFHSePGYR
         Fnt/Uwh/E6Ii6BvXYcvMa4iWJ+msN5LW3kaqqowXeLdIWVLIMjj4DaHIJ+T8lt5sJXXE
         9DCWzIkkpJqfm4mD+BTkf5OeZypYaUrxffPItRyDd71rvR2FvH8ECuNvKkhlJJuR8zyA
         NuFw==
X-Gm-Message-State: AOAM533+xpYDJ7jZIUGO+m8KqRc7l3pW25D+rF6+gtNYfQt9LcXBcZV0
        Y+st0+UeuxTuMecp08y1Fr9W/AD15t4=
X-Google-Smtp-Source: ABdhPJxvOyxWrFrfdSeYFgEZW0vN3ESP+d6i5l29mIhd8ro9UaD9Zd651omuIzA2cece87Wv0D2yrA==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr4526829wmg.182.1594374865613;
        Fri, 10 Jul 2020 02:54:25 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:24 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 11/14] arm64: defconfig: Enable devfreq cooling device
Date:   Fri, 10 Jul 2020 11:54:06 +0200
Message-Id: <20200710095409.407087-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 89538d9e39e5..8a295bcb4dd3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -504,6 +504,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
-- 
2.25.1


Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B320870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6T23DJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgGDK0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGDKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3EC08C5E1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f18so27252443wrs.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aa8te2AcMwPmqAg9uKOXlMlgp9vWL13NU2V3cR52oIU=;
        b=c6T23DJJiHs5BtAKmNutM8G+MKEe23gN/maB70SgfCaol8AfeQQ+G8TYIru7RAFnVe
         gykZWTU2QlbC2rnUKQ/HBeKg6xs9YsgBm40QwJ4zwhH7b6V/7Ao2HCNFemANB9rdpmz1
         JGS92y/SEVnqf6Q069alN55283PDakjsnw6ojaeK8uFh2m9hWHymIla+yylDoYHDNT/J
         oXEdNQuVRJCH3VP1rH1BurCJaDG1gwBa5NraMYbPyV3H/2Y5auqTzHfV9RYBjfUEwO+T
         f57qbaQfqFsW5tAD7qITLW8NpanEznAi0SVdgUU+uetvWDuteTw9g9xAGH31Gb+MZ49G
         3t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aa8te2AcMwPmqAg9uKOXlMlgp9vWL13NU2V3cR52oIU=;
        b=nnWWyCMYTs+Q9p9ytzqbjSgkG8S/2oXfKWt7AHWSl0v0CfnlZna39GxelJvga0LF2W
         INYc16fJ3l5FPc8kgFg6S0fi+3fH9ASt9Cj0BxPtRg6dty2L5VW4FyR/FZcLqx7UFisH
         WfS2ozH1wQGePKcN48POBQsNghCZcHq75Ch20lPySAbT5/N+LSG4x0FOj8nkbdZYMx6S
         1u9jHPcVdLXGfziWiLAZX9sa64XaZp09ZvUt8Khv5ZpsSnXzz3OX2UgVC679iTe1fJji
         xtS2t6cTitFi+c5tG8daUCHyhLAIg4JP0mGOe037UHIpQW33GXfYJEATI4Ups/GIq/xn
         rBSg==
X-Gm-Message-State: AOAM533jA1UMwyE4FWtfGhIvJ6W1uEyqbYSpR5s5YzBBZm+sZdaGKqEm
        xEgRdNBBPiN+Yo3qok0hnn4=
X-Google-Smtp-Source: ABdhPJwTY8xk+AwUuvBq2SX6rifzkA/0NydoFJzAmeI9i+CYuQQd2tXt9uKF7RQQ7yyoYhGi5RfQZA==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr42893726wrm.40.1593858354417;
        Sat, 04 Jul 2020 03:25:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:53 -0700 (PDT)
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
Subject: [PATCH v2 11/14] arm64: defconfig: Enable devfreq cooling device
Date:   Sat,  4 Jul 2020 12:25:32 +0200
Message-Id: <20200704102535.189647-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8bace3ed..1b7f9ffdc314 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -501,6 +501,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
-- 
2.25.1


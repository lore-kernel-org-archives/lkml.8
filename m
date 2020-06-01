Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B1206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l67SRuA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFAUEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgFAUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:04:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8753C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:04:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so703720wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5Dn7h8F8p+9hiFtim1wM4aaeJzWbt5/JlaxHO0hK24=;
        b=l67SRuA8PBupQ7fNCIDym72270aida6TA0K/imDtClEIRKSkhBKgy9+1yFC0juX9+m
         LIFR2HpW+Y/YRv5Q7HSqFeyH/yM7vKvpHkLdPBsqJtv2MRQ0pp8sfcJ7cHrrb1u6Aqw9
         g81acLRL3UVGHjnyWWymDPldpIppTYdhzbGLx9Uub8loMmNs0w4KRoabp0d1WpB/miF+
         4d+tUd53hJU1mwIwinyoe0ewffZH7cdP96KkldvyOF8z8o6UVkZkye7Ll0DsoJ/7s+k9
         ru2VmbQytV3hJuV+29DPmZb6DJiNzkbUkgzc5V7AArClc6dbKD0jD67wN8Mle+vg3VAE
         4Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5Dn7h8F8p+9hiFtim1wM4aaeJzWbt5/JlaxHO0hK24=;
        b=hygnxkmFPnXpmotjltG1OjGRcSLUaDsWnrmS05GlyPxhHU9JRkurrynrsMfnELDwfm
         eawg4WHVCRGjxAuak9/IcK8lTyDlKUGR1GOzsUFxh5AYJeL5mvEKgzKr9TSTvU3Mu2Tw
         2fH37yNdi5tWdTBcSwZNpSuYyIuQzJztrQZWFymSyzy8lOCH5mPRfiiG9WTfdRYCQTI2
         foHPoNQFmO3q91bBYxHtOQDXu8R+KfdorWexMVc1oJxUCKgwcUTlob3T2i92DzwrzJuT
         h+KKNaAeSSSb90xSr7Mt3WkPUaaR9tqBXz8l3YHVZfc6uSmanowWi29XKQVDqhAqIjgB
         S+SA==
X-Gm-Message-State: AOAM532CqBsYM7oqdD2I1w45wxc/ytKsyNlu4Eze0hrjVSaVSlbsIK5b
        EFWROzjFruY7vZyaE/DBHys=
X-Google-Smtp-Source: ABdhPJzRb8zSAFQ6wsfxxoYSHAaMpja+sGsf3SPHYEbdIY/I0SegpgESf3NRVDz71fWygY8zMyq3OQ==
X-Received: by 2002:a1c:49:: with SMTP id 70mr790457wma.184.1591041880550;
        Mon, 01 Jun 2020 13:04:40 -0700 (PDT)
Received: from localhost.localdomain (p200300f137189200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3718:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g3sm773130wrb.46.2020.06.01.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:04:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
Date:   Mon,  1 Jun 2020 22:04:11 +0200
Message-Id: <20200601200411.2006603-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3.10 vendor kernel defines the following GPU 20 interrupt lines:
  #define INT_MALI_GP                 AM_IRQ(160)
  #define INT_MALI_GP_MMU             AM_IRQ(161)
  #define INT_MALI_PP                 AM_IRQ(162)
  #define INT_MALI_PMU                AM_IRQ(163)
  #define INT_MALI_PP0                AM_IRQ(164)
  #define INT_MALI_PP0_MMU            AM_IRQ(165)
  #define INT_MALI_PP1                AM_IRQ(166)
  #define INT_MALI_PP1_MMU            AM_IRQ(167)
  #define INT_MALI_PP2                AM_IRQ(168)
  #define INT_MALI_PP2_MMU            AM_IRQ(169)
  #define INT_MALI_PP3                AM_IRQ(170)
  #define INT_MALI_PP3_MMU            AM_IRQ(171)
  #define INT_MALI_PP4                AM_IRQ(172)
  #define INT_MALI_PP4_MMU            AM_IRQ(173)
  #define INT_MALI_PP5                AM_IRQ(174)
  #define INT_MALI_PP5_MMU            AM_IRQ(175)
  #define INT_MALI_PP6                AM_IRQ(176)
  #define INT_MALI_PP6_MMU            AM_IRQ(177)
  #define INT_MALI_PP7                AM_IRQ(178)
  #define INT_MALI_PP7_MMU            AM_IRQ(179)

However, the driver from the 3.10 vendor kernel does not use the
following four interrupt lines:
- INT_MALI_PP3
- INT_MALI_PP3_MMU
- INT_MALI_PP7
- INT_MALI_PP7_MMU

Drop the "pp3" and "ppmmu3" interrupt lines. This is also important
because there is no matching entry in interrupt-names for it (meaning
the "pp2" interrupt is actually assigned to the "pp3" interrupt line).

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Reported-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index eedb92526968..a4ab8b96d0eb 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -239,8 +239,6 @@ mali: gpu@c0000 {
 				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.26.2


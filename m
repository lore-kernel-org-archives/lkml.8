Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D726C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B0A20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V3oTzjYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgHOWHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHOVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3378C004580
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:20:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so13296300ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OpZZK28b8NffZ5B6TNfkcT7DySPSUfUL+HBLi8ymZuk=;
        b=V3oTzjYqO9jTTYGBEiyf2ShErrFEq3jU/oWgQAJGZyC8jk7rfxUp/+JMzVQtQ6fK77
         m8H2Gm1/6/SbOfXKPJyH9tFEL8EZMNAfs5h99a1J1qvVeZJA7UdCzA86H7HDX8FdA0Ep
         Zm+HmzqBMOAEBb6b3qtm0btBSNHDtUr8M4pbBp6cBip9EZv5QGLKIGlNjj4ZaR5tD34l
         HOs0G2kBkmpwrkQCVvsJzcv50aEu4w5Vl0kEs6tGK8PxiIaEKDRsWSgsLkKDCl/2lLa7
         xNSt1uRbf2ymzz7S7H/YLojd694kvZzxp0CxaVHhaE4GQS0p2Q8NYI+05I72GpgSJuuL
         xj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OpZZK28b8NffZ5B6TNfkcT7DySPSUfUL+HBLi8ymZuk=;
        b=UYr15ocnQRiieJ2TgurL26qr7KSKAlOtlgJ7zQd6KqFMS/wmdHeUAdQE/02cdcLMA+
         bIvUT4qCxOh0FFL8URiUUr9HyQQFPPWLMVaE6WDr+XFmmL+KJ3c1vMmKFCxr/5cjK8n5
         9WwtgJwmkd+xbPPY97hNch4jwTi9NerNZym26YjAQa8kvq3EFGj+zA6U/xYiBCyu70kc
         5s3QDQLqYj2QtAN5SmuGnxT98iFWl5kGrjNx/vwgmpxQtrbxZv1J2Wg9KMx8ycqFTq0R
         p1QuXvXnz1E4qbI05/HzcgCYbJfIisHPtmGoPM9CtfbHhzmUTurQhfYNDbu3ttolTCC5
         1VyA==
X-Gm-Message-State: AOAM533he2SD/nJeWtWeTJP/uv9LPFva6jcCPbdTidQkPwgwRusM3t7e
        +CTF6J4SLniM6AqyRXoap1qq5QSAZs8=
X-Google-Smtp-Source: ABdhPJxAif+DHTGIAVE8RS/VpsGIEnHOWkllB8nTHgbQiXkpv5KQMmpXc1hoO29G0LpqIJ5e1wSw/g==
X-Received: by 2002:a17:906:c406:: with SMTP id u6mr8344063ejz.47.1597515607044;
        Sat, 15 Aug 2020 11:20:07 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371a97000000000000000fcc.dip0.t-ipconnect.de. [2003:f1:371a:9700::fcc])
        by smtp.googlemail.com with ESMTPSA id os4sm10054989ejb.117.2020.08.15.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:20:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
Date:   Sat, 15 Aug 2020 20:19:57 +0200
Message-Id: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
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
re-send of v1 from [0] because it was never picked up


[0] https://patchwork.kernel.org/patch/11582619/


 arch/arm/boot/dts/meson8.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 277c0bb10453..04688e8abce2 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -240,8 +240,6 @@ mali: gpu@c0000 {
 				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.28.0


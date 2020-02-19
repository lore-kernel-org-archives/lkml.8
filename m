Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B539C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02FC24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfNCQIIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBSUm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:42:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42542 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:42:29 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so12950779ila.9;
        Wed, 19 Feb 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xMDNRqXigFwE5mAPTxNYoRMwFlx8Rk5qiR4uZXsscw4=;
        b=qfNCQIIH2j6wCkLKQ2mqWetFZntTRzqNjtBUM8anjzkPqf4Ynd0oWZWBb6hyrQPdCF
         uN3+mto+zq5HiY0xnelQ4PTO7z5fp0Jptf5qhcMwXW26QHdu1ppBMrN3gLdBGvkz9+7T
         uRGr6xPSZ2CPQYBvje7dwuPnzGTMvObbihSz3JgDRUVY/mlY9r1FmcAbwILshnrGxHoV
         YQ7XIWi0j7DxuapC2Mxf0BgFsQfhqPDfPdS4oL0kZVxd1wsk1YdXR26HaffZljlbj16u
         HGigXFMIMG0GQvDQ1WBnBaABCa1Y1CGM0wnxF/ut7KE88BxGE0dzo71L5H0o2zyYBRH3
         /9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xMDNRqXigFwE5mAPTxNYoRMwFlx8Rk5qiR4uZXsscw4=;
        b=Zqt/maHMHrjlYLj1DRb19O1RYnSCUOdo3R2aXSoZCT5MXyulP0P0zJ520p03SI93zB
         4c1gbX+96TVxfwSc+eCB7op+bO4hX8MkLc23BMyvDGLj6cT2ABvk5gP2ze9vkA8o84pc
         qlvUIC1JGYyvH+wWAuHF66sDurWk12X7eQJOTqyyodH4h/cJMaAOtl6/KoqqovisZY5J
         Qwb2aHbz0ZKzV5h//F+yS/T9KD7WYKcKnhUhR8A2MWTcqhbIjwJyw4KYdbOB7icguLX+
         /8R5EGpf2lUTeyvvuQuZ2j17NF4DiKbun46KJfvLEZz7xVubiNP6Y2hKl6gxA7nqePxP
         TOrw==
X-Gm-Message-State: APjAAAUJJnuAe+hG2YWkwPSuXHZqmhMEpYKy0Fv0jqdflwRmrrcIUYLx
        7vXKtrI3jdjnUoajnrq4M0Q=
X-Google-Smtp-Source: APXvYqxamlA1ssz9lk4Vdd4EvOofQze/gD2b+EfZA1Xkq+0ovJF0gt8l+vaKreCew2We51oCAM8OcA==
X-Received: by 2002:a92:35c9:: with SMTP id c70mr26726162ilf.79.1582144947299;
        Wed, 19 Feb 2020 12:42:27 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id l81sm305023ild.87.2020.02.19.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:42:26 -0800 (PST)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joshua Watt <JPEWhacker@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: dts: rockchip: Keep rk3288-tinker SD card IO powered during reboot
Date:   Wed, 19 Feb 2020 14:42:20 -0600
Message-Id: <20200219204224.34154-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO voltage regulator for the SD card must be kept on all the time,
otherwise when the board reboots the SD card can't be read by the
bootloader.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 312582c1bd37..acfaa12ec239 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -276,6 +276,7 @@
 			};
 
 			vccio_sd: LDO_REG5 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
-- 
2.17.1


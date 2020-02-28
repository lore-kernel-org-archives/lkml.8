Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981A246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoIne1Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1Fr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:47:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40108 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1Fr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:47:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id 143so1950649ljj.7;
        Thu, 27 Feb 2020 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e3rRbEToSCqTcYjLDTcdw4LcAsL1QAmXUv8JS5cebgQ=;
        b=XoIne1Nb5kFUDj41LjD7kbLI5h5o3wzu5VM5IngJI7deJOu6WjFlxaYnNQ1UQ6NFhu
         BG7RLL6hzImb4cHu34XCXFPKdZ70ow+w4lJC9jkdte2AU2B1q4IBd1HD/d3z9UzOPr7f
         sXRsrJhUZ1bJNHLIHDXh3SzOmormK+EbIoPDZdQ9+wnFUKgASpsyXkz0GJz7++pF4wx/
         GWFbdZbGiHiZkeNw3dmghR5KxMmcat6H+IOtpj+N46ndfmHQubOI28sQ5lG7jofBLJpO
         NXf7cCfBJbmHvF8CHzVsijz1SMReF2LsksShAumP69hR/eqMsYo/UKrU9g1SimzgE8yR
         gP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e3rRbEToSCqTcYjLDTcdw4LcAsL1QAmXUv8JS5cebgQ=;
        b=oZ9tXD6K4+3pxCuvP4ctrAP1EF4rxbjolbnkeQeY55YWb7+C0J0XG3bz08feE5QduV
         pe0lYozfNuDE5FIq1YTxmHVyuAHGeOreu+JTUegy4VEFMRo/Nt5Ex2iIWm2kD0wJ+dIJ
         bpVo0xo0X72y+GayADzc+fsAbVeOK5liGpOKnTFVkQZKEPXHsLexXXxJfulK9jieyE2C
         o+yPgxsJ2MGo8KEb8X04omRXQviq/xlrCR8PiI/aj1/acYDKbh6gTAwC0IcJRZOjaHGZ
         5Hk9UXCRKAvtqTnPiD+wXLf+GmuNziZQ26yIJAUIWlEkPSEFYJHlXygfCDlhNTZvmYIA
         McHw==
X-Gm-Message-State: ANhLgQ05W4jEJTvOJOASut9DuerO5TMMyTcKLMmlus7xRnSjIdeRM4lk
        ExvQ8jaK0dNHR6QftZdVGxE=
X-Google-Smtp-Source: ADFU+vsMBvBqWogz63CGu3gbsY1yy+UiOZUyqdEFXylOvp7Y3ANY7Klm69JBRpTiocOvvbgNU4uikA==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr1659910lji.176.1582868875231;
        Thu, 27 Feb 2020 21:47:55 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d24sm4760642lja.82.2020.02.27.21.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Feb 2020 21:47:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: khadas-vim3: move model to g12b-khadas-vim3 dtsi
Date:   Fri, 28 Feb 2020 09:47:04 +0400
Message-Id: <1582868824-73870-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common meson-khadas-vim3.dtsi is now shared with VIM3L so move the
VIM3 model namne to meson-g12b-khadas-vim3.dtsi.

meson-sm1-khadas-vim3l.dts contains the VIM3L model name.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 5548634..2b2d72c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
+	model = "Khadas VIM3";
+
 	vddcpu_a: regulator-vddcpu-a {
 		/*
 		 * MP8756GD Regulator.
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 90815fa..0ef60c7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -9,8 +9,6 @@
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
-	model = "Khadas VIM3";
-
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
-- 
2.7.4


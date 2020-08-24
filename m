Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6730A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="A8vJ6tGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHXK2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:28:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A596C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:28:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so11170838eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duZKn03ykVx09U/dZNksja6SxycNwf6QKBHfwct5ls4=;
        b=A8vJ6tGeG7iAEIGi/SDw8YKaNyKC2WQdSuZUcYRysv0uoD0OaOTcq0B1UsaAXdMvcg
         qA8tTYfaMYSjrzAn0QJ2sIyYhnHifPzGBEEvjTcKN2JKOtW0k42yOR1sJICir9cHrBsv
         lSXqBacyfPcnc3ZVIU7Q7oD1pPZubLghTOozMYyVkoJhuO9mqGKqaOvPZGFymT4UHaAQ
         mnT6ETDs197O1xOVi0p8H4UCCoHuk1UtAhopwwzLrizWVqzgmXNcLJynVapnyq0OfAVo
         BWmxYxfOcMXxI31nEVksdTBWX0WPgEAD78ATRNGXBLGPZ5BLHtg19nsmOXsKIFTio0mc
         SbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=duZKn03ykVx09U/dZNksja6SxycNwf6QKBHfwct5ls4=;
        b=qPoYtMrHn/+fOmXe8wTlSo3/3dpTcny+ej1lNegx+MxX85ls4OlhNoNds/Rku26C7C
         QdWzvqomGo7thAnXzc6Jv60dsE65v9ObMr8zAgtbQULCUUaiMB4ECJMtwv29oHdlV3Lm
         YS+tslMN7BphxqCBZZL+dvjuLd631nwp5VBUkgYChGyuWQcrulXNskbevbK4Jlpe/iXH
         XAE9lVZvc318N7Em84cRHd4H1+cwf1/V6lwK6IArSzqO/4tFNn6aAWeP6ftBjKsiaDhW
         nHgkrrRwdkL7lcPdorgZHLSg9KJxLHlhzDfulxxRM9R+Cgsam8gebg4ARYrv5dV+Wx1K
         0kFw==
X-Gm-Message-State: AOAM532iuJCaT46ZU1ucTmgX0SjlNYHYqLfm07RNBfVsFUaWsh5gLU4d
        AKfau4r+K+hrgJL3OYfiCjv9RQ==
X-Google-Smtp-Source: ABdhPJzo5Z/rkYnyE2/+kuqWK3/ftBN164gf8Tre6SLhi97rJLX7dBBObMOlJdVUVPoL5IQIA79oPA==
X-Received: by 2002:a17:906:7c82:: with SMTP id w2mr572069ejo.87.1598264921305;
        Mon, 24 Aug 2020 03:28:41 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r26sm7943799ejb.102.2020.08.24.03.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:28:40 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     u-boot@lists.denx.de, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: zynqmp: Fix leds subnode name for zcu100/ultra96 v1
Date:   Mon, 24 Aug 2020 12:28:39 +0200
Message-Id: <1a69c3fa0291f991ffcf113ea222c713ba4d4ff0.1598264917.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the leds subnode names to match (^led-[0-9a-f]$|led).

Similar change has been also done by commit 08dc0e5dd9aa ("arm64: dts:
meson: fix leds subnodes name").

The patch is fixing this warning:
avnet-ultra96-rev1.dt.yaml: leds: 'ds2', 'ds3', 'ds4', 'ds5' do not match
any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

vbus-det led is not fixed because it is not LED. It should be likely
handled as gpio hog.
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d60110ad8367..2352dc553ba7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -56,27 +56,27 @@ sw4 {
 
 	leds {
 		compatible = "gpio-leds";
-		ds2 {
+		led-ds2 {
 			label = "ds2";
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds3 {
+		led-ds3 {
 			label = "ds3";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx"; /* WLAN tx */
 			default-state = "off";
 		};
 
-		ds4 {
+		led-ds4 {
 			label = "ds4";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0rx"; /* WLAN rx */
 			default-state = "off";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "bluetooth-power";
-- 
2.28.0


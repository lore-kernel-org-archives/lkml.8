Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D4120675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvE+QjV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCINkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:40:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgCINka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:40:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so2186082wro.12;
        Mon, 09 Mar 2020 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dfCIxcOnP/0No04iQLbl9qRZ5XXuFOMBWpVPNhSslK0=;
        b=TvE+QjV/Emq8Ejod4yOAQ3SjW85I9pv4uA1tuM280dy+KaH8L+rQ+0/nqV9rlllRl3
         6qc2ydP1JNclBtIw6xQYxivq5UnAgp5mqn86M6p0yx3dLW63cYSX4covJC3RKMZMuybD
         hIy5eZ99mJLKOhGh4sazWeUvxa2zaMc2mB636k5Cxh1N/W61/9fuv3UebPQUsTAVRR97
         MXqShPt2kM1mXpGDpgk6lPFb5Pfrjtq9rro7lxlewNqVlVPsO4cFvXm+sgduc5X09Z3j
         MNx3cZ3DpBPa5O5TIoq2kWX2Uycp7XI1cxY6swoxzmhcScv7iBBUFKWscptX7dtHAHFm
         W72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dfCIxcOnP/0No04iQLbl9qRZ5XXuFOMBWpVPNhSslK0=;
        b=drVpeB/WMNKcWi/Ph3RnXY85uys36DsmnRov2XzR8Su6F4+c8+207+z7Gw1ZG//HFn
         Dc3yr4d4+PpdpJbPClLKXsQKhyC5OfIGHKiQh8UL00+zj2oCC7HNEw/PcDzfiKH5ofS+
         XGX+yrKFniBZqbbk+X87KSWhe89ZVY4X3qWgWnYtWf0l1v5AGS1BIUGkNymfk1mYChg7
         7Wiu7hnsYYJxSd5FgyAhaa53cUR/SRS/zJLCPuky/7qrIpluuWUqnUvW53IYLyQ16lsy
         68QpA+Z0+AxPMiRjXRXPINOx27k5gSGWFj/9wnFPmi1rRlOA915xzNi/W6eGuKiK6rsz
         2/YQ==
X-Gm-Message-State: ANhLgQ1vVwykEMgLdlgDyXWq76/oXoAqMkFfSJkwKX0iiIpvnNHZYegX
        kn/fhsJ4fSYjOQue5hluwZI=
X-Google-Smtp-Source: ADFU+vum0vFqAdXvHbJNX40jof7bCt99HKnCoeew+WNOZtw7BQ4UtkW70Jon8MgOr+2lGqDoKY28Rw==
X-Received: by 2002:adf:a419:: with SMTP id d25mr22152214wra.210.1583761227808;
        Mon, 09 Mar 2020 06:40:27 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i14sm8888439wrp.82.2020.03.09.06.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 06:40:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ARM: dts: rockchip: remove #dma-cells from dma client nodes for rv1108
Date:   Mon,  9 Mar 2020 14:40:20 +0100
Message-Id: <20200309134020.14935-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we combine spi-rockchip.yaml and
spi-controller.yaml and add 'additionalProperties: false'
it gives for example this error:

arch/arm/boot/dts/rv1108-evb.dt.yaml: spi@10270000:
'#dma-cells' does not match any of the regexes:
'^.*@[0-9a-f]+$', '^slave$'

'#dma-cells' are not used for dma clients, so remove them all.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 59295babd..fda16f976 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -120,7 +120,6 @@
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
 		dmas = <&pdma 6>, <&pdma 7>;
-		#dma-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart2m0_xfer>;
 		status = "disabled";
@@ -136,7 +135,6 @@
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
 		dmas = <&pdma 4>, <&pdma 5>;
-		#dma-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart1_xfer>;
 		status = "disabled";
@@ -152,7 +150,6 @@
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
 		dmas = <&pdma 2>, <&pdma 3>;
-		#dma-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
 		status = "disabled";
@@ -208,7 +205,6 @@
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&pdma 8>, <&pdma 9>;
 		dma-names = "tx", "rx";
-		#dma-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
2.11.0


Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69C5C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F22075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq0bI2jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCGNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:48:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40040 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCGNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id e26so5241717wme.5;
        Sat, 07 Mar 2020 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2imEdS/PBWfabOn+dN51LVNZ4eyxGJ7p2pvJGQCDbMA=;
        b=Zq0bI2jEf9UR4l3dw4/5Q20mWx9OFcm4BXeRZihBnHD77OfRm41Te+m7y0b3E3wYk/
         OW9F+mRGvUT4/yHOWoOTXtzcWqaHYuCQL63AYI+wJhPTdn39ROdOP6oezU8c4g1wX0jP
         32O33kibj9C6ND4j4Lw0ZJWiQ96pCUmfsSCDy6A8UjORaRnVto9vAHJzriQCpabDNW2n
         +4UhR1aXzOoc8E4g2ymLuOBwO/mYavCGa0lwGxexZHcfePDNh3E6NGaEk/sJoCmfv09G
         Om2iD1R39JblW6s5FVs+hbRTjFcv/eXhUjmdsF1PD8j4chZMPOMsaDRrXS7TozTHSGsy
         m+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2imEdS/PBWfabOn+dN51LVNZ4eyxGJ7p2pvJGQCDbMA=;
        b=kolG+VGmpnFt40QpNg+8UBgQE0Gz+IZQhp2e+JVPR0WbzOWqILSg2I9+Db0bAZEsQ4
         3HcUGP+w2IU7qVYG10mHYIJl9R8mr5SiFQiokbVhEgB+O7jjVm9MJRbVgQlzYkvSaNUf
         iBai0Pdbdx0crjptUF+wN/suHYp8g97b0BmY1mJk5uhgVYHJd7TrnuNbIt+ND4vjPhey
         c9dR+HioD/pN83YBX8nZ0KF48teJTCbLGSZzgxzYrRbmfjtl3mU/CsT/Z+QlWzhfi/Tp
         s0r/GKUYhQKKnaFCQ0av5ddgsBOEbf1jwtru7vUKDgUCS3K++PAv+ARBqU2fW9Gc7Gyg
         9Lkw==
X-Gm-Message-State: ANhLgQ1DUwcQcvSrhNfN+Rxnd0HcvVj2Ui4m++zM8HQ8/e3VV4tUsSkq
        /Na1Rwv7n0yaPCVyzBKvYvY=
X-Google-Smtp-Source: ADFU+vu8s4n5Jiy9JVKXd+Qg1OTKkxCBR1qUX5tnXAgdtgg4qZfDvCaWow+W0/h6haum4suXa5MHVg==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr10103753wmd.139.1583588929397;
        Sat, 07 Mar 2020 05:48:49 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm11767265wmx.32.2020.03.07.05.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 05:48:49 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: rockchip: fix rockchip,default-sample-phase property names
Date:   Sat,  7 Mar 2020 14:48:38 +0100
Message-Id: <20200307134841.13803-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200307134841.13803-1-jbx6244@gmail.com>
References: <20200307134841.13803-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below does not detect all errors
in combination with 'additionalProperties: false' and
allOf:
  - $ref: "synopsys-dw-mshc-common.yaml#"
allOf:
  - $ref: "mmc-controller.yaml#"

'additionalProperties' applies to all properties that are not
accounted-for by 'properties' or 'patternProperties' in
the immediate schema.

First when we combine rockchip-dw-mshc.yaml,
synopsys-dw-mshc-common.yaml and mmc-controller.yaml it gives
for example this error:

arch/arm/boot/dts/rk3036-evb.dt.yaml: mmc@1021c000:
'default-sample-phase' does not match any of the regexes:
'^.*@[0-9]+$', '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$', 'pinctrl-[0-9]+'

'default-sample-phase' is not a valid property name for mmc nodes.
Fix this error by renaming it to 'rockchip,default-sample-phase'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 2 +-
 arch/arm/boot/dts/rk3036.dtsi      | 2 +-
 arch/arm/boot/dts/rk322x.dtsi      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index fb3cf005c..2ff9f152d 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -319,7 +319,7 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	cap-sdio-irq;
-	default-sample-phase = <90>;
+	rockchip,default-sample-phase = <90>;
 	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index c28d293df..2226f0d70 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -263,7 +263,7 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		default-sample-phase = <158>;
+		rockchip,default-sample-phase = <158>;
 		disable-wp;
 		dmas = <&pdma 12>;
 		dma-names = "rx-tx";
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index b98579035..8ad44213f 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -698,7 +698,7 @@
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		bus-width = <8>;
-		default-sample-phase = <158>;
+		rockchip,default-sample-phase = <158>;
 		fifo-depth = <0x100>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-- 
2.11.0


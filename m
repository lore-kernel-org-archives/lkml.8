Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02715C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32B32075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfYmzcoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgCGNtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:49:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39597 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCGNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id r15so563717wrx.6;
        Sat, 07 Mar 2020 05:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8vU221Fl1wRDhepKyfW4xhkJN/Ivc1A7S2pOvLbFIU=;
        b=NfYmzcoZPQlWO8KkyWMuaJlZPYo19zE/UOr4wWnKj0CXCeV5mI3VM14xv/GTDDfC+Q
         aJ/I4k7kR2K3vFGUM17z8EpkkPdUESTEw4ap/uAmbuBrcmzcmPTxty/QVlNCPONcwRuB
         VR3tL7aNU0JN7wHU0BjO7tk3165sP1n+4WkSaQEVnGI2rqi4PZkLK/X/rqpoESXw+C0y
         iw51B9JbCFDuVX+lyFlUkJuBWsE6IUjCxBj5mlHzKLV85FVaB22hphOHsSl8IqPxsICM
         JhM69/IXjbk7QAiwYopnQoBndYH12Ro1nhGPwlqVEM5P8EakCx2eDcAmJvYdcMDN9SBH
         uUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8vU221Fl1wRDhepKyfW4xhkJN/Ivc1A7S2pOvLbFIU=;
        b=B0Fu7D1fE7uhKzxnjap5cw8D4S77EHbQkNwhAObdflkaICzZ6T3EvU7S8XXYBRBqSX
         pcZdjzldVLP/4ZpSzvy6nXj+ofCRKSG66jiPVP+fwvJG0JtWEs7hlf6Nn2cVVdAhxH50
         wzwwREaDJuFAWlIZZ5QWXv2MJRnNljgZ/KWq3jqLWazWauSs1juYw+JYFz4DXYABhKq0
         4b8m0fAJmQS+s0VeXQcpOgzvJNPHC6TTCo/nkpuRKsuMyz/YkWyAGPhCOFBVVFxD7A8Y
         qUjfn5S+vF8vONjHXXqWvlef0n7V22kw0pAlmWVP60bPpjjBsabu4crLPepwrImrFWjW
         JDWw==
X-Gm-Message-State: ANhLgQ254LWp4tEn+Sw5OEkOMmAmx2r+J5r3oI5jKQ6/B54WcUgkclZW
        9kDNqpr+PIv+m8w+wqXVi0Y=
X-Google-Smtp-Source: ADFU+vuqgLoogFvxDf8zmOIagX/6EgMcrmjZMR1lY83duVqibjH1wJOvkB2FC4KR1mQPDt79vOxiRw==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr3848479wrv.17.1583588932141;
        Sat, 07 Mar 2020 05:48:52 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm11767265wmx.32.2020.03.07.05.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 05:48:51 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] arm64: dts: rockchip: replace clock-freq-min-max by max-frequency
Date:   Sat,  7 Mar 2020 14:48:41 +0100
Message-Id: <20200307134841.13803-5-jbx6244@gmail.com>
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

arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: mmc@fe320000:
'clock-freq-min-max' does not match any of the regexes:
'^.*@[0-9]+$', '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$', 'pinctrl-[0-9]+'

'clock-freq-min-max' is deprecated, so replace it by 'max-frequency'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index d69a613fb..f2ffee639 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -555,7 +555,7 @@
 
 &sdmmc {
 	clock-frequency = <150000000>;
-	clock-freq-min-max = <200000 150000000>;
+	max-frequency = <150000000>;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index b69f0f2cb..ba7c75c9f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -542,7 +542,7 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	clock-frequency = <100000000>;
-	clock-freq-min-max = <100000 100000000>;
+	max-frequency = <100000000>;
 	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	sd-uhs-sdr104;
-- 
2.11.0


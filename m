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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D7C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69AA2077B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMI7D0qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:48:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37139 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCGNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a141so5264782wme.2;
        Sat, 07 Mar 2020 05:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STsCYmVzqE0DyGQSLcvjOSy6vdxPWBxzS0jjS6ORcro=;
        b=rMI7D0qKgKibOcLcQS/QK9oNfgZ2LNDtF/Z/YgZsX1xLCBu6Hnc/lKSrbOQBIEPLSg
         v33E7/H4iz+xsgbL6klyAa2fO1kLmSk9WFqB3c2ywEYP4BrQ5FQBwLJR/w/7ZVewQ5Er
         x9vt6l9dgXR4fq1ZR+GjY5VwDC/kWtcYmlxiLWv67te7rD91XlNwNHh4dIFuaM6ZgYLV
         j2IlO3Bkc1QfTXJmt9crdZlOMc29O3PBfvM+e6ecbZkXb2fT5WBtxaDiA7whoQLBhfu3
         jsEv8QPE9yD2K3nbYB+voC9kE5WhA+/zYjgFrXL8V7e1RTiZYDXH3LBsGxem2LC4vzot
         xd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STsCYmVzqE0DyGQSLcvjOSy6vdxPWBxzS0jjS6ORcro=;
        b=TtJg0p7LGnfFylaeRAnhrhNzSgg24HJMQjY5QI2sxVd2sWebBNRAyP+Bvi4X09EGJN
         7J4w6nfc4bMjzEQEknmHLDiiLbIVk9bT8OeUsvoUfcU/8NLIdnLlYWET/HYPcho7+luE
         bpovDRVg04DJDXikqxl3MidXkiODRcuwhtOpYG9raBUgDBsU9TMR6pMIbJzZ6eUcfkqQ
         TJpoZdM4q1+FV1ZMHMtQQJy/0QM6J3ysN47YkbI3UEZjn7+LWASVVUchz4I55JAABDYf
         TKNix0OVuyAyl8jAqRdGycJgmnpQVeYhhqympwiruwnMhW4umF2LCpCDuN7DsmjpB656
         steg==
X-Gm-Message-State: ANhLgQ2/CcG3Jg26zDu0lK3P10Lj6Mm8U/ZUGOz9HaCOM1j+F1dpTZdG
        0wst6ibzkEWB5v/Jo1pmljY=
X-Google-Smtp-Source: ADFU+vs3yoiMYHy+aHEyVA2e2f6aaRqhgHSl816HFm9nXq+rhUBv2x3rBlfeJzF3+oI0XniuPhuGcw==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr9352590wmg.29.1583588931283;
        Sat, 07 Mar 2020 05:48:51 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm11767265wmx.32.2020.03.07.05.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 05:48:50 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: rockchip: fix vqmmc-supply property name for rk3399 puma
Date:   Sat,  7 Mar 2020 14:48:40 +0100
Message-Id: <20200307134841.13803-4-jbx6244@gmail.com>
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
this error:

arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dt.yaml: mmc@fe320000:
'vqmmc' does not match any of the regexes:
'^.*@[0-9]+$', '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$', 'pinctrl-[0-9]+'

'vqmmc' is not a valid property name for mmc nodes.
Fix this error by renaming it to 'vqmmc-supply'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index c1edca387..07694b196 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -480,7 +480,7 @@
 };
 
 &sdmmc {
-	vqmmc = <&vcc_sd>;
+	vqmmc-supply = <&vcc_sd>;
 };
 
 &spi1 {
-- 
2.11.0


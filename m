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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF06C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CAB2073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlXZIfiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCGNsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:48:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52563 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCGNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so5395532wmc.2;
        Sat, 07 Mar 2020 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VLve4QZOuRtttmHJksSXthYkxNJhElAvXQoUiytCJzc=;
        b=FlXZIfiEIWMFhEVLOL5GVMFzGCcwtKgnQvfyeO8sq9XM/RyhZ85+CcrsY6eYOLr9yn
         Y+nemzpqsAvWmQ1tAbhbvfBeEU89TfTXfjly5SlKt2rdqf15qv0/z/risXb78S3NB69s
         A6uWtLhx5A/zaxl6k+XIdpj2ET77JgsUTZ9gkxaYDrVlIyliS+Ct6ZamdAXUf+xRrC4F
         XQ8EQaTEVwUwjEwdcsWjHGyqJ26+YFHF8HHIKTiLlDWzQRW7OgX1FaHS80FgawfiwJ7t
         IfkOiAETeWYfwbIMz/aHZDi6kTGIAmF3jzJ9ezdpmwe/BvLHymWiRxKxZ5EEXZDIrA7P
         pXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VLve4QZOuRtttmHJksSXthYkxNJhElAvXQoUiytCJzc=;
        b=O/xhlBCZME9VvUlY+DDqj7o3/fK745qvZ9np4NyPyd/5sesfq5lAu/EgFmmPGmlAdr
         vgLFXxE/Pq/05rPJLJzOCIpNj+oLSbg+33VmJUwI5+FKNPWLTHSgWFq7MQ/M3rkUpTBV
         uGfndX9Rd2MT+y7egMS96Dp/D+f1TEpV8quHIAB2KVb7Owq0hD6Zsd2dzQlwd13Cm6lK
         BitklS7Ehykihi4T0EV9vdwOYIq4U/3xaWw7BjHFfhydw0/ov3mAniklUlf4VlMygCej
         9HSoxUoktBcTB+/kcBop4FHiHciSHETJf7oTaW15UK6MSZ9ZmUnLZFko8OjNz9cQz27f
         wqWg==
X-Gm-Message-State: ANhLgQ05RmV9AltQvEB05BEZZGvfQhj/hlRhRjRa8slWWFP3G1WCcip4
        da6D7V1i0ldCqGkW6h3UYnU=
X-Google-Smtp-Source: ADFU+vuvl0cB7rvIyFZU3kahKrREdwlXP94ms7tqOWI9oFHrGV8FXQBxgtWGuP/NMjg+U5a2Yv0tGA==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr8224185wmb.81.1583588928440;
        Sat, 07 Mar 2020 05:48:48 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm11767265wmx.32.2020.03.07.05.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 05:48:48 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: dts: rockchip: fix vqmmc-supply property name for rk3188-bqedison2qc
Date:   Sat,  7 Mar 2020 14:48:37 +0100
Message-Id: <20200307134841.13803-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
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

arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: mmc@10218000:
'vmmcq-supply' does not match any of the regexes:
'^.*@[0-9]+$',
'^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$',
'pinctrl-[0-9]+'

'vmmcq-supply' is not a valid property name for mmc nodes.
Fix this error by renaming it to 'vqmmc-supply'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index ad1afd403..8afb2fd5d 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -465,7 +465,7 @@
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_bus4>;
-	vmmcq-supply = <&vccio_wl>;
+	vqmmc-supply = <&vccio_wl>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.11.0


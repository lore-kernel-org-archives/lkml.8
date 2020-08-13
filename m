Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FB320791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBBT5t5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:35:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BDC061757;
        Thu, 13 Aug 2020 12:35:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so7433158ejb.3;
        Thu, 13 Aug 2020 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12087FTp/9siWmAQYdka9CL+BX7dl2z7W64nVKUq+mY=;
        b=tBBT5t5o2REJgDO4g+TrwhTLSetN55ivpIQFldh6ISQntwzdiBKYqnJxQH5O9o4+CR
         DHui/QjNFZbzkEZQMxIvtUp+mrz3nMQCrLHivjoFbxWpf6W+OqMwXS17teRDeRA6u5kT
         4e0RgfFQiCS1tuB7wXdr3iK9YKx7sT0jsODiIzf0GtKyemv+f7XpDkyxYQG9rN6/+7lS
         egVZtnjLpyT0lvDRpHQVB6ONg7Ydnybksd21728Cw+WlQDTUHIKi4kAZhFp6Tlf6AdKH
         E3cF0aDwhHoXp7FaDSnIf19s9m7aYOMnYJN6gBi+t4gjyfmvoIz6/6uT1azYh8XyQq0C
         W64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12087FTp/9siWmAQYdka9CL+BX7dl2z7W64nVKUq+mY=;
        b=MR8EmkKrTj5IX4nSEJuZ7dsxtbfdfSw2nD6k4orA/CBfaCoSfbelAgDDDB5UFTeBTc
         8TPlc0chRFi9qGb2JWjk8EqRL20XquQoPUUC7V6nRZEPippLhyjed+FHl/uXy4wV+h5S
         n11/bwna3qv9nvLltZz+jAUSjsQW1DdhlMerFwAdSEx+zSEByAo1NolQD3SXnqrKbkBT
         aYK4JFIYT4gavy9x4WKXjuxamcrTVs3O6vPevV07jTkxNIy9NRNslcDkEG+0iD/+C9uL
         qGq/XkNTUj1W1N+8MrOg8rRoPuMKtAjWchCxfXQWdJiJ7hux7yPPpBsCZwxsh1bPz8j0
         XXvA==
X-Gm-Message-State: AOAM532JraNDtvq9ETp5WuyDnTpPwocQUwg9TkwhrNS0+SLASDAKQR5e
        eZFAk0XfKtGKkQKX+2oF4gNHI2JiqHQ=
X-Google-Smtp-Source: ABdhPJzxzJWAiaIXjEwIoz/ywgVFx1eH/wgrFrgxLMsQw0GYqiJify07ZgB3889gG5pzyXz6wyQ0/w==
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr6601465ejf.102.1597347302920;
        Thu, 13 Aug 2020 12:35:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d9sm4120603edt.20.2020.08.13.12.35.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:35:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: rockchip: rename and label gpio-led subnodes part 3
Date:   Thu, 13 Aug 2020 21:34:54 +0200
Message-Id: <20200813193455.19772-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'gpio-led' nodes were manually verified.
In order to automate this process leds-gpio.txt
has been converted to yaml. With this conversion a check
for pattern properties was added. In part 3 rename and label
gpio-led subnodes with pinctrl. To make things equal to other
dts files move pinctrl below the compatible property.

Fix with help of the following rules:

1: Add nodename in the preferred form.

2: Always add a label that ends with '_led' to prevent conflicts
   with other labels such as 'power' and 'mmc'

3: If leds need pinctrl add a label that ends with '_led_pin'
   also to prevent conflicts with other labels.

patternProperties:
  # The first form is preferred, but fall back to just 'led'
  # anywhere in the node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/
leds-gpio.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 7154b827e..bf808cda6 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -15,12 +15,12 @@
 
 	leds: gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&work_led_pin>;
 
 		work_led: led-0 {
 			gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
 			label = "kylin:red:led";
-			pinctrl-names = "default";
-			pinctrl-0 = <&led_ctl>;
 		};
 	};
 
@@ -367,7 +367,7 @@
 
 &pinctrl {
 	leds {
-		led_ctl: led-ctl {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.11.0


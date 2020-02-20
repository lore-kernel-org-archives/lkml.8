Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E585C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A58206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN4+M85M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgBTQZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:25:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46460 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgBTQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:25:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so4815690ljd.13;
        Thu, 20 Feb 2020 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kLCeh2hYjGPl6+22S9skiaS6Lwi7X9cC+fUScfOkfNs=;
        b=KN4+M85MvqR5gFb7czqWImi4xpcDKLXmqdj8vJd13/UVhbm+Ehz8HjJ45PCdv9t5hr
         EMiY0KvpZQfVFhJsYFB9ydYiaae3jiLf9CHCXv2yXKpHOBH0+QGl+/notDZh2iWObg4t
         niwC1nF9zN8OoE2gcR38Hqv2yu1jtyT3rVENUGhTKctAL/JQo0un1O3sTope2C/JCe3J
         9gPtSyu2s3GJ7wXuFTx/MpR8+K/A04Vh1ylVtqS0smwGUcHMC3+tir5AgZUl8V4KQD//
         hHPWYv06Drm2IxW8GGSZ41Aj7lekNPbGqULcbtgoyvYMn6gXNG5ytM+omknRtTv8sAzJ
         uNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kLCeh2hYjGPl6+22S9skiaS6Lwi7X9cC+fUScfOkfNs=;
        b=qemP5QpWVL9H4+ZYfo/7pkzOIFr3Uj2fmBKgUq66h5Mb5PlUvrhmj7T0O7IyGwjtlH
         4ysx6cwTHC37T5j2LHb2UKlMz+64Y4WnuoyAjMBETO1dfwr9OUnKtvd/EkvSoV8cSn9X
         rFse6eAIS98wbrw7PVq2RE15XjxV9CRYyLLjoQR93yZxd3iV/hhnna7rC9ZPOP6HJHz5
         Ff4lhpuzl8RTDBX6+mvXwu1zejEp1WXqnN2ETHDqfdnxmZNv5icnWiM4luIhB5GZv6Th
         QwGV82saf3GtXf+b/Sh8S9A8shJWOMMJN3CyzaWUlHewSFs08bcHnPOjgCNAeeysIxmz
         7/MA==
X-Gm-Message-State: APjAAAWVqEr80G3LDLAHzlaZHkc9AKluM88oChmSjC/jp6jjXoW5vKUC
        1JNNN6aN6I3JnlYG20gey3w=
X-Google-Smtp-Source: APXvYqzbjfJc19VrvFIqTzezHsniNvpL9Nn/rt4Xov1EelOo+z+JciRkBvpVmCJuqeULxMU6fKE13w==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr19455557lji.194.1582215951463;
        Thu, 20 Feb 2020 08:25:51 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b13sm2217956lfi.77.2020.02.20.08.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 08:25:50 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH] arm64: dts: meson-gxbb-vega-s95: fix bindings and bluetooth node
Date:   Thu, 20 Feb 2020 20:25:00 +0400
Message-Id: <1582215900-12716-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds missing bindings and fixes BT output.

Fixes: b07a11dbdfeb ("arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support")

Suggested-by: Oleg Ivanov <balbes-150@yandex.ru>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 5eab3df..0012779 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
@@ -245,6 +247,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.7.4


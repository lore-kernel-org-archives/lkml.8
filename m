Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E26207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK0CbIaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgERCzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERCy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:54:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34865C061A0C;
        Sun, 17 May 2020 19:54:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so8168108ljk.7;
        Sun, 17 May 2020 19:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2jFq9prhAH2wIK8gbzUKR9isfuzYq/gIMJSIzZWYu8E=;
        b=tK0CbIaIPpHV4gEM+abpdSUOYcpDl4B/nOcUHEziOVj3EUHlB8pHsOITbBcnsbu/tJ
         S+0SrN0fBP/JoVMkCUENN6b1hmeEVpBqFkCvdU1dddTqvF5J7coZWydu6ngNjw4WHb4f
         nrM1txpP6q3qhVlWTqG1BqTsXC8jaOBPqLIJK6h7FUtQqTr9P8XdI3t5sMNkZCICfxu0
         LO69wVLwPqU31KaFbGTQZ+5zzBN/4VHT0P80bj7r3GtBwNqtxD0fpH45w8E0+kinasr4
         XJDtcoaESd3jQSY4ERTbLzMJ9+zdwfp9IJA3Z6YDm8B37x8wsHSS148tQNUxmutMEZr3
         BpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2jFq9prhAH2wIK8gbzUKR9isfuzYq/gIMJSIzZWYu8E=;
        b=kdUE2rGTULpzO3hlo+GpW5WPkoygDAwazp23C3P3w+LbzS1EPRpOVIrEXQMdBjcvo5
         i+T5XDv0QQaCKSxPYTFNSRPWlkPmiYAQZXCRYp1OhHogcIrp5uttb3gs09KFMilswqwd
         P8kLmujk2pzSOf/Srsk8kCc51qz1XS5uzs941nul1grYMro3J7pTDRn2oVKo9Jn1fNL5
         h62MyMv/Er0qg6dO+nfS6hyKfyrilI7aMbYZqsR9XGVOH02QOM8ateGyouRnxcXsaZ9D
         PlL9Dg9J7OEzIsvrsKiRSMkTU+bcvz1r5vpKilrWjKapj+PsEnKJM7QTESLQsVU+62r0
         HBlw==
X-Gm-Message-State: AOAM530VfOEb657AkQbuXEbaKq9DxenfKAKmr9xNIOqQILs7JqnB8iIG
        Z/EjgyTUF/wjKknX+lAqKhI=
X-Google-Smtp-Source: ABdhPJyYzqTgPOAmvsxyCf7uSX8bDqWTZcSY82RpGn8VgcPggP06JGDFO93AVoCohi3Bqow+954rfA==
X-Received: by 2002:a2e:9b8d:: with SMTP id z13mr3094942lji.35.1589770496715;
        Sun, 17 May 2020 19:54:56 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id q21sm6849368lfe.0.2020.05.17.19.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:54:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add ethernet interrupt to wetek dtsi
Date:   Mon, 18 May 2020 02:54:51 +0000
Message-Id: <20200518025451.16401-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet interrupt details to the WeTek Hub/Play2 dtsi to resolve
an issue with Ethernet probing in mainline u-boot.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index d6133af09d64..ad812854a107 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -149,6 +149,10 @@
 			reset-assert-us = <10000>;
 			reset-deassert-us = <30000>;
 			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+			interrupt-parent = <&gpio_intc>;
+			/* MAC_INTR on GPIOZ_15 */
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
-- 
2.17.1


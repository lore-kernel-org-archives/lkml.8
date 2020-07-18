Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E2C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EA820809
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht7EAniV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGRF35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgGRF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:29:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344CC0619D2;
        Fri, 17 Jul 2020 22:29:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so2864711wrh.3;
        Fri, 17 Jul 2020 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rqatcQsvNnH489JiyTckIeyzp1Uk83CW3W6g2HlZiXI=;
        b=ht7EAniV2VwVIjDt2coFsLdF0qOfytsvxoXCTyI68FZcWBFnZV300S80lysLs4n0/+
         9ps8caWmmP+IDjMuoM2YfPIlp/seCkFSd9vRYPfeY+VY0dT9liPagwLbsw9QFD5fUdGN
         Hinf5h8xRRFDUWQRV6lKNror4mZr6gZHD+ra1HNxrXKylhJ7S31dsHk1YlB7fkkyhOCW
         iOVmoYngzhC/rx0jDxoI0EGrnrr26r0hvMLWpAzRXu+bC4yg9kxVf0WNL1KfEB5iKIg1
         67JBj/hcm4AxRHm96doGfMU1Rt4FS+UM7KMuZOAQaCtzbRWC/izujaAmBhtJsnVhDo68
         M85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rqatcQsvNnH489JiyTckIeyzp1Uk83CW3W6g2HlZiXI=;
        b=QA9zmFdEdXqYGRQDOLP2LUsBBfdpu514cHOBHbkAqTIk/4p7cxpevwwrR85CDjPvnc
         8cDDsrMdkBslbY2UTqFeemhaMcQOv1PHNqI4zQuFSyL+OCLEUElwySLix89TNVzEDlSf
         emUM1dLXFJBTHih0emdpmk7ZUvRZe9IoNnGaZ0QC0qyZDsFvtBMw2vkXxT6KBLNVApsX
         g1yO34XicJTKgzHvvQU9C4LEocnCenI31kCsI+4dLGyjL1qAcavpbXOSpfIIY83jDczk
         lTmRevTOvjpgDyMeumN+XPHolcz4Plh/QRlHQlKsl3heupS0HxRy3ZU42UEVQ7Sf1K6D
         on1g==
X-Gm-Message-State: AOAM533lWYAt+KTYKkFRkN9UeJVUqqHlmS9gQLyAgKxDHxtcm5LBG+gS
        6jfeQJF6x8P7Tl826xSjoUO8+nY9
X-Google-Smtp-Source: ABdhPJxIZIk8IpaHWGoqT3B44PSmWmajAlSFxLC+YGacclYjd9J4ahr2meIk1JK0DS4HW7oSiVnXww==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr12526132wrr.279.1595050194874;
        Fri, 17 Jul 2020 22:29:54 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r10sm18393722wrm.17.2020.07.17.22.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:29:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: misc fixups for w400 dtsi
Date:   Sat, 18 Jul 2020 05:29:50 +0000
Message-Id: <20200718052950.3707-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current devices using the W400 dtsi show mmc tuning errors:

[12483.917391] mmc0: tuning execution failed: -5
[30535.551221] mmc0: tuning execution failed: -5
[35359.953671] mmc0: tuning execution failed: -5
[35561.875332] mmc0: tuning execution failed: -5
[61733.348709] mmc0: tuning execution failed: -5

Removing "sd-uhs-sdr50" from the SDIO node prevents this. We also add
keep-power-in-suspend to the SDIO node and fix an indentation.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index 98b70d216a6f..2802ddbb83ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -336,9 +336,11 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	non-removable;
 	disable-wp;
 
@@ -398,7 +400,7 @@
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-	clock-names = "lpo";
+		clock-names = "lpo";
 	};
 };
 
-- 
2.17.1


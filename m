Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C154DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A0A21775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKpA5ANu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCAVUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:20:39 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:41973 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCAVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:20:39 -0500
Received: by mail-pl1-f169.google.com with SMTP id t14so3363827plr.8;
        Sun, 01 Mar 2020 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFTyi8DW0IuKC/6+mmSXVV/ifKvMR4lpHSQc45481xg=;
        b=tKpA5ANuIyP8IbtLlptofIZyr5COO4tZDOepft9b/F6Qq0qRXGTA1dzMY+3DTwm8OY
         SIU8qSqVw34+brjuSBKHlNwp5zNP7UMn1QozSMQegBj5Wrb5NfCZ2Uy+5g8XmL8eRLNv
         geuf+ISnAlJDqIXl8ym2HnAi+e5nOL35WDadRWd+JtfqQpJvcN1/fv7kGf75pqxr4kob
         9j1CZIac1mYIRCgL2LxEpc+dOxd7rV1FZQ7TOBwNGGkBMuDj+aRn/cQaFHlksyaFWTMH
         wzDv45QlZK0PjWM/yCHAxJKhqeYReS3DqBWpvZKdkF1+pGpH/PomdWeYTdHA1SnNz/sj
         4sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFTyi8DW0IuKC/6+mmSXVV/ifKvMR4lpHSQc45481xg=;
        b=F/yc/MopVkDbo8uE9rK9SUgyz637g3JtgAdWageNnDx0/drg4jSmXMxxvYtQd6S/ZQ
         NXPSIhKoyL2amYmvNcsviG5F7p9dyfL/9pVJNqugR/QNrScugnksYCmlapLMDcKEJJtq
         aLUBcJwjHAzRwt3j/cIMxmm8y3MsoPRAg0uYHGKH4YQwvSrJkhzVaXvlANyx/VkoFj5g
         t/rJsxuzLmeKKYBSegPWIaJ1icnvCvZVWKB4P4gua7W4Y6GAvbGHEVOOZ9cCaE9ndafO
         G5w3lTGgN4vscHXUvW4gmxbAL2eBAYA+37z1x6eVrl7ETxL9nj5v4jKJQ+Q9lnC7SBSv
         IXYw==
X-Gm-Message-State: APjAAAU08BeWQSNsur4bpJ/UgaomfihLzytU10ebghatCYIAwzaRtijl
        NxADj44OV2QA7wxJHjyUatR7oykG
X-Google-Smtp-Source: APXvYqxxO086EU0oDGLWKKeU0ppH/s01jURiRGoGxAUJ4jJA7gzPeMlYl8zy2POclwE7Yf9VtuasGQ==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr15411460plo.259.1583097637445;
        Sun, 01 Mar 2020 13:20:37 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id u19sm4547686pgf.11.2020.03.01.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:20:37 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/3] devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3 clocks support
Date:   Sun,  1 Mar 2020 21:20:16 +0000
Message-Id: <20200301212019.2248-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200301212019.2248-1-linux.amoon@gmail.com>
References: <20200301212019.2248-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new compatible string for Exynos5422 DWC3
to support enable/disable of core and suspend clk by DWC3 driver.
Also updated the clock names for compatible samsung,exynos5420-dwusb3.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Previous changes:
	Added the missing clock name for Exynos5420 complatible
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 6aae1544f240..220f729ac8eb 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -69,7 +69,9 @@ DWC3
 Required properties:
  - compatible: should be one of the following -
 	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5250/5420.
+					    Exynos5250.
+	       "samsung,exynos5420-dwusb3": for USB 3.0 DWC3 controller on
+					    Exynos5420.
 	       "samsung,exynos5433-dwusb3": for USB 3.0 DWC3 controller on
 					    Exynos5433.
 	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
@@ -82,6 +84,7 @@ Required properties:
                 Following clock names shall be provided for different
                 compatibles:
                  - samsung,exynos5250-dwusb3: "usbdrd30",
+                 - samsung,exynos5420-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
                  - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
                                               "phyclk",
                  - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
-- 
2.25.1


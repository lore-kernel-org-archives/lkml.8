Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BA32065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PDTBmh/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgGVTKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732552AbgGVTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:10:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B07C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so1793785pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9R0zBQZNkWUaNZ8knUV7ykpWNGLCPzZJT92AJTWbRM=;
        b=PDTBmh/KaH9xKwF325iZ9WPo/AQp+h19N7VfEHao+92WaTz1oW6s2LYiKVGr/ROIuf
         mMJ9UOycup+TSjb7NtRu1p9cqPfDMafKlpxxWrwS382VwydXQDv2R50Y9ngDU5/zsFJc
         07UzBgQioEKmfR0v7jVsz7kcYdwrp7fANyPY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9R0zBQZNkWUaNZ8knUV7ykpWNGLCPzZJT92AJTWbRM=;
        b=XmvbbCHC221UTPhMwu100VNKmWkLILCQYARuGvH7oxIz5smBE0XWKRLa63W8RYLvYM
         UpA64sWwi2EXEVGiSyoGxJnxjzA+rzMGWDNLQZ5jhsxujTjQtaHX8VQjW5i4y8i/QT1w
         4jU2a508+RdICPDrrYCu7MxfR8UCZ+6S83N04/1APhYv2CT04C4z+dbk7XguRwZZb5vj
         a/oZ56kI+53/Jvo/Ot4YBo+nZHrOMKcm0TjE4svlmaLN7GK3UOInqHRz3MwiqRb+ma5w
         RAu88ndaQHMS5YKfMEiW54rmnZDaN52LWHmfOhH2k2HL5hLuFByEdEz7NUh9sU6TMG83
         fOKg==
X-Gm-Message-State: AOAM532vwr4aCJJZlObdhOdNnygsDQ938zaI3gEZg2ImjmzzxmUAsijk
        hO2Wze1kmpcadNd87Z/jCnJLUA==
X-Google-Smtp-Source: ABdhPJx/pkpGCVF7ZJrH5L3zHr8u0P4E0FO+NstQq1Sv7MuBOlPkf5ejOUlbnfPCpatWluNziGAVlg==
X-Received: by 2002:a63:1406:: with SMTP id u6mr1100583pgl.108.1595445018595;
        Wed, 22 Jul 2020 12:10:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:fda7:aaf8:9d1a:6749])
        by smtp.gmail.com with ESMTPSA id n137sm342398pfd.194.2020.07.22.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:10:17 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 5/6] dt-bindings: arm: rockchip: Add ROCKPi 4C binding
Date:   Thu, 23 Jul 2020 00:39:48 +0530
Message-Id: <20200722190949.215656-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722190949.215656-1-jagan@amarulasolutions.com>
References: <20200722190949.215656-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for ROCKPi 4C which is similar to 4B with
additional mDP and HDMI port replaced with Micro HDMI port.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7250adb43d24..1faf1ce92dba 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -454,6 +454,12 @@ properties:
           - const: radxa,rockpi4b
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi 4C
+        items:
+          - const: radxa,rockpi4
+          - const: radxa,rockpi4c
+          - const: rockchip,rk3399
+
       - description: Radxa ROCK Pi N8
         items:
           - const: radxa,rockpi-n8
-- 
2.25.1


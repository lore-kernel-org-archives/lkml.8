Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52852080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l21Kp+H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIHUb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgIHUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:31:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE224C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:31:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so119480pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GinH/+WlUUwJ7OA+sMknkcAQqYifytKaKvguzz2CVE8=;
        b=l21Kp+H0v8uAYf7toyEqNp3Cy4s11aUKhZNJtNGZTVsWzEe+4XQnEK6SNIaJHitQmE
         gu0LHt6kxnMPygob8IiXd9ep45Ga6YVhpp9KCxHz+aHqmSm9f2FmAGW0zjo7cscXts8Q
         ngeAx0qvGqsdpZhohbQBiqI0ba9dNBOtJO8tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GinH/+WlUUwJ7OA+sMknkcAQqYifytKaKvguzz2CVE8=;
        b=mBjUJKl0reW3RuBxcUbEVbe8jJ6YwbOumCGuwkBA8kW2xSKfOyBsax9EPd5xLrViMW
         LpEHtdjAZfnfgKtrR54tsfHtvSXg413Gn5S3Vo11p5OXSoi3qNjm1PwLQo9FEQaXQhb+
         jlf64tE9qB3pLZ+yqupHr6rWfcTrBMxwVytkolGKvS/4MewhZhrdQfm+Tg5hbs9zn2lC
         JNbgnHAqS76cJB3tz0lbgrm+waKU0OIFUu0PKulDgLCSM12pr0M8q1k0lAAq5M7Satrt
         0pbeCAIVSu9Shxi9qT1J2jZjx7jfDiYKrHoyJw55gip+loRzMULOoK3W7bFu9oGIV8lS
         Zs7g==
X-Gm-Message-State: AOAM5338ICQLYZCpLjmFtUSGsesRDxG2o5GYPGWUv8vuCaRDuqSCTw/o
        yhnN05Kr4+lkv3ZjAJ20e4/8qg==
X-Google-Smtp-Source: ABdhPJxR1cfQbHMi4YHouw7fFkCUEVsDqRPvLhAz8c9yVtVO2T5nIYTRtwU1uGRh8JQFx6b5KMCvSg==
X-Received: by 2002:a17:902:d206:b029:d0:cbe1:e711 with SMTP id t6-20020a170902d206b02900d0cbe1e711mr793068ply.31.1599597113155;
        Tue, 08 Sep 2020 13:31:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id y7sm113620pjn.54.2020.09.08.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:31:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add sc7180-lazor sku2
Date:   Tue,  8 Sep 2020 13:31:17 -0700
Message-Id: <20200908133037.1.Ia98a6b938453254e360c4a9fa253d2d6807dff3f@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new SKU variant.  This is a pick from the downstream tree that
is the current source of truth for this platform.

Link: https://crrev.com/c/2386997
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/Makefile               |  1 +
 .../dts/qcom/sc7180-trogdor-lazor-r1-kb.dts     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5899101526a7..af5ff84889cb 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts
new file mode 100644
index 000000000000..c3f426c3c30a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include "sc7180-trogdor-lazor-r1.dts"
+
+/ {
+	model = "Google Lazor (rev1+) with KB Backlight";
+	compatible = "google,lazor-sku2", "qcom,sc7180";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
-- 
2.28.0.526.ge36021eeef-goog


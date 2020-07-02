Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70805C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48250208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHYTzLii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGBGYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgGBGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:24:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8DC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:24:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a205so18771258qkc.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iAAvm140uabXTl+jHo1MA3XpYMJqItzUT/T49Tq/jsE=;
        b=kHYTzLiiwAcymrEuy2t4xpNOUScn5Lchdcc0t1JjYbvXgAyblfAUldguvPrFi7PLsL
         OMO8k+MiyIOHXgBHn9cqSUo9/EL+vvY3zcwjjCrbIOXtzed3gWpla8EgWuFG7IaUyjUa
         KpievEzGpDkxAuuwmZ5LtpmfMjXczIXZcHrlEmBSgrei3aOLWhrE45hATpoT6SKkg91x
         hKlyrvyBHwteXHacR1PdKN+Hb+aLWoO1q0zUVJU35WVF50UbggaRcrDcPAfxl0RZtynv
         lSE9bipkznoS52wS+CJHh9YCG4FxQUBzvEPX7iLtHBZcNH3lLYrk4b5BptcgTQwH4y1B
         d3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iAAvm140uabXTl+jHo1MA3XpYMJqItzUT/T49Tq/jsE=;
        b=Tw1jr2vYUiwD0+s+0xUIgbEN0UAfhF0iG0fOsv2PNU0MrI6Jdciut96W44l6u9i1R/
         eSd9o9q8BhxR/Oic8X8jW9ENMpIaT1Ap2MiCq968UycN83yAzCRjktqgad2Mx/PimgoY
         mbMlLX7j9xsTydCUM1L2rdM3qNQPlthYrYQabTAyXWqC/hBQLk4TmmLsrRL6O/iH1ptI
         YiEjowxYuje1xIUgjLye+3KsvzZwtuMQ4AImWyTCeJNNz/B6RPazlHU76rdSqkiCPUdp
         RLeJo5TpUOqPBKo9Xqr93AD9PRpBgRrhioZbAzjqN9cMJsW1T9UFBLQ1EVsdJXPtin4i
         GKOQ==
X-Gm-Message-State: AOAM531WFZp5GLZcR+io64lhiH2x2TI1VcF+d3HXfWLPgtWHBpBlwuAw
        1Ryx6wuPBtLAJ+jrCovzDvp8oMmQVMYE
X-Google-Smtp-Source: ABdhPJx5gWyUPIpirkdQ+kayP/qflMJSBQVvzakrGUJ3dxaXfYaUR0EhWXVX6sjNNxNRPVQuX/3W7A5g8oJn
X-Received: by 2002:a0c:ab55:: with SMTP id i21mr29086666qvb.139.1593671046028;
 Wed, 01 Jul 2020 23:24:06 -0700 (PDT)
Date:   Thu,  2 Jul 2020 16:23:20 +1000
In-Reply-To: <20200702062320.2903147-1-amistry@google.com>
Message-Id: <20200702162231.v2.4.Ia24db14ffcd7803db3a728e15fa9fb2e6ce83e0b@changeid>
Mime-Version: 1.0
References: <20200702062320.2903147-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 4/4] arm64: dts: mediatek: Update allowed mt6397 regulator
 modes for elm boards
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsin-hsiung.wang@mediatek.com, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the allowed mt6397 regulator modes for elm (and derivative)
boards to use named constants.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

Changes in v2:
- Introduce constants in dt-bindings
- Improve conditional readability

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a5a12b2599a4..e9cfded307b3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
 #include "mt8173.dtsi"
 
 / {
@@ -926,7 +927,8 @@ mt6397_vpca15_reg: buck_vpca15 {
 				regulator-max-microvolt = <1350000>;
 				regulator-ramp-delay = <12500>;
 				regulator-always-on;
-				regulator-allowed-modes = <0 1>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-- 
2.27.0.212.ge8ba1cc988-goog


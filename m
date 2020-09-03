Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E5C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BA1208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160456;
	bh=zcPjSOyp5Dki4rv1iK/4c15JsC0Bdplu3k5SOqRm7MU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NVMjUQGpopOCINKvqqX2+BjJNXrqvqSkUJ53IH9i/sCya6az88tJ3LjPcdiSLVPoH
	 HWF37sj2m5yx+hiBk9S4l93lCjJXBMmmI9fV6AzzfPQT+TgwSxf3P5ApfBk7J711UG
	 eUPS+z2sekNgUcbUh9VMfrxqvaWkwUbtPmhalIN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgICTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgICTOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC37F208CA;
        Thu,  3 Sep 2020 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160453;
        bh=zcPjSOyp5Dki4rv1iK/4c15JsC0Bdplu3k5SOqRm7MU=;
        h=From:To:Cc:Subject:Date:From;
        b=coFuuOh5ogZ55RKLGWY4h8ZqIU+UDx9nY/t+w0KqKw3AGae1weIMagpOgnyk6FQs6
         9N4/P6SV21/8o0bSkCewaSuN+k8+kBuMuMMDGNDuspfdfixIAM1+/7Wu/FzhgFhzs+
         DpsqJ2xUT2JmDBy65NACZMaW4u272Ufmst8nt+5s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: google,cros-ec: Add missing properties
Date:   Thu,  3 Sep 2020 21:14:07 +0200
Message-Id: <20200903191407.12686-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (controller-data,
wakeup-source) to partially fix dtbs_check warnings like:

  arch/arm/boot/dts/exynos5250-snow.dt.yaml: embedded-controller@1e:
    'keyboard-controller', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'

  arch/arm/boot/dts/exynos5800-peach-pi.dt.yaml: cros-ec@0:
    'controller-data', 'i2c-tunnel', 'keyboard-controller' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 6a7279a85ec1..f49c0d5d31ad 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -30,6 +30,11 @@ properties:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
 
+  controller-data:
+    description:
+      SPI controller data, see bindings/spi/spi-samsung.txt
+    type: object
+
   google,cros-ec-spi-pre-delay:
     description:
       This property specifies the delay in usecs between the
@@ -63,6 +68,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  wakeup-source:
+    description: Button can wake-up the system.
+
 required:
   - compatible
 
-- 
2.17.1


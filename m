Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A78BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB8F20885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593705120;
	bh=apLz+zrhUgxyrfqkQLdEuC5ASVc2V3MNWdOwzPav1VI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WXs8Y+w/s3qNeJYblZjh3cIa9+S4fEGKuDDor1TL4qDCfKkOdS20VA0tkerSizvIs
	 1IpRQ9DtAIjBdT5MLc1krWVEF1Yf7uOe8YM+lWWt0yM0vYpMQjm+9WFXahpYUnNx4v
	 vxweRXNQL4ormy4yoEqBL2uuYkl62EYRGUGIj0Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgGBPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGBPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:51:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226ED20771;
        Thu,  2 Jul 2020 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705117;
        bh=apLz+zrhUgxyrfqkQLdEuC5ASVc2V3MNWdOwzPav1VI=;
        h=From:To:Cc:Subject:Date:From;
        b=bY6BgyAp1lfg3CkxpD7UVA6yNiwl/Pu74JlyfZdlt7G/VwPG7Ww04+pPn9V7tORU6
         SJc5dq1zFueUWiw1cIqs2eym1caoWtp3VyhhS19iLX82N/6QYj+MyNPPkOWzpq3lq+
         oGbrGr06R1STimaY8RUBRciMx6n5iDrWw+HQnnn8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require interrupts on Exynos SoCs
Date:   Thu,  2 Jul 2020 17:51:42 +0200
Message-Id: <20200702155149.12854-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings required interrupts for all SoCs but actually only the PWM
timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
clocksource driver is not used on Exynos SoCs thus the interrupts can be
marked as optional.

Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 .../devicetree/bindings/pwm/pwm-samsung.yaml  | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index fc799b0577d4..188679cb8b8c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -18,9 +18,6 @@ description: |+
 
   Be aware that the clocksource driver supports only uniprocessor systems.
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
     enum:
@@ -63,7 +60,8 @@ properties:
 
   interrupts:
     description:
-      One interrupt per timer, starting at timer 0.
+      One interrupt per timer, starting at timer 0. Necessary only for SoCs which
+      use PWM clocksource.
     minItems: 1
     maxItems: 5
 
@@ -88,12 +86,27 @@ required:
   - clocks
   - clock-names
   - compatible
-  - interrupts
   - "#pwm-cells"
   - reg
 
 additionalProperties: false
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s3c2410-pwm
+              - samsung,s3c6400-pwm
+              - samsung,s5p6440-pwm
+              - samsung,s5pc100-pwm
+    then:
+      required:
+        - interrupts
+
 examples:
   - |
     pwm@7f006000 {
-- 
2.17.1


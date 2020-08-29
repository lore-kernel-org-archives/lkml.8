Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F900C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6811A206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711426;
	bh=yRtU1Fa0o9ZoIFsQKUqrspZV2ksZuSwlryG7FVqDwNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2/LdW7SciH8vTYMNcMCfF4IMBpBRyerWdkb353NYzyF9gBbDeKRWwv+/qCpZnwFk
	 yEDA0k6Kc2KM0nWC4ubAatrpj+FJphU5Q3nb0asePmxsxNfDcEQkMEyUFvDjXyxGg5
	 rGYUMzlGaoxobb7CQawU8GNAUcPh3/utpGfFrgS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgH2OaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgH2OaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:30:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE01A20791;
        Sat, 29 Aug 2020 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711400;
        bh=yRtU1Fa0o9ZoIFsQKUqrspZV2ksZuSwlryG7FVqDwNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNrV564qQdiRjx+h72CUgMXZF/mu13WUvcNPkqEbgx8ruJtBfL0VmHu656yApGtU8
         dkhcdetdb1dyhtn9kivUkIMl2z+nLCzgDjmXS1FlGVyGbeh2KgTjMmbjFAzKlVE+2K
         YfCE5vr7yyktrNrG7qgX1T/ifuwgKDeqA+/+NAAY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfc@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 2/4] dt-bindings: net: nfc: s3fwrn5: Remove wrong vendor prefix from GPIOs
Date:   Sat, 29 Aug 2020 16:29:46 +0200
Message-Id: <20200829142948.32365-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142948.32365-1-krzk@kernel.org>
References: <20200829142948.32365-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree property prefix describes the vendor, which in case of
S3FWRN5 chip is Samsung.  Therefore the "s3fwrn5" prefix for "en-gpios"
and "fw-gpios" is not correct and should be deprecated.  Introduce
properly named properties for these GPIOs and rename the fw-gpios" to
"wake-gpios" to better describe its purpose.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/net/nfc/s3fwrn5.yaml  | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/s3fwrn5.yaml
index c22451dea350..1f13b4553db4 100644
--- a/Documentation/devicetree/bindings/net/nfc/s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/s3fwrn5.yaml
@@ -14,28 +14,40 @@ properties:
   compatible:
     const: samsung,s3fwrn5-i2c
 
+  en-gpios:
+    maxItems: 1
+    description:
+      Output GPIO pin used for enabling/disabling the chip
+
   interrupts:
     maxItems: 1
 
   reg:
     maxItems: 1
 
+  wake-gpios:
+    maxItems: 1
+    description:
+      Output GPIO pin used to enter firmware mode and sleep/wakeup control
+
   s3fwrn5,en-gpios:
     maxItems: 1
+    deprecated: true
     description:
-      Output GPIO pin used for enabling/disabling the chip
+      Use en-gpios
 
   s3fwrn5,fw-gpios:
     maxItems: 1
+    deprecated: true
     description:
-      Output GPIO pin used to enter firmware mode and sleep/wakeup control
+      Use wake-gpios
 
 required:
   - compatible
+  - en-gpios
   - interrupts
   - reg
-  - s3fwrn5,en-gpios
-  - s3fwrn5,fw-gpios
+  - wake-gpios
 
 examples:
   - |
@@ -53,7 +65,7 @@ examples:
             interrupt-parent = <&gpa1>;
             interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 
-            s3fwrn5,en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
-            s3fwrn5,fw-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
+            en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.17.1


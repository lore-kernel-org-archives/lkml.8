Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316CC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B002073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vJPkEeJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgDAIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:39:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30396 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgDAIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:39:49 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318cr5K028133;
        Wed, 1 Apr 2020 10:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qWbSrOJCI90YANyiMWSeBsBNnDP7Y5LT4/yIPcQXcb4=;
 b=vJPkEeJ1tq13Gf3gmUvInOrPmt92KtOS4VIptuWs8OsdY3Tp8MM+RY0gKkaLN4qqx/IZ
 Zm4jGHI0TEmvX2kloUlQIpyDYJA4veKdvEcuSpo+hn5Ub84LdZ00GNllm7xX4OLEjPU+
 45OdGZHk5muRW8gpayvGXPkbGQOQlnpDuGZbNb883amyX2Fqc4w+PGE+nko3LkT0otEe
 5oH/cMlkNCR17N+KL393LjWu52fHK2rUvWFzYC1A4i246b3beI6LqMI3e0fpQZoo5LEv
 7qNaTrDRTHLe7YQ2o+mN1+DPbw6YHn+ugngiCKLILHzdA7Gdg/u8KftjulsZz6kdX5vr 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y53x221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:39:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A77B100034;
        Wed,  1 Apr 2020 10:39:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F197C21CA8F;
        Wed,  1 Apr 2020 10:39:34 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr 2020 10:39:34
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v6 1/6] dt-bindings: mfd: Document STM32 low power timer bindings
Date:   Wed, 1 Apr 2020 10:39:04 +0200
Message-ID: <20200401083909.18886-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200401083909.18886-1-benjamin.gaignard@st.com>
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subnode to STM low power timer bindings to support timer driver

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
version 6:
- only use one interrupt

version 5:
- the previous has been acked-by Rob but since I have docummented
  interrupts and interrupt-names properties I haven't applied it here.

version 4:
- change compatible and subnode names
- document wakeup-source property

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index 1a4cc5f3fb33..2a99b2296d2b 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -33,12 +33,17 @@ properties:
     items:
       - const: mux
 
+  interrupts:
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
   "#size-cells":
     const: 0
 
+  wakeup-source: true
+
   pwm:
     type: object
 
@@ -81,6 +86,16 @@ patternProperties:
     required:
       - compatible
 
+  timer:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-lptimer-timer
+
+    required:
+      - compatible
+
 required:
   - "#address-cells"
   - "#size-cells"
@@ -94,11 +109,13 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     timer@40002400 {
       compatible = "st,stm32-lptimer";
       reg = <0x40002400 0x400>;
       clocks = <&timer_clk>;
       clock-names = "mux";
+      interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
       #address-cells = <1>;
       #size-cells = <0>;
 
@@ -115,6 +132,10 @@ examples:
       counter {
         compatible = "st,stm32-lptimer-counter";
       };
+
+      timer {
+        compatible = "st,stm32-lptimer-timer";
+      };
     };
 
 ...
-- 
2.15.0


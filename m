Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E26C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0020787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="h3Vg+Wm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgCaIcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:32:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbgCaIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:32:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V8RAVq026922;
        Tue, 31 Mar 2020 10:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=UvUiuQXXX/lmwa34ZnG6SSANaGi47hg/fFk3TsJH6HU=;
 b=h3Vg+Wm4fycqUNzJ9Qant4f7R4hHkwNV0rG2XlarDQ5sjPuhEgtO7tWDl6AxX/rkgZv4
 n/KLFjQmaEU2Yaop5QCZosTMfm987uQ+C/Adhf0pVUl6Zpk7ae9RknvhN8ayK1wBlKih
 mte9Ys/D4VZpUmD/a6BnZE/3C63uJOeT78GqHsRkOjy0pZ84JYBZOhRXePjwTxxG5qmW
 PAimFJnUMDrQ02IfIcW/iawhq9dD+f11S6b8uib/KLLTWvwbcXWiaRmRHYrzoZJwtCT2
 t1363+OVeVk6eZo2mjWnxoMN0GMgKYwl/tQo3iIZ6P0nwTpSqaDfRFTh6H65+K/u5KJS Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301vkdp6r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 10:32:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8375F100034;
        Tue, 31 Mar 2020 10:32:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 73F0621E677;
        Tue, 31 Mar 2020 10:32:01 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 10:32:00
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
Subject: [PATCH v5 1/6] dt-bindings: mfd: Document STM32 low power timer bindings
Date:   Tue, 31 Mar 2020 10:31:41 +0200
Message-ID: <20200331083146.10462-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200331083146.10462-1-benjamin.gaignard@st.com>
References: <20200331083146.10462-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subnode to STM low power timer bindings to support timer driver

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 5:
- the previous has been acked-by Rob but since I have docummented
  interrupts and interrupt-names properties I haven't applied it here.

version 4:
- change compatible and subnode names
- document wakeup-source property

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index 1a4cc5f3fb33..2809c4a186c4 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -33,12 +33,28 @@ properties:
     items:
       - const: mux
 
+  interrupts:
+    items:
+      - description: timer event interrupt
+      - description: wake up interrupt
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: event
+      - const: wakeup
+    minItems: 1
+    maxItems: 2
+
   "#address-cells":
     const: 1
 
   "#size-cells":
     const: 0
 
+  wakeup-source: true
+
   pwm:
     type: object
 
@@ -81,6 +97,16 @@ patternProperties:
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
@@ -94,11 +120,15 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     timer@40002400 {
       compatible = "st,stm32-lptimer";
       reg = <0x40002400 0x400>;
       clocks = <&timer_clk>;
       clock-names = "mux";
+      interrupt-names = "event", "wakeup";
+      interrupts-extended = <&intc GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+                            <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
       #address-cells = <1>;
       #size-cells = <0>;
 
@@ -115,6 +145,10 @@ examples:
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


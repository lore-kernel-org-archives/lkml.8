Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47137C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2315A206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="muDi0CJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDTMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:16:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDTMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:16:40 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBrrvo025502;
        Mon, 20 Apr 2020 14:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=QP2tbu5dwpD9e8Zu7LVjrUW0dMsgcQdi5gD98XyB37I=;
 b=muDi0CJDJC4idzu8cGs0J+9H+sWwe9jbbsL7PUL7A/EqjQw9LaycchW0MHcWuUZxNfLc
 ZVag80+fWXsOABm4+l6wXCJPBus3y55/iXS7NbNUk4a6Ek7ny5VN8sQo+ojDl69nxTWQ
 4XBWs/yK6cRwiMQ0q4FCnIagFH90VPzi8oQ6dDy7KOXqZJGGCvN1zgx4OC8aHTEhirgh
 nB11cEdiHzX9g2I0tPqo1U7tBuaIwHvfGq/r1eT1FSS2XrnIa4gQ6WD7gooLcimzYZxa
 VBp7ptw4Dai9iFoUZmp7dJVvmaDZ53hwNhnREIKn5dfyThtYsB5LryyXARDm8xnj8gZP eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11a66j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 14:16:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 315DA10002A;
        Mon, 20 Apr 2020 14:16:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D4C8F20FA76;
        Mon, 20 Apr 2020 14:16:26 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Apr 2020 14:16:25
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
Subject: [PATCH v7 1/6] dt-bindings: mfd: Document STM32 low power timer bindings
Date:   Mon, 20 Apr 2020 14:16:15 +0200
Message-ID: <20200420121620.2099-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200420121620.2099-1-benjamin.gaignard@st.com>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subnode to STM low power timer bindings to support timer driver

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index ddf190cb800b..2a99b2296d2b 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -33,6 +33,9 @@ properties:
     items:
       - const: mux
 
+  interrupts:
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
@@ -106,11 +109,13 @@ additionalProperties: false
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
 
-- 
2.15.0


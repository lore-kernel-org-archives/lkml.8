Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B921C34023
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MIjRGjfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBQNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:46:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727135AbgBQNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:46:08 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HDguYC011549;
        Mon, 17 Feb 2020 14:45:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=JdvFCHNI6jzPSKXjuDoAcaFc+WamuN6rhJfZvw7jqRk=;
 b=MIjRGjfW2U2/NcxtKVa8WNVcMKOtR5klk6893x5AGc+dPbBFCcZEWUvXP6dWO+y622ui
 Al48na4jMXpYv/bNWDxhd1YR/g4GAl3ZiEcd/v68R6JVlR8uxMznqLUiLC+3spO+nwm4
 wz/vZYdp0w/XvDsyuE98SDIlhrxkbNHxGRyqxUjq4qa0CF+1I8eBOH3EY3Svb2huQ/cZ
 m19AWzHY8V5AIN5uYZuhR2piApcIg7rsdolQ1p9C+BgBsRU75kQmAyubA5Yk6dHtXHKM
 /Ua7+iWkcojCYh5zkZnLK8YjLA5SPmol6RF78zW3PtQlOyntNcWm1CikjzrBYSD1AAAi Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y66nduqmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:45:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41EBC10002A;
        Mon, 17 Feb 2020 14:45:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D1782FF5C7;
        Mon, 17 Feb 2020 14:45:50 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Feb 2020 14:45:49
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 1/3] dt-bindings: mfd: Document STM32 low power timer bindings
Date:   Mon, 17 Feb 2020 14:45:44 +0100
Message-ID: <20200217134546.14562-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200217134546.14562-1-benjamin.gaignard@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_08:2020-02-17,2020-02-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subnode to STM low power timer bindings to support timer driver

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 4:
- change compatible and subnode names
- document wakeup-source property

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index 1a4cc5f3fb33..ddf190cb800b 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -39,6 +39,8 @@ properties:
   "#size-cells":
     const: 0
 
+  wakeup-source: true
+
   pwm:
     type: object
 
@@ -81,6 +83,16 @@ patternProperties:
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
@@ -115,6 +127,10 @@ examples:
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


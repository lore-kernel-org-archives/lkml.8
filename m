Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F557C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DAA20897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oAdAxGYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgFRNHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:07:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgFRNHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:07:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ID2ZVf030156;
        Thu, 18 Jun 2020 15:07:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=wzZNcYBfyuUeNiTtVen51N6/kCN5vjlsNYLVHoB5I1A=;
 b=oAdAxGYNAqXNISIMfpu6F7A2plIhnbbyY82kJ4K6Q3tUNw6HZQ/IbOIeizV1OgbHdghB
 Ra4ZHCnBrxYdLr2yLFl9YLTdsByD3OACm9Rdv96xR10vie6X3HOrzHCoN6lj2Y012Owm
 jn2HJmRaVIGLs3A8GWse3kDi/bVmm4kAit885Vo1iZ51wVu4GuHkCFfMUnwcT/ptbQO+
 yW7PBpCApFW1FpWzqLS4PzwLXaKsUzJ+eHvAZxfJgg7sOfVH8dLtfr+jwwcKnZFS1Zmx
 581JUZ6BYRim+d3pi0i7+hYMTeS29ZY06KfexohQm1IFyoWu42mAoe0rig/jGA9ep8rF zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31q64cb3ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 15:07:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30FFD10002A;
        Thu, 18 Jun 2020 15:07:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 248C62B8A0D;
        Thu, 18 Jun 2020 15:07:01 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun 2020 15:07:00
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 3/5] ARM: dts: stm32: add usart3 node to stm32mp157c-ev1
Date:   Thu, 18 Jun 2020 15:06:49 +0200
Message-ID: <20200618130651.29836-4-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618130651.29836-1-erwan.leray@st.com>
References: <20200618130651.29836-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the usart3 node to stm32mp157c-ev1 board. usart3 pins are connected to
GPIO Expansion connector. usart3 is disabled by default.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

Changes in v2:
 - Add a comment to indicate how to wire USART3_RTS flow control to the GPIO
   expansion connector on ev1. 

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index b19056557ef0..85628e16d2d5 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,6 +19,7 @@
 
 	aliases {
 		serial0 = &uart4;
+		serial1 = &usart3;
 		ethernet0 = &ethernet0;
 	};
 
@@ -341,6 +342,20 @@
 	};
 };
 
+&usart3 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&usart3_pins_b>;
+	pinctrl-1 = <&usart3_sleep_pins_b>;
+	pinctrl-2 = <&usart3_idle_pins_b>;
+	/*
+	 * HW flow control USART3_RTS is optional, and isn't default wired to
+	 * the connector. SB23 needs to be soldered in order to use it, and R77
+	 * (ETH_CLK) should be removed.
+	 */
+	uart-has-rtscts;
+	status = "disabled";
+};
+
 &usbh_ehci {
 	phys = <&usbphyc_port0>;
 	status = "okay";
-- 
2.17.1


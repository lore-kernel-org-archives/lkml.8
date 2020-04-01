Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB5C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EAB20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JoZlrTrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgDAPEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:04:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29004 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732929AbgDAPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:04:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031EqsJa011860;
        Wed, 1 Apr 2020 17:03:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ia/w/Dr7BasELP+Rh61NrAVeUw12Ky4ZCp/8xxycRqk=;
 b=JoZlrTrSP5foMhcxBSj+XDsO/Way7ED7GXPtjVK7Np3kufuxQAgb7/DZ3BWZZePZK3HI
 SMYe6oFoZViQhNFXcDLqrZ0be6N3HOXdDbqTP8I6jLbtwN9smYR8xaNB/yGZmsO0XoM6
 yEVQJ7ErGYLBBgQus4qHBPJgqJWM7jr499hYCAVL2hFI1Yz6GNZD8Eq60Lm+d6n3Docw
 i0E5o5/qDrNPikpBP218jGQ91iiT7hwpvf3OIpkzNguksFrlVfHOZw3kZqEtILwxn0hp
 fXCu09/lOTJSGLb4cuuu6As03Ff9FYgEaRZVuCDrXG584Yt7vuG7KRi8XyFvYVzAWkBX vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y5402um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 17:03:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE7E9100034;
        Wed,  1 Apr 2020 17:03:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7486A2B3A4B;
        Wed,  1 Apr 2020 17:03:49 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr 2020 17:03:49
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2] ARM: dts: stm32: add cortex-M4 pdds management in Cortex-M4 node
Date:   Wed, 1 Apr 2020 17:03:39 +0200
Message-ID: <20200401150339.7933-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add declarations related to the syscon pdds for deep sleep management.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
v2: patch rebasing

 arch/arm/boot/dts/stm32mp151.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 5260818543e5..a40772eac487 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1124,6 +1124,11 @@
 			};
 		};
 
+		pwr_mcu: pwr_mcu@50001014 {
+			compatible = "syscon";
+			reg = <0x50001014 0x4>;
+		};
+
 		exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
@@ -1700,6 +1705,7 @@
 			resets = <&rcc MCU_R>;
 			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
 			st,syscfg-tz = <&rcc 0x000 0x1>;
+			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1


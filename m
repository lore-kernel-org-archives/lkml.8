Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E9C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0D52075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EmajLjxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEEHdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:33:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgEEHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:33:41 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0457XE8i019011;
        Tue, 5 May 2020 09:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=iGCDghN3T5Y00zNouGbtPQSvGhwl/OIHxAZ2MQmEADQ=;
 b=EmajLjxqcwUHcoKFOnS/MbPJFNI09jkypCeIsZf9g1TVhc5Zb+ixhiVdNqoy96bu/ktQ
 KAkOLbJAlMdGRbwVrlDws8jkZ8ZA72Edw6KZWfpF82PcD69caXHNDQNkBLJzU1sDLhn4
 GSqG35pnXN5cLuuePB9yMDOjv2rMEZURG7cpXAGtoxYwdc8WP+Je1ipKG7xDYqFVHq/T
 ynRYajyApOLE5vL1hvIAEFz1xvP+c5UCDBHSJMIiLkjpYH00v23AQIQZtL3dNRVPlrck
 FTA8/mMTMjZA9ES3Qq/Ig9h4ZrJozqcZk2dggRXb6og0RyLwHOdzYo2Fu9JlV7rQSis4 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxmveesn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 09:33:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2785100034;
        Tue,  5 May 2020 09:33:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A62F62A4927;
        Tue,  5 May 2020 09:33:30 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 May 2020 09:33:29
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <gregkh@linuxfoundation.org>,
        <loic.pallardy@st.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 5/5] ARM: dts: stm32: Use ETZPC firewall bus
Date:   Tue, 5 May 2020 09:33:08 +0200
Message-ID: <20200505073308.22914-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200505073308.22914-1-benjamin.gaignard@st.com>
References: <20200505073308.22914-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_04:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow STM32 ETZPC to check firewall configuration before populating
the platform bus.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3ea05ba48215..0290eb6f3c35 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -4,6 +4,7 @@
  * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/bus/stm32/stm32-etzpc.h>
 #include <dt-bindings/clock/stm32mp1-clks.h>
 #include <dt-bindings/reset/stm32mp1-resets.h>
 
@@ -110,8 +111,10 @@
 		status = "disabled";
 	};
 
-	soc {
-		compatible = "simple-bus";
+	etzpc_bus: soc@5c007000 {
+		compatible = "st,stm32-etzpc-bus", "simple-bus";
+		reg = <0x5c007000 0x400>;
+		#firewall-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		interrupt-parent = <&intc>;
-- 
2.15.0


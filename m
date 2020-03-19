Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F99120739
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="V+mZ7etU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCSKbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:31:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13864 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgCSKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:31:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JASqwX011436;
        Thu, 19 Mar 2020 11:30:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=T6KxkBVdSlvswEwEr/fHrokZ23VjltZtaEhbr8esy5Y=;
 b=V+mZ7etU3SXK2Sgi/eC0JJJcC0C2b6+W/lPBlCAm7cql5HaWiqr1nCquGskoO938ojO3
 TdSa/73rQ4/9Vvydn+LYsfxmm9I3QKhZN0JEy+AOwUCnb0aeS/71iN2Yva50ffyWCgq9
 I0MCbyxNAYcW/39U+TDk9ZKbSkOZsYCL8JGlcJt3G2UCWPWPGhcKA1ZyR7oHBgPqpjgV
 d5U7uQKSx9mtCf1tjaEMXBLZGcjHBReEe4BlbVciglZhy7j4HO9qOoGTq5xv49RadOwH
 UDbgdOcwmZUUsC+ZbjX8ZrM2hb9dppXkrhQGS0VR4mTJn5+H9X7tbTD8lWRFOJtMYtOh AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu6xdhk8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 11:30:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12BCD100038;
        Thu, 19 Mar 2020 11:30:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0ED82A5824;
        Thu, 19 Mar 2020 11:30:53 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar 2020 11:30:53
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: fix a typo for DAC io-channel-cells on stm32mp15
Date:   Thu, 19 Mar 2020 11:30:26 +0100
Message-ID: <1584613826-10838-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_02:2020-03-19,2020-03-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo on STM32MP15 DAC, e.g. s/channels/channel

Fixes: da6cddc7e8a4 ("ARM: dts: stm32: Add DAC support to stm32mp157c")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3ea05ba..5260818 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -550,14 +550,14 @@
 
 			dac1: dac@1 {
 				compatible = "st,stm32-dac";
-				#io-channels-cells = <1>;
+				#io-channel-cells = <1>;
 				reg = <1>;
 				status = "disabled";
 			};
 
 			dac2: dac@2 {
 				compatible = "st,stm32-dac";
-				#io-channels-cells = <1>;
+				#io-channel-cells = <1>;
 				reg = <2>;
 				status = "disabled";
 			};
-- 
2.7.4


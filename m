Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C31AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6447121739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FWSZDpXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgCDIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:10:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728744AbgCDIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:10:29 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02487rix032637;
        Wed, 4 Mar 2020 09:10:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=eCzixOUfq5r9UpQnewtb7MxuweEMYFpNFZEz0vgGxiY=;
 b=FWSZDpXjEYgq2r2Q26HrIUhJc8yu109joF/LALnFKZkC+hfIAjg7g+FulJaSRFrjjS/W
 41JaMB8WpI29FqZE5o49S/9yNlL+uyReVWGznXEP7kXkiFoF/DiFeY6U+vf0oazGT9LK
 IQmSVmE9HBy5M/IQguhYUtSWxsPGWNx2WpHJ4DxfI2RfMozmnJWUMjmC4QQIpcKH7LNw
 m42mce8cmCfmCcXhaQh/nuugsUG73Xn+poVxQpBWIlvFjNS1ieE5pFtFZqx9NGu9Pze5
 z7n7OTCsdnhZO47dmyb17LEGX+VHw5yK8DIjKczgw4Z26dXh7V3IHBPWmS3CTGVaXZr0 XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfem0ybwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 09:10:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B85DC10003A;
        Wed,  4 Mar 2020 09:10:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6E6D21FE85;
        Wed,  4 Mar 2020 09:10:06 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar 2020 09:10:06
 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yann Gautier <yann.gautier@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: add cd-gpios properties for SD-cards on STM32MP1 boards
Date:   Wed, 4 Mar 2020 09:09:54 +0100
Message-ID: <20200304080956.7699-2-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304080956.7699-1-yann.gautier@st.com>
References: <20200304080956.7699-1-yann.gautier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broken-cd properties are replaced with cd-gpios, with the correct
GPIO to detect the card insertion. The GPIO lines require a pull-up.

Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 2 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts       | 2 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index cbfa4075907e..2bdfab192a39 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -300,7 +300,7 @@
 	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
 	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
 	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
-	broken-cd;
+	cd-gpios = <&gpioi 8 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	st,sig-dir;
 	st,neg-edge;
 	st,use-ckin;
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1fc43251d697..5daaec3aec9b 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -313,7 +313,7 @@
 	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
 	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_a>;
 	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_a>;
-	broken-cd;
+	cd-gpios = <&gpiog 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	st,sig-dir;
 	st,neg-edge;
 	st,use-ckin;
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index f6672e87aef3..02d52eb3c34f 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -479,7 +479,7 @@
 	pinctrl-0 = <&sdmmc1_b4_pins_a>;
 	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
 	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
-	broken-cd;
+	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	st,neg-edge;
 	bus-width = <4>;
 	vmmc-supply = <&v3v3>;
-- 
2.17.1


Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA67C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD70620897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WVz26Pwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgFRNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:07:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57000 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbgFRNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:07:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ID2ZvO030173;
        Thu, 18 Jun 2020 15:07:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Vziesq9T1Vwi7upsEQvfvn3cU0cCEod7h3VYJIhC8yg=;
 b=WVz26PwolGQWQ6MfULl5J9dxPXVnVtSR10s6/VnqukL6XpgLwVtTIjcGdIShtqct/Zcl
 sbPVRldel/J1tmJ7eD09KdcLXzIL/ysv64VJNkGznrZ+pSyGyGhpTHZkj0G+O3/MeuVY
 YRF/AahQuUT+uAvlQftqrYm2xcEapDarXs2VXjq/OVIgh7q0eWVYs5XvAbKnoKx8SxKz
 AcbnB2en62xFRFW6V96U3b89aLWyh6FANEXRebq5JWdSpPox81PNCiwasxZN/udGWrNL
 VvFkYTFmpCugm6wXqtbgaHbNqUacbRjnOBrP7m1MNwu55JH+4N7LxfOav9k75w+6XMIP 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31q64cb3fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 15:07:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4367100039;
        Thu, 18 Jun 2020 15:07:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6A452B8A0D;
        Thu, 18 Jun 2020 15:07:01 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun 2020 15:07:01
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
Subject: [PATCH v2 4/5] ARM: dts: stm32: add uart7 support to stm32mp15xx-dkx boards
Date:   Thu, 18 Jun 2020 15:06:50 +0200
Message-ID: <20200618130651.29836-5-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618130651.29836-1-erwan.leray@st.com>
References: <20200618130651.29836-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds uart7 node to stm32mp15xx-dkx and uart7 alias to stm32mp157a-dk1 and
stm32mp157c-dk2 boards. uart7 pins are connected to Arduino connector.
uart7 is disabled by default.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 65ee61b7667a..4c8be9c8eb20 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -19,6 +19,7 @@
 		ethernet0 = &ethernet0;
 		serial0 = &uart4;
 		serial1 = &usart3;
+		serial2 = &uart7;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index fb690a817e28..ffbae4a8753d 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -20,6 +20,7 @@
 		ethernet0 = &ethernet0;
 		serial0 = &uart4;
 		serial1 = &usart3;
+		serial2 = &uart7;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 243aa4b2063d..cfbe3e2afef2 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -591,6 +591,14 @@
 	status = "okay";
 };
 
+&uart7 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart7_pins_c>;
+	pinctrl-1 = <&uart7_sleep_pins_c>;
+	pinctrl-2 = <&uart7_idle_pins_c>;
+	status = "disabled";
+};
+
 &usart3 {
 	pinctrl-names = "default", "sleep", "idle";
 	pinctrl-0 = <&usart3_pins_c>;
-- 
2.17.1


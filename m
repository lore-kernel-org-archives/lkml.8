Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70540C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EABF208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SRSUIvX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgE1Hkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:40:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28996 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgE1Hkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:40:45 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S7cETi026352;
        Thu, 28 May 2020 09:40:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=n3PpjtcxTQP2S04rV4dD6wy+XyykGrsw3yJUS++ZlGg=;
 b=SRSUIvX/es1cI6zPboA4gtFKFqBQG3wRaTxeoAqC4w40yBxRELJ8p50Llo445a3CqzdL
 gGShYyeUs4s5K03Rr+8uobta6lnALtGgOsWoH/ksN39tRyKigF8Y/pbzYP39o6M37YEF
 hR42F85eDy/cTCFhgoquPDnv/s7+3iEUdedtLoPFTevmHiMWzfZkJFKw74Q/r3ZPs3WE
 p+Dq9Yp99CE+FjJElYF0zp6WUoPF8ePOQxNRfA1aO2cgtQ5lcrjrdbc/Sa+f2MZznnlM
 NuqbYNISbZuMdAKlEkPBGMqZVHQvrsh+oA2eJZVsBtDwUfiTlKK8Jk/TyeMRYTmjzgtw fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316skwj24x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 09:40:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59E19100038;
        Thu, 28 May 2020 09:40:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4DF872B188D;
        Thu, 28 May 2020 09:40:35 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May 2020 09:40:34
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
Subject: [PATCH 3/5] ARM: dts: stm32: add usart3 node to stm32mp157c-ev1
Date:   Thu, 28 May 2020 09:40:27 +0200
Message-ID: <20200528074029.24962-4-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528074029.24962-1-erwan.leray@st.com>
References: <20200528074029.24962-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the usart3 node to stm32mp157c-ev1 board. usart3 pins are connected to
GPIO Expansion connector. usart3 is disabled by default.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index b19056557ef0..e56dde8d20f8 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,6 +19,7 @@
 
 	aliases {
 		serial0 = &uart4;
+		serial1 = &usart3;
 		ethernet0 = &ethernet0;
 	};
 
@@ -341,6 +342,15 @@
 	};
 };
 
+&usart3 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&usart3_pins_b>;
+	pinctrl-1 = <&usart3_sleep_pins_b>;
+	pinctrl-2 = <&usart3_idle_pins_b>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
 &usbh_ehci {
 	phys = <&usbphyc_port0>;
 	status = "okay";
-- 
2.17.1


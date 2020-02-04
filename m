Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25733C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCC120661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wESYPm8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgBDN0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:26:36 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44304 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbgBDN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:26:31 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014DN70m018475;
        Tue, 4 Feb 2020 14:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=svNIL8S5ikLq6fC5dYVL1FJyfGZacEgFr1/P7H/Zw64=;
 b=wESYPm8NZ7MqQhZxSsf1kewzyR9WtukfZ9+7H77bjnhQUGqHmBIW735MRm6eLYOvU9g2
 1joyWI2Z0sxhLzw0ZsmG/jcw/tDRSW2Ca3xn20jVFLAmyOzsQcocIh7vvGwAb+8lAyF1
 GG5ygIRZoaWOvBG52snMnyzOYV6EIXgIRWPAjRnIP7E6+poWekKDMh/R3/8Ilj3ZwWPO
 4XJkRh3Y/XJYHbHrHLe080cLWjvTImZhCw7FRoy4LSRbckMbvAXAtRLG8j700FJez2sR
 7tmslg+wDuka/NI83N/OhvDYVbiGnuD8aSy/sNZXHNG+RolSIAxpNVWtA+zvAp2RpNE3 Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvyp61uyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 14:26:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D14F2100039;
        Tue,  4 Feb 2020 14:26:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C6A832BC7BA;
        Tue,  4 Feb 2020 14:26:14 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 14:26:14
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: add USB OTG pinctrl to stm32mp15
Date:   Tue, 4 Feb 2020 14:26:05 +0100
Message-ID: <20200204132606.20222-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204132606.20222-1-amelie.delaunay@st.com>
References: <20200204132606.20222-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definition for USB High-Speed OTG ID pin and USB Full-Speed OTG
DP and DM lines that can be used on stm32mp15.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 0237d4ddaa92..345dc18d2224 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1040,6 +1040,19 @@
 			bias-disable;
 		};
 	};
+
+	usbotg_hs_pins_a: usbotg-hs-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
+		};
+	};
+
+	usbotg_fs_dp_dm_pins_a: usbotg-fs-dp-dm-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* OTG_FS_DM */
+				 <STM32_PINMUX('A', 12, ANALOG)>; /* OTG_FS_DP */
+		};
+	};
 };
 
 &pinctrl_z {
-- 
2.17.1


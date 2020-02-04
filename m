Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DACC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE10F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fYZdzA3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgBDN0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:26:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1321 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727225AbgBDN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:26:31 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014DN8pc018480;
        Tue, 4 Feb 2020 14:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=P0O19dVNFkEtZ9n15KyWMo1KjYvKtsJrmOpSkOaeAtM=;
 b=fYZdzA3e/39RPkICu4+JFfAkKwu9q/CnSeoF7oBE40U1c8tok4MzjYWBpsDTE7RtMQCU
 3fZvUmsrGQ1BnUp1dwVxaUkbnr+H0nyn3VkreT4RdUN+5ta44bILGYvNJiRh2ZjPwaKi
 5m/7RPMBhwQECf7cGcC0z6xCBKGf03OM1aCwgUeQ7sbue4mGgzN9JzlJGeN0LdOXkkT1
 /uvYl4F7NXjwjFXW6pO2YWrssEmBHr2kRq8+VBmFGYa8ul3t9AseF9Wcotp6xAl4dl/3
 YkWssuuRt0KaxTuEhDOL0zNwJfsFl04s5YyqVKWWy+i7yIVnpuGDkQda/NZfFlnk+vio XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvyp61uyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 14:26:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 98484100038;
        Tue,  4 Feb 2020 14:26:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 892B42B188F;
        Tue,  4 Feb 2020 14:26:13 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 14:26:13
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
Subject: [PATCH 1/3] ARM: dts: stm32: add USB OTG full support on stm32mp151
Date:   Tue, 4 Feb 2020 14:26:04 +0100
Message-ID: <20200204132606.20222-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204132606.20222-1-amelie.delaunay@st.com>
References: <20200204132606.20222-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the st,stm32mp15-hsotg compatible allows to use USB OTG with Dual Role
mode support.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index fb41d0778b00..53fa6ed82b34 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1044,7 +1044,7 @@
 		};
 
 		usbotg_hs: usb-otg@49000000 {
-			compatible = "snps,dwc2";
+			compatible = "st,stm32mp15-hsotg", "snps,dwc2";
 			reg = <0x49000000 0x10000>;
 			clocks = <&rcc USBO_K>;
 			clock-names = "otg";
@@ -1055,6 +1055,7 @@
 			g-np-tx-fifo-size = <32>;
 			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
 			dr_mode = "otg";
+			usb33d-supply = <&usb33>;
 			status = "disabled";
 		};
 
-- 
2.17.1


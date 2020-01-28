Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DFC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C331D24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FirNxXdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA1Piw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1475 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgA1Pil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:41 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFX6T6021991;
        Tue, 28 Jan 2020 16:38:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=BYJzgUMk733kauvTheIZCyk54aZylmh0QOl0v2b0GrM=;
 b=FirNxXdnv49pNeVN1usCbem2Cb2nRu2k4Tw4PsQujj7GM8CmdqSeR+fy5T6U6fuL92CN
 CgupI1Hyz0yV8cXqR1FRnKkOvfrD0PROALtQDWZfX5pffmVw+ZAJuNjaQuGnizWk6LR3
 7Y8dZNYWahYPZWjXpSHNZPHzP43Allr2xocKcwv0dAN2KtbwCdB9iiJOiwnpnvmTuMT/
 oTY6aGLyrfP5dQgYiv4mg2xtu/TzxbLs0Qvc9faObd49LcyaK8lI9/Izo4Zs8nnNK3cm
 q0T3I+Xykq6+9rG9UL3n8KtqornDLYjSrjoOphBaXUie3yuPeMSvHVqiE71/1QKz0BX3 cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxmdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 351F710002A;
        Tue, 28 Jan 2020 16:38:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22FDE2BF9D0;
        Tue, 28 Jan 2020 16:38:25 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:24
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>, <sudeep.holla@arm.com>, <lkml@metux.net>
CC:     <loic.pallardy@st.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <system-dt@lists.openampproject.org>,
        <stefano.stabellini@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 6/7] ARM: dts: stm32: Add firewall node for stm32mp157 SoC
Date:   Tue, 28 Jan 2020 16:38:05 +0100
Message-ID: <20200128153806.7780-7-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare ETZPC device as a firewall controller node for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index ed8b258256d7..8a00dad9688e 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1499,6 +1499,13 @@
 			};
 		};
 
+		etzpc: etzpc@5c007000 {
+			compatible = "st,stm32-etzpc";
+			reg = <0x5c007000 0x400>;
+			#firewall-cells = <2>;
+			status = "okay";
+		};
+
 		i2c6: i2c@5c009000 {
 			compatible = "st,stm32f7-i2c";
 			reg = <0x5c009000 0x400>;
-- 
2.15.0


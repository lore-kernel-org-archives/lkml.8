Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF3C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF1424687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="OP6eHigr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA1Piz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1467 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726945AbgA1Pip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:45 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFX6T7021991;
        Tue, 28 Jan 2020 16:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=EpLaj1uTqlqIXOijIZ+YGkBlgBoIhfiPnvEapUy+Zj4=;
 b=OP6eHigrOq+xTQR2TTmyl+frb0fPBLoISPaZptCGJaX+DwZ4da5qsIAY3YV+aSTpDz1P
 f0tPorxPoFl8Na68wFAjKxy9L7iIIG72UGAWe+BHrfEiDs3vt8Nal1sY03gTlnCR6GV5
 Ju++ZXpGgAs5kmhdKk14W//VCxyvtXvSARjDBXI38Yd1OD82xi+os+JpFO/G/Ieu2kBL
 RDmPf0arI+R41qBGlrEZZEMlsA5M5tgBNuuoBnPyruAdT2oj5Sxs40fweoSjB5NgCYjN
 1IHLPm9RDol8mjtz44wodaPB9m0QCvbzSVcOEKqCvufo2TpLo6PTptHSz4/uKk58YsKI Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxmdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8BB3100038;
        Tue, 28 Jan 2020 16:38:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5DAD2BF9D0;
        Tue, 28 Jan 2020 16:38:25 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:25
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
Subject: [PATCH v2 7/7] ARM: dts: stm32: enable firewall controller node on stm32mp157c-ed1
Date:   Tue, 28 Jan 2020 16:38:06 +0100
Message-ID: <20200128153806.7780-8-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ETZPC and set configuration for CEC node

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 3789312c8539..5b72ef2a54df 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "stm32mp157c-ed1.dts"
+#include <dt-bindings/bus/firewall/stm32-etzpc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
@@ -77,6 +78,7 @@
 &cec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cec_pins_a>;
+	firewall-0 = <&etzpc STM32_ETZPC_CEC STM32_ETZPC_NON_SECURE>;
 	status = "okay";
 };
 
-- 
2.15.0


Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2580C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IEmCqz7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgA3NxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:53:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1421 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgA3NxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:53:17 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UDnSjw004657;
        Thu, 30 Jan 2020 14:53:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=SD9ONTcrqh7sLptkSCNzDFwyy/VkjsecS0bueRwE0no=;
 b=IEmCqz7FmwowZpTDCN3w3Kl6DEuQx9oD4MhHEI2UZ4UB17EWonGLODlAL1QvIVvKHZ8k
 64YPxPkmuNMvRsXT3JSDbTgHE1EhWTSjcsfJy7C+dQaiBVhNxJp8HLGVmjTLS/c3Qtdg
 v4siMxrzYhs6iq3NRSL8W4G4CEiKlwVLWvstJ20YRAKGNAY1Kj4wktOlP7D6S+s8X+8B
 fF5hW6+EFVD1MReO3+R3kaJFUYfaEj48SjOIagmy0Yg4YhENTZ3qrMaswId4upEFdC1B
 FC2A/hbxIuprQR1E/75/KbflZ4IzSOf594k5t0fJTETvpfj8BdkQDhVlRvy99zbOESwC Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpb8w2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 14:53:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B256710002A;
        Thu, 30 Jan 2020 14:53:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A045D2D792D;
        Thu, 30 Jan 2020 14:53:06 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 30 Jan 2020 14:53:05
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32: remove useless properties in stm32mp157a-avenger96 stmpic node
Date:   Thu, 30 Jan 2020 14:53:04 +0100
Message-ID: <20200130135304.27842-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_04:2020-01-28,2020-01-30 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theses 3 properties are not coded in driver so remove them from the DTS.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index 628c74a45a25..e2d9febaa661 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -134,10 +134,6 @@
 		#interrupt-cells = <2>;
 		status = "okay";
 
-		st,main-control-register = <0x04>;
-		st,vin-control-register = <0xc0>;
-		st,usb-control-register = <0x30>;
-
 		regulators {
 			compatible = "st,stpmic1-regulators";
 
-- 
2.15.0


Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C7C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EF421744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LN4xvgGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:11:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33930 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727210AbgBDOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:11:13 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014E7HMS032493;
        Tue, 4 Feb 2020 15:10:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=x0039EP8HFPOf0RsTP5nutRrLlUwQCJuQ4Qn7Y7ROVM=;
 b=LN4xvgGWloVP5OMzg2X9XIW8phOvk1uKNM84DLAmoOaWDOVwNmIhJRVWq4QIP8qjaDNY
 yrQXkfMQDAoy/W7+FoTMO8xjwwPlxU9c7Qt3plc7esRHJeyOoNqyPS+xkOkYy+yCI+t4
 MVXJciklou7suhyFSKmqRAI/zzxc4mPu3+OXlmQCrGxYR/OdW2rqlNQ90LeM1At7JPUy
 hvcrLklGDiUOxNWNo+DO0R4WJ8VCKdWRm3Gs5ldmGciC1jB3vqsjpDdw2LSclPXAOCIY
 2fqXb7S+G0Hz394onVULvlDPbY5e5Q1I1q0vEiIDUzBkE6DBxqoFUlDs5PtE8aulbq4y cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw13nssby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 15:10:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 059BF100034;
        Tue,  4 Feb 2020 15:10:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E54822CD0E3;
        Tue,  4 Feb 2020 15:10:53 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 15:10:53
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
Subject: [PATCH 1/1] ARM: dts: stm32: add resets property on all DMA nodes on stm32mp151
Date:   Tue, 4 Feb 2020 15:10:53 +0100
Message-ID: <20200204141053.28072-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resets property is well-managed in DMA drivers. In previous products,
there were no reset lines, that's why they are missing here in dma1, dma2,
dmamux and mdma nodes.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 53fa6ed82b34..96f43fa48ec4 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -959,6 +959,7 @@
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc DMA1>;
+			resets = <&rcc DMA1_R>;
 			#dma-cells = <4>;
 			st,mem2mem;
 			dma-requests = <8>;
@@ -976,6 +977,7 @@
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc DMA2>;
+			resets = <&rcc DMA2_R>;
 			#dma-cells = <4>;
 			st,mem2mem;
 			dma-requests = <8>;
@@ -989,6 +991,7 @@
 			dma-masters = <&dma1 &dma2>;
 			dma-channels = <16>;
 			clocks = <&rcc DMAMUX>;
+			resets = <&rcc DMAMUX_R>;
 		};
 
 		adc: adc@48003000 {
@@ -1281,6 +1284,7 @@
 			reg = <0x58000000 0x1000>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc MDMA>;
+			resets = <&rcc MDMA_R>;
 			#dma-cells = <5>;
 			dma-channels = <32>;
 			dma-requests = <48>;
-- 
2.17.1


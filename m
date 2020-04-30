Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD9C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705B62137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IGqjm8Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3KRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:17:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29128 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgD3KRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:17:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UAGZUt020402;
        Thu, 30 Apr 2020 12:16:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qH2niGVO8C1BeTnQ7Oe306OijojtPE7/RcJ+6sOZsQU=;
 b=IGqjm8BuEM3mXncZUDSzDMP/Lmn/LDtP0RV2YIqFSJ2+t4Xq6nHLIdZ2eYQ6i4TcaoyU
 MwCQYyh9/C6g38RalXELQgxJcE4862DXCkDowpr7+KcpOYw+udM2bswNM/yRuTSNf+7m
 6Gv1/xYDAb71WGIXYBlFHsYA6dPpTYjNANColkckebqnWLDQsaCHCfcp6FBcUMnbsIw0
 WSUcAylk6Qnl7okgyORLkZpLZo9oQfMXm6BUHMr4GJH019r/mwwJnRBbjFc51ZdLwVZP
 PAZPlVy8b6aGOIRx6JKAYc0WM5NcgxBuqGdDa9Ws6T1KGNJo8DZ9oX3Yw4nLF+Due92p Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30qst09622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 12:16:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43E6910002A;
        Thu, 30 Apr 2020 12:16:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3611E2B690C;
        Thu, 30 Apr 2020 12:16:58 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr 2020 12:16:57
 +0200
From:   Yann Gautier <yann.gautier@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yann Gautier <yann.gautier@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] ARM: dts: stm32: add sd-uhs properties in SD-card node for stm32mp157c-ed1
Date:   Thu, 30 Apr 2020 12:16:49 +0200
Message-ID: <20200430101649.29381-1-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_06:2020-04-30,2020-04-30 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdmmc1 peripheral is connected on SD-card on STM32MP1-ED1 board.
Add the UHS features the controller is able to manage.
Those features require a level shifter on the board, and the support of
the voltage switch in driver, which is done in Linux v5.7.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9d2592db630c..1d7dfe97b160 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -320,6 +320,10 @@
 	bus-width = <4>;
 	vmmc-supply = <&vdd_sd>;
 	vqmmc-supply = <&sd_switch>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
 	status = "okay";
 };
 
-- 
2.17.1


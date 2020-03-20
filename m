Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB32C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6136320754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qcHeB6Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCTM7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:59:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbgCTM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:59:20 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KCcOWJ003548;
        Fri, 20 Mar 2020 13:59:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=o41DLb60dwo0XgM7XyP9TCm5BF2bWxbtelGzKn5ttsg=;
 b=qcHeB6XbZYRgiaXbFm1srtc3QoUBsAu1yHFSKI+okPPT0K/lFR34o73UZj/hFnHwiNUu
 h0Dx2PfLYKlb/nAzhE0N5p7UcPXqlnEAKQeROJL1xfvPhqB9NeoP7ZqFi3v7Lszin0+D
 LALKHcG+EqeIUaMaEA8MZ5+Wh8PEGY8oD5Z8lxR8CPUh4g/EVAH6RZYPATpJe8wfCR5w
 2C5WJqIkfZ04qJDBU2Mwm+VkXAYo2sqkm/uVIDd3JICfNdwQ+gDV5Z5w9bLmOqr3BMwo
 3iu+Na2a2wgqDBU9255CyKVKE28k3Ko/oluwY+Rh99qYKXauTH8l7XiyMjY4Vi+SidZl OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu8etqtk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 13:59:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0E3B100034;
        Fri, 20 Mar 2020 13:58:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B48982AE6AF;
        Fri, 20 Mar 2020 13:58:59 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar 2020 13:58:57
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] ARM: dts: stm32: add cortex-M4 pdds management in Cortex-M4 node
Date:   Fri, 20 Mar 2020 13:58:41 +0100
Message-ID: <20200320125841.11059-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_03:2020-03-20,2020-03-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add declarations related to the syscon pdds for deep sleep management.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 7b93eb4b8f49..46ea1024340e 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1115,6 +1115,11 @@
 			};
 		};
 
+		pwr_mcu: pwr_mcu@50001014 {
+			compatible = "syscon";
+			reg = <0x50001014 0x4>;
+		};
+
 		exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
@@ -1693,6 +1698,7 @@
 			st,syscfg-tz = <&rcc 0x000 0x1>;
 			st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
 			st,syscfg-copro-state = <&tamp 0x148 0xFFFFFFFF>;
+			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1


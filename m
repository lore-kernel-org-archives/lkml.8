Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B022BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SZltyI84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgH0HVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:21:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:22016 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgH0HVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R7Ho8j013608;
        Thu, 27 Aug 2020 09:21:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=9bTCitwnBAltRZQ7gOYLHIo8QHxlqk1VrxB1btIyl3k=;
 b=SZltyI84G5I3H89Zdo7KZ/TXsfPszKhCDxsNzPo5pVtE6yxVAOo1aNf45b7GHE6b/ZJQ
 3ko/Hyx+2Ghn4Iv4Yx7006IPxHHOFxdCLpbJwcWe4MP/vJHmancbJGKftoMk3w4p8T2L
 nQXlH9ugTxMfZGyIR5T/nEfa9Ps9WvEJFt820mjWeqfSEbH+xsTceHiQCc3T+ngioGhp
 h8vfNSV0jymM/30WYOgci71fFvx7R7I+oFhhorZ+BNy8z9uo47nzyLygac9F/YqcdeW2
 TMBj1kp41XelvDEREmqZus7i5zJaVwmWxaG5iGuy1QceWn6ZFDlVQkQ8712+9aU8saf6 aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b2mvfv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:21:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87C5610002A;
        Thu, 27 Aug 2020 09:21:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A770212648;
        Thu, 27 Aug 2020 09:21:21 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug 2020 09:21:20
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 3/3] ARM: dts: stm32: update stm32mp151 for remote proc synchronisation support
Date:   Thu, 27 Aug 2020 09:21:01 +0200
Message-ID: <20200827072101.26588-4-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827072101.26588-1-arnaud.pouliquen@st.com>
References: <20200827072101.26588-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two backup registers are used to store the Cortex-M4 state and the resource
table address.
Declare the tamp node and add associated properties in m4_rproc node
to allow Linux to attach to a firmware loaded by the first boot stages.

Associated driver implementation is available in commit 9276536f455b3
("remoteproc: stm32: Parse syscon that will manage M4 synchronisation").

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bfe29023fbd5..842ecffae73a 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1541,6 +1541,11 @@
 			status = "disabled";
 		};
 
+		tamp: tamp@5c00a000 {
+			compatible = "st,stm32-tamp", "syscon";
+			reg = <0x5c00a000 0x400>;
+		};
+
 		/*
 		 * Break node order to solve dependency probe issue between
 		 * pinctrl and exti.
@@ -1717,6 +1722,8 @@
 			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
 			st,syscfg-tz = <&rcc 0x000 0x1>;
 			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
+			st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
+			st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1


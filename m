Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0049C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6412073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o9kiB+xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGCJzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:55:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48180 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgGCJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:55:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0639b8Gr014179;
        Fri, 3 Jul 2020 11:55:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kcM9zpk7usTINpTpW+g3ztD8RyrBmABS2CfKlqCo7L0=;
 b=o9kiB+xMazYDkvNotKpWmlu+/0bGVRwrOnorH74DtmOGGneVTfmP4mAf5Q63QxrE+TEe
 zigK1ZYqLMZ4e220G69lffNGkDcnDBtHWYZLUfVrHVA7FnTxglkrs5iUYHtGTowR3kEm
 FzY5B6qMc9Pfppf9FUqphpQz/UZocm1Whrc5qj7/4j7ty4J/n6bk+7znxqPzTITwjDT4
 pbRqnSXaCCkLBaHHIdLISpTPCs21xScgZrXwPpzwt7Gg/8eL9ZNdVerCx7X49Vajpmn4
 nRuOz2vco+MoqOKUviFPtYJqr8/D2d/ithp98RyLYPegsD7Ty9RP2mOoEfllxGwydQJl Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31ww0gp0j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 11:55:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C45F10002A;
        Fri,  3 Jul 2020 11:55:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 013E72BAC64;
        Fri,  3 Jul 2020 11:55:27 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Jul 2020 11:55:25
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>,
        <benjamin.gaignard@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ARM: dts: stm32: Add compatibles for syscon for stm32h743
Date:   Fri, 3 Jul 2020 11:55:19 +0200
Message-ID: <20200703095520.30264-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200703095520.30264-1-benjamin.gaignard@st.com>
References: <20200703095520.30264-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_03:2020-07-02,2020-07-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscon nodes needs at least 2 compatibles to be compliant why yaml documentation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 9b7fc68380e9..387f1f85b23f 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -361,8 +361,8 @@
 			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <62>, <76>;
 		};
 
-		syscfg: system-config@58000400 {
-			compatible = "syscon";
+		syscfg: syscon@58000400 {
+			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x58000400 0x400>;
 		};
 
@@ -502,7 +502,7 @@
 		};
 
 		pwrcfg: power-config@58024800 {
-			compatible = "syscon";
+			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x58024800 0x400>;
 		};
 
-- 
2.15.0


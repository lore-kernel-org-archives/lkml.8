Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74020C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F7720767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GgG8LG7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCSK1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:27:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34324 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgCSK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:27:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JAPFPx031888;
        Thu, 19 Mar 2020 11:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=S2ou1+M3hvPA+NgQvCNpYae8BrEknM8QmlCHsuTCeDk=;
 b=GgG8LG7RFjnlGFSgyvaAN6ilwh9lf9/aoYDxeQOyw6x19jTK13eZsBImdjOIxnj7HPqT
 IXxnTx2fbmI0fkEKyIP3Lo2gbOO9E981dJeEBlOVVXjXq/COJlbzD5mjY78NpP6E4oie
 caEjEWLBOoiXnT/BfLMI5V5mO2RGwdyz70ON3ueJQZr398E7xnHAEIwKAMfY3cGoYEYU
 3JMHuy0tYZhO3CUFI8IIMS6u6nc7p7gUk42SMUfKWYtq+dAPSfBOkG25y5+ZmXL2le/V
 cKtTv4TLHJ5Grp5iZtvm3bvkMhjC6K8i8gwrdCl99AJelT7Idm4c9FZgWDNYBLFQ604g vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu6xdhjm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 11:26:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89F09100039;
        Thu, 19 Mar 2020 11:26:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A9062A5810;
        Thu, 19 Mar 2020 11:26:50 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar 2020 11:26:49
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: fix a typo for DAC io-channel-cells on stm32h743
Date:   Thu, 19 Mar 2020 11:26:11 +0100
Message-ID: <1584613571-10544-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_02:2020-03-19,2020-03-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo on STM32H743 DAC, e.g. s/channels/channel

Fixes: 1536dec45e77 ("ARM: dts: stm32: Add DAC support on stm32h743")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 05eb02e..9b7fc68 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -180,14 +180,14 @@
 
 			dac1: dac@1 {
 				compatible = "st,stm32-dac";
-				#io-channels-cells = <1>;
+				#io-channel-cells = <1>;
 				reg = <1>;
 				status = "disabled";
 			};
 
 			dac2: dac@2 {
 				compatible = "st,stm32-dac";
-				#io-channels-cells = <1>;
+				#io-channel-cells = <1>;
 				reg = <2>;
 				status = "disabled";
 			};
-- 
2.7.4


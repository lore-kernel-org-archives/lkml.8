Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40216C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ACE2223E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uDEgwfep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896016AbgDPQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:15:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442867AbgDPQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDEcF005340;
        Thu, 16 Apr 2020 18:14:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=BECJGiUvhGzClMdYvElFVDvpweq8Gq2dCCcfEt+39VM=;
 b=uDEgwfep1IxcMNE3qQYLz7nmAf7hRsnCEl2UqP0aBHrsslBvDeBlhzBOaowRWi2eejG1
 Lii/Ye/5Rf7muXqnQhi0wIqPuuESWBYCvhLSFPf8KXM2106qEK0LGVPHgoZ36z/0RSwj
 PVAtuZ8whFjfSVrOtnyR8HQYSe/BspgNeElg/cVonS3EiGMLwPg/BgMO1MUWvrb5xD+G
 eIRWiw4Lz39TG3GZmXJfynyaUuEcRngu0GmHyYnj/fIQE7ML+Dd8F5mizwly3n2K0yfQ
 C3JlNQnV3T78RhYb9dI2YWQ2SfWfW6kBMIXiy6cTbgk7BhYJFog4sSwvvmxB4euekuzF 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6t3nds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2952210002A;
        Thu, 16 Apr 2020 18:14:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E6B22B2D2C;
        Thu, 16 Apr 2020 18:14:34 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:33
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 18/18] ARM: dts: stm32: Declare a virtio device
Date:   Thu, 16 Apr 2020 18:13:31 +0200
Message-ID: <20200416161331.7606-19-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare a virtio device as sub device of the stm32 remote proc

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index f6672e87aef3..2bb16c860c82 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -414,6 +414,16 @@
 	interrupt-parent = <&exti>;
 	interrupts = <68 1>;
 	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vdev@0 {
+		memory-region = <&vdev0vring0>,	<&vdev0vring1>, <&vdev0buffer>;
+		compatible = "rproc-virtio";
+		reg = <0>;
+		status = "okay";
+	};
 };
 
 &pwr_regulators {
-- 
2.17.1


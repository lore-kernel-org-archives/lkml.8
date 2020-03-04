Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FECBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A972166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="I56EG6/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgCDIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:10:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10637 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbgCDIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:10:28 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02487pWQ004028;
        Wed, 4 Mar 2020 09:10:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=n8QvI0PPy92ZGlxWhkH/DeXcDD5fh4/qSAfLtW2Sw08=;
 b=I56EG6/WTGws/FvGYwTs8CaH+fCOT1m0dnxRcg1Aa/nACFmejccWTQUV9K/NtpWuE+oG
 0mYjN1A3jdkh+KVST/lkp8re+MOCyj7PiQ/MuryJGKkPrVz5VeG7762ecP915r+R759D
 RAEPgVpId6Rj+g0+Zy3lz1184m/h0Jwrl1vrJT5VkQamj98YdYn+7Z59DwCP0CyQesVG
 KdOt3dU6pstO8neTDBucgPj4maX5/ZCDMM/EiAimrQDQ0+u6cS3/RsEfXRxvRsFHpVcu
 TVNRo1teZ/nRAN/p3MKLNt5FmH47qRH5KdoqP8231U+V1XtS4sGhu+6E5An0pr+QRv01 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfea6yeag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 09:10:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CA7110003B;
        Wed,  4 Mar 2020 09:10:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 509BE21FE85;
        Wed,  4 Mar 2020 09:10:08 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar 2020 09:10:07
 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yann Gautier <yann.gautier@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: use correct vqmmc regu for eMMC on stm32mp1 ED1/EV1 boards
Date:   Wed, 4 Mar 2020 09:09:56 +0100
Message-ID: <20200304080956.7699-4-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304080956.7699-1-yann.gautier@st.com>
References: <20200304080956.7699-1-yann.gautier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On those boards, as stated in schematics files, the regulator used for IOs
is VDD. It was wrongly set to v3v3.

Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 6f8d23a7d4a6..ae6f80f9794e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -335,7 +335,7 @@
 	st,neg-edge;
 	bus-width = <8>;
 	vmmc-supply = <&v3v3>;
-	vqmmc-supply = <&v3v3>;
+	vqmmc-supply = <&vdd>;
 	mmc-ddr-3_3v;
 	status = "okay";
 };
-- 
2.17.1


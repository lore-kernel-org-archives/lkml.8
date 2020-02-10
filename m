Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF8C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B052A2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hbQKLK43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgBJNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:43:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7234 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgBJNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:43:45 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADeiD5018105;
        Mon, 10 Feb 2020 14:43:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=mNx6+zp69Q3t2n4c06wtHJyz+4qv+M+Nal4MBFxGjZE=;
 b=hbQKLK43y3MW6b97apngBQIc33OT+HX4maLomrfxzdK1W3IXBzW8NtcI5qNey2yf3+9Y
 TzjBOWalMVRpaGdDnIl+xfav59byvvxZ0MSovev1scci5j0B1pvt5vU+Sk+KF/8sMdVQ
 2+/fI/vJT+XfI6zhePESg1Db/m++NGevwXXl9GiHq4uxEsYhi+ENBPAYIMt9tvbCPrcC
 Y+BQ/14mFFkn7LnAv5+sNRV/ADPJZPb+0Tf/PD1By2wJ7cWQOt9xjffLLdUC6BJpRKm6
 XNm5Av/XLYo/QFTrOpH2m/qKqv7PALtXEUzaleWjysJI1bZSwgEnejrgl2YrPcVemDuJ xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urgt43d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 14:43:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 650C1100038;
        Mon, 10 Feb 2020 14:43:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 594BE2AD24B;
        Mon, 10 Feb 2020 14:43:33 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb 2020 14:43:32
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32: Correct stmfx node name on stm32mp157c-ev1 board
Date:   Mon, 10 Feb 2020 14:43:31 +0100
Message-ID: <20200210134331.14039-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200210134331.14039-1-benjamin.gaignard@st.com>
References: <20200210134331.14039-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change stmfx node name to fit with yaml requirements.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 228e35e16884..ffd4e0caeedc 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -210,7 +210,7 @@
 		interrupt-parent = <&gpioi>;
 		vdd-supply = <&v3v3>;
 
-		stmfx_pinctrl: stmfx-pin-controller {
+		stmfx_pinctrl: pinctrl {
 			compatible = "st,stmfx-0300-pinctrl";
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.15.0


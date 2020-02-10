Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DFE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Qfl9XKph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgBJNnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:43:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53893 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727369AbgBJNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:43:45 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADebXV018034;
        Mon, 10 Feb 2020 14:43:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=FrkdY4tsBuYMECkQYYjvl6NPFI1bBJ0eMZYUwhekgN0=;
 b=Qfl9XKphuwdpR0VNKmRuSOgtxYn9wMCbnLJSQgpPl1AK4Q3itqA89ehMhj7K/LFH1jAg
 VNq3bfVCjCGIKp6yraLBzpnNdhB4Gs2T/uvF49ivJpGvRmeDHxga5gnYZOC8ngh3RCZK
 wkKy3UxGJjmXRLg7P7I5rVjgMrNRfvqCUbjyTW2DKJGkVR60hyZ81Y8zpItbLxuwMa6N
 7s3znNKiRvlalB7VLV8kyzKyrsD1bI+PwJTAtUsyggcfhN/dmehv/4t88xvc34rIBYYR
 WfbAlbZIGdwF1PO4GC+FgDfsYMwxiQPUO0Esa3jcB3CKPDG46lHofM9gf6guFtmuv75R Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urgt43c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 14:43:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E85D410002A;
        Mon, 10 Feb 2020 14:43:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B91572AD24B;
        Mon, 10 Feb 2020 14:43:32 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb 2020 14:43:32
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32: Correct stmfx node name on stm32746g-eval board
Date:   Mon, 10 Feb 2020 14:43:30 +0100
Message-ID: <20200210134331.14039-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE3.st.com
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
 arch/arm/boot/dts/stm32746g-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index fcc804e3c158..4ea3f98dd275 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -165,7 +165,7 @@
 		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
 		interrupt-parent = <&gpioi>;
 
-		stmfx_pinctrl: stmfx-pin-controller {
+		stmfx_pinctrl: pinctrl {
 			compatible = "st,stmfx-0300-pinctrl";
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.15.0


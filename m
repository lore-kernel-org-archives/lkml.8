Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1820C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771B4206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XUf6koA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415105AbgDOQAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:00:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1415060AbgDOP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:59:44 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FFX9IH020652;
        Wed, 15 Apr 2020 17:59:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=HlleByQ0ZQm+05TayeH9E0d5N1iu4zV7eIq5O83VKV0=;
 b=XUf6koA5SbJNHWNZvY2R6ve0Y5y3/e5Qo6lCEyEAQHtuQasYkeLCMIOi3m9x2AWTVpvM
 pV7U2UP2eK74qktlTu85+m5OMu5DEEeM5iynz0iC5nRFvdl68NSb0euJIwiK11f0XiOi
 Wd5mAfW7GhwrAkLDnC4arr3PLbjtDBctj5ZzqDCdkhRbpxeQOxucWZr3Zv0heZKyukwZ
 vbEATjR28zaf5N1qk9y5L49gKqhuTHXejfWQ/7nK81Q9TBXaznw1Fx779MxXxrpaQdg0
 ClgLHab2qvDIxcxbEt6C93UPV7T2f0ESGdyTlWZN4GyBAB/a2hbucZDK0UX1iIqakpPy Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6svyp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 17:59:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6353B100034;
        Wed, 15 Apr 2020 17:59:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 54A582B213E;
        Wed, 15 Apr 2020 17:59:27 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 17:59:26
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 12/12] mtd: rawnand: stm32_fmc2: add new MP1 compatible string
Date:   Wed, 15 Apr 2020 17:57:36 +0200
Message-ID: <1586966256-29548-13-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds "st,stm32mp1-fmc2-nand" compatible string.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 4f931e2..f82c7dd 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1938,6 +1938,7 @@ static SIMPLE_DEV_PM_OPS(stm32_fmc2_nfc_pm_ops, stm32_fmc2_nfc_suspend,
 
 static const struct of_device_id stm32_fmc2_nfc_match[] = {
 	{.compatible = "st,stm32mp15-fmc2"},
+	{.compatible = "st,stm32mp1-fmc2-nand"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_nfc_match);
-- 
1.9.1


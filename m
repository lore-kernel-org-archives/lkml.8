Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD2A20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hz0b0Qz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgCDI4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:56:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51062 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727734AbgCDIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:55:59 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0248s6Gp016466;
        Wed, 4 Mar 2020 09:55:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=/qiD8X3t4cPtlJawNy1q2Zqg0xWhtfmpQr6wgwRGjrM=;
 b=hz0b0Qz0JNlgGjP1cioYkf5IGoiRBgECEFc+UFw+3ZkktXnOidYT/kqNYTPSdyFu/W15
 3c9Jvudx4NKmVAZscAkPTlEwDvgepIDzIiFBlC2psgIASwfVNIHwdjNLkaLXfwliyFbe
 7kwLBhNJppeTrzb1BEfQgHaPOrD7Q6FizAX6dPzA0nfgc06HigMHv9Ut8j3lrHFabXPR
 qi42hY5070HPMsEP5vHDu3h5tUCSABYXYU9pWaGGfcEf8rTxksL/5AGKVDUwOE/il2N5
 pYoZ6M6+nHxvenxN0qnW9GiXui7k3XrpkDoCjaYX5QxhPa5lWSY6gtw3CsQAL+mIh5Ex 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfea6yqap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 09:55:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01A0310003B;
        Wed,  4 Mar 2020 09:55:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3DD1920F831;
        Wed,  4 Mar 2020 09:55:45 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar 2020 09:55:44
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] regulator: stm32-vrefbuf: fix a possible overshoot when re-enabling
Date:   Wed, 4 Mar 2020 09:55:32 +0100
Message-ID: <1583312132-20932-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There maybe an overshoot, when disabling, then re-enabling vrefbuf
too quickly. VREFBUF is used by ADC/DAC on some boards. When re-enabling
too quickly, an overshoot on the reference voltage make the conversions
inaccurate for a short period of time.
- Don't put the VREFBUF in HiZ when disabling, to force an active
discharge.
- Enforce a 1ms OFF/ON delay

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/regulator/stm32-vrefbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index bdfaf7e..992bc18 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -88,7 +88,7 @@ static int stm32_vrefbuf_disable(struct regulator_dev *rdev)
 	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-	val = (val & ~STM32_ENVR) | STM32_HIZ;
+	val &= ~STM32_ENVR;
 	writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 
 	pm_runtime_mark_last_busy(priv->dev);
@@ -175,6 +175,7 @@ static const struct regulator_desc stm32_vrefbuf_regu = {
 	.volt_table = stm32_vrefbuf_voltages,
 	.n_voltages = ARRAY_SIZE(stm32_vrefbuf_voltages),
 	.ops = &stm32_vrefbuf_volt_ops,
+	.off_on_delay = 1000,
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
 };
-- 
2.7.4


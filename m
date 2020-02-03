Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF321C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836CA20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="d1iMBlHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBCKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:09:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60663 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbgBCKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:09:55 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013A7d68002999;
        Mon, 3 Feb 2020 11:09:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=M2jnD6diEAiCiDSSKt4lpAXDZaO42lzlkkGu8G6hrk0=;
 b=d1iMBlHTZIAisSNdM50aON9r3VxqSNyPDE0F2aH87mYbz5CVQugjuG14qMgiTmNsIl4x
 DOBs4A8gR9Zl9SDDIRKlCzNGA9Hy5T8HjVEnAc5z95hzH5lMGmo0i5eRQXWZeIIO6jDz
 tTlL5FKV2t0zm0LxaLDs74s29ZXpRdjBQDob/G8X9egkAgSLvA78l1Wd/Kkhzh90oiZl
 VXOaDsQ8mPLUa14dEPFZw5bTttYPob3ljlQZ9POWXtBTOQNMTUry8Rwxsxt3bXribX5j
 ktAxADmqULuHb4VAJIYXy6mMW0O+kSpkDv/mtCl14n5YDBSLIwymc+0ZS4dDR8q/bGHL 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw0010k6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 11:09:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CEC7B100034;
        Mon,  3 Feb 2020 11:09:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCC142BE22D;
        Mon,  3 Feb 2020 11:09:00 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 11:09:00
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC:     Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH 3/6] ASoC: stm32: i2s: manage error when getting reset controller
Date:   Mon, 3 Feb 2020 11:08:11 +0100
Message-ID: <20200203100814.22944-4-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203100814.22944-1-olivier.moysan@st.com>
References: <20200203100814.22944-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_02:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error when the i2s driver fails to get a reset controller.
Also add an error trace, except on probe defer status.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 3e7226a53e53..cdcc00d9a67e 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -866,12 +866,16 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	}
 
 	/* Reset */
-	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
-		reset_control_assert(rst);
-		udelay(2);
-		reset_control_deassert(rst);
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rst)) {
+		if (PTR_ERR(rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Reset controller error %ld\n",
+				PTR_ERR(rst));
+		return PTR_ERR(rst);
 	}
+	reset_control_assert(rst);
+	udelay(2);
+	reset_control_deassert(rst);
 
 	return 0;
 }
-- 
2.17.1


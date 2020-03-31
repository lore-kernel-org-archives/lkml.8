Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF6C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6826620787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pIj1GH14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgCaIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:32:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8688 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729624AbgCaIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:32:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V8Rq9p026602;
        Tue, 31 Mar 2020 10:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=y5y8bWAzSXfW+28B5IZdTTirhUr3alseyHBXkQkA+Os=;
 b=pIj1GH14RlT7gHtmdpCCCbQqTgPwBRGsfv4wrUf5Y2LNvqDYVYBx/jVJj0cKVTwQbyFq
 UN+uUNP16sSHZUIfHXJmo/Q7+r70/KH/o9MSFnohrU/w3EQfzlx1KErgCdAnm970r9z+
 qz77yFKeu8/C1Q5zwEQ1mAVnbnC/xPKMAbQDDbX7jOR/SbzJ0n3q81JroyOpimwsWmh5
 BSZAwQyL9GWGSf1ZznC8Qh1p48MYjRyWOQeG6DYMk2BTBhfmYEjWwt+I4P9enl7ZIYNd
 2LCyXkZM2LE7LKEphnLzge+YXoJ4HGzM83KFncNhjbvJWAgPSoBMeZUd1+frg8GC/tcD Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301w80wtpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 10:32:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A91C6100034;
        Tue, 31 Mar 2020 10:32:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9ADCF21E676;
        Tue, 31 Mar 2020 10:32:05 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 10:32:05
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v5 4/6] mfd: stm32: enable regmap fast_io for stm32-lptimer
Date:   Tue, 31 Mar 2020 10:31:44 +0200
Message-ID: <20200331083146.10462-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200331083146.10462-1-benjamin.gaignard@st.com>
References: <20200331083146.10462-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because stm32-lptimer need to write in registers in interrupt context
enable regmap fast_io to use a spin_lock to protect registers access
rather than a mutex.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/mfd/stm32-lptimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
index a00f99f36559..746e51a17cc8 100644
--- a/drivers/mfd/stm32-lptimer.c
+++ b/drivers/mfd/stm32-lptimer.c
@@ -17,6 +17,7 @@ static const struct regmap_config stm32_lptimer_regmap_cfg = {
 	.val_bits = 32,
 	.reg_stride = sizeof(u32),
 	.max_register = STM32_LPTIM_MAX_REGISTER,
+	.fast_io = true,
 };
 
 static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
-- 
2.15.0


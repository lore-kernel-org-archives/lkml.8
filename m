Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311CD2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lrdKTUv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgDAIjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:39:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55962 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731878AbgDAIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:39:49 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318cpC9028106;
        Wed, 1 Apr 2020 10:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1o0Izbp2L810/aRMfi0HxXPaokBREpCphH53oslSJGg=;
 b=lrdKTUv572Ww/RurqrUfIW2rPAx/Gn7OEqQa9fmxbrl1zyillmD1EsQuMNFyj9G1EA0I
 roQe7oEpdNTigAGatuuQeum9KIfeUaHQmJBUvDBX9ujE5InhrF0kEhO7IDWSR0C//7H3
 ilGhH/t/rIlIjYhP4ZipVmb6UMUzExJ171A1POhRk1p2rosDS5kCwxSi4qZh75x82H7Z
 eFO0Pje8tnjU/7SafOnl4GHsmOk1MfRkm3whOF/0G8Bi21N9KC6uAZClLPw9nDWP7oRT
 Ao8zrXEY/B9AI9e068YhOzWDgTYSTc+nLr4Hq6OqUwgWu/6iI6UjP+hU7NZUdymzP6No lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 302y53x222-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:39:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C40D10003D;
        Wed,  1 Apr 2020 10:39:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A30721CA8F;
        Wed,  1 Apr 2020 10:39:37 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr 2020 10:39:36
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
Subject: [PATCH v6 3/6] mfd: stm32: Add defines to be used for clkevent purpose
Date:   Wed, 1 Apr 2020 10:39:06 +0200
Message-ID: <20200401083909.18886-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200401083909.18886-1-benjamin.gaignard@st.com>
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines to be able to enable/clear irq and configure one shot mode.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/stm32-lptimer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
index 605f62264825..90b20550c1c8 100644
--- a/include/linux/mfd/stm32-lptimer.h
+++ b/include/linux/mfd/stm32-lptimer.h
@@ -27,10 +27,15 @@
 #define STM32_LPTIM_CMPOK		BIT(3)
 
 /* STM32_LPTIM_ICR - bit fields */
+#define STM32_LPTIM_ARRMCF		BIT(1)
 #define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
 
+/* STM32_LPTIM_IER - bit flieds */
+#define STM32_LPTIM_ARRMIE	BIT(1)
+
 /* STM32_LPTIM_CR - bit fields */
 #define STM32_LPTIM_CNTSTRT	BIT(2)
+#define STM32_LPTIM_SNGSTRT	BIT(1)
 #define STM32_LPTIM_ENABLE	BIT(0)
 
 /* STM32_LPTIM_CFGR - bit fields */
-- 
2.15.0


Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43BC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70E5214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XEXfpe4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgBQNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:46:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21414 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgBQNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:46:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HDhdgQ025520;
        Mon, 17 Feb 2020 14:45:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=SY0lDuNc6BQxUxy2se9OGvOUF0DMEfHB47CslidcaOU=;
 b=XEXfpe4bSf3AW3e+IY8hCsWPHvgIxUyRmcknVjy9ZhHrC86hvI71j1BCcXWJ+tqzgtPv
 Rp9tXAyhZPlKCYDuykQ2O5XdGb7z7kFkJeQj2GvUX4U85n5lk6kW9cbw8zMiMc2rKir3
 WhuUSScnPzH0CrBqJK4mWhsl9QmiUs1zCvaaEens/oxGw2KkE7wHKpT4d9TqBkTUAvm7
 wX6hIamNbTWw2eA3hA2CGiCl3HIoXpy5StZj8fWzJWFoyxl1X82K7v/I0rhWcs9zESvY
 T5H32ApLW08kegEKG3CNdvv1tdgYuxgYdBtc1KRsPg0yIF7iaxYKvLkv7CzcAXaRx6s1 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y67a1kfcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:45:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5B80100034;
        Mon, 17 Feb 2020 14:45:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C798B2FF5C7;
        Mon, 17 Feb 2020 14:45:50 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Feb 2020 14:45:50
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent purpose
Date:   Mon, 17 Feb 2020 14:45:45 +0100
Message-ID: <20200217134546.14562-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200217134546.14562-1-benjamin.gaignard@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_08:2020-02-17,2020-02-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines to be able to enable/clear irq and configure one shot mode.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 4:
- move defines in mfd/stm32-lptimer.h

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


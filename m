Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BBA206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UJFrYfOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgDTMQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:16:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgDTMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:16:55 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBqlCg014149;
        Mon, 20 Apr 2020 14:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=AXPGvtsGWLkKS+I+Kb5oNNnn9+C77me7iOpHlW+3zcQ=;
 b=UJFrYfOfeauzWmjMtx5d+WSMuBCWNXdOfKRdSQ/1EfguSeB5d5sCbCxYl68Nof0YXX9u
 u0lyjQs7w+h4/W+tebjZH6fWdwOQo98gh2OXrkG5giVvNwy2S//XFY7dXnPYI/t/+kpl
 fB/T8M+leyXor1WnlNb8uRLgffgOMDRGAXex63D5HXQhq93octL2QFZkchJ3mb/ZyRyn
 OU2FMqZ5azBlsLk8KXlCQTuZvT9wdgyoo0OSOjT7DZBq2DtKgK7J8RlTJG+Z5NaILzvh
 RoyCJN64hRbhaEgYB3VAqbdhLFnZs3P4uHCcQEM54PmJke4Yl8oSKI1I8DjQ0WcQPWP6 Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqaw24e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 14:16:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20CDA10003A;
        Mon, 20 Apr 2020 14:16:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E18A920FA76;
        Mon, 20 Apr 2020 14:16:36 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Apr 2020 14:16:36
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
Subject: [PATCH v7 6/6] ARM: mach-stm32: select low power timer for STM32MP157
Date:   Mon, 20 Apr 2020 14:16:20 +0200
Message-ID: <20200420121620.2099-7-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200420121620.2099-1-benjamin.gaignard@st.com>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make MACH_STM32MP157 select CLKSRC_STM32_LP to get a broadcast timer.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 57699bd8f107..d78f55b7b1d0 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,7 @@ if ARCH_MULTI_V7
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
 	select ARM_ERRATA_814220
+	select CLKSRC_STM32_LP
 	default y
 
 endif # ARMv7-A
-- 
2.15.0


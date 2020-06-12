Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D582F207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jH8SbsSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLH31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:29:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgFLH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:29:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05C7NZDm021034;
        Fri, 12 Jun 2020 09:29:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9NAA+9cKZ/kIbCpAlrsaa+GS6yrhN/7VAfW5Ht3g5Cw=;
 b=jH8SbsSpiAPLvArNfqxH4fXnFflp0jen+BfFrBqm5pgkYROJLUlpAZQ3iXV3u9W0nphh
 3dbjafBIbbXyx/yTjXRX5eDkaf/zzfX9wsbsiKHjrsuDssQtdrmOKn/5OshQUGgMe7zH
 qdRJuZ27bgVcOUKwi0HcZIBNLTviyyjfENLK/XAECEXUGR8pHNIsg6TQMWwAJf9icneS
 YXdYAG2JGmY2dcSQwCbO6Oo+Y4ANUNL7Qqtt/ect9UHhHpF7m4jN+e+RI/PANN+/UjPL
 2/X0v9OLvy5YdWpPaG0pkD1HN1+0J8DyafSdp09pdLzIoUtMF6K7izptqotPATMVkz/6 dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31jppp4bn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 09:29:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5E1C100034;
        Fri, 12 Jun 2020 09:29:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2D572AC93E;
        Fri, 12 Jun 2020 09:29:05 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jun 2020 09:29:05
 +0200
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] irqchip/stm32: fix return value of stm32_exti_h_set_affinity
Date:   Fri, 12 Jun 2020 09:29:01 +0200
Message-ID: <20200612072901.14388-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_06:2020-06-11,2020-06-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exti hardware point of view, there is no specific action on set_affinity.
So the affinity must be forwarded to parent if there is a
descendent irqchips, otherwise just return IRQ_SET_MASK_OK_DONE.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index faa8482c8246..1a0a60ee7140 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -555,7 +555,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	if (d->parent_data->chip)
 		return irq_chip_set_affinity_parent(d, dest, force);
 
-	return -EINVAL;
+	return IRQ_SET_MASK_OK_DONE;
 }
 
 static int __maybe_unused stm32_exti_h_suspend(void)
-- 
2.17.1


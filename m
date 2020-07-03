Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB29D20723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o2Tl32h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGCJzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:55:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgGCJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:55:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0639bMKr014401;
        Fri, 3 Jul 2020 11:55:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=BScJztGlfYcevM6vG7P/xzi6490U6vbgga1vE9lI1xc=;
 b=o2Tl32h/Gk9cJ9YiuPZJ0nWBn2ZUE9tEKMeRGD6+isCJgCUm6Tu4D32MYtlEFfcBReHK
 Np1uqbf7NrA0HnodlLdDebrHHBL66qQOAdBVLUm9paVu/NqfaRoD4rfcQmtpgCCstLBb
 r+W1TNLd/aOJ2Znr6tlp3XoJz7/dxDvFip6UA054MDXVLvUf5l8t0sOnBBjcNuyB6txr
 rSM+wJMEIzFyHINR0junLiadv3dRLbF5uwr1o0mUAhDyiNHmvwhoG1WtzUat7SsIJeMg
 6DhzB4YUwXWdD6cwdQRi3ohAIfwTlFLkaRJB8g7KF2Ijdq0OJkjXWS3P231csmZy7ar3 xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31ww0gp0hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 11:55:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F290810002A;
        Fri,  3 Jul 2020 11:55:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E09F72BAC64;
        Fri,  3 Jul 2020 11:55:23 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Jul 2020 11:55:23
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>,
        <benjamin.gaignard@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] ARM: STM32: Add compatibles for syscon nodes
Date:   Fri, 3 Jul 2020 11:55:15 +0200
Message-ID: <20200703095520.30264-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_03:2020-07-02,2020-07-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a more specific compatible")
it is required to provide at least 2 compatibles string for syscon node.
This series update the syscon of the STM32 SoCs to fix the reported errors. 

Benjamin Gaignard (5):
  dt-bingings: arm: stm32: Add compatibles for syscon nodes
  ARM: dts: stm32: Add compatibles for syscon for stm32f426
  ARM: dts: stm32: Add compatibles for syscon for stm32f746
  ARM: dts: stm32: Add compatibles for syscon for stm32h743
  ARM: dts: stm32: Add compatibles for syscon for stm32mp151

 .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml     | 14 +++++++++++++-
 arch/arm/boot/dts/stm32f429.dtsi                           |  6 +++---
 arch/arm/boot/dts/stm32f746.dtsi                           |  6 +++---
 arch/arm/boot/dts/stm32h743.dtsi                           |  6 +++---
 arch/arm/boot/dts/stm32mp151.dtsi                          |  2 +-
 5 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.15.0


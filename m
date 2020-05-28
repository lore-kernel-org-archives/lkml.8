Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5090208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Rgn0mOUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE1HjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:39:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64274 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgE1HjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:39:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S7cAos017153;
        Thu, 28 May 2020 09:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=1lcgbL/rxGsDAqjZW9JrG35AHt9dvjJGVv5G7y5dl7U=;
 b=Rgn0mOUxRpssrSLPHqhK1vfcK7aNcIion3VK+PPT2GZkS1vbu7RkZkfMO6Ay3tEGf+/D
 /7/J4SU84mXeTBdyC6eqmGwukNqada7gTEmFlFhoFeS+kjpp6C9cAtLLmw5LMhyxMO6B
 j617JlYBP9tUPPYQR29Ggpy7sJUqGyqkYnjXkPGb2fflfsKnQsjUBFfyyf59f2V8xoR2
 Iy5Yt3yqIlmeBQZuvpZNaWxuxyqm058uI3WctRj3K0RZ5O7kLlCYs0p1twTst8c1A46X
 GKDV/go4p0arIvn1cT+HqqtWCSaviPSpQb57cBmVDewttDrS7TBvS4H79QbzhIDC5yf4 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa29wn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 09:38:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1A7710002A;
        Thu, 28 May 2020 09:38:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BEEC2B187F;
        Thu, 28 May 2020 09:38:57 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May 2020 09:38:57
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/3] STM32 update uart4 pin configuration for low power
Date:   Thu, 28 May 2020 09:38:50 +0200
Message-ID: <20200528073853.24759-1-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update uart4 pin configuration for low power in pinctrl, and for ed/ev
and dkx boards.

Erwan Le Ray (3):
  ARM: dts: stm32: update uart4 pin configuration for low power on
    stm32mp157
  ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
  ARM: dts: stm32: Update UART4 pin states on stm32mp15xx-dkx

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts    |  4 +++-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |  4 +++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.17.1


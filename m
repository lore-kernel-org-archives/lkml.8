Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F0F20888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="s1m/o/mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgFRNH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:07:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730120AbgFRNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:07:23 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ID2ZVd030156;
        Thu, 18 Jun 2020 15:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=8ffjSa1WBrW1OVyG9ClDZn5fyYDO6RsbX3ADHi53fhU=;
 b=s1m/o/mkC+rtXapEsEMy6XitXk0X4Rw7fZ4xISMw/A3QuhT+G0EoZiewQJXRhdPcw7Qw
 JO4dqSi5wxxmOSftJMxZ7PfA0VlqnFy7sIKhiJN7L8pBXEPhQ83k9kNIC1xbxg7Yt8dz
 IebUJ4YDYmSAmsEYyhBjG+weAVHSAlD/frSxrhH61VN3pANhlEOEjjoqqwERhxsvsQB6
 ZF22HaSJy5NyHDBSf8ZMloLf5IzPWLfI112Flp3eZXU9WZfL5s30sQ6xmzetsaKMev5E
 y7SftYRXIB4YdLhjqryOxxWg2CNIJL5N7v7ZqJfhjaDKBxhweFnUbUVz8ZFPtZ1ZpxMC sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31q64cb3fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 15:07:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BA3310002A;
        Thu, 18 Jun 2020 15:06:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E95052AAA6C;
        Thu, 18 Jun 2020 15:06:58 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun 2020 15:06:58
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
Subject: [PATCH v2 0/5] STM32 add usart nodes support
Date:   Thu, 18 Jun 2020 15:06:46 +0200
Message-ID: <20200618130651.29836-1-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of uart instances available on STM32MP157 boards:
- usart3 on stm32mp157c-ev1, stm32mp157a-dk1, and stm32mp157c-dk2
- uart7 on stm32mp157a-dk1 and stm32mp157c-dk2
- usart2 on stm32mp157c-dk2

Erwan Le Ray (5):
  ARM: dts: stm32: add usart2, usart3 and uart7 pins in
    stm32mp15-pinctrl
  ARM: dts: stm32: add usart3 node to stm32mp15xx-dkx boards
  ARM: dts: stm32: add usart3 node to stm32mp157c-ev1
  ARM: dts: stm32: add uart7 support to stm32mp15xx-dkx boards
  ARM: dts: stm32: add usart2 node to stm32mp157c-dk2

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 138 +++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts    |   2 +
 arch/arm/boot/dts/stm32mp157c-dk2.dts    |  11 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |  15 +++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |  17 +++
 5 files changed, 183 insertions(+)

-- 
2.17.1


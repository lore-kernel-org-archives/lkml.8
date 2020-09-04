Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13CBC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8689420E65
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="B/uuqjBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgIDNyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:54:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48078 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730714AbgIDNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:54:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084DMWMg007079;
        Fri, 4 Sep 2020 15:23:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=7fozBuXU3Cbd4IFH/r62M8Ur8q8NxDDJWRTMXFRdk9g=;
 b=B/uuqjBhphDFCBQDV0YZoyLJb26WBFQ7nuxgfZcET3bLpTQmOe16OKEnlmANxUp2XYfv
 pQY0xw9iUPHzvgOVB3Z19Mu7cFt1cir8jRp5JPswQQC+F4VK7Z/yhR5Ir9YCp1NjTwDL
 9GBkMmUGUQHWrN1520J2qkUOOOqYnDXd0JALna2iDWmZLP9CQvuLj8pGcR/CwDnQ8QxB
 3eSWYMl13z7TSUERhjQ+bbVkK0OUWSFvPp6KrLyccvYlMBeFLXOb9pjUImlS/1RCd4Do
 +XZEcuVabiv0P5dld/kwoz6vfJasT8GHYaxV5LP2JNiwXgq1IWkOzPGixZCl5L+SwLvT kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337dwhsvhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 15:23:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90C4410002A;
        Fri,  4 Sep 2020 15:22:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76B172AD2B4;
        Fri,  4 Sep 2020 15:22:59 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep 2020 15:22:59
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <linux@armlinux.org.uk>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH 0/2] add FMC2 EBI controller support
Date:   Fri, 4 Sep 2020 15:20:41 +0200
Message-ID: <1599225643-5558-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_07:2020-09-04,2020-09-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables FMC2 EBI support on STM32MP1 SOCs.

Christophe Kerello (2):
  ARM: multi_v7_defconfig: add FMC2 EBI controller support
  ARM: dts: stm32: add FMC2 EBI support for stm32mp157c

 arch/arm/boot/dts/stm32mp151.dtsi     | 43 +++++++++++++++++++++++------------
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 16 +++++++------
 arch/arm/configs/multi_v7_defconfig   |  1 +
 3 files changed, 39 insertions(+), 21 deletions(-)

-- 
1.9.1


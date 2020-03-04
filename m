Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81607C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B712166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="u6FbvwLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgCDIK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:10:28 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18098 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbgCDIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:10:27 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02487rv0032631;
        Wed, 4 Mar 2020 09:10:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Ic1C52dxdRVd8hopKHFmxL20NCwaptXElaVaPhP+rUE=;
 b=u6FbvwLMTti9eJsDBmKkvCAdcWlQHcVPaTZQa1CAlCVWbdVsR8z3WQm8rWX5mGHprAzY
 UDheNAzsQerzo9oF26Gt0wPFywt8/XZ8BjXzsvcrApxtZmqQmPxK/jrIIe3XEcf9hYsH
 /i38IKdL5CbjyNHVzaPQgSH4yxBwz7SQB82pKilAtkB+Ci+iO1L3echhIDpDBHE1Btur
 39xwg/rAuASlDHFKre50CDyR4vzHZqNqEtT1DFyp4gfiWDOBlQk1+ovqlN/ksAsZk/Og
 lO+89gvrrYTulefBJICTaWWZliGQqVRxot335MocEGI9kCJh0jP5BxNKQXMJswScNrMS lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfem0ybx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 09:10:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01392100038;
        Wed,  4 Mar 2020 09:10:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF0AC21FE85;
        Wed,  4 Mar 2020 09:10:05 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar 2020 09:10:05
 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yann Gautier <yann.gautier@st.com>
Subject: [PATCH 0/3] Update SDMMC nodes on STM32MP1 boards 
Date:   Wed, 4 Mar 2020 09:09:53 +0100
Message-ID: <20200304080956.7699-1-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates the sdmmc nodes for STM32MP1.
For SD cards nodes, the cd-gpio property is used instead of broken-cd,
and the disable-wp property is added.
The last patch corrects the vqmmc regulator for eMMC on ED1/EV1 boards.

Yann Gautier (3):
  ARM:dts: stm32: add cd-gpios properties for SD-cards on STM32MP1
    boards
  ARM: dts: stm32: add disable-wp property for SD-card on STM32MP1
    boards
  ARM: dts: stm32: use correct vqmmc regu for eMMC on stm32mp1 ED1/EV1
    boards

 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 3 ++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts       | 5 +++--
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi      | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1


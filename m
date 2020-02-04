Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD51C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF5221D7E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZQptpfXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBDN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:26:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37237 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbgBDN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:26:29 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014DNoVK030249;
        Tue, 4 Feb 2020 14:26:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=AplTNN5L+r2sBe+jH4b1Al4L+72dRx8nYadx/tYF8Ug=;
 b=ZQptpfXca1Q2Ug7CIhv4qXR30/e2gpoGXV3YL2Z0t0T2MGKKK6j5dXKjgJUQnDbREHsm
 FEysJBgBfVpQDR8mZnRG92U3HBeQXHpUDhKKdXAMkIcs9IyZtsv1rbVmyFwMNlEGVV2j
 x7ZIhpJim5exW954sZQ+vPSCWnvUSHDhsy7wuwu11nc+ieZGNLt/s59zvAMv9j4cJUAX
 eX7jYYNdXmUZZRecIbbBvVvtNV4YAQWTOgtanF04qHn+qhcm6WfOsccx1ZWXFiVuNdaV
 2q7bZKb+DXRrie9IFAtHat4+z2rcugLY1ZQOsegz0Sz/kylIvf2LdD2uJHYZaXlJbYHF 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw0019tb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 14:26:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 042AB100034;
        Tue,  4 Feb 2020 14:26:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5FEA2B188F;
        Tue,  4 Feb 2020 14:26:12 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 14:26:12
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] USB OTG Dual Role on STM32MP15
Date:   Tue, 4 Feb 2020 14:26:03 +0100
Message-ID: <20200204132606.20222-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB OTG Dual Role on stm32mp15.
USB OTG HS is configured in Dual Role mode on stm32mp157c-ev1, role detection
uses ID pin.

Amelie Delaunay (3):
  ARM: dts: stm32: add USB OTG full support on stm32mp151
  ARM: dts: stm32: add USB OTG pinctrl to stm32mp15
  ARM: dts: stm32: enable USB OTG Dual Role on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/stm32mp151.dtsi        |  3 ++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts    |  4 ++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |  3 ++-
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1


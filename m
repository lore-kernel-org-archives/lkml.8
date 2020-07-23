Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C14C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50737206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zgcA6GOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgGWLHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:07:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728282AbgGWLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:07:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NAwU4c027391;
        Thu, 23 Jul 2020 13:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=B8FNCHpPJo15iadwOE6rPE190prlO9w4wXVteCya9nk=;
 b=zgcA6GOvFc1l5ZCgd+ZOaIrP7vM4hl4947z/fAoiy1UXl1WazB+YJ58SQUFtzoXy/x+J
 AQ4pglkbv/Lnk2yJ7mPuxGEUMztOpfqeBcKJHznpRBukRzfocSn+MzlAdfdmHUeKHtvS
 G3xRRYN1CQiD+GQPaQtGwFogug8dYvdWFYadAfOoEp6Ez0uNQOWCokx5aE+35VLKFp+4
 jECBzQGEovPwANETvNSXHfTUrlatDzT4qxQ+3ecTSCkyMcvGcL5woZbyVnMHFs1eT/8V
 VC3oA+rvKx+dkhScP1SoNREVFzMgE04bH4KpSltcRY0G8wRnJs2ZzRdqeOBJepZNi5RM ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32cux0mrg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 13:07:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75709100034;
        Thu, 23 Jul 2020 13:07:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 606EB2AD9F6;
        Thu, 23 Jul 2020 13:07:32 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 13:07:32
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] Add USB role switch support to DWC2
Date:   Thu, 23 Jul 2020 13:07:14 +0200
Message-ID: <20200723110717.18699-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using usb-c connector (but it can also be the case with a micro-b
connector), iddig, avalid, bvalid, vbusvalid input signals may not be
connected to the DWC2 OTG controller.
DWC2 OTG controller features an overriding control of the PHY voltage valid
and ID input signals.
So, missing signals can be forced using usb role from usb role switch and
this override feature.

This series adds support for usb role switch to dwc2, by using overriding
control of the PHY voltage valid and ID input signals.

It has been tested on stm32mp157c-dk2 [1], which has a Type-C connector
managed by a Type-C port controller, and connected to USB OTG controller.

[1] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html

Amelie Delaunay (3):
  usb: dwc2: override PHY input signals with usb role switch support
  dt-bindings: usb: dwc2: add optional usb-role-switch property
  usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15
    SoCs
---
Changes in v2:
- Previous DT patch already in stm32-next branch so removed from v2 patchset
  "ARM: dts: stm32: enable usb-role-switch on USB OTG on stm32mp15xx-dkx"
- DWC2 DT bindings update added
- Build issue reported by kernel test robot fixed
- Martin's comments taken into account
---
 .../devicetree/bindings/usb/dwc2.yaml         |   4 +
 drivers/usb/dwc2/Kconfig                      |   1 +
 drivers/usb/dwc2/Makefile                     |   2 +-
 drivers/usb/dwc2/core.h                       |   9 +
 drivers/usb/dwc2/drd.c                        | 183 ++++++++++++++++++
 drivers/usb/dwc2/gadget.c                     |   2 +-
 drivers/usb/dwc2/params.c                     |   4 +-
 drivers/usb/dwc2/platform.c                   |  15 ++
 8 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/dwc2/drd.c

-- 
2.17.1


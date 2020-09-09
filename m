Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A79B21D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zk9Wn5Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIIJfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:35:53 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:8276 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgIIJfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:35:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0899WnO6015286;
        Wed, 9 Sep 2020 11:35:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=AsXvjGauEbCvShCQXkbkbgTM2OrLJ2IWVxMse8nLIso=;
 b=zk9Wn5Lbk9qPHpYqCdVkPDjFQWWLJE1rXvqCjiXv2HCgVvHid5tFPEoTuBkEuj6HKYg4
 pHiZm7Kf/bgRILHP2KyeDhGtasPe56YrMVdCABkzwaR+w2PfrIy3+VyQwo/XAch8THU/
 mQLleJg77r9AhHM7TL8kFeKvpB/fC3Et8QNxDLfW9EJJdbW6AuCo9/oKq1fV7LylLvnF
 lACvCMRFb5QctXrZUmidrx5xZvbCjloOQwYR/l6062Ip+OQSgvLUf26eY02HJdbNW/W1
 WiqYAUL4In/OL8xvuqk9mOBtvVwmcGTwj/XeQy6QJVuFTLTvjmGtZ+qStL4vRdgM98VY pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33c051c6gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 11:35:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CCA210002A;
        Wed,  9 Sep 2020 11:35:19 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag3node5.st.com [10.75.127.72])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 73410220AE9;
        Wed,  9 Sep 2020 11:35:19 +0200 (CEST)
Received: from localhost (10.75.127.47) by GPXDAG3NODE5.st.com (10.75.127.72)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep 2020 11:35:19
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
Subject: [PATCH v6 0/3] Add USB role switch support to DWC2
Date:   Wed, 9 Sep 2020 11:35:08 +0200
Message-ID: <20200909093511.4728-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
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
  dt-bindings: usb: dwc2: add optional usb-role-switch property
  usb: dwc2: override PHY input signals with usb role switch support
  usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15
    SoCs
---
Changes in v6:
- Select USB_ROLE_SWITCH if USB_DWC2, and not only if USB_DWC2_DUAL_ROLE:
  drd.c is built whatever DWC2 mode (DUAL, HOST, PERIPHERAL) as it is used also
  to detect attach/detach (so a-valid/b-valid sessions). 
Changes in v5:
- Use device_property_read_bool instead of of_read_property_bool in params.c
Changes in v4:
- Simplify call to dwc2_force_mode in drd.c
- Add error_drd label in probe error path in platform.c
Changes in v3:
- Fix build issue reported by kernel test robot in drd.c
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
 drivers/usb/dwc2/drd.c                        | 180 ++++++++++++++++++
 drivers/usb/dwc2/gadget.c                     |   2 +-
 drivers/usb/dwc2/params.c                     |   2 +-
 drivers/usb/dwc2/platform.c                   |  20 +-
 8 files changed, 215 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/dwc2/drd.c

-- 
2.17.1


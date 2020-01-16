Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F67C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE973207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WhGcOXtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAPOpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:45:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgAPOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GEc9df028289;
        Thu, 16 Jan 2020 15:45:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=MzhYp1pTTAFs6phM/AXFgfZU+jA+iDcfjidwqVIbTe8=;
 b=WhGcOXtN3R71jqyfyCDB3m6yNwa2jZZ3phzNCF/y17QbIzICBWF3oHaBxnkBoct+/19W
 4btgHF008LAsBx6R4iZ4884x+SwjIQyVOfkuH/Ven0NmkLw7Kn4XdJanId/qgSfD8G4G
 37queaoZ/Gh9U4tYV/y/6gwcZTm7x5E4PIwQOHlYDycqeY3uWEL9jWz1BpQmUPujlmej
 vV4ulYkyEYW4FEOQkPPC/Cj4NfIekfJNvuQ9M8DVGE0gMR8jUx7hbj7In9qAlHJ0Rvkr
 0BCZS3l0P0oWlArw3b61RKAx/+H+qAcn3Dpttg2JcnmuQtRTlFUXcCmIseKAYSaGEYNV 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78shvbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 15:45:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E64B10002A;
        Thu, 16 Jan 2020 15:45:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BC7B2D3798;
        Thu, 16 Jan 2020 15:45:30 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 16 Jan 2020 15:45:30
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCHv2 0/2] USB DWC2 support for STM32MP15 SoCs USB OTG
Date:   Thu, 16 Jan 2020 15:45:22 +0100
Message-ID: <20200116144524.16070-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for STM32MP15 SoCs USB OTG HS and FS based on DWC2 IP.

STM32MP15 SoCs embeds a DWC2 IP that can be used in HS or in FS, and
uses an external Vbus and ID level detection to support OTG operations.

Amelie Delaunay (2):
  dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and
    FS
  usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS
---
Changes in v2:
- add Minas Acked-by on driver
- use dwc2.yaml bindings

 .../devicetree/bindings/usb/dwc2.yaml         |  6 ++
 drivers/usb/dwc2/core.h                       |  8 ++
 drivers/usb/dwc2/hw.h                         |  8 ++
 drivers/usb/dwc2/params.c                     | 33 +++++++
 drivers/usb/dwc2/platform.c                   | 94 ++++++++++++++++++-
 5 files changed, 147 insertions(+), 2 deletions(-)

-- 
2.17.1


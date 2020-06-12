Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B68C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B7820888
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="V3oHbThV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgFLPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:23:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26444 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726644AbgFLPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:23:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CF1VeH016986;
        Fri, 12 Jun 2020 17:23:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ZNCgFY29ushPSChdQisNmd/nPHJRu5GNLEvEuVDL5BM=;
 b=V3oHbThVFkfRLV1aqUq4Dvf3ONhnmS7OuMBOhlANd777f+fD9tVVoIHaEwJ4vgFpvSZg
 ny2jfjYOv8WKIkMSjIjFTk1FrvIB5BnbeNpKH6maohfuQ408ijgATIlmvcpp/WGF8ken
 yhOmcT8+nBDSVFsBEFSOcrzGFWyKtA25YStyyT1nOgNdn/yyBXg0p/abfGQW5Mu3KYKX
 nh9D9z8m9I6iztupBtDMJEcYx/OnMXF3EgJXK8zxXq0gOzsqig1v2pffJtgeN0ILZPS+
 ieUcR3UoocZX38owaQxDBdc4zbuFRzQM5+meJgD+bGymcZCR8WxA2oGIDZ2Qx+LWV0Ay LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31g097s1j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 17:23:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF14210002A;
        Fri, 12 Jun 2020 17:23:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 960112B9918;
        Fri, 12 Jun 2020 17:23:12 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 12 Jun 2020 17:23:11
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <arnd@linaro.org>,
        <alexandre.torgue@st.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v5 0/6] add STM32 FMC2 EBI controller driver
Date:   Fri, 12 Jun 2020 17:22:36 +0200
Message-ID: <1591975362-22009-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_11:2020-06-12,2020-06-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FMC2 functional block makes the interface with: synchronous and
asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
peripherals) and NAND flash memories.
Its main purposes are:
  - to translate AXI transactions into the appropriate external device
    protocol
  - to meet the access time requirements of the external devices
All external devices share the addresses, data and control signals with the
controller. Each external device is accessed by means of a unique Chip
Select. The FMC2 performs only one access at a time to an external device.

Changes in v5:
 - NAND:
   - do not display errors if the driver is deferred.
   - look at the parent compatible string to match what we expect.
 - bindings:
   - add Rob reviewed-by tag on patch 3.
   - fix indent descriptions.
   - add new NFC compatible string to handle reg number of entries. 

Changes in v4:
 - bindings:
   - fix filename: st,stm32-fmc2-ebi.yaml

Changes in v3:
 - NAND:
   - rename labels used on errors
   - add in the commit log the reason to increase FMC2_TIMEOUT_MS (patch 3)
   - add Miquel reviewed-by tag (patches 2/4/5/9)
 - EBI:
   - move in memory folder
   - merge MFD and BUS drivers to avoid a MFD driver
 - bindings:
   - pattern name has been modified
   - vendor properties have been modified
     - s/_/-/
     - add unit suffix (-ns) on timing properties

Christophe Kerello (6):
  mtd: rawnand: stm32_fmc2: do not display errors if the driver is
    deferred
  dt-bindings: mtd: update STM32 FMC2 NAND controller documentation
  dt-bindings: memory-controller: add STM32 FMC2 EBI controller
    documentation
  memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
  mtd: rawnand: stm32_fmc2: use regmap APIs
  mtd: rawnand: stm32_fmc2: get resources from parent node

 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  252 ++++
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   83 +-
 drivers/memory/Kconfig                             |   10 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/stm32-fmc2-ebi.c                    | 1206 ++++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig                       |    1 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c             |  311 ++---
 7 files changed, 1688 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
 create mode 100644 drivers/memory/stm32-fmc2-ebi.c

-- 
1.9.1


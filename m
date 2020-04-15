Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6612063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Du3qQOqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415015AbgDOP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:58:56 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39533 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410029AbgDOP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:58:49 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FFW5Hf032217;
        Wed, 15 Apr 2020 17:58:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=25grhCA0X75blAO5Q3+BsOtCodm4ez+TgXpHxUqmcPk=;
 b=Du3qQOqROvE191kXxbyLKK3rNuybC6dxETaPya+QqpmMu6r1eNoMUNktUHtPCj4kvv/K
 zdsUFo681t87gK1b+uuyI+3mvYSmMXJ/tyVN0obCbPwi37+TIekKPPv71JfapyPQDukD
 HKJPYsuyn640CFD2HdYgh0SNME/AiQVOYCMa78MdXGa4TdbXJCD86/pI3FEeo4JJVjAS
 eK4cibIgeZfgh4E5tB4IOCLC9MU6lC2EBVrSyPcPTzESRHgAdRx8xbHyR7H3QIM3AnC+
 YisKXfbiJhaGkMIhu0CzyOc1VTAUxcuTc5aDDQuIvXuvjyt6KUg3sJkwfFcWH71idRUF eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94cxv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 17:58:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C56710003B;
        Wed, 15 Apr 2020 17:58:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34964212FAB;
        Wed, 15 Apr 2020 17:58:13 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 17:58:12
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 00/12] add STM32 FMC2 controller drivers
Date:   Wed, 15 Apr 2020 17:57:24 +0200
Message-ID: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
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

Changes in v2:
 - use of regmap_bulk_write/regmap_bulk_read APIs
 - remove ops from stm32_fmc2 structure
 - add 2 APIs to manage FMC2 enable/disable
 - add 2 APIs to manage FMC2 NWAIT shared signal

Christophe Kerello (12):
  dt-bindings: mfd: stm32-fmc2: add STM32 FMC2 controller documentation
  mfd: stm32-fmc2: add STM32 FMC2 controller driver
  bus: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
  mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
  mtd: rawnand: stm32_fmc2: remove useless inline comments
  mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
  mtd: rawnand: stm32_fmc2: cleanup
  mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
  mtd: rawnand: stm32_fmc2: move all registers
  mtd: rawnand: stm32_fmc2: use regmap APIs
  mtd: rawnand: stm32_fmc2: use stm32_fmc2 structure in nfc controller
  mtd: rawnand: stm32_fmc2: add new MP1 compatible string

 .../devicetree/bindings/mfd/st,stm32-fmc2.yaml     |  370 ++++++
 drivers/bus/Kconfig                                |   11 +
 drivers/bus/Makefile                               |    1 +
 drivers/bus/stm32-fmc2-ebi.c                       | 1091 +++++++++++++++++
 drivers/mfd/Kconfig                                |   12 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/stm32-fmc2.c                           |  136 +++
 drivers/mtd/nand/raw/Kconfig                       |    3 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c             | 1277 +++++++++-----------
 include/linux/mfd/stm32-fmc2.h                     |  225 ++++
 10 files changed, 2413 insertions(+), 714 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-fmc2.yaml
 create mode 100644 drivers/bus/stm32-fmc2-ebi.c
 create mode 100644 drivers/mfd/stm32-fmc2.c
 create mode 100644 include/linux/mfd/stm32-fmc2.h

-- 
1.9.1


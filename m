Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E036320780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QJTqmhCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgGANZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:25:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37747 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728392AbgGANZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:25:41 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061DOnOH002515;
        Wed, 1 Jul 2020 15:25:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=N34mf34zyNH9z+LguQ97xJdxyRAZPkEJBPLArQ3FE8Y=;
 b=QJTqmhCOxZoThXwbTq++hh4KGoR/c3s9PepKJUzV6ZAJmNaavbNWbBvqg+WoYes1XzJO
 o5l7J2GWYSSQRv87klZAtytpDpxg3anxGaHxrmHGCaXJeOJ94YEsZbNWr+qWd4Rk4736
 Kov+noZnCruOg4Nl8OHPMYc6avk0hnBo3PTqJCiPXGDm2RbGgljDa8cdg0d4t4NJta9F
 xYGyhyNROh9ExR3mIBdzklb71NqzrpPMSZsj5N22JA7mjG/h5hklWzqCcJxjfBLI2Qri
 qJCBO8ZBaIFo1I/pdqHTrHdYtWI9u69HNYqpC3qEH8lbVL1931bo6lxvPmsLkadMUklF 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wuvwa82n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 15:25:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3B6310002A;
        Wed,  1 Jul 2020 15:25:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFABD2B6DD8;
        Wed,  1 Jul 2020 15:25:27 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Jul 2020 15:25:27
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stefano.stabellini@xilinx.com>,
        <tomase@xilinx.com>, <devicetree@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 0/5] STM32 ETZPC bus controller
Date:   Wed, 1 Jul 2020 15:25:18 +0200
Message-ID: <20200701132523.32533-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 Extended TrustZone Protection controller act like a firewall on the
platform bus. Depending of its configuration devices could be accessible
by the TrustZone, the co-processor or the non-secure world. ETZPC
configuration could evolve at runtime for example to switch a device from
non-secure world to co-processor.

The series introduce 'firewall' helpers to handle the new devices-tree
properties. These properties are not dedicated to ETZPC and will be reused
for STM32 next generation of bus controller.

version 4:
- use bus API

version 3:
- add description in firewall consumer bindings
- add Linus reviewed-by tag

version 2:
- fix unit name into st,stm32-etzpc.yaml example and DT


Benjamin Gaignard (5):
  dt-bindings: bus: Add firewall bindings
  bus: stm32: Introduce firewall controller helpers
  dt-bindings: bus: Add STM32 ETZPC firewall controller
  bus: stm32: Add stm32 ETZPC firewall bus controller
  ARM: dts: stm32: Use ETZPC firewall bus

 .../bindings/bus/stm32/firewall-consumer.yaml      |  36 +++
 .../bindings/bus/stm32/firewall-provider.yaml      |  18 ++
 .../bindings/bus/stm32/st,stm32-etzpc.yaml         |  46 ++++
 arch/arm/boot/dts/stm32mp151.dtsi                  |   7 +-
 drivers/bus/Kconfig                                |   2 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/stm32/Kconfig                          |  11 +
 drivers/bus/stm32/Makefile                         |   2 +
 drivers/bus/stm32/firewall.c                       | 251 +++++++++++++++++++++
 drivers/bus/stm32/firewall.h                       |  66 ++++++
 drivers/bus/stm32/stm32-etzpc.c                    | 163 +++++++++++++
 include/dt-bindings/bus/stm32/stm32-etzpc.h        |  90 ++++++++
 12 files changed, 692 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
 create mode 100644 drivers/bus/stm32/Kconfig
 create mode 100644 drivers/bus/stm32/Makefile
 create mode 100644 drivers/bus/stm32/firewall.c
 create mode 100644 drivers/bus/stm32/firewall.h
 create mode 100644 drivers/bus/stm32/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/stm32/stm32-etzpc.h

-- 
2.15.0


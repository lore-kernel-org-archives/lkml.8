Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DBD24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dXSOaGJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgA1Pix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1491 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgA1Pij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFX6td021997;
        Tue, 28 Jan 2020 16:38:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=mizgnvruNb3pP6RjBqNnV58jqve6OZmR65T5OWriiZI=;
 b=dXSOaGJtRyoHa5muquJxJJeTJ+6Z3QybKURz6IzRIHfROdSwNRT85M0xTkzJWDr5xtUH
 LpPpvCPDfhxAk7nMZxy1Cl9HBS/3p7kf9vqOdqPONkK9nfHNuqIoM8Uri9FHPofsHImm
 1knkNG43iserOUngjyUNGGgKj7DTCssR6WJJ+rrOvqwNREbaHMySpF6jT/vUuxW3YHDr
 CxMeOx3tzn3okOAzfHurTMesa0/jsONnRykE05rrXWUR4XlT2z5+YD2aW9WAIk3fgQ2Q
 nlCVIpniqp6KXjM96/dVisVgCU/k1ZP+q/jtmgH0AF9HnzJFR2iM/NNpFdNyNXmRUI6h 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxmdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D10E10002A;
        Tue, 28 Jan 2020 16:38:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F86B2BF9CF;
        Tue, 28 Jan 2020 16:38:19 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:18
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>, <sudeep.holla@arm.com>, <lkml@metux.net>
CC:     <loic.pallardy@st.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <system-dt@lists.openampproject.org>,
        <stefano.stabellini@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/7] Introduce bus firewall controller framework
Date:   Tue, 28 Jan 2020 16:37:59 +0100
Message-ID: <20200128153806.7780-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus firewall framework aims to provide a kernel API to set the configuration
of the harware blocks in charge of busses access control.

Framework architecture is inspirated by pinctrl framework:
- a default configuration could be applied before bind the driver.
  If a configuration could not be applied the driver is not bind
  to avoid doing accesses on prohibited regions.
- configurations could be apllied dynamically by drivers.
- device node provides the bus firewall configurations.

An example of bus firewall controller is STM32 ETZPC hardware block
which got 3 possible configurations:
- trust: hardware blocks are only accessible by software running on trust
  zone (i.e op-tee firmware).
- non-secure: hardware blocks are accessible by non-secure software (i.e.
  linux kernel).
- coprocessor: hardware blocks are only accessible by the coprocessor.
Up to 94 hardware blocks of the soc could be managed by ETZPC.

At least two other hardware blocks can take benefits of this:
- ARM TZC-400: http://infocenter.arm.com/help/topic/com.arm.doc.100325_0001_02_en/arm_corelink_tzc400_trustzone_address_space_controller_trm_100325_0001_02_en.pdf
  which is able to manage up to 8 regions in address space.
- IMX Ressource Domain Controller (RDC): supports four domains and up to eight regions 

Version 2 has been rebased on top of v5.5
- Change framework name to "firewall" because the targeted hardware block
  are acting like firewall on the busses.
- Mark Brown had reviewed the previous version but it was on kernel 5.1 and I change
  the name framework so I have decided to remove it.
- Use yaml file to describe the bindings

Benjamin

Benjamin Gaignard (7):
  dt-bindings: bus: Add firewall bindings
  bus: Introduce firewall controller framework
  base: Add calls to firewall controller
  dt-bindings: bus: Add STM32 ETZPC firewall controller
  bus: firewall: Add driver for STM32 ETZPC controller
  ARM: dts: stm32: Add firewall node for stm32mp157 SoC
  ARM: dts: stm32: enable firewall controller node on stm32mp157c-ed1

 .../bindings/bus/firewall/firewall-consumer.yaml   |  25 ++
 .../bindings/bus/firewall/firewall-provider.yaml   |  18 ++
 .../bindings/bus/firewall/st,stm32-etzpc.yaml      |  41 ++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   2 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   7 +
 drivers/base/dd.c                                  |   9 +
 drivers/bus/Kconfig                                |   2 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/firewall/Kconfig                       |  14 ++
 drivers/bus/firewall/Makefile                      |   2 +
 drivers/bus/firewall/firewall.c                    | 264 +++++++++++++++++++++
 drivers/bus/firewall/stm32-etzpc.c                 | 140 +++++++++++
 include/dt-bindings/bus/firewall/stm32-etzpc.h     |  90 +++++++
 include/linux/firewall.h                           |  70 ++++++
 14 files changed, 686 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/firewall-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/firewall-provider.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/st,stm32-etzpc.yaml
 create mode 100644 drivers/bus/firewall/Kconfig
 create mode 100644 drivers/bus/firewall/Makefile
 create mode 100644 drivers/bus/firewall/firewall.c
 create mode 100644 drivers/bus/firewall/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/firewall/stm32-etzpc.h
 create mode 100644 include/linux/firewall.h

-- 
2.15.0


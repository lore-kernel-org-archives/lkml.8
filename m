Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3AC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695702072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFNHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:33 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36292 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 938808030702;
        Fri,  6 Mar 2020 13:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3hoOnvFZIbC7; Fri,  6 Mar 2020 16:07:30 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache drivers
Date:   Fri, 6 Mar 2020 16:07:15 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130731.938808030702@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
system controller provides three vendor-specific blocks. In particular
there are two Errors Handler Blocks to detect and report an info regarding
any problems discovered on the AXI and APB buses. These are the main buses
utilized by the SoC devices to interact with each other. In addition there
is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
L2-to-RAM latencies. All of this functionality is implemented in the
APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
framework of this patchset.

This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
commit 98d54f81e36b ("Linux 5.6-rc4").

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (6):
  dt-bindings: Add Baikal-T1 AXI-bus EHB dts bindings file
  dt-bindings: Add Baikal-T1 APB-bus EHB dts bindings file
  dt-bindings: Add Baikal-T1 L2-cache Control Block dts bindings file
  soc: bt1: Add Baikal-T1 AXI-bus EHB driver
  soc: bt1: Add Baikal-T1 APB-bus EHB driver
  soc: bt1: Add Baikal-T1 L2-cache Control Block driver

 .../soc/baikal-t1/be,bt1-apb-ehb.yaml         |  66 +++
 .../soc/baikal-t1/be,bt1-axi-ehb.yaml         |  52 +++
 .../bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml | 108 +++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/baikal-t1/Kconfig                 |  49 +++
 drivers/soc/baikal-t1/Makefile                |   4 +
 drivers/soc/baikal-t1/apb-ehb.c               | 381 ++++++++++++++++++
 drivers/soc/baikal-t1/axi-ehb.c               | 250 ++++++++++++
 drivers/soc/baikal-t1/common.h                |  37 ++
 drivers/soc/baikal-t1/l2-ctl.c                | 325 +++++++++++++++
 11 files changed, 1274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-apb-ehb.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-axi-ehb.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
 create mode 100644 drivers/soc/baikal-t1/Kconfig
 create mode 100644 drivers/soc/baikal-t1/Makefile
 create mode 100644 drivers/soc/baikal-t1/apb-ehb.c
 create mode 100644 drivers/soc/baikal-t1/axi-ehb.c
 create mode 100644 drivers/soc/baikal-t1/common.h
 create mode 100644 drivers/soc/baikal-t1/l2-ctl.c

-- 
2.25.1


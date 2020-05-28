Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12133C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20612078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406591AbgE1TbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:31:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43946 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406369AbgE1TbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:31:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3F4AA8030839;
        Thu, 28 May 2020 19:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cIkU-J_EueAk; Thu, 28 May 2020 22:31:18 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] bus: bt1-axi: Build the driver into the kernel
Date:   Thu, 28 May 2020 22:31:13 +0300
Message-ID: <20200528193113.17372-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528193113.17372-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528193113.17372-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alas the method trigger_all_cpu_backtrace() isn't exported by the
kernel, but we need to have it called in case of the bus errors detected
to get a better description of a possible cause of the error. Let's
disable the ability to build the driver as a loadable kernel module then.
Note In future the driver will support the AXI-bus interconnect capability,
so we'd have to make it built into the kernel anyway.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 18858f560d1f..4be793c5ab4d 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -45,7 +45,7 @@ config BT1_APB
 	  accessed via corresponding sysfs nodes.
 
 config BT1_AXI
-	tristate "Baikal-T1 AXI-bus driver"
+	bool "Baikal-T1 AXI-bus driver"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
 	select MFD_SYSCON
 	help
-- 
2.26.2


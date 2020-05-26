Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C023C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3920707
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbgEZVzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:55:53 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59986 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbgEZVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:55:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2ED9A8030877;
        Tue, 26 May 2020 21:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z0qVl-qB3sNO; Wed, 27 May 2020 00:55:39 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/12] i2c: designware: slave: Set DW I2C core module dependency
Date:   Wed, 27 May 2020 00:55:22 +0300
Message-ID: <20200526215528.16417-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200526215528.16417-1-Sergey.Semin@baikalelectronics.ru>
References: <20200526215528.16417-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW APB I2C slave code in fact depends on the DW I2C driver core, but not
on the platform code. Yes, the I2C slave interface is currently supported
by the platform version of the IP core, but it doesn't make it dependent
on it. So make sure the DW APB I2C slave config is only available if the
I2C_DESIGNWARE_CORE config is enabled.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ddca08f8a76..b907d4046942 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -540,8 +540,8 @@ config I2C_DESIGNWARE_PLATFORM
 
 config I2C_DESIGNWARE_SLAVE
 	bool "Synopsys DesignWare Slave"
+	depends on I2C_DESIGNWARE_CORE
 	select I2C_SLAVE
-	depends on I2C_DESIGNWARE_PLATFORM
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C slave adapter.
-- 
2.26.2


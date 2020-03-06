Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29029C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86D2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFNUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:20:09 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36686 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCFNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:20:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B9F618030786;
        Fri,  6 Mar 2020 13:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sst7jy4boByd; Fri,  6 Mar 2020 16:20:06 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] scripts/dtc: check: Add additional i2c reg flags support
Date:   Fri, 6 Mar 2020 16:19:50 +0300
In-Reply-To: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132006.B9F618030786@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Recently the I2C-controllers slave interface support was added to the
kernel I2C subsystem. In this case Linux can be used as, for example,
a I2C EEPROM machine. See [1] for details. Other than instantiating
the EEPROM-slave device from user-space there is a way to declare the
device in dts. In this case firstly the I2C bus controller must support
the slave interface. Secondly I2C-slave sub-node of that controller
must have "reg"-property with flag I2C_OWN_SLAVE_ADDRESS set (flag is
declared in [2]). That flag is declared as (1 << 30), which when set
makes dtc unhappy about too big address set for a I2C-slave:

Warning (i2c_bus_reg): /example-2/i2c@1120000/eeprom@64: I2C bus unit address format error, expected "40000064"
Warning (i2c_bus_reg): /example-2/i2c@1120000/eeprom@64:reg: I2C address must be less than 10-bits, got "0x40000064"

Similar problem would have happened if we had set the 10-bit address
flag I2C_TEN_BIT_ADDRESS in the "reg"-property.

In order to fix the problem we suggest to alter the I2C-bus reg-check
algorithm, so one would be aware of the upper bits set. Normally if no
flag specified, the 7-bit address is expected in the "reg"-property.
If I2C_TEN_BIT_ADDRESS is set, then the 10-bit address check will be
performed. The I2C_OWN_SLAVE_ADDRESS flag will be just ignored.

[1] Documentation/i2c/slave-interface.rst
[2] include/dt-bindings/i2c/i2c.h

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 scripts/dtc/checks.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 756f0fa9203f..01c1ad895e6d 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1025,6 +1025,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 	const char *unitname = get_unitname(node);
 	char unit_addr[17];
 	uint32_t reg = 0;
+	uint32_t addr;
 	int len;
 	cell_t *cells = NULL;
 
@@ -1041,17 +1042,21 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 	}
 
 	reg = fdt32_to_cpu(*cells);
-	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
+	addr = reg & 0x3FFFFFFFU;
+	snprintf(unit_addr, sizeof(unit_addr), "%x", addr);
 	if (!streq(unitname, unit_addr))
 		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
 		     unit_addr);
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
-		if (reg > 0x3ff)
+		addr = reg & 0x3FFFFFFFU;
+		if ((reg & (1 << 31)) && addr > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
-				  reg);
-
+				  addr);
+		else if (!(reg & (1 << 31)) && addr > 0x7f)
+			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits, got \"0x%x\"",
+				  addr);
 	}
 }
 WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bridge);
-- 
2.25.1


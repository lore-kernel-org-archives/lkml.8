Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8C220826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Bq6LSuSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgERR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:59:39 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:28443 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbgERR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3585; q=dns/txt; s=iport;
  t=1589824772; x=1591034372;
  h=from:to:cc:subject:date:message-id;
  bh=E6wUvoksm92tkLhsV1QtOJo4fFsp8OB5V3olcAzEjgg=;
  b=Bq6LSuSWVMotaEP+8pzwkcyHPVffmS2ILZfzRQBhAXcx5epuTQDy5uyY
   qf/v0/4B2cBs2/aDHG303Ayrsfj7dOXp5r/4rp55nN4gY+5aKBNF7yV5b
   c4l38+sa+lWU9VKm4J5+gpPAnqP729NbBwoGtp40eQQ95Ivv2blvTX+EO
   s=;
X-IronPort-AV: E=Sophos;i="5.73,407,1583193600"; 
   d="scan'208";a="768458442"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 18 May 2020 17:59:31 +0000
Received: from zorba.cisco.com ([10.24.1.223])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id 04IHxUGK000659;
        Mon, 18 May 2020 17:59:31 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bobby Liu <bobbliu@cisco.com>, xe-linux-external@cisco.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: create/Export parameter softwareseq for intel-spi driver to user
Date:   Mon, 18 May 2020 10:59:29 -0700
Message-Id: <20200518175930.10948-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.1.223, [10.24.1.223]
X-Outbound-Node: rcdn-core-10.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bobby Liu <bobbliu@cisco.com>

How to use:
append softwareseq=1 while probe the driver.
example:
modprobe intel-spi writeable=1 softwareseq=1
it will let driver use software sequence to write register for opt=EN4B
by default it's 0 if not specified, driver will do usual HW cycle

Why this parameter is posted to user:
Intel PCH provides two groups of registers for SPI flash operation,
Hard Sequence registers and Software Sequence registers,
corresponding to intel_spi_hw_cycle() and intel_spi_sw_cycle()
respectively in driver code. But HW sequence register won't send EN4B
opcode to SPI flash. BIOS code use SW register to send EN4B.

On some Cisco routers, two 32M SPI flashes, which require 4-byte address mode enabled,
are physically connected to an FPGA, one flash is active and one is inactive.
When we do BIOS upgrade, we need switch to the inactive one,
but unfortunately, this one is still 3-byte address mode as default,
after we do real-time switch, we need reload SPI driver to send EN4B code to
enable 4-byte address mode.

Refering to our BIOS code, Software sequence register is processed
while sending EN4B opcode. So here we use sw_cycle in driver for EN4B as well.

Why I don't just easily use software sequence for all:
1.It will impact all flash operation, include flash W/R, high risk
2.The only SPI type I can use is INTEL_SPI_BXT according to datasheet,
  this will require using hw seq.
  I tried to specify other SPI type, it couldn't work with Intel PCH.
  If I force SW seq for all, during boot up, sw_cycle fails to read
  vendor ID.

In conclusion, I only use SW cycle for EN4B opcode to minimize impact.
It won't impact other users as well.

Why the default flash can work at 4-byte address mode:
BIOS sets 4-byte address mode for the current active SPI flash with SW seq registers.
So we don't need append softwareseq=1 for normal boot up script,
it will only be used in BIOS upgrade script.

Cc: xe-linux-external@cisco.com
Signed-off-by: Bobby Liu <bobbliu@cisco.com>
[ danielwa: edited the commit message a little. ]
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..e5a3d51a2e4d 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -163,6 +163,10 @@ static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
 
+static bool softwareseq;
+module_param(softwareseq, bool, 0);
+MODULE_PARM_DESC(softwareseq, "Use software sequence for register write (default=0)");
+
 static void intel_spi_dump_regs(struct intel_spi *ispi)
 {
 	u32 value;
@@ -619,6 +623,18 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 	if (ret)
 		return ret;
 
+	/*
+	 * Intel Skylake will not send EN4B to SPI flash if we use HW sequence
+	 * Here export one interface "softwareseq" to OS,
+	 * let driver user decide if use SW sequence or not
+	 */
+	if (opcode == SPINOR_OP_EN4B && softwareseq) {
+	    dev_info(ispi->dev,
+		"Write register opcode is SPINOR_OP_EN4B, do SW cycle\n");
+	    return intel_spi_sw_cycle(ispi, opcode, len,
+		OPTYPE_WRITE_NO_ADDR);
+	}
+
 	if (ispi->swseq_reg)
 		return intel_spi_sw_cycle(ispi, opcode, len,
 					  OPTYPE_WRITE_NO_ADDR);
-- 
2.17.1


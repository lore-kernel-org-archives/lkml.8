Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4262051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IzZoduoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgCPKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:44:37 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:26529 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:44:37 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 02GAhAuL009137;
        Mon, 16 Mar 2020 19:43:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 02GAhAuL009137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584355391;
        bh=eH0tXIcYLCqmcLVo06DK5lNOc5wLHC+Jd1svMkw2h9E=;
        h=From:To:Cc:Subject:Date:From;
        b=IzZoduoAAlaoRLSqt8Pe3RQwhtr+4J2FVnMl0E/7CuZ74e8zhHJeQMBsFW+N8gz2Q
         Rxjdu23Ajddrs9qxNdlSyM/kQiUykORkUxheziboUWhneU0QT1a4peJQVJ5SFhtLZa
         vLboppCY5JfkX1PxHvvSesj4dOPZR7x1ZFQEgu2drBhkIoHNCSA6b0bFYE8eYFvWnc
         sqjTRxN7n+o/l1GOnOxWv9urD47MQn1GcUrzjzwOEl2xo9vgYKT7v6Nn36kX8Uuf72
         /8sS2p/KIUyMgZ4bSf0Sf6o08IT6mcdZjzppqjQrROjQpwhN6yZKFP1AAA/AV7luRM
         XtYC5Me7buMJQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: add more delays before latching incoming data
Date:   Mon, 16 Mar 2020 19:43:07 +0900
Message-Id: <20200316104307.1891-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali IP have several registers to specify how many clock cycles
should be waited between falling/rising signals. You can improve the
NAND access performance by programming these registers with optimized
values.

Because struct nand_sdr_timings represents the device requirement
in pico seconds, denali_setup_data_interface() computes the register
values by dividing the device timings with the clock period.

Marek Vasut reported this driver in the latest kernel does not work
on his SOCFPGA board. (The on-board NAND chip is mode 5)

The suspicious parameter is acc_clks, so this commit relaxes it.

The Denali NAND Flash Memory Controller User's Guide describes this
register as follows:

  acc_clks
    signifies the number of bus interface clk_x clock cycles,
    controller should wait from read enable going low to sending
    out a strobe of clk_x for capturing of incoming data.

Currently, acc_clks is calculated only based on tREA, the delay on the
chip side. This does not include additional delays that come from the
data path on the PCB and in the SoC, load capacity of the pins, etc.

This relatively becomes a big factor on faster timing modes like mode 5.

Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
the timing mode 5.

We would not go back to the hard-coded acc_clks, but we need to include
this factor into the delay somehow. Let's say the amount of the additional
delay is 10000 pico sec.

In the new calculation, acc_clks is determined by timings->tREA_max +
data_setup_on_host.

Also, prolong the RE# low period to make sure the data hold is met.

Finally, re-center the data latch timing for extra safety.

[1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
[2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 44 ++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 6a6c919b2569..ecd11c08aa2a 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -764,6 +764,7 @@ static int denali_write_page(struct nand_chip *chip, const u8 *buf,
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 				       const struct nand_data_interface *conf)
 {
+	static const u32 data_setup_on_host = 10000;
 	struct denali_controller *denali = to_denali_controller(chip);
 	struct denali_chip_sel *sel;
 	const struct nand_sdr_timings *timings;
@@ -796,15 +797,6 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 
 	sel = &to_denali_chip(chip)->sels[chipnr];
 
-	/* tREA -> ACC_CLKS */
-	acc_clks = DIV_ROUND_UP(timings->tREA_max, t_x);
-	acc_clks = min_t(int, acc_clks, ACC_CLKS__VALUE);
-
-	tmp = ioread32(denali->reg + ACC_CLKS);
-	tmp &= ~ACC_CLKS__VALUE;
-	tmp |= FIELD_PREP(ACC_CLKS__VALUE, acc_clks);
-	sel->acc_clks = tmp;
-
 	/* tRWH -> RE_2_WE */
 	re_2_we = DIV_ROUND_UP(timings->tRHW_min, t_x);
 	re_2_we = min_t(int, re_2_we, RE_2_WE__VALUE);
@@ -862,14 +854,44 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp |= FIELD_PREP(RDWR_EN_HI_CNT__VALUE, rdwr_en_hi);
 	sel->rdwr_en_hi_cnt = tmp;
 
-	/* tRP, tWP -> RDWR_EN_LO_CNT */
+	/*
+	 * tREA -> ACC_CLKS
+	 * tRP, tWP, tRHOH, tRC, tWC -> RDWR_EN_LO_CNT
+	 */
+
+	/*
+	 * Determine the minimum of acc_clks to meet the setup timing when
+	 * capturing the incoming data.
+	 *
+	 * The delay on the chip side is well-defined as tREA, but we need to
+	 * take additional delay into account. This includes a certain degree
+	 * of unknowledge, such as signal propagation delays on the PCB and
+	 * in the SoC, load capacity of the I/O pins, etc.
+	 */
+	acc_clks = DIV_ROUND_UP(timings->tREA_max + data_setup_on_host, t_x);
+
+	/* Determine the minimum of rdwr_en_lo_cnt from RE#/WE# pulse width */
 	rdwr_en_lo = DIV_ROUND_UP(max(timings->tRP_min, timings->tWP_min), t_x);
+
+	/* Extend rdwr_en_lo to meet the data hold timing */
+	rdwr_en_lo = max_t(int, rdwr_en_lo, acc_clks - timings->tRHOH_min / t_x);
+
+	/* Extend rdwr_en_lo to meet the requirement for RE#/WE# cycle time */
 	rdwr_en_lo_hi = DIV_ROUND_UP(max(timings->tRC_min, timings->tWC_min),
 				     t_x);
-	rdwr_en_lo_hi = max_t(int, rdwr_en_lo_hi, mult_x);
 	rdwr_en_lo = max(rdwr_en_lo, rdwr_en_lo_hi - rdwr_en_hi);
 	rdwr_en_lo = min_t(int, rdwr_en_lo, RDWR_EN_LO_CNT__VALUE);
 
+	/* Center the data latch timing for extra safety */
+	acc_clks = (acc_clks + rdwr_en_lo +
+		    DIV_ROUND_UP(timings->tRHOH_min, t_x)) / 2;
+	acc_clks = min_t(int, acc_clks, ACC_CLKS__VALUE);
+
+	tmp = ioread32(denali->reg + ACC_CLKS);
+	tmp &= ~ACC_CLKS__VALUE;
+	tmp |= FIELD_PREP(ACC_CLKS__VALUE, acc_clks);
+	sel->acc_clks = tmp;
+
 	tmp = ioread32(denali->reg + RDWR_EN_LO_CNT);
 	tmp &= ~RDWR_EN_LO_CNT__VALUE;
 	tmp |= FIELD_PREP(RDWR_EN_LO_CNT__VALUE, rdwr_en_lo);
-- 
2.17.1


Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4843C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791AC21741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+hIx8PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHIlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 03:41:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgBHIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 03:41:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so1085120pgk.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4fT1flivhHE2bOiFUCwrYP2oGVgN/u3bLIm2YsCtVs=;
        b=j+hIx8PPKVttFIFcJkTAOz8wLBNnQ0xmyv248cqVekR4q7ODZSC7HOTdeDlYUHJpTX
         /Yofq526CRXJD6p7SeG0rg5/3NSTyZGVkePh9g8DwzfWfmqtzELW79BTNLQMRxh7KDgc
         SyLwxRFlhr1CWYdivSVAnGbiOmICIMvd/43KpKo2kLI51N8CcBUBJGX0ldpwu47Jlshe
         mV3Qcy67jPCdc8FlvkzQLF28sRqYxf4DQ5h4RYupY2izf5ae8PBo1i3H8BICW9OxQbq5
         fJQEzlT+5bD6nEvRdQeJRm2ejYaZHW4qus76uEdo2N7DbIfolJZYali6WDSVyYGaOryV
         52eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4fT1flivhHE2bOiFUCwrYP2oGVgN/u3bLIm2YsCtVs=;
        b=RHWO88aYVa7UmrthjaQSmlDVtZi15OBOrjcRAV0j9w5PTNCvefLOmQoYf7otOh4GiT
         qFf5vWVmuU5kX3y7FpAL1HD9FKEe+B5T4eNxTFjzn4zAntkr7fczraIqir9AGp5Rs1xQ
         Kz3wmfDegzHN7KMqwuLfDfPsOMiTrVP/68M3nVmGAGYxhZo0uePH11FL8r0o8n6CoCqd
         9W0ms2CohB8vpdD1WQT+7J9bQSfsZO/9BFcVV16yYI9aL5mCDNNpbeOOTEsn8M77oDy0
         VAe9hmY97I0SoYzw1DbT2EFzfDxTC+QgTYpK9s67lAngxZUZfxMyjUGKZGdEtGr7Ox4I
         2iTA==
X-Gm-Message-State: APjAAAWhpzhcEvSJkQnteSjx/8ohG2WJiCAaluAqK79XvKXzoCiedYq7
        1bCEfYE9tRsNCpkMp9XEL/tBGwqf9UQ=
X-Google-Smtp-Source: APXvYqw8yuRdAlV0i6bI+LVdCO1J+fT6uuUjHQnYnfC2NQZy2tbSx1BIZdWlWOR+b4PIAmizEgcjUg==
X-Received: by 2002:a62:cec7:: with SMTP id y190mr3075149pfg.191.1581151268223;
        Sat, 08 Feb 2020 00:41:08 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id t63sm5639365pfb.70.2020.02.08.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 00:41:07 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: mtk-quadspi: add support for DMA reading
Date:   Sat,  8 Feb 2020 16:40:09 +0800
Message-Id: <20200208084022.193231-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIO reading mode on this controller is pretty inefficient
(one cmd+addr+dummy sequence reads only one byte)
This patch adds support for reading using DMA mode which increases
reading speed from 1MB/s to 4MB/s

DMA busy checking is implemented with readl_poll_timeout because
I don't have access to IRQ-related docs. The speed increment comes
from those saved cmd+addr+dummy clocks.

This controller requires that DMA source/destination address and
reading length should be 16-byte aligned. We use a bounce buffer if
one of them is not aligned, read more than what we need, and copy
data from corresponding buffer offset.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

Changes since v1:
1. cast pointers to ulong instead of u32 to fix warnings on 64bit
   platform
2. drop the other patch for reading with custom opcode. That'll
   be a separated fix which is unrelated to this one.

 drivers/mtd/spi-nor/mtk-quadspi.c | 99 +++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index b1691680d174..85101b84b516 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -17,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -70,6 +72,10 @@
 #define MTK_NOR_DELSEL2_REG		0xd0
 #define MTK_NOR_DELSEL3_REG		0xd4
 #define MTK_NOR_DELSEL4_REG		0xd8
+#define MTK_NOR_FDMA_CTL_REG		0x718
+#define MTK_NOR_FDMA_FADR_REG		0x71c
+#define MTK_NOR_FDMA_DADR_REG		0x720
+#define MTK_NOR_FDMA_END_DADR_REG	0x724
 
 /* commands for mtk nor controller */
 #define MTK_NOR_READ_CMD		0x0
@@ -88,6 +94,7 @@
 #define MTK_NOR_DUAL_READ_EN		0x1
 #define MTK_NOR_DUAL_DISABLE		0x0
 #define MTK_NOR_FAST_READ		0x1
+#define MTK_NOR_DMA_TRIG		0x1
 
 #define SFLASH_WRBUF_SIZE		128
 
@@ -97,7 +104,10 @@
 #define MTK_NOR_MAX_SHIFT		7
 /* nor controller 4-byte address mode enable bit */
 #define MTK_NOR_4B_ADDR_EN		BIT(4)
-
+/* DMA address has to be 16-byte aligned */
+#define MTK_NOR_DMA_ALIGN		16
+/* Limit bounce buffer size to 32KB */
+#define MTK_NOR_MAX_BBUF_READ		(32 * 1024)
 /* Helpers for accessing the program data / shift data registers */
 #define MTK_NOR_PRG_REG(n)		(MTK_NOR_PRGDATA0_REG + 4 * (n))
 #define MTK_NOR_SHREG(n)		(MTK_NOR_SHREG0_REG + 4 * (n))
@@ -260,13 +270,12 @@ static void mtk_nor_set_addr(struct mtk_nor *mtk_nor, u32 addr)
 	writeb(addr & 0xff, mtk_nor->base + MTK_NOR_RADR3_REG);
 }
 
-static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
-			    u_char *buffer)
+static ssize_t mtk_nor_read_pio(struct mtk_nor *mtk_nor, loff_t from,
+				size_t length, u_char *buffer)
 {
 	int i, ret;
 	int addr = (int)from;
 	u8 *buf = (u8 *)buffer;
-	struct mtk_nor *mtk_nor = nor->priv;
 
 	/* set mode for fast read mode ,dual mode or quad mode */
 	mtk_nor_set_read_mode(mtk_nor);
@@ -281,6 +290,88 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
 	return length;
 }
 
+static int mtk_nor_dma_exec(struct mtk_nor *mtk_nor)
+{
+	int reg;
+
+	reg = readl(mtk_nor->base + MTK_NOR_FDMA_CTL_REG);
+	writel(reg | MTK_NOR_DMA_TRIG, mtk_nor->base + MTK_NOR_FDMA_CTL_REG);
+	return readl_poll_timeout(mtk_nor->base + MTK_NOR_FDMA_CTL_REG, reg,
+				  !(reg & MTK_NOR_DMA_TRIG), 20, 10000);
+}
+
+static ssize_t mtk_nor_read_dma(struct mtk_nor *mtk_nor, loff_t from,
+				size_t length, u_char *buffer)
+{
+	ssize_t ret;
+	ssize_t read_length = length & ~(MTK_NOR_DMA_ALIGN - 1);
+	dma_addr_t dma_addr;
+
+	mtk_nor_set_read_mode(mtk_nor);
+	mtk_nor_set_addr_width(mtk_nor);
+
+	dma_addr = dma_map_single(mtk_nor->dev, buffer, read_length,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(mtk_nor->dev, dma_addr)) {
+		dev_err(mtk_nor->dev, "failed to map dma buffer.");
+		return -EINVAL;
+	}
+
+	writel(from, mtk_nor->base + MTK_NOR_FDMA_FADR_REG);
+	writel(dma_addr, mtk_nor->base + MTK_NOR_FDMA_DADR_REG);
+	writel((u32)dma_addr + read_length,
+	       mtk_nor->base + MTK_NOR_FDMA_END_DADR_REG);
+	ret = mtk_nor_dma_exec(mtk_nor);
+	dma_unmap_single(mtk_nor->dev, dma_addr, read_length, DMA_FROM_DEVICE);
+	if (!ret)
+		ret = read_length;
+	return ret;
+}
+
+static ssize_t mtk_nor_read_dma_bounce(struct mtk_nor *mtk_nor, loff_t from,
+				       size_t length, u_char *buffer)
+{
+	ssize_t nor_unaligned_len = from % MTK_NOR_DMA_ALIGN;
+	loff_t read_from = from & ~(MTK_NOR_DMA_ALIGN - 1);
+	ssize_t read_len;
+	u_char *buf;
+	u_char *bouncebuf;
+	size_t mem_unaligned_len;
+
+	if (length > MTK_NOR_MAX_BBUF_READ)
+		length = MTK_NOR_MAX_BBUF_READ;
+	read_len = length + nor_unaligned_len + MTK_NOR_DMA_ALIGN;
+
+	buf = kmalloc(read_len + MTK_NOR_DMA_ALIGN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mem_unaligned_len = (ulong)buf % MTK_NOR_DMA_ALIGN;
+	bouncebuf = (buf + MTK_NOR_DMA_ALIGN) - mem_unaligned_len;
+
+	read_len = mtk_nor_read_dma(mtk_nor, read_from, read_len, bouncebuf);
+	if (read_len > 0)
+		memcpy(buffer, bouncebuf + nor_unaligned_len, length);
+
+	kfree(buf);
+	return length;
+}
+
+static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
+			    u_char *buffer)
+{
+	struct mtk_nor *mtk_nor = nor->priv;
+
+	if (length < MTK_NOR_DMA_ALIGN)
+		return mtk_nor_read_pio(mtk_nor, from, length, buffer);
+
+	if (object_is_on_stack(buffer) || !virt_addr_valid(buffer) ||
+	    (ulong)buffer % MTK_NOR_DMA_ALIGN || from % MTK_NOR_DMA_ALIGN)
+		return mtk_nor_read_dma_bounce(mtk_nor, from, length, buffer);
+
+	return mtk_nor_read_dma(mtk_nor, from, length, buffer);
+}
+
 static int mtk_nor_write_single_byte(struct mtk_nor *mtk_nor,
 				     int addr, int length, u8 *data)
 {
-- 
2.24.1


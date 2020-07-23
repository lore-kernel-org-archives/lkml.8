Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E2720737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgGWNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:12:33 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45905 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:12:32 -0400
X-Originating-IP: 42.109.196.68
Received: from localhost.localdomain (unknown [42.109.196.68])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 986591C0014;
        Thu, 23 Jul 2020 13:12:26 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v11 01/14] mtd: spi-nor: core: add spi_nor_{read,write}_reg() helpers
Date:   Thu, 23 Jul 2020 18:41:50 +0530
Message-Id: <20200723131203.40916-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723131203.40916-1-me@yadavpratyush.com>
References: <20200723131203.40916-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

They are thin wrappers around nor->controller_ops->{read,write}_reg().
In a future commit DTR support will be added. These ops can not be
supported by the {read,write}_reg() hooks and these helpers will make it
easier to reject those calls.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 110 ++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 63 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 65eff4ce6ab1..2ccf2c154779 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -82,6 +82,18 @@ static int spi_nor_spimem_exec_op(struct spi_nor *nor, struct spi_mem_op *op)
 	return spi_mem_exec_op(nor->spimem, op);
 }
 
+static int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			    size_t len)
+{
+	return nor->controller_ops->read_reg(nor, opcode, buf, len);
+}
+
+static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+			     size_t len)
+{
+	return nor->controller_ops->write_reg(nor, opcode, buf, len);
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -228,10 +240,8 @@ int spi_nor_write_enable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d on Write Enable\n", ret);
@@ -257,10 +267,8 @@ int spi_nor_write_disable(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d on Write Disable\n", ret);
@@ -288,10 +296,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    sr, 1);
-	}
+	} else
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDSR, sr, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR\n", ret);
@@ -319,10 +325,8 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    fsr, 1);
-	}
+	} else
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDFSR, fsr, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
@@ -351,9 +355,8 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 				   SPI_MEM_OP_DATA_IN(1, cr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
-	}
+	} else
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDCR, cr, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading CR\n", ret);
@@ -384,12 +387,11 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 				  SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor,
-						     enable ? SPINOR_OP_EN4B :
-							      SPINOR_OP_EX4B,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor,
+					enable ? SPINOR_OP_EN4B :
+						 SPINOR_OP_EX4B,
+					NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
@@ -420,10 +422,8 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-						     nor->bouncebuf, 1);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
@@ -452,10 +452,8 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-						     nor->bouncebuf, 1);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
@@ -483,10 +481,8 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
-						    sr, 1);
-	}
+	} else
+		ret = spi_nor_read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
@@ -528,10 +524,8 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
@@ -592,10 +586,8 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
@@ -736,10 +728,8 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr, len);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRSR, sr, len);
 
 	if (ret) {
 		dev_dbg(nor->dev, "error %d writing SR\n", ret);
@@ -938,10 +928,8 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
-						     sr2, 1);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
 
 	if (ret) {
 		dev_dbg(nor->dev, "error %d writing SR2\n", ret);
@@ -972,10 +960,8 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
-						    sr2, 1);
-	}
+	} else
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR2\n", ret);
@@ -1003,10 +989,8 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DATA);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-						     NULL, 0);
-	}
+	} else
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d erasing chip\n", ret);
@@ -1158,8 +1142,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 		addr >>= 8;
 	}
 
-	return nor->controller_ops->write_reg(nor, nor->erase_opcode,
-					      nor->bouncebuf, nor->addr_width);
+	return spi_nor_write_reg(nor, nor->erase_opcode, nor->bouncebuf,
+				 nor->addr_width);
 }
 
 /**
-- 
2.27.0


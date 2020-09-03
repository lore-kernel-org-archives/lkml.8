Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC8C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28AA208B3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MRw50pvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgICRNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:13:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43694 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgICRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:13:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083HDKVL115688;
        Thu, 3 Sep 2020 12:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599153200;
        bh=u0sI9f3tR1JZc8y0PykyoBxkHz/0Tzpb47xAfYHBw0s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MRw50pvAPrDY9++bfi2esTAbMjZN8GxbdwqUfjErs6aKy0ZHM4Hr4Xjk/bk/60F/o
         sX6EtgfhNTAian5wyTrSDHK7yng0eQw5xAoihyhsXxeVL6JgVdPlU9YfwrH933n51u
         Ep/M2+eD/DYfeJ3rR+TC3qHkWstSkm9DQDgi3hcA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083HDKRs094999;
        Thu, 3 Sep 2020 12:13:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 12:13:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 12:13:20 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083HDDPu088669;
        Thu, 3 Sep 2020 12:13:17 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v12 01/14] mtd: spi-nor: core: add spi_nor_{read,write}_reg() helpers
Date:   Thu, 3 Sep 2020 22:43:00 +0530
Message-ID: <20200903171313.18741-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200903171313.18741-1-p.yadav@ti.com>
References: <20200903171313.18741-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.25.0


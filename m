Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A327C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AB9207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753120;
	bh=90v7GWqKPrOeoj463uhOu72VM+HIUqvK41t3azHjKDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dgt9ssH6dtQ4HrYFcck4q974MKXpLVYCBJgeJRMhrxp31P6645f8PQqBAmC5VXw6L
	 osL5xtLOCC5g6/PmebnyUmqCVDuwMMYboTr3Vl/gvHqwcdxLwvKLtPUUpxypQyDot6
	 djoC+cmcJJhafOb9x81WV7XOQqU1Pwj/KSMN4f2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgGNS6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731219AbgGNS6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:58:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A98207F5;
        Tue, 14 Jul 2020 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753113;
        bh=90v7GWqKPrOeoj463uhOu72VM+HIUqvK41t3azHjKDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTvPJJZNH1wF+f1LFKfuwmGRQ0xgYwVk+7A5/k7GpCEj2lE1YhJV2g58JLZKytz+a
         MYQGgvuuUQTiH9RCmdG6CJ9S6Dfpf6XnmKA3CfG8f5gLzCvqQsslV0haYT2VoYN+57
         0kc+W5KU1f6LjP4ZfmwIK/soUsEjSclw3BqIUK9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Huy Nguyen <huyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 094/166] net/mlx5: Fix eeprom support for SFP module
Date:   Tue, 14 Jul 2020 20:44:19 +0200
Message-Id: <20200714184120.346474181@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 47afbdd2fa4c5775c383ba376a3d1da7d7f694dc ]

Fix eeprom SFP query support by setting i2c_addr, offset and page number
correctly. Unlike QSFP modules, SFP eeprom params are as follow:
- i2c_addr is 0x50 for offset 0 - 255 and 0x51 for offset 256 - 511.
- Page number is always zero.
- Page offset is always relative to zero.

As part of eeprom query, query the module ID (SFP / QSFP*) via helper
function to set the params accordingly.

In addition, change mlx5_qsfp_eeprom_page() input type to be u16 to avoid
unnecessary casting.

Fixes: a708fb7b1f8d ("net/mlx5e: ethtool, Add support for EEPROM high pages query")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/port.c    | 93 +++++++++++++++----
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index cc262b30aed53..dc589322940c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -293,7 +293,40 @@ static int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num)
 	return 0;
 }
 
-static int mlx5_eeprom_page(int offset)
+static int mlx5_query_module_id(struct mlx5_core_dev *dev, int module_num,
+				u8 *module_id)
+{
+	u32 in[MLX5_ST_SZ_DW(mcia_reg)] = {};
+	u32 out[MLX5_ST_SZ_DW(mcia_reg)];
+	int err, status;
+	u8 *ptr;
+
+	MLX5_SET(mcia_reg, in, i2c_device_address, MLX5_I2C_ADDR_LOW);
+	MLX5_SET(mcia_reg, in, module, module_num);
+	MLX5_SET(mcia_reg, in, device_address, 0);
+	MLX5_SET(mcia_reg, in, page_number, 0);
+	MLX5_SET(mcia_reg, in, size, 1);
+	MLX5_SET(mcia_reg, in, l, 0);
+
+	err = mlx5_core_access_reg(dev, in, sizeof(in), out,
+				   sizeof(out), MLX5_REG_MCIA, 0, 0);
+	if (err)
+		return err;
+
+	status = MLX5_GET(mcia_reg, out, status);
+	if (status) {
+		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
+			      status);
+		return -EIO;
+	}
+	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
+
+	*module_id = ptr[0];
+
+	return 0;
+}
+
+static int mlx5_qsfp_eeprom_page(u16 offset)
 {
 	if (offset < MLX5_EEPROM_PAGE_LENGTH)
 		/* Addresses between 0-255 - page 00 */
@@ -307,7 +340,7 @@ static int mlx5_eeprom_page(int offset)
 		    MLX5_EEPROM_HIGH_PAGE_LENGTH);
 }
 
-static int mlx5_eeprom_high_page_offset(int page_num)
+static int mlx5_qsfp_eeprom_high_page_offset(int page_num)
 {
 	if (!page_num) /* Page 0 always start from low page */
 		return 0;
@@ -316,35 +349,62 @@ static int mlx5_eeprom_high_page_offset(int page_num)
 	return page_num * MLX5_EEPROM_HIGH_PAGE_LENGTH;
 }
 
+static void mlx5_qsfp_eeprom_params_set(u16 *i2c_addr, int *page_num, u16 *offset)
+{
+	*i2c_addr = MLX5_I2C_ADDR_LOW;
+	*page_num = mlx5_qsfp_eeprom_page(*offset);
+	*offset -=  mlx5_qsfp_eeprom_high_page_offset(*page_num);
+}
+
+static void mlx5_sfp_eeprom_params_set(u16 *i2c_addr, int *page_num, u16 *offset)
+{
+	*i2c_addr = MLX5_I2C_ADDR_LOW;
+	*page_num = 0;
+
+	if (*offset < MLX5_EEPROM_PAGE_LENGTH)
+		return;
+
+	*i2c_addr = MLX5_I2C_ADDR_HIGH;
+	*offset -= MLX5_EEPROM_PAGE_LENGTH;
+}
+
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 			     u16 offset, u16 size, u8 *data)
 {
-	int module_num, page_num, status, err;
+	int module_num, status, err, page_num = 0;
+	u32 in[MLX5_ST_SZ_DW(mcia_reg)] = {};
 	u32 out[MLX5_ST_SZ_DW(mcia_reg)];
-	u32 in[MLX5_ST_SZ_DW(mcia_reg)];
-	u16 i2c_addr;
-	void *ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
+	u16 i2c_addr = 0;
+	u8 module_id;
+	void *ptr;
 
 	err = mlx5_query_module_num(dev, &module_num);
 	if (err)
 		return err;
 
-	memset(in, 0, sizeof(in));
-	size = min_t(int, size, MLX5_EEPROM_MAX_BYTES);
-
-	/* Get the page number related to the given offset */
-	page_num = mlx5_eeprom_page(offset);
+	err = mlx5_query_module_id(dev, module_num, &module_id);
+	if (err)
+		return err;
 
-	/* Set the right offset according to the page number,
-	 * For page_num > 0, relative offset is always >= 128 (high page).
-	 */
-	offset -= mlx5_eeprom_high_page_offset(page_num);
+	switch (module_id) {
+	case MLX5_MODULE_ID_SFP:
+		mlx5_sfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
+		break;
+	case MLX5_MODULE_ID_QSFP:
+	case MLX5_MODULE_ID_QSFP_PLUS:
+	case MLX5_MODULE_ID_QSFP28:
+		mlx5_qsfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
+		break;
+	default:
+		mlx5_core_err(dev, "Module ID not recognized: 0x%x\n", module_id);
+		return -EINVAL;
+	}
 
 	if (offset + size > MLX5_EEPROM_PAGE_LENGTH)
 		/* Cross pages read, read until offset 256 in low page */
 		size -= offset + size - MLX5_EEPROM_PAGE_LENGTH;
 
-	i2c_addr = MLX5_I2C_ADDR_LOW;
+	size = min_t(int, size, MLX5_EEPROM_MAX_BYTES);
 
 	MLX5_SET(mcia_reg, in, l, 0);
 	MLX5_SET(mcia_reg, in, module, module_num);
@@ -365,6 +425,7 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 		return -EIO;
 	}
 
+	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
 	memcpy(data, ptr, size);
 
 	return size;
-- 
2.25.1




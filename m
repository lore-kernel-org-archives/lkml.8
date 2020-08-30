Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597CCC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1E2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH3PeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:34:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42719 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgH3P2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:28:01 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 30 Aug 2020 18:27:55 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07UFRt7Z029629;
        Sun, 30 Aug 2020 18:27:55 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 07UFRsV1027837;
        Sun, 30 Aug 2020 18:27:54 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 07UFRsdD027833;
        Sun, 30 Aug 2020 18:27:54 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC v3 04/14] net/mlx5: Add functions to set/query MFRL register
Date:   Sun, 30 Aug 2020 18:27:24 +0300
Message-Id: <1598801254-27764-5-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions to query and set the MFRL reset options supported by
firmware.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  2 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 46 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/fw_reset.h    | 13 ++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 10e6886c96ba..4d45a2f6fed6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,7 +16,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o rl.o lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
+		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o fw_reset.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
new file mode 100644
index 000000000000..76d2cece29ac
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved. */
+
+#include "fw_reset.h"
+
+static int mlx5_reg_mfrl_set(struct mlx5_core_dev *dev, u8 reset_level,
+			     u8 reset_type_sel, u8 sync_resp, bool sync_start)
+{
+	u32 out[MLX5_ST_SZ_DW(mfrl_reg)] = {};
+	u32 in[MLX5_ST_SZ_DW(mfrl_reg)] = {};
+
+	MLX5_SET(mfrl_reg, in, reset_level, reset_level);
+	MLX5_SET(mfrl_reg, in, rst_type_sel, reset_type_sel);
+	MLX5_SET(mfrl_reg, in, pci_sync_for_fw_update_resp, sync_resp);
+	MLX5_SET(mfrl_reg, in, pci_sync_for_fw_update_start, sync_start);
+
+	return mlx5_core_access_reg(dev, in, sizeof(in), out, sizeof(out), MLX5_REG_MFRL, 0, 1);
+}
+
+int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_type)
+{
+	u32 out[MLX5_ST_SZ_DW(mfrl_reg)] = {};
+	u32 in[MLX5_ST_SZ_DW(mfrl_reg)] = {};
+	int err;
+
+	err = mlx5_core_access_reg(dev, in, sizeof(in), out, sizeof(out), MLX5_REG_MFRL, 0, 0);
+	if (err)
+		return err;
+
+	if (reset_level)
+		*reset_level = MLX5_GET(mfrl_reg, out, reset_level);
+	if (reset_type)
+		*reset_type = MLX5_GET(mfrl_reg, out, reset_type);
+
+	return 0;
+}
+
+int mlx5_fw_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel)
+{
+	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL3, reset_type_sel, 0, true);
+}
+
+int mlx5_fw_set_live_patch(struct mlx5_core_dev *dev)
+{
+	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL0, 0, 0, false);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
new file mode 100644
index 000000000000..1bbd95182ca6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved. */
+
+#ifndef __MLX5_FW_RESET_H
+#define __MLX5_FW_RESET_H
+
+#include "mlx5_core.h"
+
+int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_type);
+int mlx5_fw_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel);
+int mlx5_fw_set_live_patch(struct mlx5_core_dev *dev);
+
+#endif
-- 
2.17.1


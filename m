Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1940C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E7222B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgH0Moz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:44:55 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46498 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728917AbgH0MYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:24:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 27 Aug 2020 15:17:47 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07RCHlOf008806;
        Thu, 27 Aug 2020 15:17:47 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 07RCHko3006770;
        Thu, 27 Aug 2020 15:17:46 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 07RCHhYu006767;
        Thu, 27 Aug 2020 15:17:43 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     mst@redhat.com, jasonwang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Make vdpa core driver a distinct module
Date:   Thu, 27 Aug 2020 15:17:40 +0300
Message-Id: <20200827121740.6721-1-elic@nvidia.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change core vdpa functionality into a loadbale module such that upcoming
block implementation will be able to use it.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/Kconfig               |  6 +++---
 drivers/vdpa/Makefile              |  2 +-
 drivers/vdpa/mlx5/Makefile         |  7 +++++--
 drivers/vdpa/mlx5/core/core_main.c | 20 ++++++++++++++++++++
 drivers/vdpa/mlx5/core/mr.c        |  3 +++
 drivers/vdpa/mlx5/core/resources.c | 10 ++++++++++
 6 files changed, 42 insertions(+), 6 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/core/core_main.c

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 4271c408103e..ea14a9be5dc1 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -29,8 +29,8 @@ config IFCVF
 	  To compile this driver as a module, choose M here: the module will
 	  be called ifcvf.
 
-config MLX5_VDPA
-	bool "MLX5 VDPA support library for ConnectX devices"
+config MLX5_VDPA_CORE
+	tristate "MLX5 VDPA support library for ConnectX devices"
 	depends on MLX5_CORE
 	default n
 	help
@@ -40,7 +40,7 @@ config MLX5_VDPA
 
 config MLX5_VDPA_NET
 	tristate "vDPA driver for ConnectX devices"
-	depends on MLX5_VDPA
+	depends on MLX5_VDPA_CORE
 	default n
 	help
 	  VDPA network driver for ConnectX6 and newer. Provides offloading
diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index d160e9b63a66..07353bbb9f8b 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_VDPA) += vdpa.o
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
 obj-$(CONFIG_IFCVF)    += ifcvf/
-obj-$(CONFIG_MLX5_VDPA) += mlx5/
+obj-$(CONFIG_MLX5_VDPA_CORE) += mlx5/
diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
index 89a5bededc9f..9f50f7e8d889 100644
--- a/drivers/vdpa/mlx5/Makefile
+++ b/drivers/vdpa/mlx5/Makefile
@@ -1,4 +1,7 @@
 subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
 
-obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
-mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/main.o net/mlx5_vnet.o core/resources.o core/mr.o
+obj-$(CONFIG_MLX5_VDPA_CORE) += mlx5_vdpa_core.o
+mlx5_vdpa_core-$(CONFIG_MLX5_VDPA_CORE) += core/resources.o core/mr.o core/core_main.o
+
+obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa_net.o
+mlx5_vdpa_net-$(CONFIG_MLX5_VDPA_NET) += net/main.o net/mlx5_vnet.o
diff --git a/drivers/vdpa/mlx5/core/core_main.c b/drivers/vdpa/mlx5/core/core_main.c
new file mode 100644
index 000000000000..4b39b55f57ab
--- /dev/null
+++ b/drivers/vdpa/mlx5/core/core_main.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2020 Mellanox Technologies Ltd. */
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Eli Cohen <elic@nvidia.com>");
+MODULE_DESCRIPTION("Mellanox VDPA core driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
+static int __init mlx5_vdpa_core_init(void)
+{
+	return 0;
+}
+
+static void __exit mlx5_vdpa_core_exit(void)
+{
+}
+
+module_init(mlx5_vdpa_core_init);
+module_exit(mlx5_vdpa_core_exit);
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index ef1c550f8266..c093eab6c714 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -434,6 +434,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
 	mutex_unlock(&mr->mkey_mtx);
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_create_mr);
 
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 {
@@ -456,6 +457,7 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 out:
 	mutex_unlock(&mr->mkey_mtx);
 }
+EXPORT_SYMBOL(mlx5_vdpa_destroy_mr);
 
 static bool map_empty(struct vhost_iotlb *iotlb)
 {
@@ -484,3 +486,4 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_handle_set_map);
diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 96e6421c5d1c..89606a18e286 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -98,6 +98,7 @@ int mlx5_vdpa_create_tis(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tisn)
 
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_create_tis);
 
 void mlx5_vdpa_destroy_tis(struct mlx5_vdpa_dev *mvdev, u32 tisn)
 {
@@ -108,6 +109,7 @@ void mlx5_vdpa_destroy_tis(struct mlx5_vdpa_dev *mvdev, u32 tisn)
 	MLX5_SET(destroy_tis_in, in, tisn, tisn);
 	mlx5_cmd_exec_in(mvdev->mdev, destroy_tis, in);
 }
+EXPORT_SYMBOL(mlx5_vdpa_destroy_tis);
 
 int mlx5_vdpa_create_rqt(struct mlx5_vdpa_dev *mvdev, void *in, int inlen, u32 *rqtn)
 {
@@ -121,6 +123,7 @@ int mlx5_vdpa_create_rqt(struct mlx5_vdpa_dev *mvdev, void *in, int inlen, u32 *
 
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_create_rqt);
 
 void mlx5_vdpa_destroy_rqt(struct mlx5_vdpa_dev *mvdev, u32 rqtn)
 {
@@ -131,6 +134,7 @@ void mlx5_vdpa_destroy_rqt(struct mlx5_vdpa_dev *mvdev, u32 rqtn)
 	MLX5_SET(destroy_rqt_in, in, rqtn, rqtn);
 	mlx5_cmd_exec_in(mvdev->mdev, destroy_rqt, in);
 }
+EXPORT_SYMBOL(mlx5_vdpa_destroy_rqt);
 
 int mlx5_vdpa_create_tir(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tirn)
 {
@@ -144,6 +148,7 @@ int mlx5_vdpa_create_tir(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tirn)
 
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_create_tir);
 
 void mlx5_vdpa_destroy_tir(struct mlx5_vdpa_dev *mvdev, u32 tirn)
 {
@@ -154,6 +159,7 @@ void mlx5_vdpa_destroy_tir(struct mlx5_vdpa_dev *mvdev, u32 tirn)
 	MLX5_SET(destroy_tir_in, in, tirn, tirn);
 	mlx5_cmd_exec_in(mvdev->mdev, destroy_tir, in);
 }
+EXPORT_SYMBOL(mlx5_vdpa_destroy_tir);
 
 int mlx5_vdpa_alloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 *tdn)
 {
@@ -170,6 +176,7 @@ int mlx5_vdpa_alloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 *tdn)
 
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_alloc_transport_domain);
 
 void mlx5_vdpa_dealloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 tdn)
 {
@@ -180,6 +187,7 @@ void mlx5_vdpa_dealloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 tdn)
 	MLX5_SET(dealloc_transport_domain_in, in, transport_domain, tdn);
 	mlx5_cmd_exec_in(mvdev->mdev, dealloc_transport_domain, in);
 }
+EXPORT_SYMBOL(mlx5_vdpa_dealloc_transport_domain);
 
 int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, struct mlx5_core_mkey *mkey, u32 *in,
 			  int inlen)
@@ -266,6 +274,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 	mutex_destroy(&mvdev->mr.mkey_mtx);
 	return err;
 }
+EXPORT_SYMBOL(mlx5_vdpa_alloc_resources);
 
 void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
 {
@@ -282,3 +291,4 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
 	mutex_destroy(&mvdev->mr.mkey_mtx);
 	res->valid = false;
 }
+EXPORT_SYMBOL(mlx5_vdpa_free_resources);
-- 
2.26.0


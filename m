Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE94206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597050672;
	bh=RdxyKdVpVRR7xL1pb82tzPPYk+FhaFtStyYHYAN9KGg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eUqXufrbIZvVxD+e969PHyO4imXtaRzrXGCShQvnK3MtTn/QHYXxEM1pR3jyivRdN
	 C0JcqycTAc9GuFqEa8TluDoeIzy6yq9JxjCJJZc6u4Oi9s7D8ZGNfivA0QkcTb/dId
	 XOqha03D5rbuJ+afmH6ZHO61nN4cOUyqHwqqwD70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgHJJLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgHJJLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:11:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800CA206B5;
        Mon, 10 Aug 2020 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597050668;
        bh=RdxyKdVpVRR7xL1pb82tzPPYk+FhaFtStyYHYAN9KGg=;
        h=From:To:Cc:Subject:Date:From;
        b=VnB793QZRkKe0ohK5m/v0YUH0t3GSIajdJTisBtELjBAWV7tVhxjVifmcg+hu0DTi
         /A++/Q350vgI/g2eofW1auESR68MyZoH0+tZ7kqcsS3odT8rZ8iMlK3bN4WeOQbWSJ
         UyULzEi6qp6EgJbHVdlJbM5Er3mwcEBx+8i778yg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] MAINTAINERS: Update Mellanox and Cumulus Network addresses to new domain
Date:   Mon, 10 Aug 2020 12:10:59 +0300
Message-Id: <20200810091100.243932-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Mellanox and Cumulus Network were acquired by Nvidia, so change the
maintainers emails to new domain name.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .mailmap    |  2 ++
 MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/.mailmap b/.mailmap
index db4f2295bd9d..a4f7c929bc70 100644
--- a/.mailmap
+++ b/.mailmap
@@ -119,6 +119,7 @@ Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
+Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
@@ -157,6 +158,7 @@ Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
+Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index f6302dc3a666..391329b40606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4991,7 +4991,7 @@ F:	include/linux/dm-*.h
 F:	include/uapi/linux/dm-*.h

 DEVLINK
-M:	Jiri Pirko <jiri@mellanox.com>
+M:	Jiri Pirko <jiri@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/devlink
@@ -6004,7 +6004,7 @@ F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c

 DYNAMIC INTERRUPT MODERATION
-M:	Tal Gilboa <talgi@mellanox.com>
+M:	Tal Gilboa <talgi@nvidia.com>
 S:	Maintained
 F:	Documentation/networking/net_dim.rst
 F:	include/linux/dim.h
@@ -6084,7 +6084,7 @@ F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 F:	drivers/edac/aspeed_edac.c

 EDAC-BLUEFIELD
-M:	Shravan Kumar Ramani <sramani@mellanox.com>
+M:	Shravan Kumar Ramani <sramani@nvidia.com>
 S:	Supported
 F:	drivers/edac/bluefield_edac.c

@@ -6406,8 +6406,8 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/agere/

 ETHERNET BRIDGE
-M:	Roopa Prabhu <roopa@cumulusnetworks.com>
-M:	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
+M:	Roopa Prabhu <roopa@nvidia.com>
+M:	Nikolay Aleksandrov <nikolay@nvidia.com>
 L:	bridge@lists.linux-foundation.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -6522,7 +6522,7 @@ F:	drivers/iommu/exynos-iommu.c

 EZchip NPS platform support
 M:	Vineet Gupta <vgupta@synopsys.com>
-M:	Ofer Levi <oferle@mellanox.com>
+M:	Ofer Levi <oferle@nvidia.com>
 S:	Supported
 F:	arch/arc/boot/dts/eznps.dts
 F:	arch/arc/plat-eznps
@@ -8478,7 +8478,7 @@ F:	drivers/iio/pressure/dps310.c

 INFINIBAND SUBSYSTEM
 M:	Doug Ledford <dledford@redhat.com>
-M:	Jason Gunthorpe <jgg@mellanox.com>
+M:	Jason Gunthorpe <jgg@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	https://github.com/linux-rdma/rdma-core
@@ -9137,7 +9137,7 @@ F:	drivers/firmware/iscsi_ibft*

 ISCSI EXTENSIONS FOR RDMA (ISER) INITIATOR
 M:	Sagi Grimberg <sagi@grimberg.me>
-M:	Max Gurtovoy <maxg@mellanox.com>
+M:	Max Gurtovoy <maxg@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.openfabrics.org
@@ -10962,7 +10962,7 @@ F:	Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
 F:	drivers/input/touchscreen/melfas_mip4.c

 MELLANOX ETHERNET DRIVER (mlx4_en)
-M:	Tariq Toukan <tariqt@mellanox.com>
+M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -10970,7 +10970,7 @@ Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx4/en_*

 MELLANOX ETHERNET DRIVER (mlx5e)
-M:	Saeed Mahameed <saeedm@mellanox.com>
+M:	Saeed Mahameed <saeedm@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -10978,7 +10978,7 @@ Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_*

 MELLANOX ETHERNET INNOVA DRIVERS
-R:	Boris Pismenny <borisp@mellanox.com>
+R:	Boris Pismenny <borisp@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -10989,8 +10989,8 @@ F:	drivers/net/ethernet/mellanox/mlx5/core/fpga/*
 F:	include/linux/mlx5/mlx5_ifc_fpga.h

 MELLANOX ETHERNET SWITCH DRIVERS
-M:	Jiri Pirko <jiri@mellanox.com>
-M:	Ido Schimmel <idosch@mellanox.com>
+M:	Jiri Pirko <jiri@nvidia.com>
+M:	Ido Schimmel <idosch@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -10999,7 +10999,7 @@ F:	drivers/net/ethernet/mellanox/mlxsw/
 F:	tools/testing/selftests/drivers/net/mlxsw/

 MELLANOX FIRMWARE FLASH LIBRARY (mlxfw)
-M:	mlxsw@mellanox.com
+M:	mlxsw@nvidia.com
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -11009,7 +11009,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
 MELLANOX HARDWARE PLATFORM SUPPORT
 M:	Andy Shevchenko <andy@infradead.org>
 M:	Darren Hart <dvhart@infradead.org>
-M:	Vadim Pasternak <vadimp@mellanox.com>
+M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -11017,7 +11017,7 @@ F:	drivers/platform/mellanox/
 F:	include/linux/platform_data/mlxreg.h

 MELLANOX MLX4 core VPI driver
-M:	Tariq Toukan <tariqt@mellanox.com>
+M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
@@ -11027,7 +11027,7 @@ F:	drivers/net/ethernet/mellanox/mlx4/
 F:	include/linux/mlx4/

 MELLANOX MLX4 IB driver
-M:	Yishai Hadas <yishaih@mellanox.com>
+M:	Yishai Hadas <yishaih@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -11037,8 +11037,8 @@ F:	include/linux/mlx4/
 F:	include/uapi/rdma/mlx4-abi.h

 MELLANOX MLX5 core VPI driver
-M:	Saeed Mahameed <saeedm@mellanox.com>
-M:	Leon Romanovsky <leonro@mellanox.com>
+M:	Saeed Mahameed <saeedm@nvidia.com>
+M:	Leon Romanovsky <leonro@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
@@ -11049,7 +11049,7 @@ F:	drivers/net/ethernet/mellanox/mlx5/core/
 F:	include/linux/mlx5/

 MELLANOX MLX5 IB driver
-M:	Leon Romanovsky <leonro@mellanox.com>
+M:	Leon Romanovsky <leonro@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -11059,8 +11059,8 @@ F:	include/linux/mlx5/
 F:	include/uapi/rdma/mlx5-abi.h

 MELLANOX MLXCPLD I2C AND MUX DRIVER
-M:	Vadim Pasternak <vadimp@mellanox.com>
-M:	Michael Shych <michaelsh@mellanox.com>
+M:	Vadim Pasternak <vadimp@nvidia.com>
+M:	Michael Shych <michaelsh@nvidia.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	Documentation/i2c/busses/i2c-mlxcpld.rst
@@ -11068,7 +11068,7 @@ F:	drivers/i2c/busses/i2c-mlxcpld.c
 F:	drivers/i2c/muxes/i2c-mux-mlxcpld.c

 MELLANOX MLXCPLD LED DRIVER
-M:	Vadim Pasternak <vadimp@mellanox.com>
+M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	linux-leds@vger.kernel.org
 S:	Supported
 F:	Documentation/leds/leds-mlxcpld.rst
@@ -11076,7 +11076,7 @@ F:	drivers/leds/leds-mlxcpld.c
 F:	drivers/leds/leds-mlxreg.c

 MELLANOX PLATFORM DRIVER
-M:	Vadim Pasternak <vadimp@mellanox.com>
+M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/mlx-platform.c
@@ -12027,8 +12027,8 @@ F:	net/ipv6/syncookies.c
 F:	net/ipv6/tcp*.c

 NETWORKING [TLS]
-M:	Boris Pismenny <borisp@mellanox.com>
-M:	Aviad Yehezkel <aviadye@mellanox.com>
+M:	Boris Pismenny <borisp@nvidia.com>
+M:	Aviad Yehezkel <aviadye@nvidia.com>
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Jakub Kicinski <kuba@kernel.org>
@@ -12327,7 +12327,7 @@ S:	Supported
 F:	drivers/nfc/nxp-nci

 OBJAGG
-M:	Jiri Pirko <jiri@mellanox.com>
+M:	Jiri Pirko <jiri@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	include/linux/objagg.h
@@ -12968,7 +12968,7 @@ F:	drivers/video/logo/logo_parisc*
 F:	include/linux/hp_sdc.h

 PARMAN
-M:	Jiri Pirko <jiri@mellanox.com>
+M:	Jiri Pirko <jiri@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	include/linux/parman.h
@@ -15834,7 +15834,7 @@ F:	drivers/infiniband/sw/siw/
 F:	include/uapi/rdma/siw-abi.h

 SOFT-ROCE DRIVER (rxe)
-M:	Zhu Yanjun <yanjunz@mellanox.com>
+M:	Zhu Yanjun <yanjunz@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/rxe/
--
2.26.2


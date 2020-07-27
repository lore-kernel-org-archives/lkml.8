Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D5C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE06205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgG0LHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:07:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40682 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728543AbgG0LGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:06:17 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 27 Jul 2020 14:06:11 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06RB6B3H022169;
        Mon, 27 Jul 2020 14:06:11 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 06RB6BCV002382;
        Mon, 27 Jul 2020 14:06:11 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 06RB6ADt002381;
        Mon, 27 Jul 2020 14:06:10 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC 00/13] Add devlink reload level option
Date:   Mon, 27 Jul 2020 14:02:20 +0300
Message-Id: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new option on devlink reload API to enable the user to select the
reload level required. Complete support for all levels in mlx5.
The following reload levels are supported:
  driver: Driver entities re-instantiation only. 
  fw_reset: Firmware reset and driver entities re-instantiation. 
  fw_live_patch: Firmware live patching only.

Each driver which support this command should expose the reload levels
supported and the driver's default reload level.
The uAPI is backward compatible, if the reload level option is omitted
from the reload command, the driver's default reload level will be used.

Patch 1 adds the new API reload level option to devlink.
Patch 2 exposes the supported reload levels and default level on devlink
        dev get.
Patches 3-8 add support on mlx5 for devlink reload level fw-reset and
            handle the firmware reset events.
Patches 9-10 add devlink enable remote dev reset parameter and use it
             in mlx5.
Patches 11-12 mlx5 add devlink reload live patch support and event
              handling.
Patch 13 adds documentation file devlink-reload.rst 

Command examples:

# Run reload command with fw-reset reload level:
$ devlink dev reload pci/0000:82:00.0 level fw-reset

# Run reload command with driver reload level:
$ devlink dev reload pci/0000:82:00.0 level driver

# Run reload command with driver's default level (backward compatible):
$ devlink dev reload pci/0000:82:00.0


Moshe Shemesh (13):
  devlink: Add reload level option to devlink reload command
  devlink: Add reload levels data to dev get
  net/mlx5: Add functions to set/query MFRL register
  net/mlx5: Set cap for pci sync for fw update event
  net/mlx5: Handle sync reset request event
  net/mlx5: Handle sync reset now event
  net/mlx5: Handle sync reset abort event
  net/mlx5: Add support for devlink reload level fw reset
  devlink: Add enable_remote_dev_reset generic parameter
  net/mlx5: Add devlink param enable_remote_dev_reset support
  net/mlx5: Add support for fw live patch event
  net/mlx5: Add support for devlink reload level live patch
  devlink: Add Documentation/networking/devlink/devlink-reload.rst

 .../networking/devlink/devlink-params.rst     |   6 +
 .../networking/devlink/devlink-reload.rst     |  56 +++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 114 +++++-
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  31 ++
 .../mellanox/mlx5/core/diag/fw_tracer.h       |   1 +
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 328 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |  17 +
 .../net/ethernet/mellanox/mlx5/core/health.c  |  74 +++-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  13 +
 drivers/net/ethernet/mellanox/mlxsw/core.c    |   6 +-
 drivers/net/netdevsim/dev.c                   |   6 +-
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |  12 +
 include/net/devlink.h                         |  10 +-
 include/uapi/linux/devlink.h                  |  22 ++
 net/core/devlink.c                            |  95 ++++-
 19 files changed, 764 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-reload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h

-- 
2.17.1


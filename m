Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F518C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F2A20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgGTHyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:54:11 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41322 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728185AbgGTHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:53:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 20 Jul 2020 10:53:45 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06K7rjgZ008217;
        Mon, 20 Jul 2020 10:53:45 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06K6spj7031174;
        Mon, 20 Jul 2020 09:54:51 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06K6sm5s031172;
        Mon, 20 Jul 2020 09:54:48 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V2 vhost next 00/10] VDPA support for Mellanox ConnectX devices
Date:   Mon, 20 Jul 2020 09:54:33 +0300
Message-Id: <20200720065443.31112-1-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
please note that this series depends on mlx5 core device driver patches
in mlx5-next branch in
git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 

They also depend Jason Wang's patches submitted a couple of weeks ago.

vdpa_sim: use the batching API
vhost-vdpa: support batch updating


The following series of patches provide VDPA support for Mellanox
devices. The supported devices are ConnectX6 DX and newer.

Currently, only a network driver is implemented; future patches will
introduce a block device driver. iperf performance on a single queue is
around 12 Gbps.  Future patches will introduce multi queue support.

The files are organized in such a way that code that can be used by
different VDPA implementations will be placed in a common are resides in
drivers/vdpa/mlx5/core.

Only virtual functions are currently supported. Also, certain firmware
capabilities must be set to enable the driver. Physical functions (PFs)
are skipped by the driver.

To make use of the VDPA net driver, one must load mlx5_vdpa. In such
case, VFs will be operated by the VDPA driver. Although one can see a
regular instance of a network driver on the VF, the VDPA driver takes
precedence over the NIC driver, steering-wize.

Currently, the device/interface infrastructure in mlx5_core is used to
probe drivers. Future patches will introduce virtbus as a means to
register devices and drivers and VDPA will be adapted to it.

The mlx5 mode of operation required to support VDPA is switchdev mode.
Once can use Linux or OVS bridge to take care of layer 2 switching.

In order to provide virtio networking to a guest, an updated version of
qemu is required. This version has been tested by the following quemu
version:

url: https://github.com/jasowang/qemu.git
branch: vdpa
Commit ID: 6f4e59b807db

Eli Cohen (7):
  net/vdpa: Use struct for set/get vq state
  vhost: Fix documentation
  vdpa: Modify get_vq_state() to return error code
  vdpa/mlx5: Add hardware descriptive header file
  vdpa/mlx5: Add support library for mlx5 VDPA implementation
  vdpa/mlx5: Add shared memory registration code
  vdpa/mlx5: Add VDPA driver for supported mlx5 devices

Jason Wang (2):
  vhost-vdpa: support batch updating
  vdpa_sim: use the batching API

Max Gurtovoy (1):
  vdpa: remove hard coded virtq num

 drivers/vdpa/Kconfig                   |   18 +
 drivers/vdpa/Makefile                  |    1 +
 drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
 drivers/vdpa/mlx5/Makefile             |    4 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
 drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
 drivers/vdpa/mlx5/core/resources.c     |  284 ++++
 drivers/vdpa/mlx5/net/main.c           |   76 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
 drivers/vdpa/vdpa.c                    |    3 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
 drivers/vhost/iotlb.c                  |    4 +-
 drivers/vhost/vdpa.c                   |   46 +-
 include/linux/vdpa.h                   |   24 +-
 include/uapi/linux/vhost_types.h       |    2 +
 19 files changed, 3165 insertions(+), 59 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/Makefile
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
 create mode 100644 drivers/vdpa/mlx5/core/mr.c
 create mode 100644 drivers/vdpa/mlx5/core/resources.c
 create mode 100644 drivers/vdpa/mlx5/net/main.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.26.0


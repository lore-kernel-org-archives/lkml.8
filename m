Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E3220781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgGBPJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:09:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39723 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729232AbgGBPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:09:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 2 Jul 2020 18:09:08 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.234.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 062F98Tx020252;
        Thu, 2 Jul 2020 18:09:08 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 062F98NR015403;
        Thu, 2 Jul 2020 18:09:08 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 062F97af015402;
        Thu, 2 Jul 2020 18:09:07 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 0/7] Add devlink-health support for devlink ports
Date:   Thu,  2 Jul 2020 18:08:06 +0300
Message-Id: <1593702493-15323-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for devlink health reporters on per-port basis. First
part in the series prepares common functions parts for health reporter
implementation. Second introduces required API to devlink-health and
mlx5e ones demonstrate its usage and effectively implement the feature
for mlx5 driver.
The per-port reporter functionality is achieved by adding a list of
devlink_health_reporters to devlink_port struct in a manner similar to
existing device infrastructure. This is the only major difference and
it makes possible to fully reuse device reporters operations.
The effect will be seen in conjunction with iproute2 additions and
will affect all devlink health commands. User can distinguish between
device and port reporters by looking at a devlink handle. Port reporters
have a port index at the end of the address and such addresses can be
provided as a parameter in every place where devlink-health accepted it.
These can be obtained from devlink port show command.
For example:
$ devlink health show
pci/0000:00:0a.0:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
pci/0000:00:0a.0/1:
  reporter tx
    state healthy error 0 recover 0 grace_period 500 auto_recover true auto_dump true
$ devlink health set pci/0000:00:0a.0/1 reporter tx grace_period 1000 \
auto_recover false auto_dump false
$ devlink health show pci/0000:00:0a.0/1 reporter tx
pci/0000:00:0a.0/1:
  reporter tx
    state healthy error 0 recover 0 grace_period 1000 auto_recover flase auto_dump false


Vladyslav Tarasiuk (7):
  devlink: Refactor devlink health reporter constructor
  devlink: Rework devlink health reporter destructor
  devlink: Create generic devlink health reporter search function
  devlink: Implement devlink health reporters on per-port basis
  devlink: Add devlink health port reporters API
  net/mlx5e: Move devlink port register and unregister calls
  net/mlx5e: Move devlink-health rx and tx reporters to devlink port

 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   9 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  15 +-
 include/net/devlink.h                              |  11 +
 net/core/devlink.c                                 | 245 ++++++++++++++++-----
 5 files changed, 217 insertions(+), 76 deletions(-)

-- 
1.8.3.1


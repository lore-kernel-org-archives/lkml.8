Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90261C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735B920707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgH3PeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:34:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42744 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgH3P2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:28:01 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 30 Aug 2020 18:27:56 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07UFRtXE029649;
        Sun, 30 Aug 2020 18:27:56 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 07UFRtLX027845;
        Sun, 30 Aug 2020 18:27:55 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 07UFRtJx027844;
        Sun, 30 Aug 2020 18:27:55 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC v3 08/14] net/mlx5: Handle sync reset abort event
Date:   Sun, 30 Aug 2020 18:27:28 +0300
Message-Id: <1598801254-27764-9-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If firmware sends sync_reset_abort to driver the driver should clear the
reset requested mode as reset is not expected any more.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
 .../net/ethernet/mellanox/mlx5/core/fw_reset.c    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index f9e293de9de3..61237f4836cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -14,6 +14,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_request_work;
 	struct work_struct reset_reload_work;
 	struct work_struct reset_now_work;
+	struct work_struct reset_abort_work;
 	unsigned long reset_flags;
 	struct timer_list timer;
 };
@@ -266,6 +267,16 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 	mlx5_load_one(dev, false);
 }
 
+static void mlx5_sync_reset_abort_event(struct work_struct *work)
+{
+	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
+						      reset_abort_work);
+	struct mlx5_core_dev *dev = fw_reset->dev;
+
+	mlx5_sync_reset_clear_reset_requested(dev, true);
+	mlx5_core_warn(dev, "PCI Sync FW Update Reset Aborted.\n");
+}
+
 static void mlx5_sync_reset_events_handle(struct mlx5_fw_reset *fw_reset, struct mlx5_eqe *eqe)
 {
 	struct mlx5_eqe_sync_fw_update *sync_fw_update_eqe;
@@ -280,6 +291,9 @@ static void mlx5_sync_reset_events_handle(struct mlx5_fw_reset *fw_reset, struct
 	case MLX5_SYNC_RST_STATE_RESET_NOW:
 		queue_work(fw_reset->wq, &fw_reset->reset_now_work);
 		break;
+	case MLX5_SYNC_RST_STATE_RESET_ABORT:
+		queue_work(fw_reset->wq, &fw_reset->reset_abort_work);
+		break;
 	}
 }
 
@@ -317,6 +331,7 @@ int mlx5_fw_reset_events_init(struct mlx5_core_dev *dev)
 	INIT_WORK(&fw_reset->reset_request_work, mlx5_sync_reset_request_event);
 	INIT_WORK(&fw_reset->reset_reload_work, mlx5_sync_reset_reload_work);
 	INIT_WORK(&fw_reset->reset_now_work, mlx5_sync_reset_now_event);
+	INIT_WORK(&fw_reset->reset_abort_work, mlx5_sync_reset_abort_event);
 
 	MLX5_NB_INIT(&fw_reset->nb, fw_reset_event_notifier, GENERAL_EVENT);
 	mlx5_eq_notifier_register(dev, &fw_reset->nb);
-- 
2.17.1


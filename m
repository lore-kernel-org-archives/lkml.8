Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE5BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E9620707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgH3PdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:33:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42776 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726804AbgH3P2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:28:01 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 30 Aug 2020 18:27:57 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07UFRvwB029676;
        Sun, 30 Aug 2020 18:27:57 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 07UFRv3Q027855;
        Sun, 30 Aug 2020 18:27:57 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 07UFRvUp027854;
        Sun, 30 Aug 2020 18:27:57 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC v3 13/14] net/mlx5: Add support for devlink reload action fw activate no reset
Date:   Sun, 30 Aug 2020 18:27:33 +0300
Message-Id: <1598801254-27764-14-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for devlink reload action fw_activation_no_reset which does
firmware live patching, updating the firmware image without reset.
The driver checks if the firmware is capable of handling the pending
firmware changes as a live patch. If it is then it triggers firmware
live patching flow.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
v2 -> v3:
- Replace fw_live_patch action by fw_activate_no_reset
v1 -> v2:
- Have fw_live_patch action instead of level
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index ea759bb2a120..bfdd3499f428 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -115,6 +115,29 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	return err;
 }
 
+static int mlx5_devlink_trigger_fw_live_patch(struct devlink *devlink,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u8 reset_level;
+	int err;
+
+	err = mlx5_reg_mfrl_query(dev, &reset_level, NULL);
+	if (err)
+		return err;
+	if (!(reset_level & MLX5_MFRL_REG_RESET_LEVEL0)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "FW upgrade to the stored FW can't be done by FW live patching");
+		return -EINVAL;
+	}
+
+	err = mlx5_fw_set_live_patch(dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 				    enum devlink_reload_action action,
 				    struct netlink_ext_ack *extack)
@@ -127,6 +150,8 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		return mlx5_devlink_reload_fw_activate(devlink, extack);
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE_NO_RESET:
+		return mlx5_devlink_trigger_fw_live_patch(devlink, extack);
 	default:
 		/* Unsupported action should not get to this function */
 		WARN_ON(1);
@@ -150,6 +175,10 @@ static int mlx5_devlink_reload_up(struct devlink *devlink, enum devlink_reload_a
 		if (actions_done)
 			*actions_done = BIT(action) | BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 		break;
+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE_NO_RESET:
+		if (actions_done)
+			*actions_done = BIT(action);
+		break;
 	default:
 		/* Unsupported action should not get to this function */
 		WARN_ON(1);
@@ -173,7 +202,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.flash_update = mlx5_devlink_flash_update,
 	.info_get = mlx5_devlink_info_get,
 	.supported_reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
-				    BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
+				    BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE) |
+				    BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE_NO_RESET),
 	.reload_down = mlx5_devlink_reload_down,
 	.reload_up = mlx5_devlink_reload_up,
 };
-- 
2.17.1


Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D36D20C56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCD21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:28:27 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33601 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgGCD2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:28:21 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 3 Jul 2020 06:28:14 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.234.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0633SExG006780;
        Fri, 3 Jul 2020 06:28:14 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 0633SEbi006656;
        Fri, 3 Jul 2020 06:28:14 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 0633SE74006655;
        Fri, 3 Jul 2020 06:28:14 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Subject: [PATCH net-next v2 1/7] devlink: Refactor devlink health reporter constructor
Date:   Fri,  3 Jul 2020 06:27:32 +0300
Message-Id: <1593746858-6548-2-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1593746858-6548-1-git-send-email-moshe@mellanox.com>
References: <1593746858-6548-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladyslav Tarasiuk <vladyslavt@mellanox.com>

Prepare a common routine in devlink_health_reporter_create() for usage
in similar functions for devlink port health reporters.

Signed-off-by: Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
---
 net/core/devlink.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 6ae3680..dfd7fe2 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -5295,6 +5295,31 @@ struct devlink_health_reporter {
 	return NULL;
 }
 
+static struct devlink_health_reporter *
+__devlink_health_reporter_create(struct devlink *devlink,
+				 const struct devlink_health_reporter_ops *ops,
+				 u64 graceful_period, void *priv)
+{
+	struct devlink_health_reporter *reporter;
+
+	if (WARN_ON(graceful_period && !ops->recover))
+		return ERR_PTR(-EINVAL);
+
+	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
+	if (!reporter)
+		return ERR_PTR(-ENOMEM);
+
+	reporter->priv = priv;
+	reporter->ops = ops;
+	reporter->devlink = devlink;
+	reporter->graceful_period = graceful_period;
+	reporter->auto_recover = !!ops->recover;
+	reporter->auto_dump = !!ops->dump;
+	mutex_init(&reporter->dump_lock);
+	refcount_set(&reporter->refcount, 1);
+	return reporter;
+}
+
 /**
  *	devlink_health_reporter_create - create devlink health reporter
  *
@@ -5316,25 +5341,11 @@ struct devlink_health_reporter *
 		goto unlock;
 	}
 
-	if (WARN_ON(graceful_period && !ops->recover)) {
-		reporter = ERR_PTR(-EINVAL);
+	reporter = __devlink_health_reporter_create(devlink, ops,
+						    graceful_period, priv);
+	if (IS_ERR(reporter))
 		goto unlock;
-	}
-
-	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
-	if (!reporter) {
-		reporter = ERR_PTR(-ENOMEM);
-		goto unlock;
-	}
 
-	reporter->priv = priv;
-	reporter->ops = ops;
-	reporter->devlink = devlink;
-	reporter->graceful_period = graceful_period;
-	reporter->auto_recover = !!ops->recover;
-	reporter->auto_dump = !!ops->dump;
-	mutex_init(&reporter->dump_lock);
-	refcount_set(&reporter->refcount, 1);
 	list_add_tail(&reporter->list, &devlink->reporter_list);
 unlock:
 	mutex_unlock(&devlink->reporters_lock);
-- 
1.8.3.1


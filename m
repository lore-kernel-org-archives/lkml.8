Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDAAC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2326620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGJM02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:26:28 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51773 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727863AbgGJMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:25:56 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 10 Jul 2020 15:25:48 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.234.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06ACPm6q012390;
        Fri, 10 Jul 2020 15:25:48 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06ACPmAL003372;
        Fri, 10 Jul 2020 15:25:48 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06ACPmTx003370;
        Fri, 10 Jul 2020 15:25:48 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Subject: [PATCH net-next v3 2/7] devlink: Rework devlink health reporter destructor
Date:   Fri, 10 Jul 2020 15:25:08 +0300
Message-Id: <1594383913-3295-3-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1594383913-3295-1-git-send-email-moshe@mellanox.com>
References: <1594383913-3295-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladyslav Tarasiuk <vladyslavt@mellanox.com>

Devlink keeps its own reference to every reporter in a list and inits
refcount to 1 upon reporter's creation. Existing destructor waits to
free the memory indefinitely using msleep() until all references except
devlink's own are put.

Rework this mechanism by moving memory free routine to a separate
function, which is called when the last reporter reference is put.

Besides, it allows to call __devlink_health_reporter_destroy() while
locked on a reporters list mutex in symmetry to
__devlink_health_reporter_create(), which is required in follow-up
patch.

Signed-off-by: Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
---
 net/core/devlink.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index a203d35..b85f211 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -5379,6 +5379,29 @@ struct devlink_health_reporter *
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_create);
 
+static void
+devlink_health_reporter_free(struct devlink_health_reporter *reporter)
+{
+	mutex_destroy(&reporter->dump_lock);
+	if (reporter->dump_fmsg)
+		devlink_fmsg_free(reporter->dump_fmsg);
+	kfree(reporter);
+}
+
+static void
+devlink_health_reporter_put(struct devlink_health_reporter *reporter)
+{
+	if (refcount_dec_and_test(&reporter->refcount))
+		devlink_health_reporter_free(reporter);
+}
+
+static void
+__devlink_health_reporter_destroy(struct devlink_health_reporter *reporter)
+{
+	list_del(&reporter->list);
+	devlink_health_reporter_put(reporter);
+}
+
 /**
  *	devlink_health_reporter_destroy - destroy devlink health reporter
  *
@@ -5388,14 +5411,8 @@ struct devlink_health_reporter *
 devlink_health_reporter_destroy(struct devlink_health_reporter *reporter)
 {
 	mutex_lock(&reporter->devlink->reporters_lock);
-	list_del(&reporter->list);
+	__devlink_health_reporter_destroy(reporter);
 	mutex_unlock(&reporter->devlink->reporters_lock);
-	while (refcount_read(&reporter->refcount) > 1)
-		msleep(100);
-	mutex_destroy(&reporter->dump_lock);
-	if (reporter->dump_fmsg)
-		devlink_fmsg_free(reporter->dump_fmsg);
-	kfree(reporter);
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_destroy);
 
@@ -5665,12 +5682,6 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	return NULL;
 }
 
-static void
-devlink_health_reporter_put(struct devlink_health_reporter *reporter)
-{
-	refcount_dec(&reporter->refcount);
-}
-
 void
 devlink_health_reporter_state_update(struct devlink_health_reporter *reporter,
 				     enum devlink_health_reporter_state state)
-- 
1.8.3.1


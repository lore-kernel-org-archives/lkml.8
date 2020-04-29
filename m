Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E3C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F05A20757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD2GxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:53:06 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:34233 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgD2GxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:53:05 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d18 with ME
        id YWt2220030F2omL03Wt2RM; Wed, 29 Apr 2020 08:53:03 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 08:53:03 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4 v2] firmware: stratix10-svc: Slightly simplify code
Date:   Wed, 29 Apr 2020 08:52:59 +0200
Message-Id: <8c505c686438c54da61ad4fe15e1eae722011153.1588142343.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'devm_kmalloc_array(... | __GFP_ZERO)' with the equivalent and
shorter 'devm_kcalloc(...)'.

'ctrl->genpool' can not be NULL, so axe a useless test in the remove
function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/stratix10-svc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 739004398877..c228337cb0a1 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1002,8 +1002,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!controller)
 		return -ENOMEM;
 
-	chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
-				   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
+	chans = devm_kcalloc(dev, SVC_NUM_CHANNEL, sizeof(*chans), GFP_KERNEL);
 	if (!chans)
 		return -ENOMEM;
 
@@ -1086,8 +1085,7 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 		kthread_stop(ctrl->task);
 		ctrl->task = NULL;
 	}
-	if (ctrl->genpool)
-		gen_pool_destroy(ctrl->genpool);
+	gen_pool_destroy(ctrl->genpool);
 	list_del(&ctrl->node);
 
 	return 0;
-- 
2.25.1


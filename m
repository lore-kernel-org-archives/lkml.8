Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E86C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930B3205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEQIvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 04:51:03 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:31349 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgEQIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 04:51:03 -0400
Received: from localhost.localdomain ([92.140.207.208])
        by mwinf5d34 with ME
        id fkqq2200R4WJoZY03kqrdM; Sun, 17 May 2020 10:51:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 May 2020 10:51:01 +0200
X-ME-IP: 92.140.207.208
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     airlied@linux.ie, daniel@ffwll.ch, gregkh@linuxfoundation.org,
        tglx@linutronix.de, chris@chris-wilson.co.uk,
        tvrtko.ursulin@intel.com, joonas.lahtinen@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/mm: Fix an error handling path in '__igt_once()'
Date:   Sun, 17 May 2020 10:50:49 +0200
Message-Id: <20200517085049.278103-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label of the last gotos must be switched for the error handling code to
work as expected.

Fixes: 83bc4ec37210 ("drm/mm: Add a search-by-address variant to only inspect a single hole")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 9aabe82dcd3a..af38c4fa4db5 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -1864,14 +1864,14 @@ static int __igt_once(unsigned int mode)
 		pr_err("Unexpectedly inserted the node into the wrong hole: node.start=%llx\n",
 		       node.start);
 		err = -EINVAL;
-		goto err_node;
+		goto err_hi;
 	}
 
 	err = drm_mm_insert_node_generic(&mm, &node, 2, 0, 0, mode);
 	if (err) {
 		pr_err("Could not insert the node into the available hole!\n");
 		err = -EINVAL;
-		goto err_hi;
+		goto err_node;
 	}
 
 err_node:
-- 
2.25.1


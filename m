Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EEC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03732070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgDZTDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:03:15 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:24499 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgDZTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 15:03:15 -0400
Received: from localhost.localdomain ([93.23.12.11])
        by mwinf5d64 with ME
        id XX3A2200a0EJ3pp03X3BmA; Sun, 26 Apr 2020 21:03:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Apr 2020 21:03:12 +0200
X-ME-IP: 93.23.12.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: stratix10-svc: Fix some error handling paths in 'stratix10_svc_drv_probe()'
Date:   Sun, 26 Apr 2020 21:03:07 +0200
Message-Id: <20200426190307.40840-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling 'kfifo_alloc()', the allocated memory
should be freed with 'kfifo_free()', as already done in the remove
function.

Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/stratix10-svc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d5f0769f3761..cc9df9589195 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1043,24 +1043,31 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	/* add svc client device(s) */
 	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
-	if (!svc)
-		return -ENOMEM;
+	if (!svc) {
+		ret = -ENOMEM;
+		goto err_free_kfifo;
+	}
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
 		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_kfifo;
 	}
 
 	ret = platform_device_add(svc->stratix10_svc_rsu);
 	if (ret) {
 		platform_device_put(svc->stratix10_svc_rsu);
-		return ret;
+		goto err_free_kfifo;
 	}
 	dev_set_drvdata(dev, svc);
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
+	return 0;
+
+err_free_kfifo:
+	kfifo_free(&controller->svc_fifo);
 	return ret;
 }
 
-- 
2.25.1


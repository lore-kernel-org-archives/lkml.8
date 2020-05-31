Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5ECC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7298207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgEaHhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:37:31 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:20907 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgEaHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:37:31 -0400
Received: from localhost.localdomain ([93.23.14.245])
        by mwinf5d45 with ME
        id lKdN220075HDzGl03KdP5C; Sun, 31 May 2020 09:37:28 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 31 May 2020 09:37:28 +0200
X-ME-IP: 93.23.14.245
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()' which is unused and broken
Date:   Sun, 31 May 2020 09:37:16 +0200
Message-Id: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for pinctrl registration")
has turned a 'pinctrl_register()' into 'devm_pinctrl_register()' in
'pxa2xx_pinctrl_init()'.
However, the corresponding 'pinctrl_unregister()' call in
'pxa2xx_pinctrl_exit()' has not been removed.

This is not an issue, because 'pxa2xx_pinctrl_exit()' is unused.
Remove it now to avoid some wondering in the future and save a few LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If some some reason the function should be kept, at least it should be
only 'return 0;'
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index bddf2c5dd3bf..eab029a21643 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -425,15 +425,6 @@ int pxa2xx_pinctrl_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_init);
 
-int pxa2xx_pinctrl_exit(struct platform_device *pdev)
-{
-	struct pxa_pinctrl *pctl = platform_get_drvdata(pdev);
-
-	pinctrl_unregister(pctl->pctl_dev);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
-
 MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
 MODULE_DESCRIPTION("Marvell PXA2xx pinctrl driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1


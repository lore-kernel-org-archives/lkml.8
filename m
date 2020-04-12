Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27D7C2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783D8206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783D8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDLViX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:38:22 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA9E4C0A88B5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:38:22 -0700 (PDT)
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d33 with ME
        id RxWq2200D0scBcy03xWq0Q; Sun, 12 Apr 2020 23:30:51 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Apr 2020 23:30:51 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lee.jones@linaro.org, andrew@lunn.ch
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: tqmx86: Fix a typo in MODULE_DESCRIPTION
Date:   Sun, 12 Apr 2020 23:30:47 +0200
Message-Id: <20200412213047.4827-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the file name and code of the driver, it is likely that this
module is related to TQMx86 and not TQx86.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/tqmx86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index b9f48e588d95..ddddf08b6a4c 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -274,7 +274,7 @@ static int __init tqmx86_init(void)
 
 module_init(tqmx86_init);
 
-MODULE_DESCRIPTION("TQx86 PLD Core Driver");
+MODULE_DESCRIPTION("TQMx86 PLD Core Driver");
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:tqmx86");
-- 
2.20.1


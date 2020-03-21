Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D15C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 08:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C20C20714
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 08:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgCUI7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 04:59:14 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:33136 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgCUI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 04:59:13 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d62 with ME
        id Gwyl220070scBcy03wytzK; Sat, 21 Mar 2020 09:59:12 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Mar 2020 09:59:12 +0100
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nsekhar@ti.com, bgolaszewski@baylibre.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ARM: davinci: dm646x-evm: Simplify error handling in 'evm_sw_setup()'
Date:   Sat, 21 Mar 2020 09:58:36 +0100
Message-Id: <20200321085836.16493-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call 'gpio_free(evm_sw_gpio[i])' for these error
handling cases, it is already done in the error handling path at label
'out_free'.

Simplify the code and axe a few LoC.

While at it, also explicitly return 0 in the normal path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The code after 'out_free' could also be replace by a single
'evm_sw_teardown()' call, but I'm not a big fan of such construction.

In 'evm_sw_teardown()', the 'gpio_unexport()' call could also be removed
because it is implied by 'gpio_free()'.

Let me now if interested for one or both of these additional clean-up.
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 4600b617f9b4..dd7d60f4139a 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -267,20 +267,15 @@ static int evm_sw_setup(struct i2c_client *client, int gpio,
 		evm_sw_gpio[i] = gpio++;
 
 		status = gpio_direction_input(evm_sw_gpio[i]);
-		if (status) {
-			gpio_free(evm_sw_gpio[i]);
-			evm_sw_gpio[i] = -EINVAL;
+		if (status)
 			goto out_free;
-		}
 
 		status = gpio_export(evm_sw_gpio[i], 0);
-		if (status) {
-			gpio_free(evm_sw_gpio[i]);
-			evm_sw_gpio[i] = -EINVAL;
+		if (status)
 			goto out_free;
-		}
 	}
-	return status;
+	return 0;
+
 out_free:
 	for (i = 0; i < 4; ++i) {
 		if (evm_sw_gpio[i] != -EINVAL) {
-- 
2.20.1


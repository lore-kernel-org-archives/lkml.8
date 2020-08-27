Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA151C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C45722BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598513068;
	bh=S+YE0qEWx4yI9dTxKlN3BZj1KnlkIX5R53Okn/Sb7V4=;
	h=From:To:Subject:Date:List-ID:From;
	b=qEzr2fbEEqHKPJNswm3uceYkFEmmcQsEgYxnEH6O+7nvjdja6FQm7UqseR69g57JU
	 lfKtjTXw+aAUNAMPlhKKVFhfkxZVTx0gi21hkmIHUyntCwL3g8zhroqoSDROM/9otx
	 sYGpq4fYUGkypFyMupsf5wqcw4yTX0I0tXDmQvAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgH0HY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgH0HY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:24:26 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F41522BEB;
        Thu, 27 Aug 2020 07:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513066;
        bh=S+YE0qEWx4yI9dTxKlN3BZj1KnlkIX5R53Okn/Sb7V4=;
        h=From:To:Subject:Date:From;
        b=Yyeb8XSxy68hcCJQxaJsRg1IUQoyJjvaZlMhByINmUddmrCaijr2C6IUTIwID5BLG
         nr9ZMOkzwV+8NaaLBwtp2LxnKZ4rlrQBehoXrtGlQxmhyDDZl/Uh9NG3jjK6a5NgyW
         HKR3sDP8cjc7CfUshPIqcC0cw3WvOexe4GHeBX94=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] Input: ep93xx_keypad - Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:24:17 +0200
Message-Id: <20200827072420.22848-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 60214f058f44 ("Input: ep93xx_keypad - update driver to new core support")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 7c70492d9d6b..f831f01501d5 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -250,8 +250,8 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->irq = platform_get_irq(pdev, 0);
-	if (!keypad->irq) {
-		err = -ENXIO;
+	if (keypad->irq < 0) {
+		err = keypad->irq;
 		goto failed_free;
 	}
 
-- 
2.17.1


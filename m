Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF9C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5278C20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598626677;
	bh=KYG3iaeJzQP1RJ6YodGmBJnOc9QTOtwrvTEilsPrB1g=;
	h=From:To:Subject:Date:List-ID:From;
	b=Y7CwAu9xcF5NNZw0fjq3qlBO9JVujXF1ejpgBMb+zAb0wFcjwrrB2lUe44mq+5mvB
	 H9GH1UL6UIKuIOpPPlP415VfCgzY4KcHAsJ0/HHfHaZ7u5cQed3Wl4GNC7IrVyyXYl
	 e9C33BAW7AWxNRQhWjiZBm4rOlyNpnQlaLyIKtN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH1O5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgH1O5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:57:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D921320665;
        Fri, 28 Aug 2020 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598626673;
        bh=KYG3iaeJzQP1RJ6YodGmBJnOc9QTOtwrvTEilsPrB1g=;
        h=From:To:Subject:Date:From;
        b=PeeEPWhmB2qE/0PFrPQ33ve/EDVABitCyqACXjRUNYzaYYBHxWbl3wFbHllwD3X26
         QZCnS5RCSjk8XNW5H3bgGDKA0rjjHzG4BapDKkcVR62sKRCy2+DIJUR80FJtxE/h1Y
         KREqg/JVIcScMshYurIOJjYEgz+eqMRZxldiRI60=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] Input: ep93xx_keypad - Fix handling of platform_get_irq() error
Date:   Fri, 28 Aug 2020 16:57:41 +0200
Message-Id: <20200828145744.3636-1-krzk@kernel.org>
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

Changes since v1:
1. None
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


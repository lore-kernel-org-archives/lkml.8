Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22742C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12FD20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598512279;
	bh=jNqVqQ6eWSkE3IuUZP3Pk4lbjqOHgn30X2jL8RJuqNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YoSFzIzLI9t0hH+bPJ8tlg5GkEB8nHJY6iwzddDmB0KqEu/h+fCVTfQR72eaZrObf
	 2sVUcdZWPS0F4blTU1QOQs/H0i6ZUgsWPxnICKbUxdST4wbezjLP1hd1ppPKIcB/Iv
	 u9GsZFukYoBK4iKmWtWGPfP2LEFnVzHo2eokwIOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgH0HLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0HLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:11:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEF022B4E;
        Thu, 27 Aug 2020 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598512275;
        bh=jNqVqQ6eWSkE3IuUZP3Pk4lbjqOHgn30X2jL8RJuqNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY648liRfDDyMuhlc0e4Q1u6sioGsdtcmoNAu8o4tYceNIbTN3ldfD++RSs05JrBv
         TTH31cJYqkZx+1vq8rPCkbDyVqY+8+oKS9OmCqhZNRg+cn7v+a9mb5hej3LLguR8/I
         HtLH9bsOCX4vl95DTm26MeYWRoDt+Y540odVpEDE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] drm/tve200: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:11:07 +0200
Message-Id: <20200827071107.27429-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827071107.27429-1-krzk@kernel.org>
References: <20200827071107.27429-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 179c02fe90a4 ("drm/tve200: Add new driver for TVE200")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index c3aa39bd38ec..b5259cb1383f 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -200,8 +200,8 @@ static int tve200_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto clk_disable;
 	}
 
-- 
2.17.1


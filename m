Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBC122BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598512275;
	bh=Rd3IPLSRLgrH+mJAwekrNlykvMw6D1DmCQqAjMzhlhk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TKfYyWoTFO25wRK4Oc/yBV1WZ6EE/VsVVx11o4JBHWKdYDyOXTAf0LRv7BvlNdcKc
	 1JGiNkNULyLTMEcOnUriIknV4nOZa0nF8Ssr7JBOKxeyW0f2MLTGfgtEl0EM3ISlrc
	 7dLuQg7BP/5qnujaCBH0V+2av5+4dNNRck0VT88U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgH0HLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0HLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:11:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA67320786;
        Thu, 27 Aug 2020 07:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598512273;
        bh=Rd3IPLSRLgrH+mJAwekrNlykvMw6D1DmCQqAjMzhlhk=;
        h=From:To:Cc:Subject:Date:From;
        b=rTxcLAfzjpuCyKTnq4JOJ0pRnvvdO8iQ6yJ2DW+5Y1xqxy1/+VRSMCMeeV6yOR9lG
         9ETX6ex5Uf0+rnMm7Zv3hzPlQoLxDb3j5t2U/R57vhpTyN542X+i6/cM7d+4YyQZsw
         NhmyGCEr5TfORbuMnltgBmq6OCb+ZEtYrp585CSw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] drm/mcde: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:11:06 +0200
Message-Id: <20200827071107.27429-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index c592957ed07f..f9b5f450a9cb 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -331,8 +331,8 @@ static int mcde_probe(struct platform_device *pdev)
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


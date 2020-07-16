Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95584C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F7A207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGPOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:51:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11A82ACBF;
        Thu, 16 Jul 2020 14:51:32 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>,
        Dave Emett <david.emett@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Use platform_get_irq_optional() to get optional IRQs
Date:   Thu, 16 Jul 2020 16:49:27 +0200
Message-Id: <20200716144927.7193-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside from being more correct, the non optional version of the function
prints an error when failing to find the IRQ.

Fixes: eea9b97b4504 ("drm/v3d: Add support for V3D v4.2")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpu/drm/v3d/v3d_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index c88686489b88..0be2eb7876be 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -217,7 +217,7 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
 
-	irq1 = platform_get_irq(v3d_to_pdev(v3d), 1);
+	irq1 = platform_get_irq_optional(v3d_to_pdev(v3d), 1);
 	if (irq1 == -EPROBE_DEFER)
 		return irq1;
 	if (irq1 > 0) {
-- 
2.27.0


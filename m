Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC0820786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgG0Kel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:34:41 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:58521 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgG0Kel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:34:41 -0400
Received: from localhost.localdomain ([93.23.16.147])
        by mwinf5d60 with ME
        id 8Aae2300C3ANib903AafkC; Mon, 27 Jul 2020 12:34:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 27 Jul 2020 12:34:39 +0200
X-ME-IP: 93.23.16.147
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] drm/radeon: avoid a useless memset
Date:   Mon, 27 Jul 2020 12:34:36 +0200
Message-Id: <20200727103436.50793-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a memset after a call to 'dma_alloc_coherent()'.
This is useless since
commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/radeon/radeon_gart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index b7ce254e5663..3808a753127b 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -85,7 +85,6 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 	}
 #endif
 	rdev->gart.ptr = ptr;
-	memset((void *)rdev->gart.ptr, 0, rdev->gart.table_size);
 	return 0;
 }
 
-- 
2.25.1


Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB352207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1hFqpY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgGAPdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbgGAPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:33:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8BFC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:33:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so11910038pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U9tcBWqanEmcG7y4KnRT6hQjOymIY+744WxQv0Dj8Zo=;
        b=K1hFqpY0Fmcq2Wbi/vJnWw4/HMuvHGfUuInJqu3Ga3uSw6z4rCdqHlaAlLOUwojT7r
         qgAU4kYVt+OIY/65Ibv7i+8Bf4nZFSPnMsfMGpFUaMCURJtiG7GN2g7WCIWZL3Nv+cQD
         CS3lKkwI4V/2nIHY0n4JaqAxwXj2MNrnu1kWV1+B0N1SJ7t4m3F6NVzqGwbsDLvH8dZ7
         iKGcrKRQK/FZDHFlQa6Pb6c6Rzx701nSm3E2U1caDR0qVQWjyS/Z39C9D8p4lImzO9Q2
         T/NF09gb/mY9vDwIrBlgZeHNY24isRLRkFdd3/oRXTZuwBRNDYag8IFBNOr77AzCF523
         QiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U9tcBWqanEmcG7y4KnRT6hQjOymIY+744WxQv0Dj8Zo=;
        b=E+E58iemVe2AxuGULB6G9IL4dfqqFrAJ02zf9XApBAQPgWcW9f4v9FIx64O73W/AiJ
         FprRsg/BNrxGGS9j/1COPQhSW9vTn0NRk7UllKyd3tvBHwvTfvWEJoT4TpgkZ/bOYlTB
         1iWqLeyyPU07DMGYRIh1kAH7KaQXOjUOi+uL4zjfJZrdLBCyU32DEVd1vla2hZ4H24Ce
         etB9JpSu1nnAoKLgte02/1ii7KL6Ox7wJeaUtezSv0wbRJfMWOl+PUVsFsCHIQTbarF6
         x3l4wRkwYYFTX1w0LLIJILzYRMF7cP++rKzK9izgDQraT8j9YG35NJNQ0k5iwdf1hXVq
         88rw==
X-Gm-Message-State: AOAM530Aj7BiHTuz/735LCYtT58VVcfbriRCMiFuSRbUm5qnlR/YbgEF
        Mz0pTiJvPRRoQ6e5ZQQF1UYo87tH
X-Google-Smtp-Source: ABdhPJze/rdIUGzGzRmy2i1GgLCkpJoNWrsDPUWc/0mEg5zpEaXdh/1TsueAz3luUFdpr2gRjHVLKA==
X-Received: by 2002:a63:580c:: with SMTP id m12mr19822599pgb.446.1593617612304;
        Wed, 01 Jul 2020 08:33:32 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id a9sm6566763pfr.103.2020.07.01.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 08:33:31 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Date:   Wed,  1 Jul 2020 15:31:34 +0000
Message-Id: <20200701153134.4187-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an error when igt test is run continuously. vkms_atomic_commit_tail()
need to call drm_atomic_helper_wait_for_vblanks() for give up ownership of
vblank events. without this code, next atomic commit will not enable vblank
and raise timeout error.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 1e8b2169d834..10b9be67a068 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -93,6 +93,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 		flush_work(&vkms_state->composer_work);
 	}
 
+	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+
 	drm_atomic_helper_cleanup_planes(dev, old_state);
 }
 
-- 
2.17.1


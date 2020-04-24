Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B26C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB9920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxGCXqkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDXKPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgDXKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:15:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425FEC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:15:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o10so4423606pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kKqnTUenA/rrGtoXHPWbx59Tan7ETAeJu0G1PoePj8Q=;
        b=jxGCXqkJid1cEbzBEHdxZAmk6SP0zwAOb26BSRaPOA6UiIS01PgdZvgAidmq7Vy2LM
         P+VrNbtJXKvbGkOHiu10OPUlYwB6IM6dozMYqAt7/QUi8NZ7uY7AoWQUi/0s+pNg513e
         VQmYhYVgMvui0Gns1IdMI8sWB9zHMfU/GMwr6gthtCdrJKZy56cM3H1D5xOjNgSz7ZTP
         l3pFxITeDywBjGllqR5KPy2LpeoG05Qs5mLieXRsUuBvBvX4cONL95yYRR9u/fikIiBn
         BXdkk0/RLepxrH6NO7WvXAsqDVPHXkc69UObcIOJpFcE5Vbq5wV32NbIK30dt/XaGHg1
         id7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kKqnTUenA/rrGtoXHPWbx59Tan7ETAeJu0G1PoePj8Q=;
        b=cU3LBOGuuTdpLaAUpm/qlNg/uAoS+GyYWXiwxlYjJJtLIIcBdn4NwV/9i8WwMr5Ds4
         RgTDQSFO8HlTOAgUnqaxX/8OJJ+CjpORpInB/9CDuvYKV2eahCgxQDntIhU9cVWOm7cn
         5T5iO5Fklc23xXm1DwNseDxXRt8ss2qv8/SKSqajtmVrccFx9j/QULCvihSZupC7QbDH
         sbH6vIqRh7c6t1bWvpk64RO1XmDJDwPVoEWYV+vYe6qP3XcdIm4/ymp0WulUqDTuAudj
         /j1gMFx4SD1RjnPmlyPBm3+dcTuTwva+Q1ZV4VKR6xi7O9D4J2epnOq+jr0ilkzSpw88
         10yQ==
X-Gm-Message-State: AGi0PuZbsAJK4omjgMT9HqeBdGgD8RWXjKGw2o+JgHj8qDZm/bvNR/Rk
        IDOpfZBX7bD32/J0owZYXUe8UuWeLyQM9g==
X-Google-Smtp-Source: APiQypLVT/jJRAyLJCZsU721zNGW4Fe35u6Tl5hXfGOqTbzN5EGHV16pWlevVhBY+Fi/UlcbWeNANw==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr8806021pfc.190.1587723352734;
        Fri, 24 Apr 2020 03:15:52 -0700 (PDT)
Received: from localhost.localdomain ([223.104.63.47])
        by smtp.gmail.com with ESMTPSA id 127sm5254252pfz.128.2020.04.24.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 03:15:52 -0700 (PDT)
From:   Guixiong Wei <guixiongwei@gmail.com>
To:     linux-graphics-maintainer@vmware.com, thellstrom@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guixiong Wei <guixiongwei@gmail.com>
Subject: [PATCH] drm/vmwgfx: Fix parameter name in vmw_bo_init
Date:   Sat, 25 Apr 2020 00:14:39 +1400
Message-Id: <20200424101439.13572-1-guixiongwei@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter name should be interruptible instead of interuptable.

Signed-off-by: Guixiong Wei <guixiongwei@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 8cdcd6e5f9e1..3596f3923ea3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -850,7 +850,7 @@ extern void vmw_bo_bo_free(struct ttm_buffer_object *bo);
 extern int vmw_bo_init(struct vmw_private *dev_priv,
 		       struct vmw_buffer_object *vmw_bo,
 		       size_t size, struct ttm_placement *placement,
-		       bool interuptable,
+		       bool interruptible,
 		       void (*bo_free)(struct ttm_buffer_object *bo));
 extern int vmw_user_bo_verify_access(struct ttm_buffer_object *bo,
 				     struct ttm_object_file *tfile);
-- 
2.17.1


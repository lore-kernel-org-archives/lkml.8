Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E942EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47A42075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BFrWfief"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEKJLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgEKJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:11:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6107C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so12305790wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kypGotJsMo32YHf8OUx+eQZgE4BXycYY0Yyrzee1xg4=;
        b=BFrWfiefay0G3axbOIvAU7cL37XL0viEFlie/9f9z/E/mFIyz7gZQoFRa+kNZK4LQx
         XBOAAjgo9eXYRtibV6b8JVgQXHu/raQFY9l+V/l90+qLnl7fWQMjeziBAPOHwuPSFxCx
         NRDFbLWUul18dgcd2jgUu1QFdBk9GP0ZhMwg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kypGotJsMo32YHf8OUx+eQZgE4BXycYY0Yyrzee1xg4=;
        b=G5mV9BB4J6Ize0KgvefIHp33KMTjisUb6bBJn6TajobliU1fgoqCUuj4uOt0zypo28
         o/DsexxdihI5JLJeoKptJlfanEb1E33we/24QWYHaO7o7tAQ5Ib/Ynwut8nRYfFZV+w0
         TtdG8/bSVDaYsxwr6CBAVVfJb0nOFxEQzBU7cbwLKe2pQt+Ttqe/VOlt2simBaCvFcrC
         9/ralE3MlQR1gs6DWdo4/7Y9dkYrRV/ZO9J7SjKhIQ3P3//ugmYDCvT5ugKEU5yGcnUH
         WLqo9Kzgh2ZdvP6ivU/Kns0LS7mih6h5DSkUBNEzNTrG4dESio5fo+ezszB3m5++eXuZ
         2p/g==
X-Gm-Message-State: AGi0PuZeK/s+y42WOboc8yQIvaoHlNOjT2k2fK3alsCK3K7vf9NLztqX
        qXHD5REVNNyMdHZbnBHxOPUi8RZsQXU=
X-Google-Smtp-Source: APiQypJu6MhVzS21pUOPY5hvSgBf8+CIjEHG8jg44vuH9LazUaM1m9dy/ExDV8ceiF+NtEDozOxG/w==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr24673393wme.128.1589188313116;
        Mon, 11 May 2020 02:11:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t4sm17506299wri.54.2020.05.11.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:11:52 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/3] drm/writeback: don't set fence->ops to default
Date:   Mon, 11 May 2020 11:11:40 +0200
Message-Id: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's the default.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_writeback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 43d9e3bb3a94..dccf4504f1bb 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -108,7 +108,6 @@ static const struct dma_fence_ops drm_writeback_fence_ops = {
 	.get_driver_name = drm_writeback_fence_get_driver_name,
 	.get_timeline_name = drm_writeback_fence_get_timeline_name,
 	.enable_signaling = drm_writeback_fence_enable_signaling,
-	.wait = dma_fence_default_wait,
 };
 
 static int create_writeback_properties(struct drm_device *dev)
-- 
2.26.2


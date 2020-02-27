Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20742C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BDF24692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcwliqw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgB0MCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43718 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id c13so2966498wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMAbn81YysGaNx3Ax4N9Hbye6l0w3UkvwB+0d6uRaC8=;
        b=kcwliqw0h7kmfEHfB6QGxy7vTmRIohokuOQhZsvpGsRsNyHsLL5b9Piu0IOBLciQcw
         lsm1NB22ZrI9j/RkzHHkVklamX1IsggcqtWnwMFudSDIZowCkyTZ9He1EO5xj1AGtwzr
         EG3bhfx8QuoWa4JJgaH19u/2/hyUsfV2/KdXaWVzbswY4HOjL4tbq2T9jo/MJndsxjGW
         9A0exSGYqbyY/vEl5i3hs/8nM+nJjTd2h0vDplIS+qu6YhJAj87MmHeYvXfklgDCsPRn
         sZW7BfemZtXqCVjmoUB3Ad3t5Aei+CQpPoZl80+uvXBDURc0Q6SvksjPCC97vP+i7SNo
         gqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMAbn81YysGaNx3Ax4N9Hbye6l0w3UkvwB+0d6uRaC8=;
        b=THvLhr90ny9NlnGABmNgKUuxvAxnEbu7NW3CT3EnqPRPuMSg2birqkCRAyA+fR+6jH
         RYCmE9GP3ztnUyGJ/tZYkO5WjVZG4mkYWhGILf8jSxmLrY7gPIHHoU2EWj1nEIHMThW7
         Dk2J5CIhzHJmFpYCiAoyD9uvK72ozy2gItovGypm6JsLWSSTIx3KvT6+J1Z+ZJG328FK
         UGhi/h7XiA0CRuBNa9tmtVk+jH9GxMh5m2FkalaPvWuw73KdC2DWsQ4aqfWUP5RrVr1v
         /NDZPIT9+QpanyTC59O8F7CI5OaBWswM7ug7RulL0QyaanYu2sJg71crN7emHPj9Fgxq
         ei0w==
X-Gm-Message-State: APjAAAXreg9gQMSXiHKZUXeFBvUh4XgdnZP0fbPc8GYnNYhMYN1/6uwk
        ExVchARqV9frHExW72Q4TLo=
X-Google-Smtp-Source: APXvYqx7FoldVgWhVom1JC/YSiCcWptuniuidY1zT9ZaeFkvv9JU1Km0AG6pK3zl6XCQGzNQisUoQA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr4589350wri.317.1582804969099;
        Thu, 27 Feb 2020 04:02:49 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:02:48 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/21] drm: convert the drm_driver.debugfs_init() hook to return void.
Date:   Thu, 27 Feb 2020 15:02:13 +0300
Message-Id: <20200227120232.19413-3-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail) and changes to various debugfs
functions in drm/core and across various drivers, there is no need for
the drm_driver.debugfs_init() hook to have a return value. Therefore,
declare it as void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 97109df5beac..c6ae888c672b 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -323,7 +323,7 @@ struct drm_driver {
 	 *
 	 * Allows drivers to create driver-specific debugfs files.
 	 */
-	int (*debugfs_init)(struct drm_minor *minor);
+	void (*debugfs_init)(struct drm_minor *minor);
 
 	/**
 	 * @gem_free_object: deconstructor for drm_gem_objects
-- 
2.25.0


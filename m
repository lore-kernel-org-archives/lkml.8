Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119ECA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC420206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDAPOP+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgEMLm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgEMLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:42:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F482C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so13210981wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTkY+j+6GTabMKNS4Ht855+gzZTKymsTLBvZdWCVoas=;
        b=uDAPOP+M7Yi+o7mHhwsXmOxS3LIX0uL4TTQ9frjgQy87Hb53KA9q9EzhEbKqjpm7+4
         SuGlmyRrJPKBNQtumvsjZHBQJLAev9ODOlczLVdR09BqtXZREy9lcPCgZNhJO9L6Outq
         BJNSkqgby6es7SLVkRk/Rbj+7m+krgfvcGduf+jTF0VN0bTewTBLelWHXGFR1e09dRRo
         c0MBEnQccME0vt4TydnhJnAgiXUWXh4ZjfMbzDMi+dxrYBk2dE6aPUXOTcfnPDJnE+Wa
         jcF/ZGHaQxY6siJMnhU/h28LDYVaWtoI8G+63o8pjuG0rq8dtuw4La+YCJsaj65UtYgJ
         Riug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTkY+j+6GTabMKNS4Ht855+gzZTKymsTLBvZdWCVoas=;
        b=aj1vKk7GzTBvFFOLGokxVOO6wX2fwwHFnVX95BQ6nOYqrUC7zSO3D8mjvXrRx18dUC
         0Ozj+1Ga68SJ6HIlkGquk0AnSEEc1Olz8yxX5Bpf+B2/UKHezFpMrkvgJsRqy7SVlkmU
         ILjFiIHMzz4irzndTUau8aygRrwbhkMD2YIjn+0NopRr6zvUvqDGhYBIihWZeXPe/DXF
         l2dxjknZrtFvu4CoCUY5vHZKv8sdXqETGkQ3NuILONd49MdsEiIfpNzUZa4nQ0Fd2HGy
         8JdrYz6BRAwaNre+mMwj/Dc+96KGwz0wbXHl6/S9QQYUt4PronsgZPTSEtyh8QypS6ru
         xvgA==
X-Gm-Message-State: AGi0PuZnI+Z2Pj7bik0rs2/MylHoChXMrk6dC5Pnf5eVrgEJiUBpt5G4
        RpOWOGgoOxpNbMpDnekSJXw=
X-Google-Smtp-Source: APiQypIm7YhC98as/7YeUxKj3sJfUd8kfKY8od4PzE1OLjipYDg9JmLrai+orf7Yw03sFpj+s2aMxw==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr15225880wmc.149.1589370145086;
        Wed, 13 May 2020 04:42:25 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.182.195])
        by smtp.googlemail.com with ESMTPSA id j2sm27484540wrp.47.2020.05.13.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:42:24 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] drm: introduce new method of creating debugfs files.
Date:   Wed, 13 May 2020 14:41:26 +0300
Message-Id: <20200513114130.28641-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Currently drm debugfs files are created using drm_debugfs_create_files()
on request.
This series introduces new functions and infrastructure that will enable
the mass creation of debugfs files during drm_dev_register(). Drivers can
request for the creation of debugfs files at any time using two new
functions: drm_debugfs_add_files()/drm_debugfs_add_file(). The file
requests are added to a list and tracked until drm_dev_register() when
the files are created all at once.

This concept was already in use by the drm/vc4 driver and this series
tries to introduce the same infrastructure in drm core.
Patch 2 removes vc4's functions doing the same, and replaces it
with the new drm core functions.
Patch 3 is an example of how the new functions and structs can replace
the existing drm_info_list and drm_debugfs_create_files() usage.

Hoping to get some feedback or comments on the current progress of this
series.

Thanks,
wambui karuga

Wambui Karuga (3):
  drm/debugfs: create debugfs files during drm_dev_register().
  drm/vc4: use new debugfs functions for file creation.
  drm: use new debugfs functions for various files.

 drivers/gpu/drm/drm_atomic.c      | 11 +++---
 drivers/gpu/drm/drm_client.c      | 11 +++---
 drivers/gpu/drm/drm_debugfs.c     | 59 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/drm_drv.c         |  2 ++
 drivers/gpu/drm/drm_framebuffer.c | 11 +++---
 drivers/gpu/drm/vc4/vc4_bo.c      |  4 +--
 drivers/gpu/drm/vc4/vc4_debugfs.c | 38 +++++---------------
 drivers/gpu/drm/vc4/vc4_hdmi.c    |  4 +--
 drivers/gpu/drm/vc4/vc4_hvs.c     |  4 +--
 drivers/gpu/drm/vc4/vc4_v3d.c     |  4 +--
 include/drm/drm_debugfs.h         | 38 ++++++++++++++++++++
 include/drm/drm_device.h          | 12 +++++++
 12 files changed, 138 insertions(+), 60 deletions(-)

-- 
2.26.2


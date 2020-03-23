Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3730DC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E8A206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCUPXLUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgCWL2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:28:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:28:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so16601379wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hw2/ohwzvhdDAwTeOPYmsLkFpaTkgjXMGVp6G44h3PI=;
        b=SCUPXLUw/uicEQqC2yi+8megAkqOkf+9OKn4NIu/93ohMq8xiPzCItbINGWJlS9JI2
         6jl6HgXpuxawRuG5YtcT4Xj8qypZfmst+TP5C6IXyQlnqo90oOHI3QeKfqOc8+ODWDH7
         bV/lq4EcxwGI+1P0Toc5KZczWbtsehyOc/5zCgpyv4XcYw0Ay92LchAzDj8SzSkp+Hv5
         /8lA22jOUI4/sZFR/hlJRvFpl1DrUELX3w5BYp0pwNviujN065xrah7N7ZpFDJcodGhN
         S339MsktCXEOpIf8A6U6V0YTX93mqF0GOlGElvnrpYE19ncHEO7PTbZXt1UpgN3mKh8e
         raCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hw2/ohwzvhdDAwTeOPYmsLkFpaTkgjXMGVp6G44h3PI=;
        b=mzk5Ool06LbgLBjt66li6eyloNziEUglQR76Y4+2+vbRvOwpotGum3ZAMYUjbTHp1M
         Boj3m9AbzOy0wOvHZVPofI71XlatQMYemTVBPfIdRgwy/IjwFh2uADbm/qIdABmGFERd
         q/fWBocFivUBMbqiXd1Nhgest7QvVsm7iXCES82YsunlSLbIO5bL1bAM9i6IEhWzgV8Q
         p1VpL2T2CX4+4vOHbay+b2d70x1hkeICX2HRWGvXdpDOCCO7LjXsMBdwcqg4eFJhFb2l
         Jm4YeOC6SAvZahx8cpnqizURrVI5QPKAdT8jIP8kyx71lfcM8HyhnwCJe/w2vbWoJzYv
         2sfQ==
X-Gm-Message-State: ANhLgQ3RmTqrISZWL+CHvljQkmeygA7ZL5t0V+5mES/xbV5JwmuNuIbO
        p6+ypsyDzh3UYyme7d9KYHQ=
X-Google-Smtp-Source: ADFU+vtQPSS6AllqJvb5//lTd0+Eq5uJsrK3kd4PejlM7cu+aEmdFUqp0c8a4/FGUOtoiEAlGF165g==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr24543560wrv.178.1584962889945;
        Mon, 23 Mar 2020 04:28:09 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id s22sm19731666wmc.16.2020.03.23.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:28:09 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/vram-helper: remove unneeded #if defined/endif guards.
Date:   Mon, 23 Mar 2020 14:28:02 +0300
Message-Id: <20200323112802.228214-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded #if/#endif guards for checking whether the
CONFIG_DEBUG_FS option is set or not. If the option is not set, the
compiler optimizes the functions making the guards
unnecessary.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 76506bedac11..b3201a70cbfc 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1018,7 +1018,6 @@ static struct ttm_bo_driver bo_driver = {
  * struct drm_vram_mm
  */
 
-#if defined(CONFIG_DEBUG_FS)
 static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
@@ -1035,7 +1034,6 @@ static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
 static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
 	{ "vram-mm", drm_vram_mm_debugfs, 0, NULL },
 };
-#endif
 
 /**
  * drm_vram_mm_debugfs_init() - Register VRAM MM debugfs file.
@@ -1045,11 +1043,9 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
  */
 void drm_vram_mm_debugfs_init(struct drm_minor *minor)
 {
-#if defined(CONFIG_DEBUG_FS)
 	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
 				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
 				 minor->debugfs_root, minor);
-#endif
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
-- 
2.25.1


Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035FBC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA15E24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSe3q9tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgCJNcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgCJNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so15863129wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i55w1bVxWCBYrNCs6Ap1qrne/WI6lcBozrwzFpA28wU=;
        b=rSe3q9tpfbCKCB6fqEd/+P3YDIX/0/o9UZ16SeK2CJhEziJLQqOMwxnnB5dto3rZq6
         2078mhZ5G2G+iB0a9uv3YFfADnKEp7qkX1G9bZEm5ScJOg1uEp9RNv4Uo0ppQvPbeDJ8
         i2o3QGBjZU4VKzVu7xCbGXcPO1FAuJCHAwaQhxxvZqTRkJs1o2CKaDW1VmuM13cs1AoU
         GMurzUy5LyNzESX6JSjDwsFGPPC+vxSvtCzLAAlEDtDZDC2SDmACb4OyXslHlC4okF+m
         fDmIqNDplUNjmr5fBbWrzbAuodwcWN3F/EXQayeOmitHsIondSte8Hef8X7er14KvB/+
         gTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i55w1bVxWCBYrNCs6Ap1qrne/WI6lcBozrwzFpA28wU=;
        b=gZnwwqWcaPwdeNddG35+V2bI/QebQ0ywFO6wFVDiOz2Q3KINkxyYUXuE3uE6sgC65x
         cGUzLGabJCYm5+LWp0Q7pIFmRQJqN8mLQTjsxxFpiNVRmPAErSSxzmXyrn6kKxJ66mBj
         xExyCOZPMQ4Hq2HcAaEYu1GjmBgFc3aBPOlSA8J6R0IVgqha4gYZlbCjYXgcqxFBZ4Tz
         57Q1mjmLoMDihcPBClbA9mlhSPpVLDYihRogW2zXLxF0Jib8i7mTLJq25fhfr6X7iffp
         Bu8Kl64Dy9Ks0K355uJqoqtEamfydqjk0cV9eOxnRhRGRig3jm7Zl1gLMbN2cn6y9CwB
         6bZg==
X-Gm-Message-State: ANhLgQ2nB7A9Y+CQ7sLijyPTm/cAdfhO1AGuSyC55FGAWllNVu7ip4bw
        NgZg6rsa7TTbh7A40M1th64=
X-Google-Smtp-Source: ADFU+vvd3P42obAyeG9hj9PVietm9vqXI+l6PWyB/Zxfy3c+r03MXk6MveID056aUPNNr/qIcBrx0g==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr27915078wru.275.1583847113580;
        Tue, 10 Mar 2020 06:31:53 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:53 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 10/17] drm/vram-helper: make drm_vram_mm_debugfs_init() return 0
Date:   Tue, 10 Mar 2020 16:31:14 +0300
Message-Id: <20200310133121.27913-11-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of drm_vram_mm_debugfs_init(), and have the function
return 0 directly.

v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
introducing build issues and build breakage.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 92a11bb42365..c8bcc8609650 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
  */
 int drm_vram_mm_debugfs_init(struct drm_minor *minor)
 {
-	int ret = 0;
-
 #if defined(CONFIG_DEBUG_FS)
-	ret = drm_debugfs_create_files(drm_vram_mm_debugfs_list,
-				       ARRAY_SIZE(drm_vram_mm_debugfs_list),
-				       minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
+				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
+				 minor->debugfs_root, minor);
 #endif
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
-- 
2.25.1


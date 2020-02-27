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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01392C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F4E24698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZEyoBhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgB0MD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42057 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so2978429wre.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7k4B4xeoXs3YLBA2vMb2kP4DHWFb+LUmdU32fG0p8Mc=;
        b=QZEyoBhf8xr57XhiV03Vy8ZxmVUbKR9r6uCPvct92F6D/65KC81cqCQPh2hpjre2nI
         LbR26cUaunqkI669S3tJ1GQoWrYrvTl5rt+h8mPneCt7fJqnIxt70dgU6/NnYk7/1a2u
         IwYLF4KExObhKiCPoORcF1cWk/9dlVsXbj+/P1bbMp6IhCJkCt0/ysoV9jMYq40427t9
         bOu/xjm99LLTxI7Kq2NtVv1fsOwsv/TGnhgVj6305WrE1Dew0LQ+cTmqbd8CxiVwjIgA
         zIKQuY6EcjOaGRleuNN74LCNLhz1ycrUrRTChFMsswmBnDc37tVHVc5463zRaFaPc+bo
         AQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7k4B4xeoXs3YLBA2vMb2kP4DHWFb+LUmdU32fG0p8Mc=;
        b=hg3ABM3wPBlMLMpUSM6WlLTvf9DlfnN6QpBBVKSF44xIBY2Ug/601AI8xms9rfIO1h
         EUIHpdm6jZmUyzZBW4Z9BFl8qvHiWITmerwjmVnzKE7dKiICCC+kSeGPGAjR8OhSRys3
         vX6s/el7+fKzzrP7wLaC5ymwnlC1B662Ohz38n0VYpBDiAVQ5Zxi/Tzi8VPuSvI+31xQ
         gMIWI6e8cN9+WNLTUxd+iipwuiv92b/08f05zomsnNyZ47IGMiEzXZJ59vekcoBdLq3j
         1AQG6FfjAcwakWRO1qrqPtXKu7h62d0cfAN3eKrsrInWJ/dneHPAEm0d7a365w263oe4
         AYrA==
X-Gm-Message-State: APjAAAVe7YdfAafYLFrsKOz13innn401LMVJIzf/E+zKPGoaSnvOeQqh
        s1c7rpFGAkECiZYQbRzCiDM=
X-Google-Smtp-Source: APXvYqz4RLm66a87EsZNbGF1BxomQUXgmo4w1GxbZYBn9+p8SxoQwC1+zvR1dD3aqNATe3AZSeducQ==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr77920wrn.347.1582805006629;
        Thu, 27 Feb 2020 04:03:26 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:26 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/21] drm/v3d: make v3d_debugfs_init return void
Date:   Thu, 27 Feb 2020 15:02:22 +0300
Message-Id: <20200227120232.19413-12-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of v3d_debugfs_init and have the function return void
instead.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 8 ++++----
 drivers/gpu/drm/v3d/v3d_drv.h     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 9e953ce64ef7..2b0ea5f8febd 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -258,10 +258,10 @@ static const struct drm_info_list v3d_debugfs_list[] = {
 	{"bo_stats", v3d_debugfs_bo_stats, 0},
 };
 
-int
+void
 v3d_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(v3d_debugfs_list,
-					ARRAY_SIZE(v3d_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(v3d_debugfs_list,
+				 ARRAY_SIZE(v3d_debugfs_list),
+				 minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 9a35c555ec52..4dd4772f5f27 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -301,7 +301,7 @@ struct drm_gem_object *v3d_prime_import_sg_table(struct drm_device *dev,
 						 struct sg_table *sgt);
 
 /* v3d_debugfs.c */
-int v3d_debugfs_init(struct drm_minor *minor);
+void v3d_debugfs_init(struct drm_minor *minor);
 
 /* v3d_fence.c */
 extern const struct dma_fence_ops v3d_fence_ops;
-- 
2.25.0


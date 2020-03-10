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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C24C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADD724649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2me1s7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgCJNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37846 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgCJNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so15900611wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaPM+yiWV439Fzy3XUQMI+HGG8EtlsVxEFQ3vRRH5Sw=;
        b=d2me1s7ULKAeK9p/vgoO3AcVjguXJ5vlKgmzz9zC9aAMSeWOP8neMsZUfz8j6rxeSL
         j0tMmwOtvTdukiU9DOPwxcDKfLV0n4jGDAMfJIsxyn1ReQ5tlqrniSqALxtJxyVwWIKm
         vlKjhma9AKodVHEwzU6fylB+cfA8mqd7zoOeiPp4+dqRyDlSvPhdstaHzX63kX8H5uKI
         hG7W7HDZcCYNUf1zA4x/RkWJCsJZRvjwdDnHaZ4cpUy/u4jGeyqpHhsBaDAjCsnYNcAR
         4S+m5mxZr5mr6f173LPwq0EJtUE3j9RamfUoQ1/L2mbhXJzKpkcZGD/9waAix2mwoZOS
         0PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaPM+yiWV439Fzy3XUQMI+HGG8EtlsVxEFQ3vRRH5Sw=;
        b=kurYBjZ7Ojzt1d5341xiYpK6IRGf7+JWnuWas3Hj7jDrRPut1tHA043sVSxtiUPE3p
         Ai70epC8raQiX7zM66hlMLz3H8hF90oPsk/HC4clvRXtAV5oaqQRDZeeCGy0IMWwu/Hj
         ZMuJ86Oq86fnMtKn8/WQO8e6hfa9Vfe8DYQbBiGe/m3iEMTtrjlNfUxYpZthqb+2nm2U
         Fir4U/sdYYK6CWvuiKjqmKfipV9+dzRBt6DFg6NdenhUESEBy4hmUcEDcAxVNDORZvDd
         3lZN3DUPpasmpIUsqzVqVV9+hPeKmcJ8i6dOAzo+6qzqxXBULK6urSXzlIAa0gtYjl50
         q+Hw==
X-Gm-Message-State: ANhLgQ3l2L+ZNRB4E4C99xxoHpcPqrkCtDVfiQCw/25kxplmnLBB7AT/
        9P0L2Wd07ndBsvMwrpoyWpo=
X-Google-Smtp-Source: ADFU+vtdC9olA8aA5REHbKpSKnDb0SKFwajF9MLgrdWe0koIUgGX/xKjQpu1LgVvxHG4sAdJUqb7Sw==
X-Received: by 2002:adf:8501:: with SMTP id 1mr29342949wrh.56.1583847092674;
        Tue, 10 Mar 2020 06:31:32 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:31 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 02/17] drm/tilcdc: remove check for return value of debugfs functions.
Date:   Tue, 10 Mar 2020 16:31:06 +0300
Message-Id: <20200310133121.27913-3-wambui.karugax@gmail.com>
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
fails. Therefore, remove the check and error handling of the return
value of drm_debugfs_create_files() as it is not needed in
tilcdc_debugfs_init().

Also remove local variables that are not used after the changes.

v2: remove conversion of tilcdc_debugfs_init() to void to avoid build
breakage and enable individual compilation.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0791a0200cc3..3f7071eb9c78 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -480,24 +480,17 @@ static struct drm_info_list tilcdc_debugfs_list[] = {
 
 static int tilcdc_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
 	struct tilcdc_module *mod;
-	int ret;
 
-	ret = drm_debugfs_create_files(tilcdc_debugfs_list,
-			ARRAY_SIZE(tilcdc_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(tilcdc_debugfs_list,
+				 ARRAY_SIZE(tilcdc_debugfs_list),
+				 minor->debugfs_root, minor);
 
 	list_for_each_entry(mod, &module_list, list)
 		if (mod->funcs->debugfs_init)
 			mod->funcs->debugfs_init(mod, minor);
 
-	if (ret) {
-		dev_err(dev->dev, "could not install tilcdc_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.25.1


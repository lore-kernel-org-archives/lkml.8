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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48997C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2001324698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv+UeTqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgB0MDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2996277wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBk1mOoIZkyy9kqJiXLBO3UKN8y6Y0f/CztnD4P9tt4=;
        b=hv+UeTqhEqBHGOJ71CcKZK7jNNFHkqb8OREk/ICLS/IBO0ochCWX+7fYTynoHXyfrV
         XOkxQ06JhpmEmD4pze6CpmWcSmLyvWkmJvDaOYM0zAz3crWlm0NZvoS3pxLw1ClY8rTy
         Hj7vrv98j/kmDnErCzwPbHSbRMebWWANg5yV/7BHW/Ipc22cU+5pVJid6m9bG8gIRmNj
         A9fmYw1Rqejt/Dus6KooWECm4Re5iNeqJSy2EyI+YkEqemsP8htTpAxXenssNKJiqmD2
         s+TcvN8vNYANeMzyKNvdVpxVw4Rox1bcFNC6Qqq9xqmWnZXGw3+SkJPQnC2Lz7UfMxMV
         ksXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBk1mOoIZkyy9kqJiXLBO3UKN8y6Y0f/CztnD4P9tt4=;
        b=n/CzwTW8/b5FT/Vq2d72TpstgbpEmoi+eP8LP877hbmT194cQsdSAQIvUCEvKb2bTA
         F/LPISptk8+ZQ5zKHNb0KHDPLQMMyGpWCzdl3PO0hPQTQM9mnS5O6mgXV2eiPRWttchl
         qKYgiqwKGzlqpv9+ywV7XmdZaZlDmsQId4LaxEkIzn6WtNfHnDXhKeuKg/PE387UkjSQ
         cwwl7q+2TsB6xMsKQalMfXoGjThnUQhzXowpXIm3767gWezySUa4R8RpuFqbdfow+E5t
         4jmrD/QxnR8i4TnSXB8l0kwB2N2uuVseocVnU+Vq15uIf1uyqjeWB4AX1F8U0884JpXz
         6Wvw==
X-Gm-Message-State: APjAAAVM85ucuZoo9t9kaOv861tTjmVTU0j9KufYywXlp6K/DaN74Msf
        pDTVOHvo3g6ZJUDnMNUL+/E=
X-Google-Smtp-Source: APXvYqwHljKkgGdkShlOylDLJXesMCIatBDxUYDaXf8JUNo/KPQvR2rE6Fv76uPz2LtaEEmXpQ0exA==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr2687634wrq.301.1582804989529;
        Thu, 27 Feb 2020 04:03:09 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:09 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/21] drm/arm: make hdlcd_debugfs_init() return void
Date:   Thu, 27 Feb 2020 15:02:18 +0300
Message-Id: <20200227120232.19413-8-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail), drm_debugfs_create_files()
never fails, and should return void. Therefore, remove its use as a
return value in hdlcd_debugfs_init and have the latter function
return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 2e053815b54a..194419f47c5e 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -224,10 +224,11 @@ static struct drm_info_list hdlcd_debugfs_list[] = {
 	{ "clocks", hdlcd_show_pxlclock, 0 },
 };
 
-static int hdlcd_debugfs_init(struct drm_minor *minor)
+static void hdlcd_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(hdlcd_debugfs_list,
-		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
+	drm_debugfs_create_files(hdlcd_debugfs_list,
+				 ARRAY_SIZE(hdlcd_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
 
-- 
2.25.0


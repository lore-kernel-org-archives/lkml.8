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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE5C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7F024698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx2LFnuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgB0MDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33980 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so3036493wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/va7+F8irn0jXAyeut2JlQRX+et9as0O+Q8UR0d9EU=;
        b=Wx2LFnuM84ELcCVBI+fQsZSjh7OAQ2zWLmhPsZmeMoEGTYqS/ZVOQAMceU7fMMuifW
         iRWw/x5KEMneXJz2CVvUOE8YuMRwsO6hV4vXH/2e929QQ51klNhimRlF7j4QeFsLKYBS
         aCkov2QzKZm2cbU99uBdgTJDwV94BoKaUJtsEpM6CqDPahTcdZT4E7TLfkg3UWCTOYkG
         ZUBaJhPHvG9AldY6Z0PowTmpaAW1hwBTBOcbMlZ8Tqw7iM6mc6C97tdZdPsmRAcRZYwe
         Y4vx9zToGdo97CLUm0jJT2BwF0cG99iZTF1Eg9golfhZfi4yMZdYkSjSQc0cJUCSsx68
         JJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/va7+F8irn0jXAyeut2JlQRX+et9as0O+Q8UR0d9EU=;
        b=Uv/M0I1+1cQ/5ebNMyCld5zm3sHEbhaEWo/gXK0bInxitSXG4C+aGySterOO9fXC6C
         ckFAJKBx8hbpwz5pdq8menHeZID7dDT467FuSun604Ogv8W7CXOaH3X2SAQ+9HOjb+nZ
         IZVBm6mMGrFQaVKF55k/yz6d4x1683xdEg1/99lslyBnbSitJAxiAFbOnd/ihYrOX7+d
         fYdOWth0SxywNmWzSCnEFXxdDnRGVIqLRYfKrAQe3KZrSWxhl0OwkzUuASwGeWy/I8Gw
         0A3XBpo16vPCWHFL8INaVSkqLAiuowyEpNBSlY+yIR2huPfTol4XcRSqtc5QrnxZ8yjq
         S+RA==
X-Gm-Message-State: APjAAAX+ytg/JAMMoWqkbIwIPal3rj8a8w6xrxhVl+Q3iIu5kLk6Xhsk
        qhWHTMk5snzgg1VygdTjqn0=
X-Google-Smtp-Source: APXvYqz7QyLiZZ3viPcMv1W4f/pZTLGJ3nj6EoflfhAnaBTBu+uKHbrIVlh2oDh/yh4cCsiZZk0pdg==
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr4646817wrx.142.1582804985519;
        Thu, 27 Feb 2020 04:03:05 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:04 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Alexey Brodkin <abrodkin@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/21] drm/arc: make arcpgu_debugfs_init return void
Date:   Thu, 27 Feb 2020 15:02:17 +0300
Message-Id: <20200227120232.19413-7-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail), drm_debugfs_create_files never
fails and should return void. Therefore, remove its use as the
return value of arcpgu_debugfs_init and have the latter function also
return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arc/arcpgu_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index d6a6692db0ac..c05d001163e0 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -137,10 +137,11 @@ static struct drm_info_list arcpgu_debugfs_list[] = {
 	{ "clocks", arcpgu_show_pxlclock, 0 },
 };
 
-static int arcpgu_debugfs_init(struct drm_minor *minor)
+static void arcpgu_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(arcpgu_debugfs_list,
-		ARRAY_SIZE(arcpgu_debugfs_list), minor->debugfs_root, minor);
+	drm_debugfs_create_files(arcpgu_debugfs_list,
+				 ARRAY_SIZE(arcpgu_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
 
-- 
2.25.0


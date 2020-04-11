Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5EEC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533CC20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN0e9wGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgDKUGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:06:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40395 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDKUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:06:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so6004243wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/xeNUbJ170Rcks+8UPitiY+D8+oYUtGYjLPuwDIIMo=;
        b=pN0e9wGO3ZParlDyJdUgG4KPLkAkUE96VGull5/Xg47pWLrV50uqu0XeFtOOS9oB8u
         fBIvinRcku6msWIw7B/AMKi+0LCqk+Ns4xlEZamjwMFXLL9QSUDW6ytBAEZQBFXHI5on
         z8Yj6U87jwE6nEbVHCzuwVgNK1k2TmaslfzJYIkK46+OpDwXIl+zTYnk2Odcp632qAN6
         QjWwgMdKuIwQL2Dncj50HHxFaJDxiiub/Tgle6VEBEOpfymnW5vcLf4MDq1RetwkVVlt
         PErPBYXk+zMfMwQDtTZW4oaZ/T3FUPwZI8t9fpfUsYHO2XjvlOGkaNoKKsc03AN26rzo
         btaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/xeNUbJ170Rcks+8UPitiY+D8+oYUtGYjLPuwDIIMo=;
        b=ReG8L2v6AbBJ7DfoVC5UUiCVUQIwClRnS3MMr+vgSjTx+s5SW7zKST7uduEWDGCQPj
         8jkSgfnhRw7oTabp9/EyyT7eVX7WC9dT91eeBUiskVNXsQblwleTx8yfl8uR8e5DluqJ
         a9sI/HIiXFCq47ggD6jkjveYQcxVK7KPiMgpbD2qcScvYzZvitnrZwBpVqCxUzjr4LND
         6ESYEEsJyy0ZpFTl3aq80f0c9dLh96L0bDLeF9qBQ+gG9ki41GNUEOS901TRZLPu0t5O
         az1vkInMSzFGCF3ftYzPjOmE1kiYjUKGnLbT82LRTCZn7vkahZZzV5OhYxc99tnNs7vt
         PJRA==
X-Gm-Message-State: AGi0PuaUfOvQibufrsqJFngg2LO9WrJfUVo/hAUC67Bm9HcA9l4wF+2e
        6tOQ1St6Vn5wjVRMByPdHXmLw1vxRxg=
X-Google-Smtp-Source: APiQypJiMElfxuS7xS/9PX6Fd45JEGZqUGPugBtGCjW8LaAD3OS3TMVizEGgTcv3ItEf4SBPhSxUkQ==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr11698336wmb.4.1586635605589;
        Sat, 11 Apr 2020 13:06:45 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id y5sm8712670wru.15.2020.04.11.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 13:06:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/2] drm/panfrost: missing remove opp table in case of failure
Date:   Sat, 11 Apr 2020 22:06:31 +0200
Message-Id: <20200411200632.4045-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure we need to remove OPP table.

Use Linux classic error handling with goto usage.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..62541f4edd81 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -90,8 +90,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		DRM_DEV_ERROR(dev, "Failed to set recommended OPP\n");
+		ret = PTR_ERR(opp);
+		goto err_opp;
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -100,8 +103,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_opp;
 	}
 	pfdev->devfreq.devfreq = devfreq;
 
@@ -112,6 +115,11 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdev->devfreq.cooling = cooling;
 
 	return 0;
+
+err_opp:
+	dev_pm_opp_of_remove_table(dev);
+
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
-- 
2.20.1


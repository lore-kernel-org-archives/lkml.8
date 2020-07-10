Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2840CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E4720725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4GpAiyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGJJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGJJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A1C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so5202189wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=E4GpAiyV9Kyb/V4RrgUETUNMim7T52pdnh5of0wT32aNKAQaUi+JIRWLnDzExKxNyq
         VKUH/VcndndpMN9bWmH3hEjgkzT+U9/fbuoXIBpirjvAyI0PPU+8lVBC+QsHR3IIsHJM
         54igzG/UcACPfFVmTNQy/wf+f564p8xe4DRqxbmbvlRWfzhm3SwhN/n29TZZ3gvq/TFF
         fLuVUXpo57j1spIW/pCw2zxVYPG8kH2vWXayMTxZMlFnfxMuc3FogvPWTIT5W4aCCdGN
         oLwvcv+jgRvyAQGlEoHZKEkt8Pl1ucGWSglBh1w+ymY3qdVnU+i+ERot9zuu0mWPY+X6
         Mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=o6qkI/xlSw/SvrW5Cy20r1VvjI9UNIv0kCShIbVp0DbnTEb9C9WG8P7mxZ0odnRaYJ
         vWjrEmKNvJIIeukFXqCA2cX2S+qJlh53rRWCQHBLMaeOzapfquqJqH+KUVEyCAnufKdl
         XYi12OCpMyKNNeQoUJUFiA+UkfcOgU7FZekNFs9uE3YjVwPh1hPcP28xJdsZB7TPR75j
         CZ/4CcuXPeG3STOKxf9IwSB1PJsoycfA9n0hlaj5tcsIXGF/pB3lEFcrlT+Qp11ZRq9J
         f1N7pFyPRpWWD9545IBxM0EyKytI9kIqnl/I5Nm8iFcMl+WVuN3u3Ja98KdrKjFHskVg
         R9sw==
X-Gm-Message-State: AOAM532XyLxnANVExHJYwIYzkO9DV6Ch2NeW8FSzil0Oi2Exff1hsGCL
        Qv0OnXdCDSD8lCN0ZOlO9qo=
X-Google-Smtp-Source: ABdhPJyHhHpFVP4toqlpGZIZenUeHlbbfH+Vx2+9lkZq5JZNpCl8/ymXw8F6Ur9NnenathGSw5dnLA==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr72021659wrr.226.1594373159795;
        Fri, 10 Jul 2020 02:25:59 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:25:59 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 06/14] drm/panfrost: properly handle error in probe
Date:   Fri, 10 Jul 2020 11:25:40 +0200
Message-Id: <20200710092548.316054-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a boolean to know if opp table has been added.

With this, we can call panfrost_devfreq_fini() in case of error
and release what has been initialised.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 25 ++++++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 78753cfb59fb..d9007f44b772 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -101,6 +101,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return 0;
 	else if (ret)
 		return ret;
+	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
 
@@ -109,8 +110,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto err_fini;
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -119,8 +122,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_fini;
 	}
 	pfdevfreq->devfreq = devfreq;
 
@@ -131,15 +134,25 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdevfreq->cooling = cooling;
 
 	return 0;
+
+err_fini:
+	panfrost_devfreq_fini(pfdev);
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	if (pfdevfreq->cooling)
+	if (pfdevfreq->cooling) {
 		devfreq_cooling_unregister(pfdevfreq->cooling);
-	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->cooling = NULL;
+	}
+
+	if (pfdevfreq->opp_of_table_added) {
+		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->opp_of_table_added = false;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 3392df1020be..210269944687 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -15,6 +15,7 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	bool opp_of_table_added;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.25.1


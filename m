Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2352EC54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF14620820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWFCvxF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgEJQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729190AbgEJQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7832C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so6733873wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhYrh9YhlYXknPmBF+ROBsUhxioXF1DIWp34Pf3t1c4=;
        b=uWFCvxF1Ru/RGFcBDvfix2QN6IlvVfJ0XwlpC94V8PK8wf0/7u9FsV9Hx59AqRdgiD
         Zw5rG2gT0hrmXdzL9Wg8t+sIcXdaqmOM32JJEHmBFvhpSNeixDE0AZjR/ftWAwdxBnuc
         aIQzdHgHrQndEauKrELV33RiLhbUzIf5x510r+vtym5PmJpiegUFiSa4oAGXxODnLPzZ
         l2bJ1CVPNeilrCg1fi7i15n3+5YWtXJXjdaJqrRbuiaS52d/M88E6na9EVQbeFODrbtG
         Bno5L3b+KxhcdlT3+RqwJvqxZUJwg94bkW10lihfmyKjNI2I5QFjGZwTi46B08UiNs8I
         Nqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhYrh9YhlYXknPmBF+ROBsUhxioXF1DIWp34Pf3t1c4=;
        b=UOD2gqahbZpVxi02Dxn0hyTPIrlcQuAc81HFHYsbLDcmogcly+SCRtzAANwsKvskeg
         lm31H0heiQEA686FqqNk7xDiZ3jPHEYVQyyW4BdhUqP65dJP9TrmyzxMiWIcCXhnduq9
         cFfbpR3Ra9hKx7jkQmc6kPY7L0ta0Eac5XD5oyx/gcVrRMPaFn5TOqRCS9hONk4mrvCM
         +cHe0+JPWVj4q1rdNDYOtA2Qjw0y68LsfHU1jnNU3ANCk1JPdkVStvPAVCiV9uu2HQny
         bpnlGmNH9JhBR1bJY6rHaOQXIELOE5PQBxOwlufM6+6gFpjsadNXxGXOJkJB1SWRDlVd
         wgFQ==
X-Gm-Message-State: AGi0PuYGDmMMT3WrsZnJUjJZRmsrsbYAJfOZcoF97MD6b3VVozq8/dDL
        z9sVrRrEwrPUQlt7OY4RVG4=
X-Google-Smtp-Source: APiQypKjmziT9fWp0qUklBNq8R4p9Hwvegfvv4DkG4skFkpovhpchfUnzNa2oCnZERscnArbLvpCnw==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr26041414wmc.76.1589129748553;
        Sun, 10 May 2020 09:55:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:47 -0700 (PDT)
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
Subject: [PATCH 06/15] drm/panfrost: properly handle error in probe
Date:   Sun, 10 May 2020 18:55:29 +0200
Message-Id: <20200510165538.19720-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
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
index e6629900a618..add203cb00c2 100644
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
2.20.1


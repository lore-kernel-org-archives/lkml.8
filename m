Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7996D2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruCs9b9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFNG4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:56:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F53C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:56:19 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c75so12456224ila.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TpliVuQU/7sLPsVM57NGaPTp0yUaPg8e9YE17AlDXcs=;
        b=ruCs9b9YlQlECerNcDTwY4ZAksDlHdq9kuYVhDkV1NCpUcGPSMcisPqw3OyZY3+xSC
         NLssw50CcD5BMG8oXmMvOPUqfMBZLjAKU0hslN8gofADZ7S9K2U0cq9taQRBjgKNYxIb
         D8NpUHWPP45WH/HDRaGr2larfLEPRyJ+ymOBgAMFwztfX5iDrwrV9YZkBAaAgDwBHyPB
         A1klb/6XOXwF84xLfHqjWEvTFKKP6nRAp/eIowms/lN31Wi6bdyMH2nBbz2OvbCtGJw4
         TExRz7f+x1Co/KwqSzmIMSa1ruWhttvhNsmXAGBoLh/QA70RNUuAFpo4+1QzBt0sOg4Q
         OtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TpliVuQU/7sLPsVM57NGaPTp0yUaPg8e9YE17AlDXcs=;
        b=DBoiVEhpPatEt9TeZGCL1s2mg/f50JOhEw4ZN5xS15DunSGsczagxzXKg+rZgRYpz6
         XTpdlrZ3vfNNMQYTUIxUox+W6tRsZBgBypdho9I0XxG4L3SvnAD6V8j1XbA9CyN9Dm2z
         N0QbJes3vo3k9l07srn1ZTts3xH+cQaIVnWX8g6vegX1JhKCDX7HIE5bKvNPKAoeFIbv
         8zFYiQ93DM7HAQzvV2vIomltrU8rfypsZYgmmXC+CDnosAz6Jh3Z87oR1a9oIhEwidet
         QA2v8PpvA2WtuPdI91uhZQy1dYlz6P+9goxTdedkR0R1TFNpxtNUTT7L0dfZRATTO2ha
         n2pQ==
X-Gm-Message-State: AOAM533voDfhLDS0ZDC+YAsLua2jD9stNezGSS8mflHPsOmwLaGUhzCI
        r8bZBIEQqED5gM3h68WCa/GN1yGfzhM=
X-Google-Smtp-Source: ABdhPJzCzdSi2+fMwP6dLfmzzHIJihb+qkY/Q1cEa56HUaaAiTm+jtNydLieCm1FcWQT0NimzorZ5Q==
X-Received: by 2002:a92:8b0a:: with SMTP id i10mr19990532ild.245.1592117778866;
        Sat, 13 Jun 2020 23:56:18 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id c20sm5823570iot.33.2020.06.13.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:56:18 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/vc4: fix ref count leak in vc4_v3d_pm_get
Date:   Sun, 14 Jun 2020 01:56:11 -0500
Message-Id: <20200614065611.69502-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vc4_v3d_pm_get, the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index cea77a21b205..bb03c1d1bb4d 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -135,6 +135,7 @@ vc4_v3d_pm_get(struct vc4_dev *vc4)
 
 		if (ret < 0) {
 			vc4->power_refcount--;
+			pm_runtime_put(&vc4->v3d->pdev->dev);
 			mutex_unlock(&vc4->power_lock);
 			return ret;
 		}
-- 
2.17.1


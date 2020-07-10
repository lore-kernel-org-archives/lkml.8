Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C133C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4303B206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Et6Dk9C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGJXCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGJXCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:02:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E125C08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so2832237pld.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVqx7g36rFA8fGH9HPQE1NOw2DZAuX6VKaMN/UQGYmk=;
        b=Et6Dk9C0ZAXRSSAVBOeYyozI3Jj+uhoeW1ZrbIn4h7Zhux2W8tHEXkW2/mrDbKQZqL
         Uvg6xpKFBy1wu6a4o5ZQrtYyfcgypwjH2LJNmsuaN5NHupqledwdyeX8dcn770r3gX2g
         hlziyVRNx3N8dW2y2fAPskxRWpjbeRquFS9fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVqx7g36rFA8fGH9HPQE1NOw2DZAuX6VKaMN/UQGYmk=;
        b=b/h8o1yXOvolpkfv5lg4ShBBnVYliUimU2mbBI4lKUYxe3AJwpPOtjCauulWi20ucM
         jXYf5VSR1ZChnFbXavK9ALeU4c+Mpms2lSZoBsxCR/Vo3UdNrCV8LI5ENwRFXHFkohzY
         7kGDL3+Iha/ZWJApRWd8Uc7ZbbW3HiqTXfuc/TYy65ptVIXKXUWSI9GzhYC4nTj6TgEw
         7C5uG8sAOjZSURBmmOINaVZHm7KvzjC6uEqmoNK8eE9Kpypsos62iHwGePgWiUx8H5F8
         T+OG+lyumGGjhZkHUo3Qm8vPsQsdCkPnxk5qLlUl4D/TFk9cb6FGwBPC7XT62/BNe18K
         6X3Q==
X-Gm-Message-State: AOAM53372X8DSom1tI8YzbDPh2KboIt149vRhZ9c1KgIqnpsceoZXT4+
        q27L0q2ueJhKQq6775TtKTNmOw==
X-Google-Smtp-Source: ABdhPJw4NYcILGIGbzu/Mo7t5i5bNT/aUinQfG5IFKgb6SVXfZdHoKdaoadkxhHDmq9STiHl74UbJg==
X-Received: by 2002:a17:902:d215:: with SMTP id t21mr40582652ply.136.1594422169822;
        Fri, 10 Jul 2020 16:02:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id my9sm7266836pjb.44.2020.07.10.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:02:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] drm/msm: Avoid manually populating our children if "simple-bus" is there
Date:   Fri, 10 Jul 2020 16:02:19 -0700
Message-Id: <20200710160131.4.I358ea82de218ea5f4406572ade23f5e121297555@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200710230224.2265647-1-dianders@chromium.org>
References: <20200710230224.2265647-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If our compatible string has "simple-bus" at the end of it then the
system will handle probing our children for us.  Doing this has a few
advantages:

1. If we defer we don't have to keep probing / removing our children
   which should speed up boot.  The system just probes them once.

2. It fixes a problem where we could get into a big loop where we'd
   have:
   - msm_pdev_probe() is called.
   - msm_pdev_probe() registers drivers.  Registering drivers kicks
     off processing of probe deferrals.
   - component_master_add_with_match() could return -EPROBE_DEFER.
     making msm_pdev_probe() return -EPROBE_DEFER.
   - When msm_pdev_probe() returned the processing of probe deferrals
     happens.
   - Loop back to the start.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 78b09fde9e29..f7c6ef147095 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1208,10 +1208,18 @@ static int add_display_components(struct device *dev,
 	if (of_device_is_compatible(dev->of_node, "qcom,mdss") ||
 	    of_device_is_compatible(dev->of_node, "qcom,sdm845-mdss") ||
 	    of_device_is_compatible(dev->of_node, "qcom,sc7180-mdss")) {
-		ret = devm_of_platform_populate(dev);
-		if (ret) {
-			DRM_DEV_ERROR(dev, "failed to populate children devices\n");
-			return ret;
+		/*
+		 * Old device tree files didn't include "simple-bus"
+		 * in their compatible string so we had to manually pouplate
+		 * our children.  When existing device trees are fixed this
+		 * can be removed.
+		 */
+		if (!of_device_is_compatible(dev->of_node, "simple-bus")) {
+			ret = devm_of_platform_populate(dev);
+			if (ret) {
+				DRM_DEV_ERROR(dev, "failed to populate children devices\n");
+				return ret;
+			}
 		}
 
 		mdp_dev = device_find_child(dev, NULL, compare_name_mdp);
-- 
2.27.0.383.g050319c2ae-goog


Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752FBC52D5B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C302535B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="ViyTBUKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIDRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIDRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:30:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341FC061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 10:30:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so7000077qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qMG1ps8fgPCdKYmX4D9C0vTU0mM7NukKZP7s8FwwQlE=;
        b=ViyTBUKFruXN0VnmAsL8NgjxNce0CorHAmM5BdC1GhOcVAdeJNLMUmWeG2CnKftulb
         FXUGbhhHvbRj0kchEEER/Eb9W2ilBzfHXqxWlpHzRHrvZE/4W9syeqz4vRreMGIBOXL6
         msJsqURCahbJJZF6/2RDY/mhTzUH37BFK1kiYBealqQj/75yX0xAWMBOMD/Qd1yIT0Ci
         mrvaCfUqs6QnP6V+lx6q9Ff1yg9E2hJfBCrFYHViAlbVVe4EB6B5UnpEd0E8NlRnITpQ
         xWLdRmubcwWeXUGu28zFiqNI606wGvyaWuOO/K8A1fjjVKqssVvNOfnwF5DaW03GWGcA
         C5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qMG1ps8fgPCdKYmX4D9C0vTU0mM7NukKZP7s8FwwQlE=;
        b=t+1phTYpOXYvee7ApGgCVt6uYVvKf5QSOnIjecxB3i00HEOejA3SN54/O+B1cvuyLU
         t4wjtyGdafF5zRCEgTanjJrEJavfcDZJCzetArww9AxcjKFwQhfBlD7J/X4s49O4Ucou
         1cwpUTmESWL/FHUoXT8DD65mVAR7N3nbU8uVHo2YqcqxbAtrGRKvYPwxu0BT+CtE7y3l
         bUsMDMuDZ5V5covHJl523+yuFh4I37YRGKV4nasENYdBu1efFfocTosQ52fmNIajxuYg
         qTaU2ae41Yrf4utBWTgMLXJV5CwGVSOx2hXBzu09B+v8rr39Sxb+9kliqgm7uCZ1XcUH
         2FpA==
X-Gm-Message-State: AOAM5312LMlH61850fN4kNtiBWQABKJCICGXjCSWBBVSYWEV1mAZ3C/j
        fnyO74Clra/vN135NHZ3lJF7MA==
X-Google-Smtp-Source: ABdhPJx58g/vQxNQERfeujwhlruc479tT6x7SVFypiBtCQJtMohP5A6VeGR8kjgBFY56JBEQXbOpDA==
X-Received: by 2002:a37:2cc1:: with SMTP id s184mr9064820qkh.357.1599240605934;
        Fri, 04 Sep 2020 10:30:05 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id i66sm5103330qkc.63.2020.09.04.10.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:30:05 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konradybcio@gmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/msm/dsi: remove unused clk_pre/clk_post in msm_dsi_dphy_timing
Date:   Fri,  4 Sep 2020 13:28:36 -0400
Message-Id: <20200904172859.25633-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904172859.25633-1-jonathan@marek.ca>
References: <20200904172859.25633-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_pre/clk_post values in shared_timings are used instead, and these
are unused.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index ef8672d7b123..886a9e3b44b5 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -50,8 +50,6 @@ extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
 
 struct msm_dsi_dphy_timing {
-	u32 clk_pre;
-	u32 clk_post;
 	u32 clk_zero;
 	u32 clk_trail;
 	u32 clk_prepare;
-- 
2.26.1


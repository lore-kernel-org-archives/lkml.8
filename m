Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D6208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxVEiKnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgESJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:03:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10501C061A0C;
        Tue, 19 May 2020 02:03:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so6219698pfy.8;
        Tue, 19 May 2020 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g7l8f0Zv5HCPiGiqrR0/5unpKCy3N2qumpqSQ5QZRv0=;
        b=gxVEiKnOHOpzOMXUCO9AgTFR22gtEofog93jxkLur8uXfyuNpzgdZgCu3EOHfO9WOd
         0cL7wt4UUibv9MBJafxdPTHN/RfQoO4vj/YedXi8+hmwEoSmkuzzJJoFKLBuKCSc4BrS
         yPTZjpa6RBovbwSNwyowJyjwwyk/tcLCs41eLCAB6iuD/o2z1RlRZ63TtXtAYlGMvgFc
         quh0GXOlj/vK+QcvBfttYKm6KlfCECFdW/lIoSlNDFy4srlxabF0n3c7efj2p1V/YZyb
         Lx/WtWN5LPn/l74DI721wUsRc62KfXTbuIspRtQTL3Ez/foiRnn2u40HnRmnXv1g7lki
         Q4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g7l8f0Zv5HCPiGiqrR0/5unpKCy3N2qumpqSQ5QZRv0=;
        b=evw/Akxro/w5EUyJBHfD6LYH+0xOAwBP8xx66dQeQXL1rpN+8kx+qbTBTkMeFsFIVB
         OLBcqNyduZ+yU4otXUqhdKbiDLgXgHg7qEQsnzzRxeBGiVZNhKLcPGyIgRYf4bEfL2rn
         ZtF82mv+MCXuikuv8YWDhOi2F2zzxfVkGvrYI/CCifHeXhvquPnKh+/Vm36v7GGTuv1g
         lH2Acl8jZoUpUMD5luX/XP44UPVTs3iRdSfBktP6DfPEVMJURm85kLRzUUyXXeHjTBIq
         e8z7uY2Ovv8BgVenupcFKpygS+7wKT99J9lUNSv42dLS9GiSVf2BVbykGACxEcyYXmgI
         R63A==
X-Gm-Message-State: AOAM530Q8s0UG1npE5eerTBln2BqfpjO6cHNYpJ7u2XoPaxiHdytXfP8
        SEl8KoVudWGLcQIRA1013T24qoD5lVM=
X-Google-Smtp-Source: ABdhPJzb0ZYQ3HiDvsOVxjLFhTBa2u5r+klKCMhULaQYcLI8QEUl5NNR9NwoIW5wXqC85Fj8q6UQGw==
X-Received: by 2002:aa7:8c53:: with SMTP id e19mr16678053pfd.264.1589878984490;
        Tue, 19 May 2020 02:03:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id i128sm10843094pfc.149.2020.05.19.02.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 02:03:04 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: hub: Do not enable orphaned window group
Date:   Tue, 19 May 2020 02:03:01 -0700
Message-Id: <20200519090301.32689-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the unconditional enable/disable code is not a final solution,
we don't want to run into a NULL pointer situation when window group
doesn't link to its DC parent if the DC is disabled in Device Tree.

So this patch simply adds a check to make sure that window group has
a valid parent before running into tegra_windowgroup_enable/disable.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/gpu/drm/tegra/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 8183e617bf6b..a2ef8f218d4e 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -149,7 +149,9 @@ int tegra_display_hub_prepare(struct tegra_display_hub *hub)
 	for (i = 0; i < hub->soc->num_wgrps; i++) {
 		struct tegra_windowgroup *wgrp = &hub->wgrps[i];
 
-		tegra_windowgroup_enable(wgrp);
+		/* Skip orphaned window group whose parent DC is disabled */
+		if (wgrp->parent)
+			tegra_windowgroup_enable(wgrp);
 	}
 
 	return 0;
@@ -166,7 +168,9 @@ void tegra_display_hub_cleanup(struct tegra_display_hub *hub)
 	for (i = 0; i < hub->soc->num_wgrps; i++) {
 		struct tegra_windowgroup *wgrp = &hub->wgrps[i];
 
-		tegra_windowgroup_disable(wgrp);
+		/* Skip orphaned window group whose parent DC is disabled */
+		if (wgrp->parent)
+			tegra_windowgroup_disable(wgrp);
 	}
 }
 
-- 
2.17.1


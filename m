Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78555C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A0521D80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579261;
	bh=vqpwzmqgPum7xJcl5MJ2NPLpxEZEaPhP2tB5CEtYRks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMZH/6nxQjSCSQzWAzSRhwe+eUNqwqAeAD8ZRy6CrdPtRB4JJTRDXnL7JahVjRiFP
	 qokwJUTCepxbExDhhQDhpwyz7zDaMlO+mWg4wgBWiD+W1dHyGjDx+pjM0dPbVqpCz9
	 dsff3W4Ipl+9DXVgTqP6QT00j+IO/x07PBcla23E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbgFSPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391568AbgFSPHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5502B21852;
        Fri, 19 Jun 2020 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579239;
        bh=vqpwzmqgPum7xJcl5MJ2NPLpxEZEaPhP2tB5CEtYRks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8TNzrjbMaWqigsHg47Z5cFmeyEwue9i/GIl3KHkNJiRtiSdEJtAP8jsiBrGrrp1E
         W577vesSiFZIEgjHElqIAADz1xYa/7x7H4zbTfubsE9sAeO9wGxjfoEBLoAR19ma1E
         7RXyHMw8P8sow0JjX+VrANc947I5/LoppImyZfDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihito Ogawa <yoshihito.ogawa.kc@renesas.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Tomohito Esaki <etom@igel.co.jp>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Stone <daniels@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/261] drm: rcar-du: Set primary plane zpos immutably at initializing
Date:   Fri, 19 Jun 2020 16:30:41 +0200
Message-Id: <20200619141651.356834624@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomohito Esaki <etom@igel.co.jp>

[ Upstream commit 7982471d01aac33994276bf567c8f1f3a137648a ]

According to drm_plane_create_zpos_property() function documentation,
all planes zpos range should be set if zpos property is supported.
However, the rcar-du driver didn't set primary plane zpos range. Since
the primary plane's zpos is fixed, set it immutably.

Reported-by: Yoshihito Ogawa <yoshihito.ogawa.kc@renesas.com>
Reported-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
[Turn continue into if ... else ...]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 16 +++++++++-------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c   | 14 ++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index c6430027169f..a0021fc25b27 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -785,13 +785,15 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 
 		drm_plane_create_alpha_property(&plane->plane);
 
-		if (type == DRM_PLANE_TYPE_PRIMARY)
-			continue;
-
-		drm_object_attach_property(&plane->plane.base,
-					   rcdu->props.colorkey,
-					   RCAR_DU_COLORKEY_NONE);
-		drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
+		if (type == DRM_PLANE_TYPE_PRIMARY) {
+			drm_plane_create_zpos_immutable_property(&plane->plane,
+								 0);
+		} else {
+			drm_object_attach_property(&plane->plane.base,
+						   rcdu->props.colorkey,
+						   RCAR_DU_COLORKEY_NONE);
+			drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 5e4faf258c31..f1a81c9b184d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -392,12 +392,14 @@ int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 		drm_plane_helper_add(&plane->plane,
 				     &rcar_du_vsp_plane_helper_funcs);
 
-		if (type == DRM_PLANE_TYPE_PRIMARY)
-			continue;
-
-		drm_plane_create_alpha_property(&plane->plane);
-		drm_plane_create_zpos_property(&plane->plane, 1, 1,
-					       vsp->num_planes - 1);
+		if (type == DRM_PLANE_TYPE_PRIMARY) {
+			drm_plane_create_zpos_immutable_property(&plane->plane,
+								 0);
+		} else {
+			drm_plane_create_alpha_property(&plane->plane);
+			drm_plane_create_zpos_property(&plane->plane, 1, 1,
+						       vsp->num_planes - 1);
+		}
 	}
 
 	return 0;
-- 
2.25.1




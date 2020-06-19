Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C75C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B8720809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582205;
	bh=URSM4OVSd3VdBQHRpH5PXvzyY3qrWEOKrHQAtea9Itk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nk/lzw5CqZDOxglR0wK8yGTWeW6XdFs2m6txhY9GNKLbquLpz5I9FwZq4PaaK9WFY
	 Gy7FOxuHP8NtkfFuSe3COuxhLzs/ppiB7FU3yPxEQjhGK4iFxuaW1ZmwV4BgIRn1vf
	 WA4bQbLDzguATcQykeVYg+wcA6gTCFt9UiBRLu8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392764AbgFSPUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392587AbgFSPS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8FC2080C;
        Fri, 19 Jun 2020 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579905;
        bh=URSM4OVSd3VdBQHRpH5PXvzyY3qrWEOKrHQAtea9Itk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omDlNQiBcmpbgyqfbduXfWFTyiFwLbUcIT+Bo+siAJk0YPjX3OAJbGZS2FVBPv9WW
         2WtSxL7rqIrbo8FEjiEf06PsZ/QTE2orlg1CSRMyVOawaEOzsLV+2+BRTGqYIP2U6+
         5ICjceHfDK6j5xG5ouVAPNVh0bJIXEbpT+MmdfTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 018/376] drm/bridge: panel: Return always an error pointer in drm_panel_bridge_add()
Date:   Fri, 19 Jun 2020 16:28:56 +0200
Message-Id: <20200619141711.233125652@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[ Upstream commit 30be3031087139061de4421bf52015931eaab569 ]

Since commit 89958b7cd955 ("drm/bridge: panel: Infer connector type from
panel by default"), drm_panel_bridge_add() and their variants can return
NULL and an error pointer. This is fine but none of the actual users of
the API are checking for the NULL value. Instead of change all the
users, seems reasonable to return an error pointer instead. So change
the returned value for those functions when the connector type is unknown.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200416210654.2468805-1-enric.balletbo@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/panel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 8461ee8304ba..7a3df0f319f3 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -166,7 +166,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
  *
  * The connector type is set to @panel->connector_type, which must be set to a
  * known type. Calling this function with a panel whose connector type is
- * DRM_MODE_CONNECTOR_Unknown will return NULL.
+ * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
  *
  * See devm_drm_panel_bridge_add() for an automatically managed version of this
  * function.
@@ -174,7 +174,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
 {
 	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return drm_panel_bridge_add_typed(panel, panel->connector_type);
 }
@@ -265,7 +265,7 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel)
 {
 	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return devm_drm_panel_bridge_add_typed(dev, panel,
 					       panel->connector_type);
-- 
2.25.1




Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA55C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ED920801
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657622;
	bh=URSM4OVSd3VdBQHRpH5PXvzyY3qrWEOKrHQAtea9Itk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wOw7g/S5YDWT0dkUFEn+PC3C96CZ0sV65c9ePl1XbOyN00iUrKXShM3bDP5u1hqrz
	 zbXX/xrifLIJUZgw3YUOYBX9h9A2a2N4CxWJBIF4abattBrbm29t4r3j+WcVK2KoOy
	 GqPbNCxJdANhG3CxQuHY42Bib3+kHm5rMrbMxgs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgFHXG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgFHXGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542F02076C;
        Mon,  8 Jun 2020 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657593;
        bh=URSM4OVSd3VdBQHRpH5PXvzyY3qrWEOKrHQAtea9Itk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXHZGou2DqBTPFsVuY9HKXlHWZI4PBVsyeu6721ZO61faGWNpMRl1Z0fx4cSidQF4
         TLvkYWZsqf+59prx3C6SLFxYbS0mkU0J0q8tY80j4Uo8KCn/sgUmSrq7fFDlipHLxh
         YkjifqmuTae5/xkopQhEJ3Nv3bvpUqSOEPH2YjGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 020/274] drm/bridge: panel: Return always an error pointer in drm_panel_bridge_add()
Date:   Mon,  8 Jun 2020 19:01:53 -0400
Message-Id: <20200608230607.3361041-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


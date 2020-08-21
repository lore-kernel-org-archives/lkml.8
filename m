Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1487820732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028485;
	bh=fH37D9OBwg8FmwnXoMpWvRvm003f6JYQBo7oh5pvM90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ur5VlmaNvEOyuC+VFoRjBH5PyDUNDM9YwoQTVbEGRBZrc0wlsl8CZH3agbzN4W8hv
	 uJwt2k6F4DeLJ3QDyDW4aIdSoPhMbaYrBvLnKkxI7SDAvLRMZVeYAcvvUbrU3reElh
	 30Nm6aEL/TWmz7A/iAbruxP1Q2tauAHqy8EreU4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgHUQsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgHUQUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABAD2063A;
        Fri, 21 Aug 2020 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026770;
        bh=fH37D9OBwg8FmwnXoMpWvRvm003f6JYQBo7oh5pvM90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZty6JKPgjfA4jYH4s0REebV8bUjtHCzbXDqY1MkNh3AvoCnf/hmiV8vWsVz3rCT+
         KMSCEBiRoHstgsUe5GMdbxMUucHrAkE5JHLn0QKK2mUffDUtVuzkubEVgbmsh17LCC
         zuhXbYwbeo4ep95H9tORHCagpjkHkEW6mmGkgFkk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 25/30] drm/nouveau: Fix reference count leak in nouveau_connector_detect
Date:   Fri, 21 Aug 2020 12:18:52 -0400
Message-Id: <20200821161857.348955-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161857.348955-1-sashal@kernel.org>
References: <20200821161857.348955-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 990a1162986e8eff7ca18cc5a0e03b4304392ae2 ]

nouveau_connector_detect() calls pm_runtime_get_sync and in turn
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4a7d50a96d36f..b5c8219c54557 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -580,8 +580,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		pm_runtime_get_noresume(dev->dev);
 	} else {
 		ret = pm_runtime_get_sync(dev->dev);
-		if (ret < 0 && ret != -EACCES)
+		if (ret < 0 && ret != -EACCES) {
+			pm_runtime_put_autosuspend(dev->dev);
 			return conn_status;
+		}
 	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
-- 
2.25.1


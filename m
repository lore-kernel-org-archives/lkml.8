Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C0FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FFC20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598027611;
	bh=zby1bdyNKvlbw/2B9KxrATkPOOQOOknxZ7Nnr25BQoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lfKIsU9jlcmBHY3tbIQBNG4JTBXiIgnA3c+Ou3rEqYb9R8oe5Zc4RHP1ceDi3ipBa
	 wUIjt5L4IYRCh6F+/rMQxzVq5Ms4Y07rM1jKOLPkPsa+GiUSUqiKthhmPZNDOPTZir
	 LaUBT+Xd9BdgtJAfJe3uFmO1HcDzewpacWLAOkQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHUQd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgHUQVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:21:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE03022B43;
        Fri, 21 Aug 2020 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026836;
        bh=zby1bdyNKvlbw/2B9KxrATkPOOQOOknxZ7Nnr25BQoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bnt/3PY9fgtfrcEp0VuygvKFQKf3ybaPP1aTxu4KEkw9UJzyykmI0X7NNkOZL6Zbj
         Ice57Wl/jWYxA7g0g+5B0rCutvAS/pW0qqrcsjZFkccTGGO6UmWOMqQFzGvNZWoQo3
         emmkNEPojD92CfK/4BSxcRfhij0GZC5TjTJJ3400=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 17/22] drm/nouveau: Fix reference count leak in nouveau_connector_detect
Date:   Fri, 21 Aug 2020 12:20:09 -0400
Message-Id: <20200821162014.349506-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821162014.349506-1-sashal@kernel.org>
References: <20200821162014.349506-1-sashal@kernel.org>
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
index 1855b475cc0b2..42be04813b682 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -263,8 +263,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
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


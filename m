Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C931C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BEA20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195045;
	bh=xGHnJJY+BV9qDsMFCRqzWR3Up/3LkBWtMjq6L/G3SSc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Fhwv/BYX5Klj16hsQ/0vIBcgvOq1ejJ9hp6t4/hvEy8eP0X85gqiBEe6798/MV6KB
	 yF4hZHGZpw6/U24Bx/kVPtKYkWOAEG25nDkDhN+9cjc4IAWk7knw3/FhOVaFsal7U+
	 b1Of7eL16LXYFGBgF8s8NbwPNXOo1OW9Bg3vDpwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391189AbgAPRRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgAPRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A34EC20730;
        Thu, 16 Jan 2020 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195041;
        bh=xGHnJJY+BV9qDsMFCRqzWR3Up/3LkBWtMjq6L/G3SSc=;
        h=From:To:Cc:Subject:Date:From;
        b=yFA1mMRvNd2QJEY77D2q4uBRNonZ/XgUMC181/uK0EWAWkHjMpSrz1chzxRAPt1V1
         YDe5k5/WqDTKefONqHr2auYFmBY71RAmOXIXb14TetXBlzZA2lG0sHdsXgYXAhonQN
         Ve4kUHFx1XIusfekClU6huHJVGGXc12vI/J7hUKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 001/371] drm/sti: do not remove the drm_bridge that was never added
Date:   Thu, 16 Jan 2020 12:11:09 -0500
Message-Id: <20200116171719.16965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 66e31a72dc38543b2d9d1ce267dc78ba9beebcfd ]

Removing the drm_bridge_remove call should avoid a NULL dereference
during list processing in drm_bridge_remove if the error path is ever
taken.

The more natural approach would perhaps be to add a drm_bridge_add,
but there are several other bridges that never call drm_bridge_add.
Just removing the drm_bridge_remove is the easier fix.

Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180806061910.29914-2-peda@axentia.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sti/sti_hda.c  | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index cf65e32b5090..0399bb18d387 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 30f02d2fdd03..bbb195a92e93 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1314,7 +1314,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	hdmi->drm_connector = NULL;
 	return -EINVAL;
 }
-- 
2.20.1


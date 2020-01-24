Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910E20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860523;
	bh=1sIPMoe1Z/+BmLfVqJJ6OUenHulTuiiz68b+k+52dGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyy0yu4krrnKPVpLuqxVQrc/2iqkjTYlpsQTNl8Fz/1Ow/KuwMiqGIS1FRI1fLCdR
	 pSoyHXqS2/VjDPdP+C/A9VPLwUL7oFW3MeC03VeD8UAfN5LDkHuV2G2HR0QN3RXc1B
	 IdQyVJcuiDJ2A4G39BFlnhuH25WrIkptMgQ+hTGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbgAXKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbgAXKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:08:40 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D281B20709;
        Fri, 24 Jan 2020 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860520;
        bh=1sIPMoe1Z/+BmLfVqJJ6OUenHulTuiiz68b+k+52dGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+ixRD8gzPOi9GrcTN9VW4I7VqWMaHVe30XyJRKTZDPmq6gsLGKOPSqD5YFSTTrAi
         m2oSFA+PEpGiNiDt59EU4Tna/QGA7vU/JzKwJ6RZbpx3n2C3b1MCN+6ZL/laoGd3nn
         R57l8rK3PWVHKpKKnUKV64vKr5OMMtuB8ObQS81w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Rosin <peda@axentia.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/639] drm/sti: do not remove the drm_bridge that was never added
Date:   Fri, 24 Jan 2020 10:23:08 +0100
Message-Id: <20200124093049.451948790@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 49438337f70dc..19b9b5ed12970 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 34cdc46444350..ccf718404a1c2 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_sysfs:
-	drm_bridge_remove(bridge);
 	hdmi->drm_connector = NULL;
 	return -EINVAL;
 }
-- 
2.20.1




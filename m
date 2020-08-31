Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1341C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6A120FC3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598887829;
	bh=u0Pq7CiGC8BmSqyai7/cksIuozO4tsq0yXx+8eRn6Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fyio9efUvOZsKnpwTat4ioIQEhoaYT/YHxd/JfNCJ4DYwCrqzlq5GDEg6L6AIU9xR
	 ydm8sIG1+vyZcsp3vtciRK9rYm+8u2FQyP7Lq3Un8aDw0dYevRQnSFG2ZD2HIWNRC8
	 2UYbK1rV9xCcUElkLbeLwNJNy2aMcd0jLArcmDyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgHaPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgHaPaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093642145D;
        Mon, 31 Aug 2020 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887816;
        bh=u0Pq7CiGC8BmSqyai7/cksIuozO4tsq0yXx+8eRn6Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQpZIVpTV8fDcex/Lbz7RzjU1/OoBIn9jwDQA/t8WFhorzN5GmRmHuSRp82M9StMp
         DaX37WRM3HsMD0qLip9tHSTTCS+up2WdD30dbK5t8KC6dW0tXFFHfPw5p9UfPEVN2i
         JJKZfcnOedLxxhAcKuVsbZgo5Adnc6+ccvNzrUYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 28/42] drm/omap: fix incorrect lock state
Date:   Mon, 31 Aug 2020 11:29:20 -0400
Message-Id: <20200831152934.1023912-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 7fd5b25499bcec157dd4de9a713425efcf4571cd ]

After commit 92cc68e35863c1c61c449efa2b2daef6e9926048 ("drm/vblank: Use
spin_(un)lock_irq() in drm_crtc_vblank_on()") omapdrm locking is broken:

WARNING: inconsistent lock state
5.8.0-rc2-00483-g92cc68e35863 #13 Tainted: G        W
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
ea98222c (&dev->event_lock#2){?.+.}-{2:2}, at: drm_handle_vblank+0x4c/0x520 [drm]
{HARDIRQ-ON-W} state was registered at:
  trace_hardirqs_on+0x9c/0x1ec
  _raw_spin_unlock_irq+0x20/0x58
  omap_crtc_atomic_enable+0x54/0xa0 [omapdrm]
  drm_atomic_helper_commit_modeset_enables+0x218/0x270 [drm_kms_helper]
  omap_atomic_commit_tail+0x48/0xc4 [omapdrm]
  commit_tail+0x9c/0x190 [drm_kms_helper]
  drm_atomic_helper_commit+0x154/0x188 [drm_kms_helper]
  drm_client_modeset_commit_atomic+0x228/0x268 [drm]
  drm_client_modeset_commit_locked+0x60/0x1d0 [drm]
  drm_client_modeset_commit+0x24/0x40 [drm]
  drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa8 [drm_kms_helper]
  drm_fb_helper_set_par+0x2c/0x5c [drm_kms_helper]
  drm_fb_helper_hotplug_event.part.0+0xa0/0xbc [drm_kms_helper]
  drm_kms_helper_hotplug_event+0x24/0x30 [drm_kms_helper]
  output_poll_execute+0x1a8/0x1c0 [drm_kms_helper]
  process_one_work+0x268/0x800
  worker_thread+0x30/0x4e0
  kthread+0x164/0x190
  ret_from_fork+0x14/0x20

The reason for this is that omapdrm calls drm_crtc_vblank_on() while
holding event_lock taken with spin_lock_irq().

It is not clear why drm_crtc_vblank_on() and drm_crtc_vblank_get() are
called while holding event_lock. I don't see any problem with moving
those calls outside the lock, which is what this patch does.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200819103021.440288-1-tomi.valkeinen@ti.com
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index fce7e944a280b..dbf91b3fd6f08 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -451,11 +451,12 @@ static void omap_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (omap_state->manually_updated)
 		return;
 
-	spin_lock_irq(&crtc->dev->event_lock);
 	drm_crtc_vblank_on(crtc);
+
 	ret = drm_crtc_vblank_get(crtc);
 	WARN_ON(ret != 0);
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	omap_crtc_arm_event(crtc);
 	spin_unlock_irq(&crtc->dev->event_lock);
 }
-- 
2.25.1


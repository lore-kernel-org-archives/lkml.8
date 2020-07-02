Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0145206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653657;
	bh=Xi7/eg4OGJypXMWBSatH0ZdfxFUt+M0VePkYdJ7Z6v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hrGP3ZFE+j5bCi7o2wiNzY+v8fJCJMTebiPFHk872qd82NKf4wXcfD8MRNzKIvw6+
	 DhIhXoFwIL5J5cEBDCAG1LehUBy2yZwQoQQdcvmg0fwmzhJvlxQQRK/zo+chmR3kVc
	 ut1m3spF6jGgYb1zgRWpg3M4l4VqWIfidf/sJLVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGBBeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbgGBBZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:25:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3919720748;
        Thu,  2 Jul 2020 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653135;
        bh=Xi7/eg4OGJypXMWBSatH0ZdfxFUt+M0VePkYdJ7Z6v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obWJr1/cH2DaxrkT5HiVbDCu05c7Pz9C1Z81ibW+WbubS5zjJbVJ0AN+eq5/Nw1lc
         b5l3j6GVGauaxGxWw1IIbSggaawuQ2cEFKjpghUd5qQRB3QkvU59CQw/bWJ307l5YO
         PuO5XX3LJmSasDtCJFGtftkWJciWtSpoP4WC8DDA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 09/40] drm: mcde: Fix display initialization problem
Date:   Wed,  1 Jul 2020 21:23:30 -0400
Message-Id: <20200702012402.2701121-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012402.2701121-1-sashal@kernel.org>
References: <20200702012402.2701121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit b984b6d8b52372b98cce0a6ff6c2787f50665b87 ]

The following bug appeared in the MCDE driver/display
initialization during the recent merge window.

First the place we call drm_fbdev_generic_setup() in the
wrong place: this needs to be called AFTER calling
drm_dev_register() else we get this splat:

 ------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ../drivers/gpu/drm/drm_fb_helper.c:2198 drm_fbdev_generic_setup+0x164/0x1a8
mcde a0350000.mcde: Device has not been registered.
Modules linked in:
Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[<c010e704>] (unwind_backtrace) from [<c010a86c>] (show_stack+0x10/0x14)
[<c010a86c>] (show_stack) from [<c0414f38>] (dump_stack+0x9c/0xb0)
[<c0414f38>] (dump_stack) from [<c0121c8c>] (__warn+0xb8/0xd0)
[<c0121c8c>] (__warn) from [<c0121d18>] (warn_slowpath_fmt+0x74/0xb8)
[<c0121d18>] (warn_slowpath_fmt) from [<c04b154c>] (drm_fbdev_generic_setup+0x164/0x1a8)
[<c04b154c>] (drm_fbdev_generic_setup) from [<c04ed278>] (mcde_drm_bind+0xc4/0x160)
[<c04ed278>] (mcde_drm_bind) from [<c04f06b8>] (try_to_bring_up_master+0x15c/0x1a4)
(...)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200613223027.4189309-1-linus.walleij@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5649887d2b901..16e5fb9ec784d 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -215,7 +215,6 @@ static int mcde_modeset_init(struct drm_device *drm)
 
 	drm_mode_config_reset(drm);
 	drm_kms_helper_poll_init(drm);
-	drm_fbdev_generic_setup(drm, 32);
 
 	return 0;
 
@@ -282,6 +281,8 @@ static int mcde_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto unbind;
 
+	drm_fbdev_generic_setup(drm, 32);
+
 	return 0;
 
 unbind:
-- 
2.25.1


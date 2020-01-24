Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C661AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F97A20678
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579866124;
	bh=ZwIrqZIfE43VDYCJnXmaYOrV9R5+2aYh2pbSmU6hu08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2fde9xvCGSrgZ3hLJ1AXB0jFGeRiLSOoXMkGg+Tvhphl10FfOeZe6Zg0KiMg6IoBv
	 d0764BVuUbO41R5u3MpFCpqEglipJjNvS/nHJYwJAn7H0O1RFhDVPOFbAi2IbvRQX2
	 6Lz6nO2SdddDN3RIvpqMEQ0d4Mv0oDAHqZFOS7Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392050AbgAXLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbgAXLP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:15:26 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AD5214DB;
        Fri, 24 Jan 2020 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864526;
        bh=ZwIrqZIfE43VDYCJnXmaYOrV9R5+2aYh2pbSmU6hu08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZmogi+dyecE65lglEH2sPMUA7sel/hPgiTNHl7E1FX7NobMLcULDLzsjklC2J6ma
         CszyGMFBsdxD0jc5SKOHarl8yDL/RucTYxO/0PqZ/tM6wEYpzi6EW6rjPUYrZDFeB/
         LmRFj5WLlVvtGZP8FGK1yBa6CTtumcLypgUWsf2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 290/639] drm/fb-helper: generic: Call drm_client_add() after setup is done
Date:   Fri, 24 Jan 2020 10:27:40 +0100
Message-Id: <20200124093123.208643632@linuxfoundation.org>
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

From: Noralf Trønnes <noralf@tronnes.org>

[ Upstream commit 6e3f17ee73f7e3c2ef0e2c8fd8624b2ece8ef2c9 ]

Hotplug can happen while drm_fbdev_generic_setup() is running so move
drm_client_add() call after setup is done to avoid
drm_fbdev_client_hotplug() running in two threads at the same time.

Fixes: 9060d7f49376 ("drm/fb-helper: Finish the generic fbdev emulation")
Cc: stable@vger.kernel.org
Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190401141358.25309-1-noralf@tronnes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 1c87ad6667e73..da9a381d6b577 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3257,8 +3257,6 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 		return ret;
 	}
 
-	drm_client_add(&fb_helper->client);
-
 	if (!preferred_bpp)
 		preferred_bpp = dev->mode_config.preferred_depth;
 	if (!preferred_bpp)
@@ -3267,6 +3265,8 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 
 	drm_fbdev_client_hotplug(&fb_helper->client);
 
+	drm_client_add(&fb_helper->client);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbdev_generic_setup);
-- 
2.20.1




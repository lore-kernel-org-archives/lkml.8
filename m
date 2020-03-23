Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123BC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C92073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCWFfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:35:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43612 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:35:44 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGFkN-00063j-9D; Mon, 23 Mar 2020 05:35:35 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360 Convertible 13t-aw100
Date:   Mon, 23 Mar 2020 13:35:28 +0800
Message-Id: <20200323053528.3147-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's another OLED panel needs to use DPCD aux interface to control
backlight.

BugLink: https://bugs.launchpad.net/bugs/1860303
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 8ba4531e808d..a0d4314663de 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1301,6 +1301,8 @@ static const struct edid_quirk edid_quirk_list[] = {
 	 * only supports DPCD backlight controls
 	 */
 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	/* HP Spectre x360 Convertible 13t-aw100 */
+	{ MFG(0x4c, 0x83), PROD_ID(0x42, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	/*
 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
 	 * backlight control, and some only support AUX backlight control. All
-- 
2.17.1


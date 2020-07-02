Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7159206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653552;
	bh=YTaFIXKUgmcdP1e9IE1EuXcT+y6FsRB2iZKzwevw40I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U17gUdYP0TuhTYM4fGhfdVh8Oat/Hd/AQjv1WZw0IkJaWVNAMqC1pD/+luz2+x+7S
	 Dop+h3w1mgPeYwv/Me4sn2wdw2d0DuIhA8Xz+JQfI2YNECXNXKn12qQJz51y1DMVkD
	 VLOdE9VczNDpA+T476yJUgSNSxKKnq8AuRZ9Q+m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGBB0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgGBBZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:25:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2DDD206BE;
        Thu,  2 Jul 2020 01:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653158;
        bh=YTaFIXKUgmcdP1e9IE1EuXcT+y6FsRB2iZKzwevw40I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPsUSdbdLciNPMWK6J1VktoTl+1ZKfNxB3wqoqszstDi53OouASyl+AXRAMBAxOR2
         dmS1j0YuqmV0tCTvOUxIMHPCtXhkGzWyVIZlDoXqchC9KNPJpXPqV5GnEvfV0+ve2E
         fSAEjszcJ26YKJHkDhbiJMmDs3ISdWSZWysGeF6E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 27/40] drm: panel-orientation-quirks: Use generic orientation-data for Acer S1003
Date:   Wed,  1 Jul 2020 21:23:48 -0400
Message-Id: <20200702012402.2701121-27-sashal@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a05caf9e62a85d12da27e814ac13195f4683f21c ]

The Acer S1003 has proper DMI strings for sys-vendor and product-name,
so we do not need to match by BIOS-date.

This means that the Acer S1003 can use the generic lcd800x1280_rightside_up
drm_dmi_panel_orientation_data struct which is also used by other quirks.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200531093025.28050-2-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d11d83703931e..d00ea384dcbfe 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -30,12 +30,6 @@ struct drm_dmi_panel_orientation_data {
 	int orientation;
 };
 
-static const struct drm_dmi_panel_orientation_data acer_s1003 = {
-	.width = 800,
-	.height = 1280,
-	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
-};
-
 static const struct drm_dmi_panel_orientation_data asus_t100ha = {
 	.width = 800,
 	.height = 1280,
@@ -114,7 +108,7 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
 		},
-		.driver_data = (void *)&acer_s1003,
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* Asus T100HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.25.1


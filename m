Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4719BC3B1B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15144206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702551;
	bh=Yi9pz/ne4bmU10ZVJ5yO0fZjC2dJYgduYi8RFyzbxhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S19jJriFeYcbJ4uFes2i9uxCYWyrhXacSd6JxUAFz8apkISai6YTHOpFXKtHWaBMH
	 30KjxtMPQbpeV5d1zt0P4Z+2//cyJxOqEr0X+gOAnc7J1CO7BxicBZzZ/1mlyBKhpx
	 CpvTr0RIBeN9sPUrP2+TRHe/jqJrYGmSjCrGWVvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbgBNRtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388907AbgBNP7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA2D24654;
        Fri, 14 Feb 2020 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695962;
        bh=Yi9pz/ne4bmU10ZVJ5yO0fZjC2dJYgduYi8RFyzbxhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIAINiU3O6pm5gi3fE3grBTqBVU74I64iHO+9TRBpc36+LapCl3czkStRgyecp2yl
         CDPOgw9ruiAz+8HO/1Ft2JKhegGs/pt3zFOWtVY+26AOcgE+xW5iBhh+Hdt2co0bRZ
         GWQvEs4hiDcT3xR8c/136QwlI9pcT2S+pU2Ysr5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dor Askayo <dor.askayo@gmail.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 491/542] drm/amd/display: do not allocate display_mode_lib unnecessarily
Date:   Fri, 14 Feb 2020 10:48:03 -0500
Message-Id: <20200214154854.6746-491-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dor Askayo <dor.askayo@gmail.com>

[ Upstream commit bb67bfd2e7101bf2ac5327b0b7a847cd9fb9723f ]

This allocation isn't required and can fail when resuming from suspend.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 32f31bf919151..8904a85186aab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2396,12 +2396,7 @@ void dc_set_power_state(
 	enum dc_acpi_cm_power_state power_state)
 {
 	struct kref refcount;
-	struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
-						GFP_KERNEL);
-
-	ASSERT(dml);
-	if (!dml)
-		return;
+	struct display_mode_lib *dml;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -2423,6 +2418,12 @@ void dc_set_power_state(
 		 * clean state, and dc hw programming optimizations will not
 		 * cause any trouble.
 		 */
+		dml = kzalloc(sizeof(struct display_mode_lib),
+				GFP_KERNEL);
+
+		ASSERT(dml);
+		if (!dml)
+			return;
 
 		/* Preserve refcount */
 		refcount = dc->current_state->refcount;
@@ -2436,10 +2437,10 @@ void dc_set_power_state(
 		dc->current_state->refcount = refcount;
 		dc->current_state->bw_ctx.dml = *dml;
 
+		kfree(dml);
+
 		break;
 	}
-
-	kfree(dml);
 }
 
 void dc_resume(struct dc *dc)
-- 
2.20.1


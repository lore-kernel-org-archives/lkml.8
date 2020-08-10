Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F380C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7559E22B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087219;
	bh=2V8O/8NIypxvZs/NebqPdpo3C9WCOWyFh1QBb239wzo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nWCwJ25eEN+VV3Z1gnr/bXkMfKmPwGsiBTrCB1zLCQz3O3GG5FMFtgH4FswJVzE1f
	 CdmefoZpshY24UlALj/ngKmqwaCnsuk7Fb2EUC9Sd1MlybN1yp26WPopVPMQoW5Kpu
	 n88oPCZYCZFbTPdBssajh8TlhdlYp1kjhjTVVImA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgHJTN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbgHJTNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BF4207FF;
        Mon, 10 Aug 2020 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086827;
        bh=2V8O/8NIypxvZs/NebqPdpo3C9WCOWyFh1QBb239wzo=;
        h=From:To:Cc:Subject:Date:From;
        b=obZDsGWIBsx3/SIR7TA3etrWWpfQs91cNl9urPtTEeJSVcNbJfw4K1kht8ir4AI6x
         mc+c/ftA/L+M8+3XnuY/7zTy7dC7ybcLQXNerRu2TzrcOL8qW9hyAxglyRTgI/ExAG
         LYj33Ifb/aKsBB/+J3LirmVQogRHKshjPmhKtn2g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 01/22] drm/tilcdc: fix leak & null ref in panel_connector_get_modes
Date:   Mon, 10 Aug 2020 15:13:23 -0400
Message-Id: <20200810191345.3795166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 3f9c1c872cc97875ddc8d63bc9fe6ee13652b933 ]

If videomode_from_timings() returns true, the mode allocated with
drm_mode_create will be leaked.

Also, the return value of drm_mode_create() is never checked, and thus
could cause NULL deref.

Fix these two issues.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200429104234.18910-1-tomi.valkeinen@ti.com
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 1813a3623ce60..0484b2cf0e2b5 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -152,12 +152,16 @@ static int panel_connector_get_modes(struct drm_connector *connector)
 	int i;
 
 	for (i = 0; i < timings->num_timings; i++) {
-		struct drm_display_mode *mode = drm_mode_create(dev);
+		struct drm_display_mode *mode;
 		struct videomode vm;
 
 		if (videomode_from_timings(timings, &vm, i))
 			break;
 
+		mode = drm_mode_create(dev);
+		if (!mode)
+			break;
+
 		drm_display_mode_from_videomode(&vm, mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-- 
2.25.1


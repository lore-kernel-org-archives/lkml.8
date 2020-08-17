Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D03D2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693526;
	bh=n4+rbEnu5fyOcSLZHKIsQ0tr72OZykSW/pXLx9Eq//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifUU+Ap15Erw8k8DIrjg+fUDu5Ym8ECSmD6r2UMBxKyxZW/TBms2e+AdKQA35+lBS
	 3HZs8qtCt0AXQrX8J9eYa/zyUDaTilT4QIbe4BKSKGO5PGWfm70s8n6Ts28tuIE3aP
	 gI1N7OD72Z2f3f7qlW1AyJfdymZF0zHD9bEwnfj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgHQPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgHQPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6CB22B43;
        Mon, 17 Aug 2020 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677702;
        bh=n4+rbEnu5fyOcSLZHKIsQ0tr72OZykSW/pXLx9Eq//Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8zGzL8x9NVpHjQWQNWjqMw65mPFwJmnhcEaqM5qFIMWF9MG3LAoDmuRHOlTx1pX0
         435ZfnAqrbcCnLBnRAFsfbA8NfQuFFsqN53acp1sy4S5gkPIgMgS7BCBLai4kwZVuB
         4xBrAS1zjTOnpiEfki9/faT+c+KelAKA0yvKIPE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 077/464] drm/tilcdc: fix leak & null ref in panel_connector_get_modes
Date:   Mon, 17 Aug 2020 17:10:30 +0200
Message-Id: <20200817143837.463988990@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 12823d60c4e89..4be53768f0146 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -139,12 +139,16 @@ static int panel_connector_get_modes(struct drm_connector *connector)
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




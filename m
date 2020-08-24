Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19054C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C6222B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258378;
	bh=FFaw75yiFjKfBsZ9/FI71IAOExrSv7wL9MF/7Pubngg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjHBV71ChIkIo7+TFG4eeC9QHMetnrMAq3BUYu1EXAPZx3n/VGCAG7AABEZ9C4Bi+
	 Y/8ybWQVj5Pb3xP+MlWvyTAuL7pNhAca6O+obIwGxbSKlHlcvN2hgdiCHIPgJuQTvb
	 JlP/4CQ7RGaUy6iJiKs6M98rKBzxjuvSmevuytog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHXIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHXIjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15A7221E2;
        Mon, 24 Aug 2020 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258358;
        bh=FFaw75yiFjKfBsZ9/FI71IAOExrSv7wL9MF/7Pubngg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zG0dPd0FB0/fHnPlOS/3xtECdgWnCLWt3uhynhzHT5U0Jmkp/yB4jvT8IDduGR9K2
         G/ExzAkP27fxVUBYxwTSWnxbcU+KPpAqb6mtJKUffjdckAsR14n4mSAkZbdMq7iXxo
         poDcdcJCYanJWZKuJDwq0xxd80OUQlWZASBgye7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 002/124] drm/panel-simple: Fix inverted V/H SYNC for Frida FRD350H54004 panel
Date:   Mon, 24 Aug 2020 10:28:56 +0200
Message-Id: <20200824082409.496866539@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit bad20a2dbfdfaf01560026909506b6ed69d65ba2 ]

The FRD350H54004 panel was marked as having active-high VSYNC and HSYNC
signals, which sorts-of worked, but resulted in the picture fading out
under certain circumstances.

Fix this issue by marking VSYNC and HSYNC signals active-low.

v2: Rebase on drm-misc-next

Fixes: 7b6bd8433609 ("drm/panel: simple: Add support for the Frida FRD350H54004 panel")
Cc: stable@vger.kernel.org # v5.5
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200716125647.10964-1-paul@crapouillou.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 346e3f9fd505a..a68eff1fb4297 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1537,7 +1537,7 @@ static const struct drm_display_mode frida_frd350h54004_mode = {
 	.vsync_end = 240 + 2 + 6,
 	.vtotal = 240 + 2 + 6 + 2,
 	.vrefresh = 60,
-	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
 static const struct panel_desc frida_frd350h54004 = {
-- 
2.25.1




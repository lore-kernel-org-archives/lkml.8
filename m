Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69011C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FFB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923659;
	bh=XxThjJPyWP2v4A2Uj8g2d0QYq4mP8rDRUWlgltLvewU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWVVvQO5P+5wrF8SD9Thxjr1sOOnMT3iEnTKTMzHr1eu1OdIkHANycSEdEJ8jDq0I
	 C0QwmCok84quolo51owCvh+GZIhPr7vi8ZpIqXX2ePjIU8PC43tf0j4lnmbpZKLEXn
	 0oD2epmi3Yy3hZM052l3sChQxPgdB91elbO1RtyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgHTKEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgHTKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26F422B49;
        Thu, 20 Aug 2020 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917699;
        bh=XxThjJPyWP2v4A2Uj8g2d0QYq4mP8rDRUWlgltLvewU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfrUxB353wRAcY2a0asR3LsiAHFhzMD5jXeM6SolQOPIgIUyXA214Bq6Ga8+2lszD
         REHGvTBmLgYb5ZoUd1mzgloWCCZ52NYyK79Ju+HFMYwITm0bag9Xh3SkObjcsBYAeE
         fJvtlNkHInCu9ZS6fp+TakOtymRPzpnxCgXBObYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 125/212] drm: panel: simple: Fix bpc for LG LB070WV8 panel
Date:   Thu, 20 Aug 2020 11:21:38 +0200
Message-Id: <20200820091608.663505432@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit a6ae2fe5c9f9fd355a48fb7d21c863e5b20d6c9c ]

The LG LB070WV8 panel incorrectly reports a 16 bits per component value,
while the panel uses 8 bits per component. Fix it.

Fixes: dd0150026901 ("drm/panel: simple: Add support for LG LB070WV8 800x480 7" panel")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200711225317.28476-1-laurent.pinchart+renesas@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 68a2b25deb50d..57f32d1bb3127 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1041,7 +1041,7 @@ static const struct drm_display_mode lg_lb070wv8_mode = {
 static const struct panel_desc lg_lb070wv8 = {
 	.modes = &lg_lb070wv8_mode,
 	.num_modes = 1,
-	.bpc = 16,
+	.bpc = 8,
 	.size = {
 		.width = 151,
 		.height = 91,
-- 
2.25.1




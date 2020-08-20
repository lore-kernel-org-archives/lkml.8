Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB44206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918255;
	bh=E1DSGvmQ3lkOF9Drk6umn/Ny4de30t7CdN/1wuCQCDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2cMK+rNUwerdfudYm9+4etlT3FvcTHk0gwPFfFecaxFvL0uXojiKjLPADw57pIMZ
	 /4WIt8seyzcK/BOt54gn9whp0cRI3emK87lg5olZAmG01riVYlj1/5els6aq2k1gvP
	 pipGiDLRhAU6VYsyAAYLWF5MI9OUSFWnW/HNQlq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgHTKKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbgHTKKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:10:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EC12067C;
        Thu, 20 Aug 2020 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918241;
        bh=E1DSGvmQ3lkOF9Drk6umn/Ny4de30t7CdN/1wuCQCDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb1L1s3R0n08+bD4o1B8wF3WyGRXkeQw2QyQ7XoFMbmVICBNlVxjeO8x6Du0B0Mdz
         uUdc6+PLfDrzSJ9NpJf/FOZsuGvKyTIAOC9MMpLQSpGHUYARiidUQd/2QbehdmE8dp
         qzxvQiWrUFAOgL9yMtjgQOf0mr+pGSpPa5po5KI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 102/228] drm: panel: simple: Fix bpc for LG LB070WV8 panel
Date:   Thu, 20 Aug 2020 11:21:17 +0200
Message-Id: <20200820091612.713838067@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index c1daed3fe8428..6df312ba1826b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1253,7 +1253,7 @@ static const struct drm_display_mode lg_lb070wv8_mode = {
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




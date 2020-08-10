Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E290720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073121;
	bh=nGpeLG21Dvg+Nmre5tLkQr5WxfGP/5qtM6NgnOvlGGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBT8Uxb25itMUhJMEpmKdRegZwFXyV/aXqLeUM+fX014xcOGIEmStaSt5Q0JaSYtw
	 NdjYPQylLxvmsGuYktpNXduAOP5MGW2pnxrdRbsUlxPv7LjhCrtY1gKr0pwLn6bDEe
	 VXHokB1MCgkAu0punydSFA/0xUGuPxNCiPROyaos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgHJPZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgHJPZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:25:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04ECE20772;
        Mon, 10 Aug 2020 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073108;
        bh=nGpeLG21Dvg+Nmre5tLkQr5WxfGP/5qtM6NgnOvlGGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnLfoJnhadVXLIAekAkAJPl3VjNmQw9Ukhwharc6ipobW42eoxc980FASMkKkMlTF
         N+WR58kzY7BLr2wIICtmdJEiAX7PEW01tt03RSuKeztU4Usuh986ncWmVGL//pXbkt
         1jCtrExY5fA64OClp+RoUKpoHamIfyYTqA8tdheg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 39/79] drm/panel: Fix auo, kd101n80-45na horizontal noise on edges of panel
Date:   Mon, 10 Aug 2020 17:20:58 +0200
Message-Id: <20200810151814.203744726@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

[ Upstream commit d76acc9fcddeda53b985b029c890976a87fcc3fc ]

Fine tune the HBP and HFP to avoid the dot noise on the left and right edges.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200714123332.37609-1-jitao.shi@mediatek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 48a164257d18c..3edb33e619088 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -615,9 +615,9 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
 static const struct drm_display_mode auo_kd101n80_45na_default_mode = {
 	.clock = 157000,
 	.hdisplay = 1200,
-	.hsync_start = 1200 + 80,
-	.hsync_end = 1200 + 80 + 24,
-	.htotal = 1200 + 80 + 24 + 36,
+	.hsync_start = 1200 + 60,
+	.hsync_end = 1200 + 60 + 24,
+	.htotal = 1200 + 60 + 24 + 56,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 16,
 	.vsync_end = 1920 + 16 + 4,
-- 
2.25.1




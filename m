Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15CB22D2C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073781;
	bh=SB2k0gB8/Yq6bzcEGvdag2ZgHMDNnB6qGSLVOxkZbVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nr9ourb20f7gLx6NMMOPkIncRQeII2SA+PjbCWuh7moqcnl6jWUWB+w3dkxoiHZP2
	 QI4imUMShGuuFO6XF4X4LkVEcChEGBaG7Grf5zLnGOtbRqYic2sZkGaOL5WWV+Qj5y
	 AT7PRzHfuVK44GCKJYWTfx/f/skrZc0sQBdkujvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHJP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgHJP1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C3722CF7;
        Mon, 10 Aug 2020 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073232;
        bh=SB2k0gB8/Yq6bzcEGvdag2ZgHMDNnB6qGSLVOxkZbVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGiKwwqyQCpSmeoYqLK6npXWamNEWevNdj6SECxZSuNKZKKDvu8YoPBf8CjtOVopv
         gEDm+BhIuaJ/q20EeUlVW80FklsEe9ZrQsZtC+dpFiaLIyB6fRpyUMj87wacy6zR7m
         rweka5jwMP1l+ssRDPbow6qgj5QKaY4yXLI0hNGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 33/67] drm/nouveau/fbcon: zero-initialise the mode_cmd2 structure
Date:   Mon, 10 Aug 2020 17:21:20 +0200
Message-Id: <20200810151811.065747654@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 15fbc3b938534cc8eaac584a7b0c1183fc968b86 ]

This is tripping up the format modifier patches.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 141cc89981240..5cf2381f667e2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -315,7 +315,7 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
 	struct nouveau_framebuffer *fb;
 	struct nouveau_channel *chan;
 	struct nouveau_bo *nvbo;
-	struct drm_mode_fb_cmd2 mode_cmd;
+	struct drm_mode_fb_cmd2 mode_cmd = {};
 	int ret;
 
 	mode_cmd.width = sizes->surface_width;
-- 
2.25.1




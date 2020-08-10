Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED700C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FBB22CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073609;
	bh=VKaJERNSz+3XNKtG98/BzX7fGxRhNyOOax5a2lSDGBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C9xa5DnuHPys6IKOQibAbbZlITki6uFxHowAe/g8z4Lb3UULNFHBGR87fZy0wDvIa
	 f312MvaC/6mu9CosMYljjwkaGZfPw8u/Vb1TNibSab1EaAUneqfg082mFwVp4iNOrK
	 aQLZqZUGvwdBKO3VRo1HadRylvIXPYIiNIMLI7W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgHJPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbgHJP3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:29:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC98722D02;
        Mon, 10 Aug 2020 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073390;
        bh=VKaJERNSz+3XNKtG98/BzX7fGxRhNyOOax5a2lSDGBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kt6wGF/Tf6igYx6dZxXfH8p2YniSk1RhCmvT04fvZ2I6VIpmT90Btrbyy85HOpCvd
         lkanATCLfglcoWzaeN7ivpIxguKabzSCiHwa0fRdXAlVgP5M6RkJk5k9Givn5Szznn
         ZPoT32OFwOWmyoox6nuexDF8ElBTC5NCuHOo6Fus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/48] drm/nouveau/fbcon: zero-initialise the mode_cmd2 structure
Date:   Mon, 10 Aug 2020 17:21:43 +0200
Message-Id: <20200810151805.259303158@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
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
index fef38ea146a2a..406cb99af7f21 100644
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




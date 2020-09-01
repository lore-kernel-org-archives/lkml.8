Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA3206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977665;
	bh=RbLY80t28iVxPmRZ5jqBog4FFObASEvB4HKzTo531/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xJ4RxaM4dB5nBOikGr51IWApCqLJQ+N7jLRSNbE4ZrDdjxor0C93p2dulYD/HRogQ
	 rphKJVxvo+93CjGCiDclABO223tABzTQTwLlw65QiNurS5HH6DM6SFITRD5ED2+88Z
	 US/dtju/mtTfnQot1vo/rHFe6Msm7ex6z28mkapE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgIAPcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgIAPaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:30:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B2C207D3;
        Tue,  1 Sep 2020 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974204;
        bh=RbLY80t28iVxPmRZ5jqBog4FFObASEvB4HKzTo531/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMwnfX5QOkAJbbc5O+WOdBWZcoHFxoVVK/MLQA6ezqDZOvbohyEHXaKdzDXEgxarF
         PnDseAM4o7x7NZXT/WrAMMoM2lv2LGqb41a48Eb3SdDkfhIzCbFA+m4NvHp0fWyesO
         PpBAgCaO7GC2mQzLH1EvmTv5Rb6fclRKy46WU5Ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 085/214] drm/ingenic: Fix incorrect assumption about plane->index
Date:   Tue,  1 Sep 2020 17:09:25 +0200
Message-Id: <20200901150957.065326104@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit ca43f274e03f91c533643299ae4984965ce03205 ]

plane->index is NOT the index of the color plane in a YUV frame.
Actually, a YUV frame is represented by a single drm_plane, even though
it contains three Y, U, V planes.

v2-v3: No change

Cc: stable@vger.kernel.org # v5.3
Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx SoCs")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200716163846.174790-1-paul@crapouillou.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index e746b3a6f7cbc..7e6179fe63f86 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -377,7 +377,7 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
 		width = state->src_w >> 16;
 		height = state->src_h >> 16;
-		cpp = state->fb->format->cpp[plane->index];
+		cpp = state->fb->format->cpp[0];
 
 		priv->dma_hwdesc->addr = addr;
 		priv->dma_hwdesc->cmd = width * height * cpp / 4;
-- 
2.25.1




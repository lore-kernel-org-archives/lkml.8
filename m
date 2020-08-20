Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2788207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928503;
	bh=WR2kuoklQgxnVAdTKrnFvOIBmN1Hzsr+vBvGGKBWJm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fpuV4RGwIsc/i3ClwHI8Z+XftCQHGjz6bY6t4i5tYQvas7o3Zg6aL0gA040LXjI+c
	 XlDfHxnFKED/eUun6v439cD5uz0bP4a3w3zcQOcOS0hY6vqEIrYOJTfbtlNzO8EStS
	 He5HPxgjAwoiDqg1kn9EZ1Kxsth9YeygiTQ0dtHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHTNBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgHTJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:40:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D898207DE;
        Thu, 20 Aug 2020 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916440;
        bh=WR2kuoklQgxnVAdTKrnFvOIBmN1Hzsr+vBvGGKBWJm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xVdUOM+syuy0r3++45WNLXdmE4vg7xNxKUefcYvMO1raGx2i0KrQttQdxwRB0j8yY
         si4OfhLIJx+VerzwSW0Gu/+bhNZ2/uRneO1X2xO0+5V24fSN0swtZFXq4yNGP9V1a8
         DAqIdt4zmm65QNICrOMf7NuP9nzMi12ntzem906g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5.7 098/204] drm/ingenic: Fix incorrect assumption about plane->index
Date:   Thu, 20 Aug 2020 11:19:55 +0200
Message-Id: <20200820091611.220759589@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit ca43f274e03f91c533643299ae4984965ce03205 upstream.

plane->index is NOT the index of the color plane in a YUV frame.
Actually, a YUV frame is represented by a single drm_plane, even though
it contains three Y, U, V planes.

v2-v3: No change

Cc: stable@vger.kernel.org # v5.3
Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx SoCs")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200716163846.174790-1-paul@crapouillou.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ingenic/ingenic-drm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -384,7 +384,7 @@ static void ingenic_drm_plane_atomic_upd
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
 		width = state->src_w >> 16;
 		height = state->src_h >> 16;
-		cpp = state->fb->format->cpp[plane->index];
+		cpp = state->fb->format->cpp[0];
 
 		priv->dma_hwdesc->addr = addr;
 		priv->dma_hwdesc->cmd = width * height * cpp / 4;



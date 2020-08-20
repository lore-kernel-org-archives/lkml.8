Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F992075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931101;
	bh=SYXWTX+v+/mNoU0TfcdBFAmNqqh497XAu3ylOhZeT2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+JG/XKcRX8O4X2v2bPkVxhjBurLfE9feYx25HL2D0SIUqLAaQ5AQLAHQHBhGB0S7
	 CJL0e4DxUCaQdYKhcudJkTI6dyQmP4yhuZk4nS3bfXD8Z4eHAncsQq5L2PVkSPbfnU
	 XKzrqYHB5DEFDnAeNTctL+VGW9dFuiBxNRbG68YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHTNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgHTJ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0123D22CF7;
        Thu, 20 Aug 2020 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915727;
        bh=SYXWTX+v+/mNoU0TfcdBFAmNqqh497XAu3ylOhZeT2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPcggc106yEw3Wv/tfDBtnx14Zk5rOpU2aXY84v3MqwsHn9MtXPj780igS+/3wtkf
         6O90dtCfOvI9B1a1MI0GDI1Tra3bxzxZO0tCNjfVpzw1WPc6Y1MSGNt3oZsqxTLf8O
         zqiY50NZyqdY30rhcK8kwSuKHAUlHneTSbo+XI2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5.8 113/232] drm/ingenic: Fix incorrect assumption about plane->index
Date:   Thu, 20 Aug 2020 11:19:24 +0200
Message-Id: <20200820091618.291489646@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
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
@@ -386,7 +386,7 @@ static void ingenic_drm_plane_atomic_upd
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
 		width = state->src_w >> 16;
 		height = state->src_h >> 16;
-		cpp = state->fb->format->cpp[plane->index];
+		cpp = state->fb->format->cpp[0];
 
 		priv->dma_hwdesc->addr = addr;
 		priv->dma_hwdesc->cmd = width * height * cpp / 4;



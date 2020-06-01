Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20853C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FA720678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036762;
	bh=g3sscGhPq9hLVmx658tAsrUj80UrMHlDSMwYPWU6Ecw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5vzPVltR4wcZArBVqbdypf49SqrejPPYXDaT/OK8UQChOGrZLKTvQRNFxmOgc0p2
	 Wg2M6oVTxLz0mDAsgG1BEQxk9B2S+jC40vTKwjkCi84XNb7qgP7cgRaV4pLjdpXRxR
	 niyu5fQUt5v2un/lLmeJ02Iuvyv3DotEfuIUiH54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgFASOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbgFASOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7380D2065C;
        Mon,  1 Jun 2020 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035255;
        bh=g3sscGhPq9hLVmx658tAsrUj80UrMHlDSMwYPWU6Ecw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxzp8X6/Hmn1J3kTndPqK1bTasA5uib86X4/KHPRYKDla9AXGRhuxVwMpDNmd+kRm
         aP8IbmOuF2Hjw6W8d2V6DVEMSINv7vbh9lhfgw/PRdPQ59Z4naXWAk4sZMn01LZXYC
         u2cVSy7YYagqMrHkOssN3aZmot7ujx//+5WUhChY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernard Zhao <bernard@vivo.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 077/177] drm/meson: pm resume add return errno branch
Date:   Mon,  1 Jun 2020 19:53:35 +0200
Message-Id: <20200601174055.311142505@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Zhao <bernard@vivo.com>

[ Upstream commit c54a8f1f329197d83d941ad84c4aa38bf282cbbd ]

pm_resump api did not handle drm_mode_config_helper_resume error.
This change add handle to return drm_mode_config_helper_resume`s
error number. This code logic is aligned with api pm_suspend.
After this change, the code maybe a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200428131747.2099-1-bernard@vivo.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index b5f5eb7b4bb9..8c2e1b47e81a 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -412,9 +412,7 @@ static int __maybe_unused meson_drv_pm_resume(struct device *dev)
 	if (priv->afbcd.ops)
 		priv->afbcd.ops->init(priv);
 
-	drm_mode_config_helper_resume(priv->drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(priv->drm);
 }
 
 static int compare_of(struct device *dev, void *data)
-- 
2.25.1




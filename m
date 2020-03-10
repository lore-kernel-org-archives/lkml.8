Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1258F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846758;
	bh=TRhJge8rXSTVwiWtVyAVL2+zDSITLcul7kvtQLFQMYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpol0qFA+KdexCKWbVg99G/cOvB83OGPyFSQEAOfgZPKY3zhmAML7ymhbTCsobNun
	 0ouQ3TaMcV09GLLrTjYJaD/CpIarIZbzWQ4KjWEK/IXM7aGZm5bA2VHsn5nqif+V6P
	 d4blSZB0vWwUD6PBhLiaM2IStY6R7F/1mNX8gWW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgCJNZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgCJM4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:56:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C912253D;
        Tue, 10 Mar 2020 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844997;
        bh=TRhJge8rXSTVwiWtVyAVL2+zDSITLcul7kvtQLFQMYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0FNHdvLXb74EAQRRUPXCwZchwsvZlk7t3L3TNo6s4oGP77ppumhAihb8ql5oTNdZ
         WGdJoaP31ojuBhDOM19LqRoQO0SWWKv2jRhhSK0UOmRA87qoyHSLazjUHF9zvmytgA
         eQMOChJS3wYISIL1CaR1/REo9UZWrftPwRNeyWek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 025/189] drm/modes: Allow DRM_MODE_ROTATE_0 when applying video mode parameters
Date:   Tue, 10 Mar 2020 13:37:42 +0100
Message-Id: <20200310123642.003666380@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 5c320b6ce7510653bce68cecf80cf5b2d67e907f ]

At the moment, only DRM_MODE_ROTATE_180 is allowed when we try to apply
the rotation from the video mode parameters. It is also useful to allow
DRM_MODE_ROTATE_0 in case there is only a reflect option in the video mode
parameter (e.g. video=540x960,reflect_x).

DRM_MODE_ROTATE_0 means "no rotation" and should therefore not require
any special handling, so we can just add it to the if condition.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200117153429.54700-3-stephan@gerhold.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_client_modeset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 6d4a29e99ae26..3035584f6dc72 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -951,7 +951,8 @@ bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation)
 	 * depending on the hardware this may require the framebuffer
 	 * to be in a specific tiling format.
 	 */
-	if ((*rotation & DRM_MODE_ROTATE_MASK) != DRM_MODE_ROTATE_180 ||
+	if (((*rotation & DRM_MODE_ROTATE_MASK) != DRM_MODE_ROTATE_0 &&
+	     (*rotation & DRM_MODE_ROTATE_MASK) != DRM_MODE_ROTATE_180) ||
 	    !plane->rotation_property)
 		return false;
 
-- 
2.20.1




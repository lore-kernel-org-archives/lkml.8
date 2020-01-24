Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC04C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AD021556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863772;
	bh=+zRVFBuibjWAL5fVcRaW6k78JJHhCAMQpAX3lost+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zr8i8nFVaP/qJDU18rRiiyy+UyKwvlCGl47SQdobnK318bKySpRaZxrE3zpMuUdsj
	 qD6xcr6AIsEs4VBETBdAS4V6JinBxSX/WMDKWUng2EN+d7xoG15cCS8b7nt29JZD2O
	 14qUnGXjaoB0CdoA0RTXiCxoERUjU4HCNtcnKVMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbgAXLCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgAXLCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:49 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4292075D;
        Fri, 24 Jan 2020 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863768;
        bh=+zRVFBuibjWAL5fVcRaW6k78JJHhCAMQpAX3lost+Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKN1bKdwe6xSB4XkImaPdctn0lh0sazFxmOtwO3Y3YOpS/tNfBcGhCPRCs5qBWI75
         2nWBHfpq036h/Dpr064S0S5xvSGa7SRK2zfDwU6tzacx7S4lsJY+Exx+AfQhKXqqXT
         +GXrVQrej5tpJF28IqsnV5Z3atWFvbCK6J8yu4PU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/639] drm: rcar-du: Fix the return value in case of error in rcar_du_crtc_set_crc_source()
Date:   Fri, 24 Jan 2020 10:24:00 +0100
Message-Id: <20200124093056.175746677@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 4d486f18d91b1876040bf87e9ad78981a08b15a6 ]

We return 0 unconditionally in 'rcar_du_crtc_set_crc_source()'.
However, 'ret' is set to some error codes if some function calls fail.

Return 'ret' instead to propagate the error code.

Fixes: 47a52d024e89 ("media: drm: rcar-du: Add support for CRC computation")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 15dc9caa128ba..212e5e11e4b73 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -837,7 +837,7 @@ unlock:
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_crtc_funcs crtc_funcs_gen2 = {
-- 
2.20.1




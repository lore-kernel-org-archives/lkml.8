Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BAF20855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917031;
	bh=eti6+P1Fqn+SSZDZoeC9v4RjrU3Qoz4+ArnNK5BXTI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpTyZxINwUzzsImHmHMx6Zk35YmrVXjRsJoSWwkR+kW1bpWkkn174yxVZhFVBlMlA
	 YtSvrG/uDhKm9KSvaenjwtKcKhVPYL3NiUCvzxUi9IFgcAnxZ6JVtCYzBJre7rC4Of
	 bOHR5ZgCc+WQdz/QYeZ/olzifS8e/zACu5CTchU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgHTJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbgHTJuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:50:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD8D20724;
        Thu, 20 Aug 2020 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917023;
        bh=eti6+P1Fqn+SSZDZoeC9v4RjrU3Qoz4+ArnNK5BXTI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E02mD2Svutv30FaToxS2ZteOYSJYq2pV+gGRhTliV6yYvw0lG0F7HM1WiKukiaCGe
         /ZMfFF14DhaKF/XR6JQHj39AMuCm+lcRr39xV5kZn9OhE3izUd582qA0sXCiur+i9i
         rSSEiP7UE+m66shOPhrKOeptlpFSHUPgCBFnEMIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 128/152] drm/vmwgfx: Use correct vmw_legacy_display_unit pointer
Date:   Thu, 20 Aug 2020 11:21:35 +0200
Message-Id: <20200820091600.363924601@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 1d2c0c565bc0da25f5e899a862fb58e612b222df ]

The "entry" pointer is an offset from the list head and it doesn't
point to a valid vmw_legacy_display_unit struct.  Presumably the
intent was to point to the last entry.

Also the "i++" wasn't used so I have removed that as well.

Fixes: d7e1958dbe4a ("drm/vmwgfx: Support older hardware.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Signed-off-by: Roland Scheidegger <sroland@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 5702219ec38f6..7b54c1f56208f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -81,7 +81,7 @@ static int vmw_ldu_commit_list(struct vmw_private *dev_priv)
 	struct vmw_legacy_display_unit *entry;
 	struct drm_framebuffer *fb = NULL;
 	struct drm_crtc *crtc = NULL;
-	int i = 0;
+	int i;
 
 	/* If there is no display topology the host just assumes
 	 * that the guest will set the same layout as the host.
@@ -92,12 +92,11 @@ static int vmw_ldu_commit_list(struct vmw_private *dev_priv)
 			crtc = &entry->base.crtc;
 			w = max(w, crtc->x + crtc->mode.hdisplay);
 			h = max(h, crtc->y + crtc->mode.vdisplay);
-			i++;
 		}
 
 		if (crtc == NULL)
 			return 0;
-		fb = entry->base.crtc.primary->state->fb;
+		fb = crtc->primary->state->fb;
 
 		return vmw_kms_write_svga(dev_priv, w, h, fb->pitches[0],
 					  fb->format->cpp[0] * 8,
-- 
2.25.1




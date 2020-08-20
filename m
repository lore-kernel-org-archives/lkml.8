Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BC620738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919065;
	bh=sX5hb72mhQcxV5Y/NcLs73/WvcsHj26ueUFDCkJLfW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Nor+dCeoqwZ2jTw6JiGusT7z+YHYQb+ZzhjtOd4+Q9xjizjgkcMxclxQcDF0Ev8g
	 yQJZaT6/w52fMu1Pa5KBnCGE28UcE0sT8R1KkV0vDLUIuLzu3BI6L/vz1LCwvMhWXg
	 siOiRZGxPfHHnSFL8xd4DS0CnhzLwl9uDebkCehQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgHTKYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731771AbgHTKXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:23:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3BB2072D;
        Thu, 20 Aug 2020 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597919023;
        bh=sX5hb72mhQcxV5Y/NcLs73/WvcsHj26ueUFDCkJLfW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNOzyNMiGvfdMsrcrE5KPjXCpKmsA0GQw1vY/Vyz+QwCimiDC6rJsq/SD2icrdGyz
         0PXdvo0f0QOnpvcDAw4MqKaVf5b3BFF1koSCKLjM86rXWQIAjMQ39AVXAJOUnJ/jc2
         fhc0Wak/M6ulHFx6RuV4H1LmgYcbp+41wegytesk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 142/149] drm/vmwgfx: Fix two list_for_each loop exit tests
Date:   Thu, 20 Aug 2020 11:23:39 +0200
Message-Id: <20200820092132.573386609@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4437c1152ce0e57ab8f401aa696ea6291cc07ab1 ]

These if statements are supposed to be true if we ended the
list_for_each_entry() loops without hitting a break statement but they
don't work.

In the first loop, we increment "i" after the "if (i == unit)" condition
so we don't necessarily know that "i" is not equal to unit at the end of
the loop.

In the second loop we exit when mode is not pointing to a valid
drm_display_mode struct so it doesn't make sense to check "mode->type".

Fixes: a278724aa23c ("drm/vmwgfx: Implement fbdev on kms v2")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Signed-off-by: Roland Scheidegger <sroland@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9b97f70fbb3df..0b7427d474feb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2086,7 +2086,7 @@ int vmw_kms_fbdev_init_data(struct vmw_private *dev_priv,
 		++i;
 	}
 
-	if (i != unit) {
+	if (&con->head == &dev_priv->dev->mode_config.connector_list) {
 		DRM_ERROR("Could not find initial display unit.\n");
 		return -EINVAL;
 	}
@@ -2108,13 +2108,13 @@ int vmw_kms_fbdev_init_data(struct vmw_private *dev_priv,
 			break;
 	}
 
-	if (mode->type & DRM_MODE_TYPE_PREFERRED)
-		*p_mode = mode;
-	else {
+	if (&mode->head == &con->modes) {
 		WARN_ONCE(true, "Could not find initial preferred mode.\n");
 		*p_mode = list_first_entry(&con->modes,
 					   struct drm_display_mode,
 					   head);
+	} else {
+		*p_mode = mode;
 	}
 
 	return 0;
-- 
2.25.1




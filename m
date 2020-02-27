Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8AC76562
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8CC24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814297;
	bh=S+s3cWclEBY8U+vBbH0trtzvecUl92KL8gjlYd0sTYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HMrDhrfR6dGEr2UO0L0i5xAhc3LST7yclmPcXGOUlw6q50PGzOKohvOZE+6/xVm71
	 eVbEmEXu2kXBIJLq8VBDZ/IfmXK+R5gtcImVAaGFhA9KxdTpq1rR58IEGBMTQrVXkq
	 Z92GZEcRT7PGk2feeOoQrhFoQ6bPaqLlRAVxJ+xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgB0N4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgB0N4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C37424691;
        Thu, 27 Feb 2020 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811790;
        bh=S+s3cWclEBY8U+vBbH0trtzvecUl92KL8gjlYd0sTYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekC10kHxzDFA86LaRee7vySzhFuy5mjrtcOYZ89Uir27KgAkt9VEqBm+ifL3kAm6T
         e3HEglIoCrbrRQYCK/NlXPKvexMm0Gs2KH1NamLhGXGoNZZcEDhiC1HBJWEH0+JPVE
         fq00RUZKvMFlEWuwfSuwxN2YGSrp7ZQtBuu2nfgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dingchen Zhang <dingchen.zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 101/237] drm: remove the newline for CRC source name.
Date:   Thu, 27 Feb 2020 14:35:15 +0100
Message-Id: <20200227132304.382135185@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dingchen Zhang <dingchen.zhang@amd.com>

[ Upstream commit 72a848f5c46bab4c921edc9cbffd1ab273b2be17 ]

userspace may transfer a newline, and this terminating newline
is replaced by a '\0' to avoid followup issues.

'len-1' is the index to replace the newline of CRC source name.

v3: typo fix (Sam)

v2: update patch subject, body and format. (Sam)

Cc: Leo Li <sunpeng.li@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dingchen Zhang <dingchen.zhang@amd.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190610134751.14356-1-dingchen.zhang@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 2901b7944068d..6858c80d2eb50 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -101,8 +101,8 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
 	if (IS_ERR(source))
 		return PTR_ERR(source);
 
-	if (source[len] == '\n')
-		source[len] = '\0';
+	if (source[len - 1] == '\n')
+		source[len - 1] = '\0';
 
 	spin_lock_irq(&crc->lock);
 
-- 
2.20.1




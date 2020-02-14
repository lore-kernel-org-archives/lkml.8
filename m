Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD9C3B1A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699863;
	bh=9Vc0v1JqK/71fX1NoPBzcfm+OjFk+m3ebPM3yxVZ/X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSP7XzAgucuxcvpJiPyG+jk5hUyVTWHDjE8h7NW4JEv9mO4aYfxnAjZNQgn3LVKWV
	 FdnqtQJwAiPhQjPWTRnOPjT1z7H/AsXcjoYtKvfml2eVedGFiOff5YR5AXS6Ynysji
	 sBKhddOSaX8B0vsnBRsJkzrcUo9U/2K4+MU9ZiyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404150AbgBNQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392356AbgBNQOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC95246D9;
        Fri, 14 Feb 2020 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696880;
        bh=9Vc0v1JqK/71fX1NoPBzcfm+OjFk+m3ebPM3yxVZ/X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTFCnp0eyRCsS9ADfvW4waVHPt9WwIFrBZNgyWDAiJq9PsqTqWerfP40NAGr3+Z2p
         faB6/Dv7v8tQiuhRbPQkSz5mGG5TSBSfDn8zS3R9RAxOMO+e4jIKLeRcOVhz3PS3mU
         gyJ32fdpty209sjPFiZr2Dg4WUPJAQOvEM/D7u6c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dingchen Zhang <dingchen.zhang@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 135/252] drm: remove the newline for CRC source name.
Date:   Fri, 14 Feb 2020 11:09:50 -0500
Message-Id: <20200214161147.15842-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index c88e5ff41add6..a3c756710845e 100644
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


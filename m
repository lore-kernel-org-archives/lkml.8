Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5358DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D3206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648255;
	bh=T6vLV0I9Z44mhyDrMafziRQiy2e9aQq8OQOLsX3aPN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n5UtX/8gZ7Z+VZUJaNyAPHHONetEbxF6yGpBWDNOSieGLMUBXqnKjkgQRMEnLMmoM
	 yvWvl8HFz4SN+gpaFid0BMCTCcqTwaoLme5vi9LAFll2RrwFDZSPHQU2VnfMQOrbCf
	 Whhxivp8rEXikRyHHr4iLlzWqdANd8OHlqLauVUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgDKXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgDKXIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:08:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876F92173E;
        Sat, 11 Apr 2020 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646499;
        bh=T6vLV0I9Z44mhyDrMafziRQiy2e9aQq8OQOLsX3aPN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uyl9USwkiHAVKc/mfeHSakT5dfci9dGkzQuAuVg5PBlEKjJOhyw58Xj5JtDQO08iw
         kXjq+8dSbuZFmwsM/OinpZnjbHv8P/2hCCUq3sYWpOG6HJ3n7aVeEnUmark0i3KCFj
         FKoM70qevpy27XWIIQDGzBxfP6wK7zAn7k0y2TkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Jani Nikula <jani.nikula@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 060/121] fbdev: potential information leak in do_fb_ioctl()
Date:   Sat, 11 Apr 2020 19:06:05 -0400
Message-Id: <20200411230706.23855-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d3d19d6fc5736a798b118971935ce274f7deaa82 ]

The "fix" struct has a 2 byte hole after ->ywrapstep and the
"fix = info->fix;" assignment doesn't necessarily clear it.  It depends
on the compiler.  The solution is just to replace the assignment with an
memcpy().

Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200113100132.ixpaymordi24n3av@kili.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 6f6fc785b5453..28158e21672ad 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1110,7 +1110,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		break;
 	case FBIOGET_FSCREENINFO:
 		lock_fb_info(info);
-		fix = info->fix;
+		memcpy(&fix, &info->fix, sizeof(fix));
 		if (info->flags & FBINFO_HIDE_SMEM_START)
 			fix.smem_start = 0;
 		unlock_fb_info(info);
-- 
2.20.1


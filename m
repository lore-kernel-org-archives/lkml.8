Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F57C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1394A20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551243;
	bh=Q+q+ipws7emKNmWQE7TSTrDzOF5ydU+LXg9/Ag6dkfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wTLvY21+lmX2jRGg0lOFtZ1qSunVtxcalbg8HSZA/2Z/gFPKgLApkEIekxhxVOEz1
	 CGl8yuZfcrkezYh/7knWPNdH7f8zHmAHtnDm3ZqR5uIhl3vHEUYOrX9nz1gJGoQ+0q
	 HS2b+HpcchOTt7GU4scEwsWC/mXu4cXT97E77TcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgDVK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgDVK1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AED20857;
        Wed, 22 Apr 2020 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551234;
        bh=Q+q+ipws7emKNmWQE7TSTrDzOF5ydU+LXg9/Ag6dkfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erongcNOQLgjWM9Hj0jEN0RAGj/ncjy3vYnDwgK6t2ecJbc3FbTE6u3kBm5ogCHrh
         en+ypWFk2k8KLfJRug2Ek/RBGPAj1D9Ud1jTejgaxayA9DUZ5NeOb5Mv8FYpjvoYuS
         cxRwwHWkroPhtwQJGfKm8ClouAfvosSExDVVGphM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5.6 153/166] fbmem: Adjust indentation in fb_prepare_logo and fb_blank
Date:   Wed, 22 Apr 2020 11:58:00 +0200
Message-Id: <20200422095104.941539986@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 93166f5f2e4dc593cff8ca77ef828ac6f148b0f3 upstream.

Clang warns:

../drivers/video/fbdev/core/fbmem.c:665:3: warning: misleading
indentation; statement is not part of the previous 'else'
[-Wmisleading-indentation]
        if (fb_logo.depth > 4 && depth > 4) {
        ^
../drivers/video/fbdev/core/fbmem.c:661:2: note: previous statement is
here
        else
        ^
../drivers/video/fbdev/core/fbmem.c:1075:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        return ret;
        ^
../drivers/video/fbdev/core/fbmem.c:1072:2: note: previous statement is
here
        if (!ret)
        ^
2 warnings generated.

This warning occurs because there are spaces before the tabs on these
lines. Normalize the indentation in these functions so that it is
consistent with the Linux kernel coding style and clang no longer warns.

Fixes: 1692b37c99d5 ("fbdev: Fix logo if logo depth is less than framebuffer depth")
Link: https://github.com/ClangBuiltLinux/linux/issues/825
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191218030025.10064-1-natechancellor@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/core/fbmem.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -663,20 +663,20 @@ int fb_prepare_logo(struct fb_info *info
 		fb_logo.depth = 1;
 
 
- 	if (fb_logo.depth > 4 && depth > 4) {
- 		switch (info->fix.visual) {
- 		case FB_VISUAL_TRUECOLOR:
- 			fb_logo.needs_truepalette = 1;
- 			break;
- 		case FB_VISUAL_DIRECTCOLOR:
- 			fb_logo.needs_directpalette = 1;
- 			fb_logo.needs_cmapreset = 1;
- 			break;
- 		case FB_VISUAL_PSEUDOCOLOR:
- 			fb_logo.needs_cmapreset = 1;
- 			break;
- 		}
- 	}
+	if (fb_logo.depth > 4 && depth > 4) {
+		switch (info->fix.visual) {
+		case FB_VISUAL_TRUECOLOR:
+			fb_logo.needs_truepalette = 1;
+			break;
+		case FB_VISUAL_DIRECTCOLOR:
+			fb_logo.needs_directpalette = 1;
+			fb_logo.needs_cmapreset = 1;
+			break;
+		case FB_VISUAL_PSEUDOCOLOR:
+			fb_logo.needs_cmapreset = 1;
+			break;
+		}
+	}
 
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
@@ -1065,19 +1065,19 @@ fb_blank(struct fb_info *info, int blank
 	struct fb_event event;
 	int ret = -EINVAL;
 
- 	if (blank > FB_BLANK_POWERDOWN)
- 		blank = FB_BLANK_POWERDOWN;
+	if (blank > FB_BLANK_POWERDOWN)
+		blank = FB_BLANK_POWERDOWN;
 
 	event.info = info;
 	event.data = &blank;
 
 	if (info->fbops->fb_blank)
- 		ret = info->fbops->fb_blank(blank, info);
+		ret = info->fbops->fb_blank(blank, info);
 
 	if (!ret)
 		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
 
- 	return ret;
+	return ret;
 }
 EXPORT_SYMBOL(fb_blank);
 



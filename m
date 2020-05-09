Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99978C54E4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FE321473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgEIXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgEIXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E3CC05BD11;
        Sat,  9 May 2020 16:46:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAN-004iRs-H3; Sat, 09 May 2020 23:45:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
Date:   Sun, 10 May 2020 00:45:48 +0100
Message-Id: <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

addresses passed only to get_user() and put_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/video/fbdev/amifb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index 20e03e00b66d..6062104f3afb 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -1855,8 +1855,6 @@ static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var,
 	var->yspot = par->crsr.spot_y;
 	if (size > var->height * var->width)
 		return -ENAMETOOLONG;
-	if (!access_ok(data, size))
-		return -EFAULT;
 	delta = 1 << par->crsr.fmode;
 	lspr = lofsprite + (delta << 1);
 	if (par->bplcon0 & BPC0_LACE)
@@ -1935,8 +1933,6 @@ static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var,
 		return -EINVAL;
 	if (!var->height)
 		return -EINVAL;
-	if (!access_ok(data, var->width * var->height))
-		return -EFAULT;
 	delta = 1 << fmode;
 	lofsprite = shfsprite = (u_short *)spritememory;
 	lspr = lofsprite + (delta << 1);
-- 
2.11.0


Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655EC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB815207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="QyTRECjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD3UTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgD3UTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:19:31 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Apr 2020 13:19:31 PDT
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF65C035494;
        Thu, 30 Apr 2020 13:19:31 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id B3286D9D; Thu, 30 Apr 2020 22:10:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz B3286D9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588277410;
        bh=LI8AyQasZ8cXgvIw34LgJv8O60ewaoyaj7auuR4kHpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyTRECjUL5o1cOL6DP3CfiI90m9L1YmO6nuDJ9K67DcW/O0ll3sowbPywc4tsZgoZ
         piH5oMv366cVjTB72qDwI7z7T2tiUeYnkvhGNDIch4KJSxOloZTgS6JCKnCz8CkQh/
         OEND1beQEoWCM25UsCTCHQtUY1vnVCdo4RGnnLh0=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 2/3] staging: sm750fb: add common function to set color offsets and visual mode
Date:   Thu, 30 Apr 2020 22:09:25 +0200
Message-Id: <1588277366-19354-3-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will unify code for updating color offsets and frame buffer
visual mode.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/sm750.c | 149 ++++++++++++++------------------
 1 file changed, 67 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 39e610cc3c06..c3ce7e653c7f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -297,6 +297,62 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	return hw_sm750_pan_display(crtc, var, info);
 }
 
+static inline void lynxfb_set_visual_mode(struct fb_info *info)
+{
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 24:
+	case 32:
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	default:
+		break;
+	}
+}
+
+static inline int lynxfb_set_color_offsets(struct fb_info *info)
+{
+	lynxfb_set_visual_mode(info);
+
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		info->var.red.offset = 0;
+		info->var.red.length = 8;
+		info->var.green.offset = 0;
+		info->var.green.length = 8;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 8;
+		info->var.transp.length = 0;
+		info->var.transp.offset = 0;
+		break;
+	case 16:
+		info->var.red.offset = 11;
+		info->var.red.length = 5;
+		info->var.green.offset = 5;
+		info->var.green.length = 6;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 5;
+		info->var.transp.length = 0;
+		info->var.transp.offset = 0;
+		break;
+	case 24:
+	case 32:
+		info->var.red.offset = 16;
+		info->var.red.length = 8;
+		info->var.green.offset = 8;
+		info->var.green.length = 8;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int lynxfb_ops_set_par(struct fb_info *info)
 {
 	struct lynxfb_par *par;
@@ -328,43 +384,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	 * and these data should be set before setcolreg routine
 	 */
 
-	switch (var->bits_per_pixel) {
-	case 8:
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 16:
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	case 24:
-	case 32:
-		var->red.offset = 16;
-		var->red.length = 8;
-		var->green.offset = 8;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	ret = lynxfb_set_color_offsets(info);
+
 	var->height = var->width = -1;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
@@ -511,10 +532,12 @@ static int lynxfb_resume(struct pci_dev *pdev)
 static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
+	int ret;
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
 	resource_size_t request;
 
+	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
 
@@ -523,43 +546,13 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		 var->yres,
 		 var->bits_per_pixel);
 
-	switch (var->bits_per_pixel) {
-	case 8:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 16:
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		break;
-	case 24:
-	case 32:
-		var->red.offset = 16;
-		var->red.length = 8;
-		var->green.offset = 8;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		break;
-	default:
+	ret = lynxfb_set_color_offsets(info);
+
+	if (ret) {
 		pr_err("bpp %d not supported\n", var->bits_per_pixel);
-		return -EINVAL;
+		return ret;
 	}
+
 	var->height = var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
@@ -895,16 +888,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = sm750_dev->vidreg_size;
 	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
-	switch (var->bits_per_pixel) {
-	case 8:
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 16:
-	case 24:
-	case 32:
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	}
+
+	lynxfb_set_visual_mode(info);
 
 	/* set var */
 	var->activate = FB_ACTIVATE_NOW;
-- 
2.26.2


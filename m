Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73587C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4141220771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGWRCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:02:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGWRCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:02:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jyebz-0007Ya-Q9; Thu, 23 Jul 2020 17:02:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: fix setting of pixclock because a pass-by-value error
Date:   Thu, 23 Jul 2020 18:02:27 +0100
Message-Id: <20200723170227.996229-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pixclock is being set locally because it is being passed as a
pass-by-value argument rather than pass-by-reference, so the computed
pixclock is never being set in var->pixclock. Fix this by passing
by reference.

[This dates back to 2002, I found the offending commit from the git
history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git ]

Addresses-Coverity: ("Unused value")
Fixes: 115f4504a64a ("Removed currcon and other console related code. Very little is now left.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/vga16fb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index a20eeb8308ff..52f273af6cae 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -243,7 +243,7 @@ static void vga16fb_update_fix(struct fb_info *info)
 }
 
 static void vga16fb_clock_chip(struct vga16fb_par *par,
-			       unsigned int pixclock,
+			       unsigned int *pixclock,
 			       const struct fb_info *info,
 			       int mul, int div)
 {
@@ -259,14 +259,14 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
 		{     0 /* bad */,    0x00, 0x00}};
 	int err;
 
-	pixclock = (pixclock * mul) / div;
+	*pixclock = (*pixclock * mul) / div;
 	best = vgaclocks;
-	err = pixclock - best->pixclock;
+	err = *pixclock - best->pixclock;
 	if (err < 0) err = -err;
 	for (ptr = vgaclocks + 1; ptr->pixclock; ptr++) {
 		int tmp;
 
-		tmp = pixclock - ptr->pixclock;
+		tmp = *pixclock - ptr->pixclock;
 		if (tmp < 0) tmp = -tmp;
 		if (tmp < err) {
 			err = tmp;
@@ -275,7 +275,7 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
 	}
 	par->misc |= best->misc;
 	par->clkdiv = best->seq_clock_mode;
-	pixclock = (best->pixclock * div) / mul;		
+	*pixclock = (best->pixclock * div) / mul;
 }
 			       
 #define FAIL(X) return -EINVAL
@@ -497,10 +497,10 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 
 	if (mode & MODE_8BPP)
 		/* pixel clock == vga clock / 2 */
-		vga16fb_clock_chip(par, var->pixclock, info, 1, 2);
+		vga16fb_clock_chip(par, &var->pixclock, info, 1, 2);
 	else
 		/* pixel clock == vga clock */
-		vga16fb_clock_chip(par, var->pixclock, info, 1, 1);
+		vga16fb_clock_chip(par, &var->pixclock, info, 1, 1);
 	
 	var->red.offset = var->green.offset = var->blue.offset = 
 	var->transp.offset = 0;
-- 
2.27.0


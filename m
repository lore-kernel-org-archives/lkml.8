Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BBD2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgHYE5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:33 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:59242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728875AbgHYE5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B4CE01E09;
        Tue, 25 Aug 2020 04:57:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: roll40_43024e127059
X-Filterd-Recvd-Size: 2151
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:22 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 22/29] video: fbdev: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:19 -0700
Message-Id: <3e56046e67e583ac93030297ff6d58c08ca54086.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/tgafb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index e9869135d833..666fbe2f671c 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -989,8 +989,10 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	/* We can fill 2k pixels per operation.  Notice blocks that fit
 	   the width of the screen so that we can take advantage of this
 	   and fill more than one line per write.  */
-	if (width == line_length)
-		width *= height, height = 1;
+	if (width == line_length) {
+		width *= height;
+		height = 1;
+	}
 
 	/* The write into the frame buffer must be aligned to 4 bytes,
 	   but we are allowed to encode the offset within the word in
@@ -1171,8 +1173,10 @@ copyarea_8bpp(struct fb_info *info, u32 dx, u32 dy, u32 sx, u32 sy,
 	   More than anything else, these control how we do copies.  */
 	depos = dy * line_length + dx;
 	sepos = sy * line_length + sx;
-	if (backward)
-		depos += width, sepos += width;
+	if (backward) {
+		depos += width;
+		sepos += width;
+	}
 
 	/* Next copy full words at a time.  */
 	n32 = width / 32;
-- 
2.26.0


Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D988C206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGWKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:34:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgGWKe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:34:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A1C1AC52;
        Thu, 23 Jul 2020 10:35:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH -resend] Documentation: fb, fix path to modedb.c
Date:   Thu, 23 Jul 2020 12:34:54 +0200
Message-Id: <20200723103454.26167-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modedb.c was moved twice since the modedb documentation was written.
Update the path to the current one.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/fb/modedb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/modedb.rst b/Documentation/fb/modedb.rst
index 624d08fd2856..4d2411e32ebb 100644
--- a/Documentation/fb/modedb.rst
+++ b/Documentation/fb/modedb.rst
@@ -152,7 +152,7 @@ To specify a video mode at bootup, use the following boot options::
     video=<driver>:<xres>x<yres>[-<bpp>][@refresh]
 
 where <driver> is a name from the table below.  Valid default modes can be
-found in linux/drivers/video/modedb.c.  Check your driver's documentation.
+found in drivers/video/fbdev/core/modedb.c.  Check your driver's documentation.
 There may be more modes::
 
     Drivers that support modedb boot options
-- 
2.27.0


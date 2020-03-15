Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E28C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC23820637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAQtqekK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCOHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCOHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=GNC8Sm1AlFB7BS88maKHyPxziY/VU/zokv/Jjy4PIQ4=; b=XAQtqekKRTzL+RabbcoToO8+Pb
        3np37/P21Ced4oj36Wl0MV+8yLB1fraYDdERnsakSucNF62N9JhQqt3yx6Ud09mbgDRb+H6QWe6DT
        bBXo5+mjzZr2S/bhQCNBTYFA0AnVT8qrzUyJLObxctj0vzABBwYIO+2aQjHp0c9XEHT5xzfJbs8VQ
        rtfcGFAiDuelgNF5rQQ7kCCKXgqPUMS+EfbFxZu825mtGTd+VXUzSnjHBGj/dcXw0eeAcrRcXYTUK
        TeVfRNtMOLJaWvGtLXjZkM7hKNlnP8iBqFOxsEKnFy3P/Clt7GHEC8B086MFnJizDK02opXuzOcj+
        7rSoS4+Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDKbG-0003dY-Da; Sun, 15 Mar 2020 04:10:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH 5/6] fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
Date:   Sat, 14 Mar 2020 21:10:01 -0700
Message-Id: <20200315041002.24473-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'DEBUG' is not defined, modify the DPRINTK() macro to use the
no_printk() macro instead of using <empty>.
This fixes build warnings when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/pm2fb.c:227:38: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/video/fbdev/pm3fb.c:1039:33: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Also drop one argument in two DPRINTK() macro uses to provide the
correct number of arguments and use the correct field in one case
to fix a build error:

../drivers/video/fbdev/pm3fb.c:353:9: error: ‘struct fb_info’ has no member named ‘current_par’
     info->current_par->depth);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/pm2fb.c |    2 +-
 drivers/video/fbdev/pm3fb.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20200313.orig/drivers/video/fbdev/pm2fb.c
+++ linux-next-20200313/drivers/video/fbdev/pm2fb.c
@@ -54,7 +54,7 @@
 #define DPRINTK(a, b...)	\
 	printk(KERN_DEBUG "pm2fb: %s: " a, __func__ , ## b)
 #else
-#define DPRINTK(a, b...)
+#define DPRINTK(a, b...)	no_printk(a, ##b)
 #endif
 
 #define PM2_PIXMAP_SIZE	(1600 * 4)
--- linux-next-20200313.orig/drivers/video/fbdev/pm3fb.c
+++ linux-next-20200313/drivers/video/fbdev/pm3fb.c
@@ -44,7 +44,7 @@
 #define DPRINTK(a, b...)	\
 	printk(KERN_DEBUG "pm3fb: %s: " a, __func__ , ## b)
 #else
-#define DPRINTK(a, b...)
+#define DPRINTK(a, b...)	no_printk(a, ##b)
 #endif
 
 #define PM3_PIXMAP_SIZE	(2048 * 4)
@@ -306,7 +306,7 @@ static void pm3fb_init_engine(struct fb_
 					   PM3PixelSize_GLOBAL_32BIT);
 			break;
 		default:
-			DPRINTK(1, "Unsupported depth %d\n",
+			DPRINTK("Unsupported depth %d\n",
 				info->var.bits_per_pixel);
 			break;
 		}
@@ -349,8 +349,8 @@ static void pm3fb_init_engine(struct fb_
 					   (1 << 10) | (0 << 3));
 			break;
 		default:
-			DPRINTK(1, "Unsupported depth %d\n",
-				info->current_par->depth);
+			DPRINTK("Unsupported depth %d\n",
+				info->var.bits_per_pixel);
 			break;
 		}
 	}

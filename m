Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7B206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="st8Z+DAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgCOHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCOHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=IqXEYpa5QgkSb9VlNMgtVjJmY+6NusNQBweUhfnvqp0=; b=st8Z+DASEhH4MF2YEy3O7Q3W6m
        ieV0AF3sEphRQ+YXwVyizUW9BSHyPlTmuG/DzO7MH8nomb+B1zTjDCZSwMvkiLS8Mk8RkVNdAQ71p
        V7luiwLAvDw+HuTGnjQmE4H/c2kXZjO/pcQf7bj3blBtaJ0yp7vpys1hzD45B1/Ck00vNmgzY0Bt6
        yafwZtkt191zuX5YXonoA3ibN5E/NwTcqCUsmuPwXQClA1M8wvNN1GZVl2InBCE+f/IXwjPUGM3az
        9S/aaUKIhT+SyGg0/H/RWEA36kqpaZZG8RQLp24OqUsuSh8nf56D+8lc8isZ0hvLWnptgSP7/fQt9
        +uvaIZIg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDKbG-0003dY-Rq; Sun, 15 Mar 2020 04:10:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH 6/6] fbdev: via: fix -Wextra build warning and format warning
Date:   Sat, 14 Mar 2020 21:10:02 -0700
Message-Id: <20200315041002.24473-7-rdunlap@infradead.org>
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

When 'VIAFB_DEBUG' and 'VIAFB_WARN' are not defined, modify the
DEBUG_MSG() &WARN_MSG() macros to use the no_printk() macro instead of
using <empty>.
This fixes a build warning when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/via/ioctl.c:88:47: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Also use %lu to print an unsigned long instead of just %l, to fix
a printk format warning:

../drivers/video/fbdev/via/viafbdev.c: In function ‘viafb_dvp0_proc_write’:
../drivers/video/fbdev/via/viafbdev.c:1148:14: warning: unknown conversion type character ‘]’ in format [-Wformat=]
    DEBUG_MSG("DVP0:reg_val[%l]=:%x\n", i,

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/via/debug.h    |    6 ++++--
 drivers/video/fbdev/via/viafbdev.c |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20200313.orig/drivers/video/fbdev/via/debug.h
+++ linux-next-20200313/drivers/video/fbdev/via/debug.h
@@ -7,6 +7,8 @@
 #ifndef __DEBUG_H__
 #define __DEBUG_H__
 
+#include <linux/printk.h>
+
 #ifndef VIAFB_DEBUG
 #define VIAFB_DEBUG 0
 #endif
@@ -14,14 +16,14 @@
 #if VIAFB_DEBUG
 #define DEBUG_MSG(f, a...)   printk(f, ## a)
 #else
-#define DEBUG_MSG(f, a...)
+#define DEBUG_MSG(f, a...)   no_printk(f, ## a)
 #endif
 
 #define VIAFB_WARN 0
 #if VIAFB_WARN
 #define WARN_MSG(f, a...)   printk(f, ## a)
 #else
-#define WARN_MSG(f, a...)
+#define WARN_MSG(f, a...)   no_printk(f, ## a)
 #endif
 
 #endif /* __DEBUG_H__ */
--- linux-next-20200313.orig/drivers/video/fbdev/via/viafbdev.c
+++ linux-next-20200313/drivers/video/fbdev/via/viafbdev.c
@@ -1144,7 +1144,7 @@ static ssize_t viafb_dvp0_proc_write(str
 		if (value != NULL) {
 			if (kstrtou8(value, 0, &reg_val) < 0)
 				return -EINVAL;
-			DEBUG_MSG(KERN_INFO "DVP0:reg_val[%l]=:%x\n", i,
+			DEBUG_MSG(KERN_INFO "DVP0:reg_val[%lu]=:%x\n", i,
 				  reg_val);
 			switch (i) {
 			case 0:

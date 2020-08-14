Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C792C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300ED2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHNM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHNM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:57:25 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Aug 2020 05:57:25 PDT
Received: from mx2.mailbox.org (mx2a.mailbox.org [IPv6:2001:67c:2050:104:0:2:25:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA22C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 05:57:24 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 08253A11F8;
        Fri, 14 Aug 2020 14:52:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id WAjYwPStBhZj; Fri, 14 Aug 2020 14:51:59 +0200 (CEST)
From:   Thomas Martitz <t.martitz@avm.de>
To:     3chas3@gmail.com
Cc:     tsbogend@alpha.franken.de, chris@zankel.net,
        linux-kernel@vger.kernel.org, Thomas Martitz <t.martitz@avm.de>
Subject: [PATCH] uapi: remove a few asm/ioctl.h includes
Date:   Fri, 14 Aug 2020 14:51:42 +0200
Message-Id: <20200814125142.1131183-1-t.martitz@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: **
X-Rspamd-Score: 2.99 / 15.00 / 15.00
X-Rspamd-Queue-Id: DF62E1825
X-Rspamd-UID: 6c0594
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the following warnings when build userspace for our MIPS-based boards:

include/asm-generic/ioctl.h:65: warning: "_IOC" redefined

It appears that asm/ioctl.h does not play well when compiling against musl libc.
Since almost all other uapi headers that wrap _IOC() and friends do *not*
include asm/ioctl.h itself, lets follow this route for sickios.h and atmioc.h.

The userspace is required to include <sys/ioctl.h> anyway when it wants
to call ioctl() for any macro provided by the affected headers.
---
 arch/mips/include/uapi/asm/sockios.h   | 2 --
 arch/xtensa/include/uapi/asm/sockios.h | 2 --
 include/uapi/linux/atmioc.h            | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/sockios.h b/arch/mips/include/uapi/asm/sockios.h
index 66f60234f290b..a96f3ea5430f5 100644
--- a/arch/mips/include/uapi/asm/sockios.h
+++ b/arch/mips/include/uapi/asm/sockios.h
@@ -11,8 +11,6 @@
 #ifndef _ASM_SOCKIOS_H
 #define _ASM_SOCKIOS_H
 
-#include <asm/ioctl.h>
-
 /* Socket-level I/O control calls. */
 #define FIOGETOWN	_IOR('f', 123, int)
 #define FIOSETOWN	_IOW('f', 124, int)
diff --git a/arch/xtensa/include/uapi/asm/sockios.h b/arch/xtensa/include/uapi/asm/sockios.h
index 1a1f58f4b75a2..71d05c88b8178 100644
--- a/arch/xtensa/include/uapi/asm/sockios.h
+++ b/arch/xtensa/include/uapi/asm/sockios.h
@@ -15,8 +15,6 @@
 #ifndef _XTENSA_SOCKIOS_H
 #define _XTENSA_SOCKIOS_H
 
-#include <asm/ioctl.h>
-
 /* Socket-level I/O control calls. */
 
 #define FIOGETOWN	_IOR('f', 123, int)
diff --git a/include/uapi/linux/atmioc.h b/include/uapi/linux/atmioc.h
index cd7655e40c77a..36a51ca18ea3c 100644
--- a/include/uapi/linux/atmioc.h
+++ b/include/uapi/linux/atmioc.h
@@ -13,9 +13,6 @@
 #ifndef _LINUX_ATMIOC_H
 #define _LINUX_ATMIOC_H
 
-#include <asm/ioctl.h>
-		/* everybody including atmioc.h will also need _IO{,R,W,WR} */
-
 #define ATMIOC_PHYCOM	  0x00 /* PHY device common ioctls, globally unique */
 #define ATMIOC_PHYCOM_END 0x0f
 #define ATMIOC_PHYTYP	  0x10 /* PHY dev type ioctls, unique per PHY type */
-- 
2.25.1


Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81BC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D812054F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKPJAx/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDEVXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:23:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDEVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 17:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1bSAoNjjVhZ9m44/kWpp+i3FIfhtB9K+lSQSxztifj4=; b=QKPJAx/FbRHO7YZcuylhuI7xbH
        7L788mFI9+FiALAxEOugwOKg26vRnZEj1RlZc1FscGuta2KQkBbX4UkvG+Yu2Lv4NCrNipxsYF5KC
        x5cFttriyWGx5Q8bew9cFoUoMS/tbW18FIY3QicvMjbxBhffQpjcBMHjjj6CvXXpBhWuWL+CY6da9
        hDDQDhkK61I4pPYZO8OcvP3cQubdkMOt/6my8Pf8c4lKQuzN5QVHB/6nt0EcW4hyAycCvnmBm8QYC
        Q81aftJxET3x84lUEPwEQI+qXq63FdYzaHEIbRp/13owjggcKZp3yvb0VTK5XbwHq+i+ADMEi9UP2
        h75Q2f1w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLCjJ-0008Fr-Ip; Sun, 05 Apr 2020 21:22:57 +0000
To:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] jffs2: fix if/else empty body warnings
Message-ID: <1f7332d5-c08d-77e2-e194-ce929eae7147@infradead.org>
Date:   Sun, 5 Apr 2020 14:22:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When debug (print) macros are not enabled, change them to use the
no_printk() macro instead of <nothing>. This fixes gcc warnings when
-Wextra is used:

../fs/jffs2/nodelist.c:255:37: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../fs/jffs2/nodelist.c:278:38: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../fs/jffs2/nodelist.c:558:52: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../fs/jffs2/xattr.c:1247:58: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../fs/jffs2/xattr.c:1281:65: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Builds without warnings on all 3 levels of CONFIG_JFFS2_FS_DEBUG.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
 fs/jffs2/debug.h |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- linux-next-20200330.orig/fs/jffs2/debug.h
+++ linux-next-20200330/fs/jffs2/debug.h
@@ -13,6 +13,7 @@
 #ifndef _JFFS2_DEBUG_H_
 #define _JFFS2_DEBUG_H_
 
+#include <linux/printk.h>
 #include <linux/sched.h>
 
 #ifndef CONFIG_JFFS2_FS_DEBUG
@@ -99,73 +100,73 @@ do {						\
 #ifdef JFFS2_DBG_READINODE_MESSAGES
 #define dbg_readinode(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_readinode(fmt, ...)
+#define dbg_readinode(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 #ifdef JFFS2_DBG_READINODE2_MESSAGES
 #define dbg_readinode2(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_readinode2(fmt, ...)
+#define dbg_readinode2(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Fragtree build debugging messages */
 #ifdef JFFS2_DBG_FRAGTREE_MESSAGES
 #define dbg_fragtree(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_fragtree(fmt, ...)
+#define dbg_fragtree(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 #ifdef JFFS2_DBG_FRAGTREE2_MESSAGES
 #define dbg_fragtree2(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_fragtree2(fmt, ...)
+#define dbg_fragtree2(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Directory entry list manilulation debugging messages */
 #ifdef JFFS2_DBG_DENTLIST_MESSAGES
 #define dbg_dentlist(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_dentlist(fmt, ...)
+#define dbg_dentlist(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Print the messages about manipulating node_refs */
 #ifdef JFFS2_DBG_NODEREF_MESSAGES
 #define dbg_noderef(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_noderef(fmt, ...)
+#define dbg_noderef(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Manipulations with the list of inodes (JFFS2 inocache) */
 #ifdef JFFS2_DBG_INOCACHE_MESSAGES
 #define dbg_inocache(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_inocache(fmt, ...)
+#define dbg_inocache(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Summary debugging messages */
 #ifdef JFFS2_DBG_SUMMARY_MESSAGES
 #define dbg_summary(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_summary(fmt, ...)
+#define dbg_summary(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* File system build messages */
 #ifdef JFFS2_DBG_FSBUILD_MESSAGES
 #define dbg_fsbuild(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_fsbuild(fmt, ...)
+#define dbg_fsbuild(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Watch the object allocations */
 #ifdef JFFS2_DBG_MEMALLOC_MESSAGES
 #define dbg_memalloc(fmt, ...)	JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_memalloc(fmt, ...)
+#define dbg_memalloc(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* Watch the XATTR subsystem */
 #ifdef JFFS2_DBG_XATTR_MESSAGES
 #define dbg_xattr(fmt, ...)  JFFS2_DEBUG(fmt, ##__VA_ARGS__)
 #else
-#define dbg_xattr(fmt, ...)
+#define dbg_xattr(fmt, ...)  no_printk(fmt, ##__VA_ARGS__)
 #endif 
 
 /* "Sanity" checks */



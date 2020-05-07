Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277B42495B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877492;
	bh=jpe2+TjrMnwu2H2dyg8faPNc4w8u0PpZiuofrEf/xT4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=o0S2y+jTeEmLzdClu6flngUTWaP7BolOPflQIPpQncD5gEIzA9mEhhLMoa9xIRF0l
	 ko3xKzqdloAzT9m4YcLnRo0hFo7XJt2kP7i/YUHVVj8VQOPlGcvfwvUPUxD7YN3KW8
	 s2GDw//Lsm5DCxZZ1idrp/+aVMIDYFCbmGxJ0mF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEGSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgEGSva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:51:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BEA24957;
        Thu,  7 May 2020 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877489;
        bh=jpe2+TjrMnwu2H2dyg8faPNc4w8u0PpZiuofrEf/xT4=;
        h=Date:From:To:Cc:Subject:From;
        b=hz8cQChXh4vf4srecpx8AKf9ARB4tro3ux3p9bC04rzou9lBEqxu5pkbcV3YwAtr2
         XUwYFhyS8iTI6CUN6Q+S9Uc74jYWdfW+65avnCLWTDVyt3HsikQ5A5dw0XkdBBQl+x
         oPrZRUZlVP/L2sy9TBxninEpu8ywVfKmb8NKsai0=
Date:   Thu, 7 May 2020 13:55:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: Replace zero-length array with flexible-array
Message-ID: <20200507185555.GA14739@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/jffs2/nodelist.h |    2 +-
 fs/jffs2/summary.h  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..8ff4d1a1e774 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -259,7 +259,7 @@ struct jffs2_full_dirent
 	uint32_t ino; /* == zero for unlink */
 	unsigned int nhash;
 	unsigned char type;
-	unsigned char name[0];
+	unsigned char name[];
 };
 
 /*
diff --git a/fs/jffs2/summary.h b/fs/jffs2/summary.h
index 60207a2ae952..e4131cb1f1d4 100644
--- a/fs/jffs2/summary.h
+++ b/fs/jffs2/summary.h
@@ -61,7 +61,7 @@ struct jffs2_sum_dirent_flash
 	jint32_t ino; 		/* == zero for unlink */
 	uint8_t nsize;		/* dirent name size */
 	uint8_t type;		/* dirent type */
-	uint8_t name[0];	/* dirent name */
+	uint8_t name[];	/* dirent name */
 } __attribute__((packed));
 
 struct jffs2_sum_xattr_flash
@@ -117,7 +117,7 @@ struct jffs2_sum_dirent_mem
 	jint32_t ino; 		/* == zero for unlink */
 	uint8_t nsize;		/* dirent name size */
 	uint8_t type;		/* dirent type */
-	uint8_t name[0];	/* dirent name */
+	uint8_t name[];	/* dirent name */
 } __attribute__((packed));
 
 struct jffs2_sum_xattr_mem


Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681FC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55E82495E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877486;
	bh=kMFA0b6aS1twModq1yHlIZlHwtdzbcyRe3/MvSJiG0s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FeJz1YXsC0dds7IMWIABvVjDgTGFVY9yKF1+W9/yIg37XgDXDmSXQyHkNbq1D3Dyw
	 X3dLDb/S651/EePCBqsfSeoPp+0KvzJdxynVb548jaKZKXumA+Yf7BljdZdxXOaIhd
	 sMr6FPRlqnCc48CCf11PJNrmXvZx21DtU/9NNH9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEGSvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgEGSvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:51:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9977A2495D;
        Thu,  7 May 2020 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877483;
        bh=kMFA0b6aS1twModq1yHlIZlHwtdzbcyRe3/MvSJiG0s=;
        h=Date:From:To:Cc:Subject:From;
        b=JCrk0uwwkhfkTLux/mgp5WxUeHMtQt5a6q0bHSOxYvZT8vyTogP0sJafOoEk4JRXW
         PIZOaa/Q+GYFBzbxJk0/szjg53/lf2XEHowx2S/TdV4GAH2+FlRSOj6KMgpcKOOm5s
         BsUeOg5xzmGksQMqfqO+76ntwhcL9D3rLq42GPKE=
Date:   Thu, 7 May 2020 13:55:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] JFS: Replace zero-length array with flexible-array
Message-ID: <20200507185550.GA14715@embeddedor>
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
 fs/jfs/jfs_dtree.c |    2 +-
 fs/jfs/jfs_xattr.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 3acc954f7c04..837d42f61464 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2964,7 +2964,7 @@ struct jfs_dirent {
 	loff_t position;
 	int ino;
 	u16 name_len;
-	char name[0];
+	char name[];
 };
 
 /*
diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index f0558b3348da..c50167a7bc50 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -17,12 +17,12 @@ struct jfs_ea {
 	u8 flag;	/* Unused? */
 	u8 namelen;	/* Length of name */
 	__le16 valuelen;	/* Length of value */
-	char name[0];	/* Attribute name (includes null-terminator) */
+	char name[];	/* Attribute name (includes null-terminator) */
 };			/* Value immediately follows name */
 
 struct jfs_ea_list {
 	__le32 size;		/* overall size */
-	struct jfs_ea ea[0];	/* Variable length list */
+	struct jfs_ea ea[];	/* Variable length list */
 };
 
 /* Macros for defining maxiumum number of bytes supported for EAs */


Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BA7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE35B2495E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877519;
	bh=tb88XbEj5l3Q8hlLvjSFDYyXEsoljocVtv2zF60ic9c=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SbtN3H74I/ITEAmTJOrqDe+4KAIA4jNdiOtzv9LKZJMlRH6NkLwA/UIguL7YF/Mnu
	 kWZPT+fsOXt9Uai4mzegK/WkOx4IoHbbBoh73A0g/Cnf3ADc0QyPBlFqDva3GnhIJv
	 JyJHa6/T71ZUQebOSPuUVOFKxTnvatzVFGnLjtJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgEGSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGSv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:51:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949AC2495D;
        Thu,  7 May 2020 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877517;
        bh=tb88XbEj5l3Q8hlLvjSFDYyXEsoljocVtv2zF60ic9c=;
        h=Date:From:To:Cc:Subject:From;
        b=YvnTNunoqaWZ81+jr/hN3xIN+LHMIOK4+Xrhzqz8vPKpFsOmeWNNFR2e7b4b5V1CC
         RrlPTzEhNB9Uh4JhFQbbgyZSKY+m2+0wZOLcr46kneZ8yRBb5ZYb1Za5qhdDA6jXwX
         MnVUTwGjzv3fAC5vKtvIYuiZ9v9gbEd363lYw1co=
Date:   Thu, 7 May 2020 13:56:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: Replace zero-length array with flexible-array
Message-ID: <20200507185624.GA14851@embeddedor>
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
 include/linux/kexec.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1776eb2e43a4..ea67910ae6b7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -208,7 +208,7 @@ struct crash_mem_range {
 struct crash_mem {
 	unsigned int max_nr_ranges;
 	unsigned int nr_ranges;
-	struct crash_mem_range ranges[0];
+	struct crash_mem_range ranges[];
 };
 
 extern int crash_exclude_mem_range(struct crash_mem *mem,


Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5000CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237A7208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878915;
	bh=Fv62hI8/xNXZ07gGOuPeEEfpxeEfhc1E3ooEcvdgwew=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mZ41CUdvFjDZKl4txBmR+9HCuLGztN9e8vmdMTwVpY8N/qja3rCUia/sMl9iOYVPS
	 SzfaaGoLRucAGgGihd91OmTQQIVVIxk0hOk1Q5ChXJdpeV08hAUHE+gNdMsCFYkd/b
	 CRuX8MlLQvvjK6V956EpdL6GV7qB4EkNZxRSiK9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgEGTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:15:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D0B208D6;
        Thu,  7 May 2020 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878912;
        bh=Fv62hI8/xNXZ07gGOuPeEEfpxeEfhc1E3ooEcvdgwew=;
        h=Date:From:To:Cc:Subject:From;
        b=vL+2RiWfF9+nETYPHcJkofvBiDguX1RiLxxJ78lEN1or7o3EYFlQt/BNOSB7j8ZVC
         8mb8KpXOf4rF9xh55D/YNdG5bsn20ft8aLZtQMhA7Memkh+Yn6TfGVXvVgZ+NNgg1w
         bhJ+Rkq/YcfN2p0R9jXSWm8llxUqnPot0bbO3RIM=
Date:   Thu, 7 May 2020 14:19:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: Replace zero-length array with flexible-array
Message-ID: <20200507191938.GA16011@embeddedor>
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
 drivers/rapidio/rio-scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 0e90c5d4bb2b..eb8ed28533f8 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -39,7 +39,7 @@ struct rio_id_table {
 	u16 start;	/* logical minimal id */
 	u32 max;	/* max number of IDs in table */
 	spinlock_t lock;
-	unsigned long table[0];
+	unsigned long table[];
 };
 
 static int next_destid = 0;


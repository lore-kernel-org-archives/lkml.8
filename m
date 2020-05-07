Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A09C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE124955
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877350;
	bh=4GCVx+2RHoZeWNOgLAGUpHALfHphcxV+yPDeC6Otr4Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=l/1eHYogEygay/NZp97W8JOkqgPET5N35Uc1/NeNSaxVxBAp2HV2fdV5QNcjj+v1U
	 Vo5OKG0p8H9TCzBRKP46Kt9EqjcTRTduXse4hiHx8dbciTfRBIdvaxlrasBrLG/kQ0
	 4mDsuTJQ+5FigWtTCliQr/itEmwPks4tSQqDC8OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEGStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgEGStI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:49:08 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE3E24955;
        Thu,  7 May 2020 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877348;
        bh=4GCVx+2RHoZeWNOgLAGUpHALfHphcxV+yPDeC6Otr4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=orbhB2V2scM3I+LsVS/m9YyjsPbMlFhuTcvqz0sPGcQCFuu32wMkViHmA0vAd0X4D
         40VPLekXIR4qc9ZFLc26a+v+aZj9+3uPx1MbvYE2Tx5fZMUTny+wxpbaJBofbfGgpm
         9P1j1mW/xtWuBZYgYd/Jh4ZcgtC2DT4Nv5dfh/S0=
Date:   Thu, 7 May 2020 13:53:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: Replace zero-length array with flexible-array
Message-ID: <20200507185334.GA14456@embeddedor>
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
 arch/ia64/kernel/unwind_i.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/unwind_i.h b/arch/ia64/kernel/unwind_i.h
index 67994a7e5816..1dd57ba44327 100644
--- a/arch/ia64/kernel/unwind_i.h
+++ b/arch/ia64/kernel/unwind_i.h
@@ -42,7 +42,7 @@ enum unw_register_index {
 
 struct unw_info_block {
 	u64 header;
-	u64 desc[0];		/* unwind descriptors */
+	u64 desc[];		/* unwind descriptors */
 	/* personality routine and language-specific data follow behind descriptors */
 };
 


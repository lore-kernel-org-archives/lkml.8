Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1DA24959
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877274;
	bh=dROCvQhuhTk/4ReemAeIpwKD9k2gIx4WZ5RfjEiUzYg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dn5nUCtsrWlakrY45naxamLj+k/t5vchfC+OjqsWpeppp2XvQWDl9R3CNYQAyvT4C
	 f4ryeK/xadP5gfihFsyQjgPWOd6I2aID6pA5ADwe6CuCb+YjIm4msZ6cRpq+qQ56qT
	 bGy+LA2EWqQPxRcKSWhMW/hRUDJv2yxoGorqNYDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEGSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:47:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920C124956;
        Thu,  7 May 2020 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877272;
        bh=dROCvQhuhTk/4ReemAeIpwKD9k2gIx4WZ5RfjEiUzYg=;
        h=Date:From:To:Cc:Subject:From;
        b=oSNUyDWfd/GhoGbkJciFaZdX5iWBf7Ei9QgXvUre8JgelT7EwTWVnZ/QkjXfM2Y5B
         699MdkiGbeY9eZl74bOIeL7bS76Sya7m0Hvw9Fq1YoAYkThJRH/YYfo6jy2ZNKQPqV
         6BKDIHykYuAfk/tIGmWv7BuDVF6J7N8E1axmzp6E=
Date:   Thu, 7 May 2020 13:52:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Replace zero-length array with flexible-array
Message-ID: <20200507185218.GA14186@embeddedor>
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
 include/drm/drm_displayid.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index 9d3b745c3107..94b4390bf990 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -89,7 +89,7 @@ struct displayid_detailed_timings_1 {
 
 struct displayid_detailed_timing_block {
 	struct displayid_block base;
-	struct displayid_detailed_timings_1 timings[0];
+	struct displayid_detailed_timings_1 timings[];
 };
 
 #define for_each_displayid_db(displayid, block, idx, length) \


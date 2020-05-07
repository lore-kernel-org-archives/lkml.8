Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE18C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3323A2184D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878162;
	bh=MvBOv5f4AnG3bBssPq+5ht2GAR9BRHaG65kfeHCY7fA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EBrfGVWJOGc/TsXSciBw7qcr5pbr7xZxljuuJghAxfUuEfBK48Fxzbhd60ezqPXFH
	 mmkFr6VIZm+Vgv6IgqgYFIRhffk6AHaBCBdIMrWJZfk787vOvpPJNOAtFk4KYOshQ6
	 r7hOBdeCZgfgCgdLERDQkxSgAIzboR5VHiBaU0Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEGTCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgEGTCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:02:40 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AEA2083B;
        Thu,  7 May 2020 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878160;
        bh=MvBOv5f4AnG3bBssPq+5ht2GAR9BRHaG65kfeHCY7fA=;
        h=Date:From:To:Cc:Subject:From;
        b=nkas9jw1s+UvIwksoB7oU5kB8Bcc2Hp0PBvQHgvMXl8qMqFhhlcLcGXS5/wkNuAdd
         qzp2zAqxS7vf/WtwS/7CN4aVSj2vNOKls0qI4RyMKLAPOZHZk/kQ2wK9MVZebAAcu0
         sBHkjQXNb7PY9gN4oN25Dd/KYNylzqKctGkiKUS4=
Date:   Thu, 7 May 2020 14:07:06 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: pwc: Replace zero-length array with flexible-array
Message-ID: <20200507190706.GA15730@embeddedor>
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
 drivers/media/usb/pwc/pwc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pwc/pwc.h b/drivers/media/usb/pwc/pwc.h
index 3362962d0d00..b02a3c7b7742 100644
--- a/drivers/media/usb/pwc/pwc.h
+++ b/drivers/media/usb/pwc/pwc.h
@@ -193,7 +193,7 @@ struct pwc_raw_frame {
 				   decompressor) */
 	__u8   cmd[4];		/* the four byte of the command (in case of
 				   nala, only the first 3 bytes is filled) */
-	__u8   rawframe[0];	/* frame_size = H / 4 * vbandlength */
+	__u8   rawframe[];	/* frame_size = H / 4 * vbandlength */
 } __packed;
 
 /* intermediate buffers with raw data from the USB cam */


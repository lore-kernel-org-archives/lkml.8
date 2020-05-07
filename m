Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F931C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7FC208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878925;
	bh=XgVvt1I6zgp7hLrKdR8zya9BZUOMROQtmE4xGkXj+ss=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=k4bOi+I3aWcdChgsPe5FjJWgtX1bTP0ewxrfd5NG5/zS0b0h+wmDeh11/C26Lfk82
	 fnAvlfzXDEDPKlQiEGjjVK02AmjpsNuASvq13pxGb3BK+R4+h3ZMdsJeHZCOrzC/6h
	 I11bSnVRdCNiTMKd3bdu5/3HfJmdCeaBG+dqvbR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgEGTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:15:22 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA536208E4;
        Thu,  7 May 2020 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878922;
        bh=XgVvt1I6zgp7hLrKdR8zya9BZUOMROQtmE4xGkXj+ss=;
        h=Date:From:To:Cc:Subject:From;
        b=wLn2qSA4qpYqsA72eamB1zrIXEE6uFQx70pjJyUNZlsYUB5Xh+6Q9BNNHv3pGthwf
         LKxFzO7YPbb5uelvKtb5IGuBejb38oM2LsuinYVvrSJRLy+rDc2fMk5HBefXqSJfOj
         yTSbeRzKcLaOa6xgWLsmsywvdpnOzqaakoIpRsn8=
Date:   Thu, 7 May 2020 14:19:48 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: Replace zero-length array with flexible-array
Message-ID: <20200507191948.GA16053@embeddedor>
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
 drivers/rpmsg/virtio_rpmsg_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 376ebbf880d6..07d4f3374098 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -89,7 +89,7 @@ struct rpmsg_hdr {
 	u32 reserved;
 	u16 len;
 	u16 flags;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /**


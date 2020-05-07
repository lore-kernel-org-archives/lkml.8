Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E8021835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879348;
	bh=27j1iFeO7/uFIYuS96IIzx3OB0gXSl5+yOvIErECFgA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HGW9SGO31durJDk0QVPAtsNeD6vPdlCW8tYzBoWem5petQviDrVZ0zIuaiWtId5Cw
	 lJCPlhUTAf6Wl9u0BIgGY3JK+EXQGySGt0K5HO0bBh3D1QlNtXzLQ1sp3ThHwnwjzs
	 +IiLma+Lote7bJuQmbtjur6JfPKSJjOlT1yeqpyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgEGTW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEGTW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:22:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC911208E4;
        Thu,  7 May 2020 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879346;
        bh=27j1iFeO7/uFIYuS96IIzx3OB0gXSl5+yOvIErECFgA=;
        h=Date:From:To:Cc:Subject:From;
        b=xdPU4qJBkKugdQKmTvNZ2uh/J5SNwl5PKpj9KHLoeisbBtvnthXjdCts/VAbUpF1Z
         1rPoTGkanvQxgf/aGjFuqKknFYxeNFtO4pkx4JikGk00RVhjb+rYQ2tmdqGGE1L0MS
         ztiO3xcXYnYL1TwODWrRUwZJSvdyzMi6nRDB19/A=
Date:   Thu, 7 May 2020 14:26:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: virtio: Replace zero-length array with flexible-array
Message-ID: <20200507192652.GA16743@embeddedor>
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
 arch/um/drivers/vector_kern.h |    2 +-
 arch/um/drivers/vhost_user.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index d0159082faf0..8fff93a75a92 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -129,7 +129,7 @@ struct vector_private {
 	struct vector_estats estats;
 	struct sock_fprog *bpf;
 
-	char user[0];
+	char user[];
 };
 
 extern int build_transport_data(struct vector_private *vp);
diff --git a/arch/um/drivers/vhost_user.h b/arch/um/drivers/vhost_user.h
index 6c71b6005177..6f147cd3c9f7 100644
--- a/arch/um/drivers/vhost_user.h
+++ b/arch/um/drivers/vhost_user.h
@@ -78,7 +78,7 @@ struct vhost_user_config {
 	u32 offset;
 	u32 size;
 	u32 flags;
-	u8 payload[0]; /* Variable length */
+	u8 payload[]; /* Variable length */
 } __packed;
 
 struct vhost_user_vring_state {


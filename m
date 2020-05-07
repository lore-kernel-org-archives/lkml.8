Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC739C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF68421835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877696;
	bh=HAF/oRojkDljr1eFLRHqTl9dtHCZGeFR/+2LDxzGKKY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mF43H0uRdWgfhlO4LWn+5SpghSG5VVTBHNTmatV1A78KodOEGsxC1zDGoKVfeHrOL
	 W3DtW02jeY8Dc91h8eL0zxJAM9uUM+QMURbET78mjrRpDXyUBYfnV7/kezY6RHAxjK
	 jpaS/jZs37LYfcaKxuPaOqzEd2VM0d/+IXNaHEOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgEGSy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgEGSyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:54:55 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F5E20575;
        Thu,  7 May 2020 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877694;
        bh=HAF/oRojkDljr1eFLRHqTl9dtHCZGeFR/+2LDxzGKKY=;
        h=Date:From:To:Cc:Subject:From;
        b=2EhmErFn2LX85sjp/FeeJMucTQta5AEMMF5VhGW2+khwX+hDXK9DvM3PDerwrWSzc
         pP5EnH/kZRTLqEtfwNo4xlmAlbu4Sd94+WTd0le1kMUyyxaNSlC2g6UGRgAZnzn5bf
         6lupoaMB2lCCK0sSNkkAToITfMdc1WT+GN3MQbfA=
Date:   Thu, 7 May 2020 13:59:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tariq Toukan <tariqt@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/mlx4: Replace zero-length array with flexible-array
Message-ID: <20200507185921.GA15146@embeddedor>
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
 include/linux/mlx4/qp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mlx4/qp.h b/include/linux/mlx4/qp.h
index 8e2828d48d7f..9db93e487496 100644
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -362,7 +362,7 @@ struct mlx4_wqe_datagram_seg {
 
 struct mlx4_wqe_lso_seg {
 	__be32			mss_hdr_size;
-	__be32			header[0];
+	__be32			header[];
 };
 
 enum mlx4_wqe_bind_seg_flags2 {


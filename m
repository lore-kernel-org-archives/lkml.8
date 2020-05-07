Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F24C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6716E2495E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877605;
	bh=LtgQkSM/IwxpKlPxttxhXPuDElKoRhjvop/LYhzxF6o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DyiBB0WU1X4ABolmrqs1kSfXCyn3B75w+w+5z1AhuAx7nzgVm4o7kn+WhF+WO8n4g
	 Ts/sIe043KIqCb1mccdMmI2HQSjjHim9+0mVPGccz/5xo11v2pPIa0UC8qHWcby31F
	 n18oMtQ/Gj4BmMSqutIFHT2F1dnKdYatp/7rJT5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgEGSxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:53:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D562495D;
        Thu,  7 May 2020 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877603;
        bh=LtgQkSM/IwxpKlPxttxhXPuDElKoRhjvop/LYhzxF6o=;
        h=Date:From:To:Cc:Subject:From;
        b=OJFE/I/yy5SEyPknWvR7UAN9a8xrQZex53O9c9WwdkoCg6u1Uen6YtMZMTxeeN0Ir
         VPvf/k9YWgaopZejhMrm9W6zoC+2z2B6r3knAKU7Te94WN6Qt0bhKhO4D7R8WgWOwR
         0TxOEAOxVk6s0Q/38oDXN0Byr0yLN4X1EVzCQgvE=
Date:   Thu, 7 May 2020 13:57:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Replace zero-length array with flexible-array
Message-ID: <20200507185749.GA14994@embeddedor>
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
 arch/powerpc/platforms/powermac/nvram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index dc7a5bae8f1c..853ccc4480e2 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -55,7 +55,7 @@ struct chrp_header {
   u8		cksum;
   u16		len;
   char          name[12];
-  u8		data[0];
+  u8		data[];
 };
 
 struct core99_header {


Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746BA20575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877787;
	bh=sAMUhJ6jmW33DzaBv1Y3zsijxrB/wdRq159fUGE4xBA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=E/lKHMkBynNvAZ+Ae4+TbPEETvogLKWVqEddkXbK/Nt3fBMnltEq5LyRYj8CVYgCS
	 uZJgOTroNQRfS507kf83KXFq8E0AOTzzuoFRjfZIosQUgBTbJkejtGsNiOvoxAt8Ap
	 ECFOjcUj3xUZJrEMCx1O9DyJ+si6x9v4Fxgjf26o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEGS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgEGS40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:56:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2245B20575;
        Thu,  7 May 2020 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877785;
        bh=sAMUhJ6jmW33DzaBv1Y3zsijxrB/wdRq159fUGE4xBA=;
        h=Date:From:To:Cc:Subject:From;
        b=ld84k1iV7zQCEtDcb4KRhPV9MWP7EavFa5wv6X7eXO/OR6b2F7Le9ituuQdQxcyFn
         bhNAFrMg9a+EDD4Lp6WIUu0dtFdPHxU4gUYGvD6xRemMjFS7YommBPjjwL/sofGlx3
         hyzRLiFecATsj8cZZxyGaOZ6zNmpmV2Vh9OKd7wY=
Date:   Thu, 7 May 2020 14:00:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Replace zero-length array with flexible-array
Message-ID: <20200507190052.GA15325@embeddedor>
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
 arch/mips/kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index f6efabcb4e92..4ee626049d92 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -52,7 +52,7 @@ struct sigframe {
 	/* Matches struct ucontext from its uc_mcontext field onwards */
 	struct sigcontext sf_sc;
 	sigset_t sf_mask;
-	unsigned long long sf_extcontext[0];
+	unsigned long long sf_extcontext[];
 };
 
 struct rt_sigframe {


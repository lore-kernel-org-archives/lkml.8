Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E41C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692D22071B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH2Mpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:45:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36272 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2Mpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:45:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kC0Eh-0006nT-R8; Sat, 29 Aug 2020 22:45:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 29 Aug 2020 22:45:35 +1000
Date:   Sat, 29 Aug 2020 22:45:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine: fsldma: Do not pass pointers to lower_32_bits
Message-ID: <20200829124535.GA11751@gondor.apana.org.au>
References: <20200828071125.GA18772@gondor.apana.org.au>
 <20200829105116.GA246533@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829105116.GA246533@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 03:51:16AM -0700, Guenter Roeck wrote:
> 
> This patch results in the following compile error when compiling 
> ppc:mpc85xx_defconfig.
> 
> Error log:
> In file included from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:12,
>                  from drivers/dma/fsldma.c:23:
> drivers/dma/fsldma.h: In function 'fsl_ioread64':
> ./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
>   189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
>       |                                     ^
> drivers/dma/fsldma.h:208:17: note: in expansion of macro 'lower_32_bits'
>   208 |  u32 fsl_addr = lower_32_bits(addr);
>       |                 ^~~~~~~~~~~~~
> drivers/dma/fsldma.h: In function 'fsl_ioread64be':
> ./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
>   189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
>       |                                     ^
> drivers/dma/fsldma.h:222:17: note: in expansion of macro 'lower_32_bits'
>   222 |  u32 fsl_addr = lower_32_bits(addr);
>       |                 ^~~~~~~~~~~~~
> make[2]: *** [drivers/dma/fsldma.o] Error 1

Thanks for the report.  Passing a pointer to lower_32_bits is just
bad.

---8<---
The functions fsl_ioread64* were passing a pointer to lower_32_bits
which just happened to work because it was a macro that simply did
a cast on the argument.

However, now that lower_32_bits does a mask on the argument it no
longer works.  Passing a pointer to lower_32_bits doesn't look
right anyway.

This patch adds explicit casts so that an integer is passed along
as the argument to lower_32_bits.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 56f18ae99233..da5816b1706e 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -205,7 +205,7 @@ struct fsldma_chan {
 #else
 static u64 fsl_ioread64(const u64 __iomem *addr)
 {
-	u32 fsl_addr = lower_32_bits(addr);
+	u32 fsl_addr = lower_32_bits((unsigned long)addr);
 	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
 
 	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
@@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
 
 static u64 fsl_ioread64be(const u64 __iomem *addr)
 {
-	u32 fsl_addr = lower_32_bits(addr);
+	u32 fsl_addr = lower_32_bits((unsigned long)addr);
 	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
 
 	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

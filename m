Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FDC222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581585450;
	bh=NV2EcoccPdwUw4SNFQbawZlRnPI4yYMQRsUYIbM/MI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gWHPc9zS/84kEzQVX/wW9VNewifoXaiCTtSplX03vgqzo+ONKOybB/LcFtPn2mJc
	 b05ZZd+QCNXpNwNkvtjbVNqU+8SVQU9bpO3DJPj25snFjUpqQoqMNExX9tZ32nr/sB
	 89r9UcMkjjFp9R3wTtRv7W96QEYrz3nq/ZfTFBFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgBMJR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgBMJR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:17:29 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7E521734;
        Thu, 13 Feb 2020 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581585448;
        bh=NV2EcoccPdwUw4SNFQbawZlRnPI4yYMQRsUYIbM/MI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFaWvFnYfd2PhTwWBlSReHfzGLGK6O25//fL+tSECBXPXo94QuZ6/aaAm6c51lva/
         TefnJt0/OBlDSYX7UYVUOCLnb0a+GZ+cwgj3VYYNrllj/dBdIiQG+BNaS/O/qkj7rQ
         tJQi1FQ2QBT9/UGxJGKYEd1FWX5HkvpZ4J/EOCWw=
Date:   Thu, 13 Feb 2020 09:17:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kaslr: Fix build failure with CONFIG_ARCH_RANDOM=n
Message-ID: <20200213091724.GB849@willie-the-truck>
References: <20200213042457.17842-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213042457.17842-1-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:24:57PM -0600, Samuel Holland wrote:
> Commit 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
> introduced unconditional use of arm64-specific functions exported by
> asm/archrandom.h. With CONFIG_ARCH_RANDOM=y, this header is transitively
> included through linux/random.h. However, with CONFIG_ARCH_RANDOM=n,
> this header is not included, and the kernel fails to build.
> 
> Explicitly include asm/archrandom.h so __early_cpu_has_rndr() and
> __arm64_rndr() are always available, even when they are just stubs.
> 
> Fixes: 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/kernel/kaslr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 53b8a4ee64ff..91a83104c6e8 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -11,6 +11,7 @@
>  #include <linux/sched.h>
>  #include <linux/types.h>
>  
> +#include <asm/archrandom.h>
>  #include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
>  #include <asm/kernel-pgtable.h>

Already queued up in arm64 for-next/fixes:

https://fixes.arm64.dev/

Will

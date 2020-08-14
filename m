Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80985C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA5820829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BaIDszgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHNIgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:36:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B6C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=18TPc55bkABHqhJGmY/T7ZgEAif7O4EK6l81NPcoRxY=; b=BaIDszgt+DmEDE5pdqG2vFnuja
        Q+kQmZ8spnM5fKdVLO2nF6cZTavxyE+jnAV2ebPfrM4XtEP0z92mCO9m7PcfqYqQyFpAyt2F4UAvH
        vlqES5h7qhIxarUAuGbOtgCd8ZB4ABzW9az1l6vWnEbXTJZKJFtCK53eyszVPXuN9datPI6lyBxTl
        Hw4ovzzG9RSPwIjqYeJM1YPICpRSL4pfcH3pR6dlsGAbCW47mtdiU2qbInU9br+N+nJFfkTamwvse
        tbtuNw2k51Mm+qjnOU4K4XgZXQmbU0r6QLE12zVbvdb6SCuWtpj+9/l0awex3LqczFGRMdMQOyCVL
        nDHMHWIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6VBq-00065M-6f; Fri, 14 Aug 2020 08:35:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 111E0980C8B; Fri, 14 Aug 2020 10:35:53 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:35:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xingxing Su <suxingxing@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seqlock: Fix build errors
Message-ID: <20200814083552.GE3982@worktop.programming.kicks-ass.net>
References: <1597378358-2546-1-git-send-email-suxingxing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597378358-2546-1-git-send-email-suxingxing@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:12:38PM +0800, Xingxing Su wrote:
> Fix the following build errors:
> 
> In file included from ./include/linux/time.h:6:0,
>                  from ./include/linux/compat.h:10,
>                  from arch/mips/kernel/asm-offsets.c:12:
> ./include/linux/seqlock.h: In function ‘write_seqcount_begin_nested’:
> ./include/linux/seqlock.h:286:2: error: implicit declaration of function 
>  ‘raw_smp_processor_id’ [-Werror=implicit-function-declaration]
>   lockdep_assert_preemption_disabled();
>   ^
> ./arch/mips/include/asm/smp.h: At top level:
> ./arch/mips/include/asm/smp.h:28:19: error: static declaration of 
>  ‘raw_smp_processor_id’ follows non-static declaration
>  static inline int raw_smp_processor_id(void)
>                  ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:117: recipe for target 'arch/mips/kernel/asm-offsets.s' failed
> make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
> arch/mips/Makefile:396: recipe for target 'archprepare' failed
> make: *** [archprepare] Error 2
> 

What kernel are you building?

Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")

should have solved that I think.

> 
> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> ---
>  v2:  update the commit message
> 
>  include/linux/seqlock.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 54bc204..4763c13 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -17,6 +17,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/compiler.h>
>  #include <linux/kcsan-checks.h>
> +#include <linux/smp.h>
>  #include <asm/processor.h>

Wrong place, it's lockdep_assert_preemption_disabled() that requires
asm/percpu.h, and thus lockdep.h should include linux/smp. before
asm/percpu.h

Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D661C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA6206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0nkot3V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgDGNHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:07:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGNHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u9rndlSOWcXt5MluGcOU4O98z6YSzlHpzInPEsgwmf4=; b=0nkot3V1Ujsd/IDR0hvt6z7XNp
        8tdipods6PKseW7H02KbANK8vpuBRyh0X0C4kJROp8IVqwIUaNOtDHpFJ6q44z1filvnmduIkzL3S
        vHMz5wwcshjLDc4pk5B363pgZilASh/nnksE2U4V5OexAug5p495V11y0ahC2NcuaNSvspXKlGoQa
        MthHa6DS07FJKqnZshhpVtUphR18MiXMciGHefLdmdVawIgtf68eF5a5CyMFbUidUuOuPe8IOmhU5
        gbT9tvJVZneFCEM8vMhMZDlq+kEn/xtgMhsA2qmC7X+gLy8jqn5jrh1yt8CYooeAyuPHDVSxD8C2x
        yeV62/3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLnwx-0000mK-Ef; Tue, 07 Apr 2020 13:07:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFD783010C8;
        Tue,  7 Apr 2020 15:07:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD7182B907A93; Tue,  7 Apr 2020 15:07:29 +0200 (CEST)
Date:   Tue, 7 Apr 2020 15:07:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 5/9] objtool: Add support for intra-function calls
Message-ID: <20200407130729.GZ20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-6-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-6-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:

> index a62e032863a8..7ee1561bf7ad 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
>  	state->regs[16].base = CFI_CFA;
>  	state->regs[16].offset = -8;
>  }
> +
> +
> +void arch_configure_intra_function_call(struct stack_op *op)
> +{
> +	/*
> +	 * For the impact on the stack, make an intra-function
> +	 * call behaves like a push of an immediate value (the
> +	 * return address).
> +	 */
> +	op->src.type = OP_SRC_CONST;
> +	op->dest.type = OP_DEST_PUSH;
> +}

An alternative is to always set up stack ops for CALL/RET on decode, but
conditionally run update_insn_state() for them.

Not sure that makes more logical sense, but the patch would be simpler I
think.

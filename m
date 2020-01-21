Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81C1207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579602615;
	bh=7D1HCfiOtTDIypi8kLQVfL4J6rylD03wymw6qZhwpYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yv4dI+xPhzHZbFVGhjCQg33vniLMBMURkKIyddbzI77JPnbwr91Lef01Ir9Vl5JSO
	 WMvoM2t7G6b2SCborR3K1RS8ntJONRDh8DF3mE93H5J/1XQgi3E9JzCez/J/DGe3fD
	 UelULWKeKP9pXVnvWyt/k3jK+6Nm1+utRyG7isgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAUKaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAUKaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:30:13 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A23720678;
        Tue, 21 Jan 2020 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579602610;
        bh=7D1HCfiOtTDIypi8kLQVfL4J6rylD03wymw6qZhwpYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tut9YvkGGv4ApRTsJQkQp2meT+eqI+vRYmkVnNdjmYn7BF2QAjBHV0BawxPfAhRqn
         3CKT6S+x+7ddbQxeXfOci7SBkrW8sNDEx5Hef6804IRXwt3ZVqNnWgtQnLW4KXBDwX
         vC1uQLfS7NxJsv9xWHq4p2+WEs2v54EncaNJ3vaE=
Date:   Tue, 21 Jan 2020 10:30:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
Subject: Re: [RFC v5 47/57] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
Message-ID: <20200121103005.GA11154@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-48-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-48-jthierry@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:50PM +0000, Julien Thierry wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> Some functions don't have standard stack-frames but are intended
> this way. In order for objtool to ignore those particular cases
> we add a macro that enables us to annotate the cases we chose
> to mark as particular.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  include/linux/frame.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/frame.h b/include/linux/frame.h
> index 02d3ca2d9598..1e35e58ab259 100644
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -11,14 +11,31 @@
>   *
>   * For more information, see tools/objtool/Documentation/stack-validation.txt.
>   */
> +#ifndef __ASSEMBLY__
>  #define STACK_FRAME_NON_STANDARD(func) \
>  	static void __used __section(.discard.func_stack_frame_non_standard) \
>  		*__func_stack_frame_non_standard_##func = func
> +#else
> +	/*
> +	 * This macro is the arm64 assembler equivalent of the
> +	 * macro STACK_FRAME_NON_STANDARD define at
> +	 * ~/include/linux/frame.h
> +	 */
> +	.macro	asm_stack_frame_non_standard	func
> +	.pushsection ".discard.func_stack_frame_non_standard"
> +	.quad	\func
> +	.popsection
> +	.endm
> 
> +#endif /* __ASSEMBLY__ */
>  #else /* !CONFIG_STACK_VALIDATION */
> 
> +#ifndef __ASSEMBLY__
>  #define STACK_FRAME_NON_STANDARD(func)
> -
> +#else
> +	.macro	asm_stack_frame_non_standard	func
> +	.endm
> +#endif /* __ASSEMBLY__ */

Hmm. Given that we're currently going through the exercise of converting
a bunch of ENTRY/ENDPROC macros to use the new SYM_{CODE,FUNC}_{START,END}
macros, I would much prefer for this to be a new flavour of those.

In fact, can you just use SYM_CODE_* for this?

Will

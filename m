Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6932076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0YEAT4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgDWNAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbgDWNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:00:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA8C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vlv/7RCN7mUsk4eEdDdunef/eS90EM20r4AopM5RaFw=; b=h0YEAT4OKDPD0TVhX2SkzWdrQe
        NBFO5AXzic5hqUtIxHJFbvYYvr8zU/ZJdVVbuDKloYL3mv+srmxZRgGGuNmwhowLd+DA8syVKgT+Y
        P7R7YXbN013rIij0Zfq/76GB5XxsZnjQhKYmtcG/fzEnL5r46un7cXdYVLF64BtU4HW/FfZjL5/yR
        Q9MeKZuLlCol5pfNNOcyeYsxDtY37CDFpMgrLF3TqXwmksN+ZwKlEObvuKm5uzY+ek/wYZSMO8/K4
        byhfHfNQwtFaBwW3D3cevKFIIXqv/LUM/csZ8J0rl0lFhDpDlK26Rm3vRblXMSs1YHAW7GOzm84BG
        5OHusaiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbSP-0001HF-36; Thu, 23 Apr 2020 12:59:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8737C30257C;
        Thu, 23 Apr 2020 14:59:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7762320BC7340; Thu, 23 Apr 2020 14:59:55 +0200 (CEST)
Date:   Thu, 23 Apr 2020 14:59:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 8/8] x86/retpoline: Fix retpoline unwind
Message-ID: <20200423125955.GU20730@hirez.programming.kicks-ass.net>
References: <20200423125013.452964352@infradead.org>
 <20200423125043.129313983@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423125043.129313983@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:47:25PM +0200, Peter Zijlstra wrote:
> @@ -128,10 +90,16 @@
>  
>  .macro CALL_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),\
> -		__stringify(RETPOLINE_CALL %\reg), X86_FEATURE_RETPOLINE,\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
> +	/*
> +	 * This cannot be ALTERNATIVE_2 like with JMP_NOSPEC, because ORC
> +	 * unwind data is alternative invariant and needs stack modifying
> +	 * instructions to be in the same place for all alternatives.
> +	 *
> +	 * IOW the CALL instruction must be at the same offset for all cases.
> +	 */
> +	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
> +		    __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE
>  #else
>  	call	*%\reg
>  #endif
> @@ -165,16 +133,12 @@
>   * which is ensured when CONFIG_RETPOLINE is defined.
>   */
>  # define CALL_NOSPEC						\
> -	ANNOTATE_NOSPEC_ALTERNATIVE				\
> -	ALTERNATIVE_2(						\
> -	ANNOTATE_RETPOLINE_SAFE					\
> -	"call *%[thunk_target]\n",				\
> -	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
> -	X86_FEATURE_RETPOLINE,					\
> -	"lfence;\n"						\
> -	ANNOTATE_RETPOLINE_SAFE					\
> -	"call *%[thunk_target]\n",				\
> -	X86_FEATURE_RETPOLINE_AMD)
> +	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD)	\
> +	ALTERNATIVE(ANNOTATE_RETPOLINE_SAFE			\
> +		    "call *%[thunk_target]\n",			\
> +		    "call __x86_indirect_thunk_%V[thunk_target]\n", \
> +		    X86_FEATURE_RETPOLINE)
> +

Hmm, that's a bit daft; that could be a call to
__x86_retpoline_%V[thunk_target] like for the ASM version above.

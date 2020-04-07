Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA2E206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfzBlZT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDGRBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:01:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgDGRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:01:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so2011557pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xqDOkMuBtgyJ7rmZyLLXy0pUwYBbf9fngbp9l/A1q9w=;
        b=EfzBlZT6Migud1cbymqjQ7chSvrijlPI53UumBI2O0NW8OVSWP1Ty9sy4NKai3nMSl
         uil3R9N1lA2aF7Z1m+ktMadyEMso4jH8o6/tuB5EAf4KSfAsRWgt3la2KOcrGQXJyTAE
         heDRHhbmRQ+enMFMCT4xpYkWdJ+rQUXlX/6mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqDOkMuBtgyJ7rmZyLLXy0pUwYBbf9fngbp9l/A1q9w=;
        b=AaRYa/b1CvLUuLOJOtlMq0UCsh9J9ABnGBcc7o1loa6d36znHfrBZeN4v3Ggk4xgvO
         XHR0LM6pbMDeFy5aGPLjjOo5Z39PuWddL9aZ10LSwpceCQokhGfhlajHzbwLxAAfgWRR
         XEzNJYEHAF5zp38rcXdIq60/0+NLlnAo6kSx0XsE5ICULRgMsZNmaM8VBO8OQ3MSNpeY
         RRQn13dA3aIoUL6N6AaH7Fu5Tox6UjEnVnOdBpEmvBmV+Nyg44akioF6R37sH1kZ/wIB
         wCUL1VdfFGwyhRBhvl7DN/w6vxoWAhTxlZ2K4HZgdJy1Cp7k2cAicmCE4GZ+HZ5IcDtL
         r5Kw==
X-Gm-Message-State: AGi0PuYmDrCnoZBnzzlywCOlCVsABLwuTaKt77WByntUezPDykLkpExF
        xS0omNJakMib/cQNdNISXxI0KQ==
X-Google-Smtp-Source: APiQypJ2PeBWyQxiaBSTGv1/qVRWN8VXMYFPRmo9eANgehsqxiJroRmqgqqTG6LdNxkqOwmw70QjjQ==
X-Received: by 2002:aa7:962d:: with SMTP id r13mr3629831pfg.244.1586278866117;
        Tue, 07 Apr 2020 10:01:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d23sm14463482pfq.210.2020.04.07.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 10:01:05 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:01:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <202004070958.CB8A3DA71D@keescook>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407111007.429362016@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:02:40PM +0200, Peter Zijlstra wrote:
> Since we now have infrastructure to analyze module text, disallow
> modules that write to CRn and DRn registers.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/module.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
>  	return false;
>  }
>  
> +static bool insn_is_mov_CRn(struct insn *insn)
> +{
> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
> +		return true;

I always cringe at numeric literals. Would it be overkill to add defines
for these (and the others that have comments next to them in 3/4)? It
makes stuff easier to grep, etc. (e.g. we have register names in
arch/x86/include/asm/asm.h, do we need instruction names somewhere else?
I assume objtool has a bunch of this too...)

-Kees

> +
> +	return false;
> +}
> +
> +static bool insn_is_mov_DRn(struct insn *insn)
> +{
> +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x23)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
>  {
>  	bool allow_vmx = sld_safe || !split_lock_enabled();
> @@ -285,6 +301,11 @@ static int decode_module(struct module *
>  			return -ENOEXEC;
>  		}
>  
> +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
> +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
> +			return -ENOEXEC;
> +		}
> +
>  		text += insn.length;
>  	}
>  
> 
> 

-- 
Kees Cook

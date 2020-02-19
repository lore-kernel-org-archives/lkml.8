Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F9C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978A82173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ih0TjNY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBSA63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:58:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34652 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:58:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so11600993pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iSZk69ptAiTyf7jpHNkoClrlGQ6cnI+6Xpj9dCGMjN0=;
        b=Ih0TjNY9842AqcuQgmoScvFqrmIbnDcyT2G+Zz4H7cAxEjHt0DyfSoOYIn774f5oXB
         7N482BmqyEb+fPQ62sT9IirOQ1sOWGAEpZc/b9h9LQ9qxLL2Xkg18FgiTMcYoMsUYOV1
         Agml5+hejGispc0IEUqgulEwAitKHdS/jC2J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iSZk69ptAiTyf7jpHNkoClrlGQ6cnI+6Xpj9dCGMjN0=;
        b=pfldqUK5SlUyvuNH5F+z59EzJ8yoAKwi3ufP8H7VV4koOf5kZw6S5Fv9U45Ibk65br
         5vK7myja2qVT2j10EhfBKD9AOtOntmyUoJo5cVOzSXWv5aqvpOPEnQFLzThxrlnJ8jZO
         bRisj0W2E8BzsHQo8Zd18L1ae+Nr3amR9CoxxDXnfUnSA/L32//TRAhp8T1XLw00s46p
         HcPqQGTQFr1NtKM2HBagTnN2SMNY2/X9PAn70RICnWxOGACK6abDQWRy/0LyBWhOyuR1
         3QFvgGB8QnAHAueA7IA8YzgcnTg3yDaFDtUU7E1diKdnxZhEiKm2aC2Yj9F9N37m0T4L
         9G0g==
X-Gm-Message-State: APjAAAVTQT29fDQLFdiK+vqg1hAdeMHzIpqDF2ebJGXG+pSba0QixfCX
        KoCO3gqnkwTzwOjD1vnGArmvJg==
X-Google-Smtp-Source: APXvYqwMB+TjIkvXxWZ6X+9g5aGFD1+V5OiJ0ztLwJPySi7aV3TrAhaznYiFLVqLpiYGnEPzwM+MEA==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr24532698pfi.131.1582073906946;
        Tue, 18 Feb 2020 16:58:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm213446pfn.90.2020.02.18.16.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:58:25 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:58:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] arm64: disable SCS for hypervisor code
Message-ID: <202002181658.41FA7C514E@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com>
 <20200219000817.195049-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219000817.195049-10-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:08:14PM -0800, Sami Tolvanen wrote:
> Disable SCS for code that runs at a different exception level by
> adding __noscs to __hyp_text.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/include/asm/kvm_hyp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index a3a6a2ba9a63..0f0603f55ea0 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -13,7 +13,7 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/sysreg.h>
>  
> -#define __hyp_text __section(.hyp.text) notrace
> +#define __hyp_text __section(.hyp.text) notrace __noscs
>  
>  #define read_sysreg_elx(r,nvh,vh)					\
>  	({								\
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
Kees Cook

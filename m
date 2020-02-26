Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8DBC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7A221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JK7mgAJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBZVi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:38:56 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55872 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBZViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:38:55 -0500
Received: by mail-pj1-f66.google.com with SMTP id a18so194534pjs.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ICcEQ4gQdYyuJJyaNP/FXqF/GhkUX9RbcqCJbqfCFhk=;
        b=JK7mgAJhIECWhL4BqCySSQ6RLJa9mVCEkRWbEgclZW6QParWyKb3pKOOzK7P7B2Fds
         QcJF8TMbhEkv9fkT27o5U2RrqdXSuHQHl3gd7Qlg7QioSGNbW/enlgGOtVHMRwsG9u/z
         ud39wkvioudcK1LY9iGaZX2XQoE68rMHqRca8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICcEQ4gQdYyuJJyaNP/FXqF/GhkUX9RbcqCJbqfCFhk=;
        b=LP/RU1jGnCFgmKlvFYcOy792ZITLfL4rEfkd9DOoj2zXQzOTqrFu1bErj5Mcuq1Vgo
         yt3vU/0wq6k6vz7eg3JwbX4WdqjYdKGXfY9eiURwzAGPtnVO350cMMQzs5y710p+Y059
         96HDwRFcsdYYk4nG8MD3XgJGM2Wl2K0SZ97pJ1rIDj+wV/vXwPWT4bwCEDNbW548Ue0j
         rB+Q9Rr/ZO0zCZFIjg+2WMPBLEIeDiVy40I1mjhr42Wyd8BDCMvJXxx4690WxnKfDGy+
         SWjTQr/C1itgggtG/jyF1Taynt5XHgyKUpimD9fFyEJ/TuzJ1AwtPFFF7+mgtSBD3vdR
         WFRA==
X-Gm-Message-State: APjAAAUg3Jt2k15jIV5spKIAfjob9hlgjnCSDf0LOwoO1uFebxBFvvd0
        bojCniBPIB056RcKWankStqxfQ==
X-Google-Smtp-Source: APXvYqy0FqzsDX/eNvJJ9FIhOvUOIrN2vJCL0P6ncKlZEe17n/wI063mdTJEXhlTrLSMfxHAV6Ojog==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr1273585plt.111.1582753134753;
        Wed, 26 Feb 2020 13:38:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x197sm188503pfc.47.2020.02.26.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:38:53 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:38:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 11/11] arm64: mm: Display guarded pages in ptdump
Message-ID: <202002261338.9890367C@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-12-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-12-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:14PM +0000, Mark Brown wrote:
> v8.5-BTI introduces the GP field in stage 1 translation tables which
> indicates that blocks and pages with it set are guarded pages for which
> branch target identification checks should be performed. Decode this
> when dumping the page tables to aid debugging.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/mm/dump.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 860c00ec8bd3..78163b7a7dde 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -145,6 +145,11 @@ static const struct prot_bits pte_bits[] = {
>  		.val	= PTE_UXN,
>  		.set	= "UXN",
>  		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_GP,
> +		.val	= PTE_GP,
> +		.set	= "GP",
> +		.clear	= "  ",
>  	}, {
>  		.mask	= PTE_ATTRINDX_MASK,
>  		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRnE),
> -- 
> 2.20.1
> 

-- 
Kees Cook

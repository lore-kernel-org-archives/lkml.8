Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314CEC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112A2206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDponCt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDFSZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:25:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDFSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:25:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so7965984pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9XYlLQFnWWwdu63sAOZZGoKgEJL0Ub8ZWN6C/xE+U6U=;
        b=SDponCt4iCqvCfanCAa+3pMV+vTOM+mT//ho9jt22D8PbBsbH2TJbTcKnPOBjtwXoZ
         SQGfpcE+gQXFzNGbuAmAiUIxrWnTfyp79v9RE+eyo4jV4iEqo5Rzj6koUCpF2IQ8lEGG
         y96wsJ90XGooCKj5qCos/vO8fxQnHFE8YVifk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XYlLQFnWWwdu63sAOZZGoKgEJL0Ub8ZWN6C/xE+U6U=;
        b=Y2+IibczNmkHTEbZ+Vi6Bra4YwkeCPYudeWlc4T5M2LXBiIYAli9D0ofYXCmrU8Z5i
         8z1rfWjg375twS+Mo+RRn/gXfyZUfVrZMQCK+hwabU+ahHMpniCRifuPeKBpxl1ydxWY
         r0BzmtD5/LKxPLMQvBsn+76Nb8AknpruqUSe7dAirP65mVHmQCQbAT8J7TzsTajFQ4vg
         b1h0QtU4Enk7s45zp6ftKlLOEfv0hRZaxqTXoprK8GaAfOm6F3OunI/1NyUtB3dAFZ9B
         W5ZnvYHgyYxQ7OS+AukCmgZNpodZ55s7Z36zWdWHvSLDlZr8IJ9ZdLFYbDK4H7nyheHh
         EbGA==
X-Gm-Message-State: AGi0PuYNggmM6by0DG4KG9bLr7X//hhqN4HvtcbLZQ4sp7yWBHqEiLCa
        z/ZCmryJ2Gz6AhKGv/MRcIfyvw==
X-Google-Smtp-Source: APiQypL0jJAGP0KYiq4xc4nfkEj6Ve2H6MRdFYIgYzUTD/bPjtmfpTZVeXWK4n9dyWmezbWFwHJWVQ==
X-Received: by 2002:a63:9143:: with SMTP id l64mr388752pge.75.1586197538998;
        Mon, 06 Apr 2020 11:25:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm1673185pfa.8.2020.04.06.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:25:38 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:25:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v10 12/12] efi/libstub: disable SCS
Message-ID: <202004061125.A4C4EB70@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200406164121.154322-1-samitolvanen@google.com>
 <20200406164121.154322-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406164121.154322-13-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:41:21AM -0700, Sami Tolvanen wrote:
> Shadow stacks are not available in the EFI stub, filter out SCS flags.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/firmware/efi/libstub/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 094eabdecfe6..fa0bb64f93d6 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -32,6 +32,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   $(call cc-option,-fno-stack-protector) \
>  				   -D__DISABLE_EXPORTS
>  
> +#  remove SCS flags from all objects in this directory

nit: double space

-Kees

> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> +
>  GCOV_PROFILE			:= n
>  KASAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
> -- 
> 2.26.0.292.g33ef6b2f38-goog
> 

-- 
Kees Cook

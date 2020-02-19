Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C4C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D1C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzhUosfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgBSA67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:58:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40420 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSA66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:58:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so8808611plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnHrGjs2d4rz7O5tZjdzLtL+/TxZSgxldIF3J/GkKZs=;
        b=IzhUosfrcEGWqNX3mEcMBIr1zOOchilV9ewuFD+HoG5ciFAxqXbB4J+beO2BpkVdd2
         SpEpavUmfa3Uu83TMZyvYqjzM1rYC38XzZ6PgxBVtweceDQ65TXzBQcjSOeXX0zJL559
         DAcpGs9S0QzkDBHDXRYSuTfPTPAw54Oj19kC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnHrGjs2d4rz7O5tZjdzLtL+/TxZSgxldIF3J/GkKZs=;
        b=RaQ9jMwkCVvQAUMWcLTxKMR2GeWgft/ne/T+FBm9X5PyQNBsRA4lM5kg84aFnghypS
         TfPY5jbHTdlpZFgSKqRMmyr4vIeJoXjopbGIdt9bDEfhbVPKmwZyYvHI3+QfPraEezgR
         0G41YiAlUlELnGXyYtZxUeJY8dCAo20L+iRf2VGJVeA4D3Us33G75tzrrt646EknCAHM
         IChbW3Ny8iIaZk1yHxiNueD/j5iaXAOcIVCTSAqJRPzjTeY7JSdQ01wB0Z3QzwHG3NI0
         z7PH+zx1z5aYkc0i20kOBgAxV7F36PLrpth5gWzAkObBPP8a0Eq+MkNv1rlYfl28KXY0
         TH4Q==
X-Gm-Message-State: APjAAAW4Dgipzh5qWYYVN2pdbgQzXFYCe+gV5XxJqPYgZw87FI1Mxr/R
        2QucJMhdwAyT1aScNpueh5Hi1w==
X-Google-Smtp-Source: APXvYqyyUVqi0udPEq0kk+xXnOiXAZrDL6nmRuPiWdSBtQVB+Zr5mfeTFPLXXkm6NSzwKNuLtifp4A==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr21514780pll.49.1582073937923;
        Tue, 18 Feb 2020 16:58:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18sm155133pgd.39.2020.02.18.16.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:58:57 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:58:56 -0800
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
Subject: Re: [PATCH v8 12/12] efi/libstub: disable SCS
Message-ID: <202002181658.45F66E21F@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com>
 <20200219000817.195049-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219000817.195049-13-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:08:17PM -0800, Sami Tolvanen wrote:
> Disable SCS for the EFI stub and allow x18 to be used.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/firmware/efi/libstub/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 98a81576213d..dff9fa5a3f1c 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -30,6 +30,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   $(call cc-option,-fno-stack-protector) \
>  				   -D__DISABLE_EXPORTS
>  
> +#  remove SCS flags from all objects in this directory
> +KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> +
>  GCOV_PROFILE			:= n
>  KASAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
Kees Cook

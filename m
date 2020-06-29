Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A020D222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ct0mv2T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgF2SiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgF2Sh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1247C0307BD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:09:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so8090079pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dpcg/V5/bVux0rs7VkxFu353liBeuYLlwoKIVZn1zEc=;
        b=ct0mv2T0RjdmYV1r2g3shjdEpjoUYMExe0D7cbytkVt7URajCK7sMn2lgMvkPFTDtT
         B6e0osia8R1xcxdsu1BBSWWdC90GP7XLPKUMpUNAbTFBPpu42nc6i9OZtXC71O1efA/P
         4ylNra4o8Pd7dj8TEYxISYWxhCFSaMWvEPRaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dpcg/V5/bVux0rs7VkxFu353liBeuYLlwoKIVZn1zEc=;
        b=BiDhjUyoYieapzrHcMyFBHUN+PLZfRpFPe1GD+0DciHgFw6DFsaOSeKWGSehDPS9kY
         1wYvvtXR5kkZRznlrjAbxqTBRj5wTSMAH6yfiSdGi64yQLiSdTc61dB0qdTO+80oKDjt
         EhHaxCb2lZUTTtTJ+gw5Lc4PEnZQrbMgFe5tYRiktnZumZuHBj39gdcMnQI1BBV+Ja8O
         6sks3LLkFST72rdTXLQ52nukX/hEXYSlEUoNs6Vd3WO3laR8kw3GqkVaqylxInUKudqv
         7gjbIwiBlJ38Dx/VDnetwxQD6rbmaqtFZ6IsW/vPBw/P42uyZHyCxb5fkX+XVOdJ6V6q
         kIHA==
X-Gm-Message-State: AOAM530p5CX8FExQUjBTSNkLVWBgYFp4aokd2oZ6e5AVGwJq3Agao7OE
        Xfx2JDJBz7ID1HB+Md1CoXt1oA==
X-Google-Smtp-Source: ABdhPJwdMzhUEihbszttz1nTcxlrJL0pe9SFMhjHmbbNgUqzZFGh80VrfiWcOpG+4qWPncvSOSJsew==
X-Received: by 2002:a63:a1f:: with SMTP id 31mr10760873pgk.228.1593446956199;
        Mon, 29 Jun 2020 09:09:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s194sm237565pgs.24.2020.06.29.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:09:15 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:09:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <202006290907.E5EF18A@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-8-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> Add a linker script check that there are no runtime relocations, and
> remove the old one that tries to check via looking for specially-named
> sections in the object files.
> 
> Drop the tests for -fPIE compiler option and -pie linker option, as they
> are available in all supported gcc and binutils versions (as well as
> clang and lld).
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> ---
>  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
>  2 files changed, 11 insertions(+), 25 deletions(-)

Reviewed-by: Kees Cook <keescook@chromium.org>

question below ...

> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index a4a4a59a2628..a78510046eec 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -42,6 +42,12 @@ SECTIONS
>  		*(.rodata.*)
>  		_erodata = . ;
>  	}
> +	.rel.dyn : {
> +		*(.rel.*)
> +	}
> +	.rela.dyn : {
> +		*(.rela.*)
> +	}
>  	.got : {
>  		*(.got)
>  	}

Should these be marked (INFO) as well?

> @@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
>  #else
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
>  #endif
> +
> +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected runtime relocations detected!")

I think I should be doing this same ASSERT style for other explicit
DISCARDS in my orphan series so we'll notice if they change, instead
of being silently dropped if they grow.

-- 
Kees Cook

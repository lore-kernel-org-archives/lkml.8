Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E8CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7748F20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jq4iDuXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgE0SEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387706AbgE0SEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:04:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE02C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:04:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 131so3789394pfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30RU4BWAzl0wOn2l0ox/7i0ctRamwhqcNLFYWQjdHwU=;
        b=jq4iDuXHEGkrSKMNUC1NaasBukXAHS1JfA2UuIA606mL4pHJJMIV3DJIaBkMD72NH/
         h9rHOtUPBmXtp/R6z50GLib3r19VmkN15y4Y2+aO0rT/S2UIAG7ATDEMztLRH307UWw2
         DaqONMooU5efxMmemD5WCKyCYX+hZZahJ0XiKOYh8MxYgohN97Ys3ZccX8Z5T+VVGfcv
         cGQSmfK2en3j8h5FgfLDYaEZjWB6xRa4gXvX7d0n7d9gOAPPdR9Fa/ilOYF87IBMGiWb
         4/lPmIqMh3GCGDU7KxIWY+2sOQnCpYIdpr5Pk7Wb2oEktQwngVQjBGCIlZucnG9a/DZd
         UAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30RU4BWAzl0wOn2l0ox/7i0ctRamwhqcNLFYWQjdHwU=;
        b=C8ZFQ5IlOPbgdNPhHAmU86zCD8haKY7DKCfnHyf+6tLOiWLEdMsQbOWGln2cNvtCXu
         i4CS9RiON0OSA+yu1SndDwVAXgopi4xTv9f0QGh4nQ5LITPsVg8JHzrTpm9u3a4xUpT3
         8HoVUKSkitp+iAu/hWhWEZ0r4qvxcWaZRFIp57TMC//eWAZZUmF8M+4NflJAMrSgidLs
         /tY26aYDTZfkU2yyP7HX4UEwi7IaEVVUQb9rx0PuWBKf3wR3oSzo3kt8xgjqMeoLfBZk
         HFsZEYcEAua0RmKt7GWoWmYwPokOH9ifK3NJl892hd2i94Exrv1NXL3SNLYdi3VLDjBA
         /yYw==
X-Gm-Message-State: AOAM532KIqUDQrrQJsBzJzYkraisnKDCd2AmJYDIhlzmm2Xma1yvrbRg
        Rt7Q/UGCOXg4uhk+fX7qRgIj/qvt7tODd9rkpeGu+g==
X-Google-Smtp-Source: ABdhPJyCWprooPr5gbGtmhvYEAk/ACWoP1CtoXXUVz1T91quN9BxSnwn+XuxF23ALNxLVdxEpawj2Fi18/D7j4Xk32o=
X-Received: by 2002:aa7:87d6:: with SMTP id i22mr5122213pfo.39.1590602673866;
 Wed, 27 May 2020 11:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200527141553.1768675-1-arnd@arndb.de>
In-Reply-To: <20200527141553.1768675-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 11:04:22 -0700
Message-ID: <CAKwvOdk8PToaHMWVKV-6Uhhx6CNz15OWLOp_5RCERvdOisLrpA@mail.gmail.com>
Subject: Re: [PATCH] x86: fix clang integrated assembler build
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
        Juergen Gross <jgross@suse.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Bill Wendling <morbo@google.com>, Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang and gas seem to interpret the symbols in memmove_64.S and
> memset_64.S differently, such that clang does not make them
> 'weak' as expected, which leads to a linker error, with both
> ld.bfd and ld.lld:
>
> ld.lld: error: duplicate symbol: memmove
> >>> defined at common.c
> >>>            kasan/common.o:(memmove) in archive mm/built-in.a
> >>> defined at memmove.o:(__memmove) in archive arch/arm64/lib/lib.a
>
> ld.lld: error: duplicate symbol: memset
> >>> defined at common.c
> >>>            kasan/common.o:(memset) in archive mm/built-in.a
> >>> defined at memset.o:(__memset) in archive arch/arm64/lib/lib.a
>
> Copy the exact way these are written in memcpy_64.S, which does
> not have the same problem.
>
> I don't know why this makes a difference, and it would be good
> to have someone with a better understanding of assembler internals
> review it.
>
> It might be either a bug in the kernel or a bug in the assembler,
> no idea which one. My patch makes it work with all versions of
> clang and gcc, which is probably helpful even if it's a workaround
> for a clang bug.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

+ Bill, Fangrui, Jian
I think we saw this bug or a very similar bug internally around the
ordering of .weak to .global.

> ---
>  arch/x86/lib/memmove_64.S | 4 ++--
>  arch/x86/lib/memset_64.S  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 7ff00ea64e4f..dcca01434be8 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -26,8 +26,8 @@
>   */
>  .weak memmove
>
> -SYM_FUNC_START_ALIAS(memmove)
> -SYM_FUNC_START(__memmove)
> +SYM_FUNC_START_ALIAS(__memmove)
> +SYM_FUNC_START_LOCAL(memmove)
>
>         mov %rdi, %rax
>
> diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
> index 9ff15ee404a4..a97f2ea4e0b2 100644
> --- a/arch/x86/lib/memset_64.S
> +++ b/arch/x86/lib/memset_64.S
> @@ -19,8 +19,8 @@
>   *
>   * rax   original destination
>   */
> -SYM_FUNC_START_ALIAS(memset)
> -SYM_FUNC_START(__memset)
> +SYM_FUNC_START_ALIAS(__memset)
> +SYM_FUNC_START_LOCAL(memset)
>         /*
>          * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
>          * to use it when possible. If not available, use fast string instructions.
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200527141553.1768675-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers

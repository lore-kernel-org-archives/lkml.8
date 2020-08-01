Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBA92087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCpZ5ZAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgHALuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHALuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 07:50:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB70C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 04:50:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u63so17374604oie.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vqmbfMdG1XwSN9CCMReRgW8QhRBkkbu9OHpIkCz9yJw=;
        b=LCpZ5ZAy008sBZ5/VQCY3qwcTQar36Q1TJ9wsiBkCD9cMuAbdUuEK1XL++vN8dweGH
         Jq+EsVCY468IQMHexb3bqZzVa5/Wn+Ir09P2t9QuYSj4aILrF7XXHVfJPHKThDL/RHUc
         QJUIejvqJ9vDIXyaWn8XwdV3fxQ7ae0P6/OvwR5EzL4IP9PGGiue1SE2h6eQJ8WZOW5w
         4n+OxbwDera8eKRRNcP8VldeXJJum1SzhkMsR8q4Eev1QkU48Wt9Q9JJoVId2nUPW1+S
         QzhmP/K6ylCkz3BL/9FKyuGfl7OUV2gwewBVJq2PQ7xkb8RDuTXuI9ODOgow2lY2HvRQ
         oC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vqmbfMdG1XwSN9CCMReRgW8QhRBkkbu9OHpIkCz9yJw=;
        b=dLA8ekO/tngMjQhdvCizSwgiNpnFtNr2mluWbtApqtRX1Z7ahBFHXbFWVqwbWZEABT
         1gnWnQGmG6tjsrE/df/LJE80HjtF8rAiZur91MvPQqb3bUDL1UHh93BQYbGLwzp6vUmp
         HyUI2Ulf3NdJITQSEPKW83K+Vt0pTfu9KuI32d4ReKrpSrJGgESaS/y/y3msGfEozbSu
         V9KXNZjmwxL8XMI2+jkVO6iUw6H9QuMK4zpriWPIxh2VASnzGt4kD5zXzSU2HGGUCMoF
         c/sjnWIt6nRiuaXQMG2EnS25HJNHV8XTVpyGfZ1hWOAOeOzeC630rJK2kpxbfQFhoZ0w
         EJCw==
X-Gm-Message-State: AOAM530zXoSgTCTsP8qbLPmGnYaG4GTjHD6710ID8QmEmf8zanwGNJlo
        /Q9xdLDfmRrrw4+NIo+5VkQIZCtt9ejcqhjoOG0=
X-Google-Smtp-Source: ABdhPJx2BZmReO1V1tzXBIT/jD94xZFXmrxuf25J7qJUkyd3XX3V0I9uXpt00VV11w3PEwT41V/s6ifG/7M8srLQGoc=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr5955996oib.70.1596282650952;
 Sat, 01 Aug 2020 04:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de>
In-Reply-To: <20200527135329.1172644-1-arnd@arndb.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 1 Aug 2020 13:50:39 +0200
Message-ID: <CA+icZUUcH91QDDEin9GyEoD8kqrQSPAnkZJyMnXU40Sk5FAo3A@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When using the clang integrated assembler, we get a reference
> to __force_order that should normally get ignored in a few
> rare cases:
>
> ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
>
> Add a 'static' definition so any file in which this happens can
> have a local copy.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi,

what is the status of this patch?

I needed this one to be able to build VirtualBox via DKMS as an
out-of-tree kernel-module.
Package: virtualbox-dkms version 6.1.12-dfsg-8 (Debian/unstable)

To quote myself (see [1]):
Passing LLVM_IAS=1 results in:

  AR      /var/lib/dkms/virtualbox/6.1.12/build/built-in.a
  MODPOST /var/lib/dkms/virtualbox/6.1.12/build/Module.symvers
ERROR: modpost: "__force_order"
[/var/lib/dkms/virtualbox/6.1.12/build/vboxdrv/vboxdrv.ko] undefined!

Arnd's patch is mandatory to build with Clang's Integrated Assembler
(make LLVM_IAS=1).
Here: LLVM toolchain version 11.0.0-rc1

Feel free to add:
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Can one of the tip maintainers pick this up, please?

Thanks.

Regards,
- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1104#issuecomment-667470053


> ---
>  arch/x86/boot/compressed/pgtable_64.c | 2 ++
>  arch/x86/include/asm/special_insns.h  | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index c8862696a47b..8595194cea41 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -12,7 +12,9 @@
>   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
>   * due to an undefined symbol. Define it to make these ancient GCCs work.
>   */
> +#ifndef CONFIG_CC_IS_CLANG
>  unsigned long __force_order;
> +#endif
>
>  #define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
>  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 82436cb04ccf..7081e587c1ea 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -16,8 +16,15 @@
>   * A memory clobber would solve the problem, but would prevent reordering of
>   * all loads stores around it, which can hurt performance. Solution is to
>   * use a variable and mimic reads and writes to it to enforce serialization
> + *
> + * Clang sometimes fails to kill the reference to the dummy variable, so
> + * provide an actual copy.
>   */
> +#ifdef CONFIG_CC_IS_CLANG
> +static unsigned long __force_order;
> +#else
>  extern unsigned long __force_order;
> +#endif
>
>  void native_write_cr0(unsigned long val);
>
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200527135329.1172644-1-arnd%40arndb.de.

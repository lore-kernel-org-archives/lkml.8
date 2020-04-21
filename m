Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D6C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E62206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="N47qBMdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDUWYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:24:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:24:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so16883pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7EQSergzjvpSiVEiJAnccFwyc23McE189ccKP2C8IZU=;
        b=N47qBMdQYynOCMe8tPIGMk7163MLOoNGicsdZX87gb7l1Yr9yrAon0jajrPBP3GUsC
         cKj3FoUKYCQclKrENa2xyI6d9C+OplSscBn3XdyOUP2bric1otxXTOLOlmU6anYkMlaR
         EWpwcCDf3TtLygFmQzHWu5ZQASCoNU0EJFdPTKKjW+RwV6mYmVU4M5aDFo4ahOT+PRde
         oT3pwuCyu4Mf4eJWNuK530PQaUcVfmJLsWyRivVGsgbOgHOlc4grdGo+LscUZ/aJxbNZ
         jQkV4I9YOh5zfZiwg215OgQbPTSBpdub1NGUMZfMkcyXjjJTGEPaeptrFPvUx3t3hOdz
         p/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7EQSergzjvpSiVEiJAnccFwyc23McE189ccKP2C8IZU=;
        b=cQ9OnQtwCoAZXEH0BZ3PGc3nEA9XXBSfyD8/uxUFsT2Rbrl7394IIoX5MyyLWp2qBp
         i/HA7hKXnZPh/D4RIx4paDoVHk9W6HTJm4LXnMkQmwOAu7SmsCyqZU/7j60guFP4gsnt
         DDloCwnScsp32/dAt41d7sG/qZfJQPkqtwF7GAiplv87U8B0DE0d91MluYHxaTKrIwXj
         ey8M+vL+zUaFE5hMaYQlKkxUzmQGECQ8YetAWgZldtAQhUJ0y1/P44WLrslnWbpnMXQg
         SAu/VWlYtUyWVu8vCKfEN5h8fxhcrvJyHiQd864O9cl4SehxffiqU3rm5ypS1keXxQM2
         Sh+w==
X-Gm-Message-State: AGi0PubBFogBtn+39diVqY7zAZMvL2QjTnc1I0vhvsM9xVsIHDB2+9st
        xWz66eM2/PqL3KnahEROwli6NA==
X-Google-Smtp-Source: APiQypJDBXss1fi6+/Ym5brO0L44dDM/JDTSGL3T1UlfzUfLR2N7U1fsx9kunrUqZz5PBVvwmrk+MA==
X-Received: by 2002:a63:4650:: with SMTP id v16mr20371642pgk.99.1587507872358;
        Tue, 21 Apr 2020 15:24:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r63sm3534644pfr.42.2020.04.21.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:24:31 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:24:31 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 15:24:12 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: fix vdso build with lld
In-Reply-To: <20200415142959.25673-1-ilie.halip@gmail.com>
CC:     linux-riscv@lists.infradead.org, maskray@google.com,
        rupprecht@google.com, ilie.halip@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Nick Desaulniers <ndesaulniers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        han_mao@c-sky.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ilie.halip@gmail.com
Message-ID: <mhng-8737e015-5064-456d-99cb-3e275321db5e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 07:29:58 PDT (-0700), ilie.halip@gmail.com wrote:
> When building with the LLVM linker this error occurrs:
>     LD      arch/riscv/kernel/vdso/vdso-syms.o
>   ld.lld: error: no input files
>
> This happens because the lld treats -R as an alias to -rpath, as opposed
> to ld where -R means --just-symbols.
>
> Use the long option name for compatibility between the two.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/805
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
>
> ---
> Changed in v2:
>   * a comment line dropped, another one slightly reworded
>   * added Nick's Reviewed-by
> ---
>  arch/riscv/kernel/vdso/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 33b16f4212f7..a4ee3a0e7d20 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -33,15 +33,15 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
>
>  # We also create a special relocatable object that should mirror the symbol
> -# table and layout of the linked DSO.  With ld -R we can then refer to
> -# these symbols in the kernel code rather than hand-coded addresses.
> +# table and layout of the linked DSO. With ld --just-symbols we can then
> +# refer to these symbols in the kernel code rather than hand-coded addresses.
>
>  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
>  	-Wl,--build-id -Wl,--hash-style=both
>  $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
>  	$(call if_changed,vdsold)
>
> -LDFLAGS_vdso-syms.o := -r -R
> +LDFLAGS_vdso-syms.o := -r --just-symbols
>  $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
>  	$(call if_changed,ld)

Thanks, this is on fixes.

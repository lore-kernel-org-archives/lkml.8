Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89AAC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0092207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoA4IxJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBFV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBFV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:21:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70407C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 22:21:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so3294928qkn.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUaYX9zKEjE3UC87tIgYQTtj9y801Ydigt+bunW6HZ0=;
        b=CoA4IxJ6ah2GKpke3J8wgjl3AqhJAtr5OAZo3b0AeRdtZbNM8OI6vkKf8k3cFvkUHU
         DLEzwLmnFhOBIOuYL2DvY/ZIwhGoccBCDS/Q3Sj2t/oY4SujxKfv/CeJgWid/pylr/wa
         YbPbmPqxrL5GZu/gmN71BUgIIuNR+1+8Mwreekz3HyH61PQxNBqiLwlIYoBmMH7FFK+8
         xhy9xNcfFVxk9yJT4gmfpVTCaxIVv1YahHKWeR5Cb0w80G+AvCdTKKVJqjMyLymHnW/r
         b79288BW5J5ScjhDLEIKwr9iiuVV4zUBpK5TKiYDTGSxShQaQqHKdYVVsCh+ccb5O7uN
         j1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUaYX9zKEjE3UC87tIgYQTtj9y801Ydigt+bunW6HZ0=;
        b=ogd6w4tY0gE1RQuHUe4zXUXgb247cTFO4WfKrnzvIhYCAOZJu9gjoRE9W/Hv/tizSt
         eaCjLFjgAhAsSYlisP3K20c3OTEyNmEC7C7F8A9wKKiLU5IibZYw5SORpXzV5ioW39N3
         6n5zTbvu13XSJTPA+rJQUDslNP7KqqpvcXCXrb3Ga+P7J/6szFJqTxL+z0zo0TStgBzz
         auVvW9CrAkaugf+su083t/Txo9AIFQgxJWVrQZXqKBZmRB6ciZwxibJx5Ktkofxc2FCc
         /i8wTGV4U0af9LBAjXuJKnosAcDnJMPYs5bGYK2yJc4J81ooQKggiVBKx7MPJw5nbmIp
         UOIA==
X-Gm-Message-State: AOAM5302M2ukSsA2ALah5JyH8X5azTZ8iwwr6l5XB4/RGN1+yPH0HWOG
        xKNSL8Nj6YVRku5Y/5hQOgA=
X-Google-Smtp-Source: ABdhPJxMs/gCZgP754nd0TdIGrbNuQQ+VnPVejCRLYJ3xskqjAMOrIDdIzUXGUj4cBIZThgEV1rWJQ==
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr1185377qka.76.1599024085579;
        Tue, 01 Sep 2020 22:21:25 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id e23sm3697017qkl.67.2020.09.01.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 22:21:24 -0700 (PDT)
Date:   Tue, 1 Sep 2020 22:21:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH 0/2] link vdso with linker
Message-ID: <20200902052123.GA2687902@ubuntu-n2-xlarge-x86>
References: <20200901222523.1941988-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901222523.1941988-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:25:21PM -0700, Nick Desaulniers wrote:
> Kees Cook is working on series that adds --orphan-section=warn to arm,
> arm64, and x86.  I noticed that ppc vdso were still using cc-ldoption
> for these which I removed.  It seems this results in that flag being
> silently dropped.
> 
> I'm very confident with the first patch, but the second needs closer
> review around the error mentioned below the fold related to the .got
> section.
> 
> Nick Desaulniers (2):
>   powerpc/vdso64: link vdso64 with linker
>   powerpc/vdso32: link vdso64 with linker
> 
>  arch/powerpc/include/asm/vdso.h         | 17 ++---------------
>  arch/powerpc/kernel/vdso32/Makefile     |  7 +++++--
>  arch/powerpc/kernel/vdso32/vdso32.lds.S |  3 ++-
>  arch/powerpc/kernel/vdso64/Makefile     |  8 ++++++--
>  arch/powerpc/kernel/vdso64/vdso64.lds.S |  1 -
>  5 files changed, 15 insertions(+), 21 deletions(-)
> 
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

ppc44x_defconfig and powernv_defconfig start failing with this series
when LD=ld.lld is used.


$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- LLVM=1 O=out/ppc32 distclean ppc44x_defconfig uImage
ld.lld: error: relocation R_PPC_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso32/datapage.o
>>> referenced by arch/powerpc/kernel/vdso32/gettimeofday.o:(__kernel_gettimeofday)

ld.lld: error: relocation R_PPC_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso32/datapage.o
>>> referenced by arch/powerpc/kernel/vdso32/gettimeofday.o:(__kernel_clock_gettime)

ld.lld: error: relocation R_PPC_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso32/datapage.o
>>> referenced by arch/powerpc/kernel/vdso32/gettimeofday.o:(__kernel_clock_getres)

ld.lld: error: relocation R_PPC_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso32/datapage.o
>>> referenced by arch/powerpc/kernel/vdso32/gettimeofday.o:(__kernel_time)
...


$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- LLVM=1 O=out/ppc64le distclean powernv_defconfig zImage.epapr
ld.lld: error: relocation R_PPC64_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso64/datapage.o
>>> referenced by arch/powerpc/kernel/vdso64/gettimeofday.o:(__kernel_gettimeofday)

ld.lld: error: relocation R_PPC64_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso64/datapage.o
>>> referenced by arch/powerpc/kernel/vdso64/gettimeofday.o:(__kernel_clock_gettime)

ld.lld: error: relocation R_PPC64_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso64/datapage.o
>>> referenced by arch/powerpc/kernel/vdso64/gettimeofday.o:(__kernel_clock_getres)

ld.lld: error: relocation R_PPC64_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso64/datapage.o
>>> referenced by arch/powerpc/kernel/vdso64/gettimeofday.o:(__kernel_time)

ld.lld: error: relocation R_PPC64_REL16_LO cannot be used against symbol __kernel_datapage_offset; recompile with -fPIC
>>> defined in arch/powerpc/kernel/vdso64/datapage.o
>>> referenced by arch/powerpc/kernel/vdso64/cacheflush.o:(__kernel_sync_dicache)
...


We need Fangrui's patch to fix ppc44x_defconfig:

https://lore.kernel.org/lkml/20200205005054.k72fuikf6rwrgfe4@google.com/

That exact same fix is needed in arch/powerpc/kernel/vdso64/datapage.S
to fix powernv_defconfig.

Cheers,
Nathan

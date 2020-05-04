Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B21120735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgEDHck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:32:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44152 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgEDHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:32:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id a2so5833221oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooc31C0HVG+wuFWk6i8TyXlbS7UT7v67DJlPvfFWyqk=;
        b=cjB0pkijA7DLujj6UwkHKz0TGN5Guq35XcfdvBOK/zh8PF+1JeqUjPS8QLyjYAYLvB
         THF2C6/pukN2PCuAQcWn8OlWht1r+suSJsp8tgdBGMYojzGt7ndv6Asz0ajSAKKDfNZr
         jze4cnvY72eIIdCQj5bzYvf2AiL5PfxEE7vfbtuJ+Je5jWWlfhatkyimpYWT6rrsMumV
         IE/aGw7a00A9yqPamiu/xMpQmfK9fnud8zn+7mEP7KFw3xLyMgy0jFslqmRTYoeQ0QNS
         +WvMr+Q5pSFCE3HX/ALzLQH7EeXPLnIJCHWE2xL5dnH2VasY/D4Xt6Ec995DlO9vTEKi
         icmA==
X-Gm-Message-State: AGi0Puas3M8XZlRi4Q1YFMFVZkThaGRIDlf6Nyd+rUzgxbLn0jUCNrz+
        FnuCSH6dTyiZt9LML5UBQXJ2GAhW+UFauQAjrPcSNJOr
X-Google-Smtp-Source: APiQypLEE+zhkdSnfmZtRrT0AndiKSIR8Yc7ujLR9NAOfft9X24jtxxKzLyC0ok06W7mvA6Q4E3ASrRaa3/UBThdJ1c=
X-Received: by 2002:aca:895:: with SMTP id 143mr7666525oii.153.1588577558483;
 Mon, 04 May 2020 00:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200504072229.31214-1-geert@linux-m68k.org>
In-Reply-To: <20200504072229.31214-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 09:32:27 +0200
Message-ID: <CAMuHMdV3mWTcrVhut01Tt3j58QY5-UqaDYh4SSQwgk-=7TX80A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.7-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 9:24 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.7-rc4[1] to v5.7-rc3[3], the summaries are:
>   - build errors: +3/-123

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0e698dfa282211e414076f9dc7e83c1c288314fd/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/ (all 239 configs)

It's back:

  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'cpu_has_feature'
[-Werror=implicit-function-declaration]:  => 626:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'disable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 662:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'enable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 626:2

powerpc-gcc4.6/ppc64_book3e_allmodconfig

powerpc-gcc9/ppc64_book3e_allmodconfig builds fine, as it doesn't have
DRM_AMD_DC_DCN, enabled due to:

    select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL
&& KCOV_ENABLE_COMPARISONS)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

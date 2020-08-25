Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF45DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B342071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgHYI1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:27:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46972 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgHYI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:27:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id f42so4627101otf.13;
        Tue, 25 Aug 2020 01:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hxg7mNwlR3vuscL5TlgoioLVulJhR5tUG0gm7sNHuU=;
        b=RRrHLe0ECpE4rwnNUsYJDpdJv6peBfaUw4DBnTtIBp5lD+e/dlAtHYyHN7qBA8odcd
         Ct3PbYGo7kKmPia3tohF0MK6nPwW1GfHjbEIp7RolzMH81S/F0Fu1hLLmCVF5TRWCEuy
         ebVRr8/p3LiOgTEjkeOpR1h0XlrJDGMQx4ACvBa8V4GAZjDelCHxvrBzoYXV12tOxH0z
         7TcbStwKGhsisAYARUrhFE8JFLaGUAq1TEQ2ApPi8cL9yU7yoH4O5qctX5fcP9hZgc8r
         bHO/Wfzbqfrqbz3eGUjukZTM/QDk+oc6VYVtHwsFFnyVrzq+csY2i3NXmLmp4V4XxJBV
         ANYw==
X-Gm-Message-State: AOAM531ftUNIL/tL3PoQrzInT0ZupDMQhXJAHZiD43AZkZIjJxP0+2+f
        p9l0MZC+a+vhCsFh+swr624E+Dbe2PGxbc/hJnlSjYaS
X-Google-Smtp-Source: ABdhPJx0zXPstCnHnri8lFi7O8MyFA9EVV1YuGVzMSeMep6iCVN61tQvMEWQU45MOEt5Xh8X+3G5H74q0zQlBpGScQA=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr6283711otn.250.1598344064333;
 Tue, 25 Aug 2020 01:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200825081909.2797-1-geert@linux-m68k.org>
In-Reply-To: <20200825081909.2797-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Aug 2020 10:27:32 +0200
Message-ID: <CAMuHMdUZgx51cFuJdeKo57pmRX+NB+OBxsCv1sg46=MLxouN7w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:23 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9-rc2[1] to v5.9-rc1[3], the summaries are:
>   - build errors: +12/-0

  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'disable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 676:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'enable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 640:2

powerpc-gcc4.9/ppc64_book3e_allmodconfig

  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040),
(.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text
section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to
fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x1c),
(.fixup+0x34), (.fixup+0x10), (.fixup+0x4)

sparc64/sparc-allmodconfig

  + error: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource_byname"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-x86_64/um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d012a7190fc1fd72ed48911e77ca97ba4521bccd/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9123e3a74ec7b934a4a099e98af6a61c2f80bbf5/ (all 192 configs)
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

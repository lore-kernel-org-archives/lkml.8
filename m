Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECBC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABE62068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgGMJ6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:58:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47045 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGMJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:58:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id n24so9053931otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTNAtwG0yIEG8dmA/H/ghYBJ1Zja621xpjDrXvLJZBo=;
        b=rEIlfxxGaIBGpVf/9t3rml/1ttDMxnzVPqCNSyvqNgE1E9USzsWWjAyew1je/1ardi
         Bap6eeWT7Xf0zikH+UdLHUXUFp9KD+3Sl3vfWrzvuy7RRr4MzMcbqt5udOGov0dNBQRw
         0hw5MmHUkDa+Z5VsXdHHIfCC8dPfbd1spv4b3tFmm2uiNk6N7zkbZXWGC4p7jIoWZCFF
         1IakrGiPyZrjYMCPeWxy3qFCRUcci8WJ1YS9MCrQe2CGJXdUPi1xJPTy2dRzxhwwO/CA
         4fBewRPAuYbEYQqAd3k7wQsPwfKYywiUb1KoR8rKiyYHxD3VFBJwC2wkCTdQO4vMJb0/
         mYtw==
X-Gm-Message-State: AOAM530xiCMnJA68aguB2ex4MlS0q2UBx7AIBLDn7sXwKwgBRTzydwJ9
        htMiEuXvY7RcDN97ZjfnqUT/cbNs360Ah1Vj0aUW9X4swPM=
X-Google-Smtp-Source: ABdhPJyspk+42ag3JnTrIgtKKGxvyd0e7gLOFHFgg2cX9Bi7mF4gI3H2mZ+HU1Kw29UF2DyL1R5fOT6skqNJF7oJe9g=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr35921866otl.145.1594634280844;
 Mon, 13 Jul 2020 02:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200713095031.1991-1-geert@linux-m68k.org>
In-Reply-To: <20200713095031.1991-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 11:57:49 +0200
Message-ID: <CAMuHMdUG9-P_gqCssGQxheTkQKw0PD495eCO-o8xZdbzEsnrrA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:51 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8-rc5[1] to v5.8-rc4[3], the summaries are:
>   - build errors: +3/-0

  + /kisskb/src/include/linux/compiler-gcc.h: error: #error Sorry,
your compiler is too old - please upgrade it.:  => 15:3
  + /kisskb/src/include/linux/compiler.h: error: implicit declaration
of function '_Generic' [-Werror=implicit-function-declaration]:  =>
309:2
  + /kisskb/src/include/linux/compiler_types.h: error: expected
expression before 'char':  => 265:5

arcompact/axs101_defconfig, which uses a pre-v4.9 gcc:

    Compiler: arcompact (arc-buildroot-linux-uclibc-gcc (Buildroot
2015.08.1) 4.8.4 / GNU ld (GNU Binutils) 2.23.2)

While at it, you may also want to upgrade

    Compiler: arcv2 (arc-linux-gcc.br_real (Buildroot
2016.11-git-00613-ge98b4dd) 6.2.1 20160824 / GNU ld (GNU Binutils)
2.27.51.20160928)

as it has a buggy definition of size_t, and causes bogus warnings like:

>   + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 205:23
>   + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 67:23
>   + /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 2 has type 'ssize_t {aka int}' [-Wformat=]:  => 5:18
>   + /kisskb/src/kernel/dma/pool.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 249:16

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

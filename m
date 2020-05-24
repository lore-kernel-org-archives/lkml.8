Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23421C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F321320776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN+Dr78Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgEXWsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbgEXWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:48:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C0C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:48:40 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b15so15839424ilq.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx8OHjNfdF4RbJrElp/4RxNwoLrVNtVMClUKyIlLrTs=;
        b=PN+Dr78QvRGtXGo6D1dnPRk0vPE+zIl21kgD8OSlvGhPTB04QbzyTmLGv0xTQZspnS
         EYBuckOyRsszvG+4/bLAa2Lv/usK33h8SAUnWdu3fJnujjc4QuRW1ytssydO4ifZXEAr
         ijdwIqjWEkG8MT95+R1x8ZOmLbrN15EbmpuSId8aAW1CPJN85kPx35dLqk8kTkPaHp3d
         1sEJXw3goL9CuwdZOZBi7LgpVKvMbZsO1JmMvHBMRM+//rcfpqSm9bBPGcO+qrcfWwAV
         1H/L/g43CUbW2IU+lqSSbszKR12bUlpU3WnYrlfQcLZRiYXXD/SQ+6qzDPzTwd+dLAUo
         oojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx8OHjNfdF4RbJrElp/4RxNwoLrVNtVMClUKyIlLrTs=;
        b=pIHCAiYqhbl/tXLMAcbFIhCvBF2cLKR8cACy6iNfzZx9XsS1uebHQNYMROQf0oCP6h
         QpuQt0MzNRHqJ7qisYO7wmoyNnrgEjBGiCBmhOsPDpd+wNANSZEsq536zBvnqcPE/RvH
         bPNPG7B+qJDntfqsaHY4f4qxldmXUVlpw/FW9vjBPvMmL2LHhOB1D0ukjQvWwy/t3YsF
         /f/6Y3R9sNAtQO8xTtmeJYvAJHeZz6gVOfxWD6KcZWWgzup2RfrPFGRJDeZF9/s8pBZi
         DENAYoRhIwNRb9nfSaIu5LNHQbOIGgkAmhgRaxQXC9o2khQnatMYSRbc80SaTe+fT6Bo
         uOsQ==
X-Gm-Message-State: AOAM532AzilrLmhn6BmSddTAYs3icoyNe7RZQAtuld7TnJihMWE9Uvku
        A1pb5zIgcNAk6Ua0T6+5QGL1ZBNX9neHN9Przg==
X-Google-Smtp-Source: ABdhPJwhLV3Qv52aIUXRxE/dMplv8FICMmoJTN55PTP+UCQHtoo3oda2PwEauq5qThSYyOV5BKHDatjKu/WUnfJffpQ=
X-Received: by 2002:a05:6e02:13ab:: with SMTP id h11mr21007822ilo.191.1590360518989;
 Sun, 24 May 2020 15:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-2-nivedita@alum.mit.edu>
In-Reply-To: <20200524212816.243139-2-nivedita@alum.mit.edu>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 24 May 2020 18:48:27 -0400
Message-ID: <CAMzpN2hddTQkHvOYh_Q-4oO3yvZ25LA0N0rBdS2oqn8poiZn9A@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/boot: Add .text.startup to setup.ld
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 5:32 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> gcc puts the main function into .text.startup when compiled with -Os (or
> -O2). This results in arch/x86/boot/main.c having a .text.startup
> section which is currently not included explicitly in the linker script
> setup.ld in the same directory.

If the compiler is making assumptions based on the function name
"main" wouldn't it be simpler just to rename the function?

--
Brian Gerst

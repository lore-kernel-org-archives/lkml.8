Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769FDC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4958920737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+nbvgq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgICH3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:29:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC98C061244;
        Thu,  3 Sep 2020 00:29:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so1273232ejb.1;
        Thu, 03 Sep 2020 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2ZPyKLU1YkrBtAIw6FNyEviDavWBxV/x7RwKxTnSNY=;
        b=a+nbvgq8jDteeyFU2pmd0V3LboA3T4ib6jbNB2+bFyZ+aLX+5k5xYXVAIuSVnypxrN
         DYcGkl5XFNBy1yfaOeyaXcDw3kbXueho88n9nxSBMd+kZLG+YFQjYK/jCnSLj18E2eF7
         etyrfXYwR2cpswHBvDX9+jlAl6a2CapE4iSF9nw0SoVjNXvpPmW2KPBVhpFpvpHU7+L3
         a8Tn6Gb/NEXHnqSzLZAV1VHpIumwtjlYIytkb6ef6ndGQSbI113+OH7f2DrxMBggZQ1O
         ROQxJYgaAmyXINJW4pBZCmnto/ggRRO+8HBZFMz5hKOOGUD6uQdDl+5uZwsQU5mDs38a
         dWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2ZPyKLU1YkrBtAIw6FNyEviDavWBxV/x7RwKxTnSNY=;
        b=SiUYf9sun+gE0WqHekn/v0QKXseUSJvDocn0Cm01ifMPel3H8r0kxLLujCIhDAP+z5
         pgTYIE1bVeHc5h3xJlpleq9DBp11sSmdGLCR+9RdbrS3WEzFiA/meCQOs7m59NVH4WLQ
         5muese8kNF5xUves8Qc/5iRs4nH0aKOUts2pCmdIswl3oLMwUBhOA34oqFcriQyMaAH9
         07vWU5hPBmxxLGsSb1E3B+zxHx0RVanz4wtJucz8KlYHlhnLNwm207i2MBIcaJpfXnrw
         Is1dZZILPttD9bWqKcdM1m9T/kWF5vE29O/mdn5+z6pOsdB45YontreouCStA1l2ohz6
         CP2w==
X-Gm-Message-State: AOAM533wGXchESAFcNHuCp6zu4VcKb82FKNsGsHdljnRa1kdq9R6gn2t
        2BIpfUhHmMgk8jICyW5G64aUn2LHzDbgMUHwelQ=
X-Google-Smtp-Source: ABdhPJywqyR8GIjxi73MMDL2UvtZSyQX7uzjFGvNi6kH8eA5ZNax+GIlMzjUEHcvThINsAkcxV3kJTq3hQqeqY3QKpc=
X-Received: by 2002:a17:906:f1c4:: with SMTP id gx4mr822582ejb.98.1599118167544;
 Thu, 03 Sep 2020 00:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com> <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Sep 2020 00:29:16 -0700
Message-ID: <CAMo8BfJT7JJfwT1-X3vfqKGD-E3-Dbf2xyWs-RiRyUUHmbetVA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg
 support issue
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 12:01 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
> cmpxchg4 on it.

[...]

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig> index e00d94b16658..03a6c7fd999d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -48,6 +48,7 @@ config ARM
>         select GENERIC_ALLOCATOR
>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>         select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
> +       select NO_CMPXCHG_BYTE if CPU_V6
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>         select GENERIC_CPU_AUTOPROBE
>         select GENERIC_EARLY_IOREMAP
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d20927128fce..4c7f0ad5b93f 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -155,6 +155,7 @@ menu "System type"
>  config CPU_SH2
>         bool
>         select SH_INTC
> +       select NO_CMPXCHG_BYTE
>
>  config CPU_SH2A
>         bool
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index efeff2c896a5..51ae5c8ede87 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -58,6 +58,7 @@ config SPARC32
>         select CLZ_TAB
>         select HAVE_UID16
>         select OLD_SIGACTION
> +       select NO_CMPXCHG_BYTE
>
>  config SPARC64
>         def_bool 64BIT
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index e997e0119c02..862b008ab09e 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -42,6 +42,7 @@ config XTENSA
>         select MODULES_USE_ELF_RELA
>         select PERF_USE_VMALLOC
>         select VIRT_TO_BUS
> +       select NO_CMPXCHG_BYTE

Please keep the lists of select statements in Kconfig files above
alphabetically sorted.

-- 
Thanks.
-- Max

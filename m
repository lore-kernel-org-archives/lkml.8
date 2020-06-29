Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7577AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F10A206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgF2TIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbgF2TCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D10C031C64
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:47:29 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j11so12442816oiw.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtcNAtz9+vSdyHLcpRszGSFyFltMjdYop8dTMaOzAHs=;
        b=JvArKhJFXM+r2mvhzODvCSYzeqaID8bpAiTU/5LKdyUh56erPKDlLlFbUfW6XMbOI6
         PKKiKgcseKkVZgcNUWNUAmTkqFAKS8Yt4bzHzxWtKDehhIqOHHoFg+iGTx3pZOtaTtsp
         SvxhvD08f76y3xcktY64Q1Q8L9tSHrsFi3M01sn37ve8RCxRVxQNrxeOfkSEDF5geMaP
         6bEnW9K/J6e26ebljgxQD8qPuJr7SxHDUUV4U1j25Soq3H9W59TkXqVSTPRU0MOGO7k5
         7Tf6Cbsw0rLMDLBgoK+2O8JdbMk1Hv3DrEjHufN/Alb02SBIsGEHgzbFpoKuA6xwXRT3
         ak3Q==
X-Gm-Message-State: AOAM531RiPEKNDgSaiaCSlDtPu3hTeK5MVgZhjK79phZgV1PfcQGn5bR
        1D0UZc95ujX/y63tj/+XeZHFlsDWgnRZ8r1mago=
X-Google-Smtp-Source: ABdhPJwy+N5VhNGNhf3jn3kJBNz0G2KnR8Gv0THbhdcMWm+q0IHo+X2lnnToIDHCbdaaSCRwWcYY3UqvZoXSK7vzGBw=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr12577697oih.54.1593452848981;
 Mon, 29 Jun 2020 10:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200526123810.301667-1-masahiroy@kernel.org> <20200526123810.301667-3-masahiroy@kernel.org>
In-Reply-To: <20200526123810.301667-3-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 19:47:17 +0200
Message-ID: <CAMuHMdV4rvhJW2BTdxLwvVkpkRobOcTY5srEX-CR8whhnEuZ5g@mail.gmail.com>
Subject: Re: [PATCH 3/4] m68k: optimize cc-option calls for cpuflags-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:38 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> arch/m68k/Makefile computes lots of unneeded cc-option calls.
>
> For example, if CONFIG_M5441x is not defined, there is not point in
> evaluating the following compiler flag.
>
>  cpuflags-$(CONFIG_M5441x)      := $(call cc-option,-mcpu=54455,-mcfv4e)
>
> The result is set to cpuflags-, then thrown away.
>
> The right hand side of ':=' is immediately expanded. Hence, all of the
> 16 calls for cc-option are evaluated. This is expensive since cc-option
> invokes the compiler. This occurs even if you are not attempting to
> build anything, like 'make ARCH=m68k help'.
>
> Use '=' to expand the value _lazily_. The evaluation for cc-option is
> delayed until $(cpuflags-y) is expanded. So, the cc-option test happens
> just once at most.
>
> This commit mimics tune-y of arch/arm/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.9 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

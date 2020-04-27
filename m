Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE6C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561702098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aJaVtmhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD0Ir6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgD0Ir6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:47:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583EC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:47:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z25so24820009otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlWbhU9/EmkPkE3KgFalNDlgj8IuZTC+N04d/sX94zU=;
        b=aJaVtmhnB60iCS5aU72qYpjSl4GarLyMRo6mE3SWoVddygx/s1bcaKs3gTE7K6UUbO
         o4RayG4kLMsthZ9NAP40ehfOAxyhj1LEfHG6eB/gKUS0vVj/9mXcBIpIkUzUKNi3NCri
         hHRRvTjFPtdMy6vHuqYxugy7S7L4Le7YTPCBV3O/K1uZVjb6eeVVAy9m9PSWczUpLWJI
         OQ0ci1aMz8766LfwSXYkTxDlOXnE+Sp7uR/aCOClWA2dJTGvai4EeTwjlFCYCtpdtzm8
         fyrwDqx8JizdfM4qescTEoft91MXwbAOE8Jn49/tyDCfNvjsXpUyPgTfuA80krsiVVb/
         7qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlWbhU9/EmkPkE3KgFalNDlgj8IuZTC+N04d/sX94zU=;
        b=e1CADfzOk4Dv2xmiIwv1GYe/XFphRSD2cbR7Iyum+hzKOzCFcydRK9iHY+PCv+8+nV
         wetXP0UvpmdVkEMBLdHWhRNWy1QfHgxD0OhJo8eRwpoRMOYza4W0LRb1uCZZIerah8mu
         dcGfSIPrNm8oSOuUnAIBwM6RsL7S4/Xwsd4I/uUok7ks5ZyIvKIZ+m4XnZSGuj1nZ5/i
         7aejI0FLm3T63QGyGrjO1f/DQO2MBRiDK4dPngUPHU6ZQIWT/3SJI3UWrfhNJBy3c8l9
         dXqDlKoTNhsP09yfpdkwhfNf8TlN5oh+z0RCk/j+b1c8cNqN6f5x7Jjw4pXF2kTDXWOs
         8sJg==
X-Gm-Message-State: AGi0PuYh5pzZzvLT5SzxSYRsHqjKDbB6Txhs0V562fTBzvGd018kkN7t
        BsvgPlEtacIzW9S78SUlLMIDb/7EUFE9Bc9vFvxkAg==
X-Google-Smtp-Source: APiQypLF9Liz1Wy9Drrlg62h9adl1IQdvPHEtoI3csNtrhxw2UwXHBiWwoYfsvKYHOmr9NvTZRbKN9FmhAyxIBwBF3g=
X-Received: by 2002:aca:c78d:: with SMTP id x135mr351307oif.91.1587977277220;
 Mon, 27 Apr 2020 01:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587455584.git.zong.li@sifive.com> <23980cd0f0e5d79e24a92169116407c75bcc650d.1587455584.git.zong.li@sifive.com>
 <20200427074915.GA11787@willie-the-truck>
In-Reply-To: <20200427074915.GA11787@willie-the-truck>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 27 Apr 2020 16:47:47 +0800
Message-ID: <CANXhq0rW5j+uAymXbfsND9AXHYvM+fPUX9YYYRVXY-Y1u6yo0Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: add DEBUG_WX support
To:     Will Deacon <will@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 3:49 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 04:17:12PM +0800, Zong Li wrote:
> > Some architectures support DEBUG_WX function, it's verbatim from each
> > others. Extract to mm/Kconfig.debug for shared use.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  mm/Kconfig.debug | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index 0271b22e063f..077458ad968d 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -118,6 +118,39 @@ config DEBUG_RODATA_TEST
> >      ---help---
> >        This option enables a testcase for the setting rodata read-only.
> >
> > +config ARCH_HAS_DEBUG_WX
> > +     bool
> > +
> > +config DEBUG_WX
> > +     bool "Warn on W+X mappings at boot"
> > +     depends on ARCH_HAS_DEBUG_WX
> > +     select PTDUMP_CORE
> > +     help
> > +       Generate a warning if any W+X mappings are found at boot.
> > +
> > +       This is useful for discovering cases where the kernel is leaving
> > +       W+X mappings after applying NX, as such mappings are a security risk.
> > +       This check also includes UXN, which should be set on all kernel
> > +       mappings.
>
> "UXN" is the name of a bit in the arm64 page-table descriptors, so this
> should be reworded now that it's in generic help text.
>

It's exactly. Sorry for missing the statement.

Hi Andrew,
Shall I send a next version patch to fix it? It should be "This is
useful for discovering cases where the kernel is leaving W+X mappings
after applying NX, as such mappings are a security risk." here.

> Will

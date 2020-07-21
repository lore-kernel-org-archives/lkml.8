Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80852C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6165E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347559;
	bh=MVP3OpzScc9JjM+8+tSf1gE2+cNmrTX8DEqNNjz9VeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X622oKPkkdreX1AH50i5ii3R6PptlrE0Vm+bJ77agSCAAI1gREisFvIbpyZnr3tkV
	 ThwSN7FJXEigxABFmZjn70X/7S3D/fM2LlSrvHdQ2qy6ne2KbpSnl7AWMFrblYN0+e
	 AzbN/LtTS3Nn4n+E6nIWaojMvKZOOVUf7AhDeKD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgGUQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgGUQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:05:55 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349AD2077D;
        Tue, 21 Jul 2020 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595347554;
        bh=MVP3OpzScc9JjM+8+tSf1gE2+cNmrTX8DEqNNjz9VeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXLGUgyVuW69/ZzoZ6TWEjcHhoEQ4BmikarMVI4Dhz8eDjCovH2uVMUE3ZnocqhSH
         5BSXQOkx0OpI+wsw8ixesFZwggbK2OgnrFDuViYcaa9tGcLmJMP5RXbNmk5hmogqOn
         1lY69HAJMsGS6O0PvxhQuaC809BzpGMmYzH8cXsg=
Received: by mail-lj1-f172.google.com with SMTP id e8so24700053ljb.0;
        Tue, 21 Jul 2020 09:05:54 -0700 (PDT)
X-Gm-Message-State: AOAM533U6Brvk89hzf3QPqTt5X6KyfqBE218z3heBL4cgQDT9G/PUisE
        UF6rBlifKVfDllaehxfXBl5CwPuB4xQ0995m36s=
X-Google-Smtp-Source: ABdhPJw0hco+aL68Av32bukogJjf6+WGT3mk7PwPG+qMfUeXDISwCl7Tlm4ssAdoDblIYlw7Sqih8P3eV+rx3LbhTTw=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr13406723ljj.441.1595347552511;
 Tue, 21 Jul 2020 09:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200721132155.GA27649@roeck-us.net>
In-Reply-To: <20200721132155.GA27649@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Jul 2020 00:05:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR34maSk_Up2CUKyxaHJ=wKLUx+LfhKsv6=Ci25dWbqJg@mail.gmail.com>
Message-ID: <CAJF2gTR34maSk_Up2CUKyxaHJ=wKLUx+LfhKsv6=Ci25dWbqJg@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix build with upstream gcc
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joerg Roedel <joro@8bytes.org>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Joerg & Guenter,

Cool work!

Acked-by: Guo Ren <guoren@kernel.org>

Approve to next branch.

On Tue, Jul 21, 2020 at 9:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jul 21, 2020 at 01:23:14PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Building a kernel for the CSKY architecture with CONFIG_FRAME_POINTER
> > set requires a gcc supporting the non-upstream '-mbacktrace' option.
> > Check for the '-mbacktrace' option before enabling CONFIG_FRAMEPOINTER
> > and fix building CSKY with an upstream gcc compiler.
> >
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> > ---
> >  arch/csky/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index bd31ab12f77d..1622e1c56026 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -8,7 +8,7 @@ config CSKY
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >       select ARCH_USE_BUILTIN_BSWAP
> >       select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
> > -     select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
> > +     select ARCH_WANT_FRAME_POINTERS if (!CPU_CK610 && STACKTRACE_SUPPORT)
> >       select COMMON_CLK
> >       select CLKSRC_MMIO
> >       select CSKY_MPINTC if CPU_CK860
> > @@ -125,7 +125,7 @@ config MMU
> >       def_bool y
> >
> >  config STACKTRACE_SUPPORT
> > -     def_bool y
> > +     def_bool $(success,echo 'int foo(void) { return 0; }' | $(CC) -mbacktrace -x c - -c -o /dev/null)
> >
> >  config TIME_LOW_RES
> >       def_bool y
> > --
> > 2.27.0
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

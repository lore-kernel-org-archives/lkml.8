Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410CE2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588311809;
	bh=STl/cOiJ+TrZjOhdcawi25rjDnNEg5UXyO+NbDdggjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oV2Wlk6WHd4GYCXZ2w0QC2QlE1tcMcA64CYT9eVhth5eJ+WHrjyEl0O0miTlKSVvf
	 s8lgrmpE/pKuwSkOd/PDlI6QCgXU/Rrd6WFqadzPOfjg73x4kGo+FQm0OcE5KrhuJ6
	 IOaprhmUs4UTMoQMCUVyyi7kMO+/YNxfY+/4O2bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEAFn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 01:43:28 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26606 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 01:43:28 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0415hDPe016289;
        Fri, 1 May 2020 14:43:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0415hDPe016289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588311793;
        bh=JQ+NT5tSci3ERKOVJyxa+oPFKBaFqVmX8JUwPvEgrjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8jJKgCnJSdNy3Ag+st7t/1vQ3Xo3+uvpba3XN96gbcisGv49qI7nt8biF5cRiWCK
         76WGkmVC5my2SwOJw9pJ6ikV9YKmblXeGt1NdGvjNW9IuB6hyjKsgdyIvCKhE6gwU2
         BeYkDA+UP+ef/gUxjt2/TkuW/Q65MMgm3P4k71vFF2/bGuI9PCogCY+5KrwrMjqXzu
         e7UiTp5eJ8NfSBm1IFIJ6AH/uGTz8dqCtVdITDQrhuubYyBhoE1t9KRMN1wsRAXEK1
         dZs8P4/Qj2MFiVtp6JeyA+jIE54LnHElDSh17Hk8UCLyX962Ti/zUxlAiGdcQJUWKh
         BUzzGKFYxfILA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id m9so3375393uaq.12;
        Thu, 30 Apr 2020 22:43:13 -0700 (PDT)
X-Gm-Message-State: AGi0PubUOy9N886bh4dO2Swz5K/7rAG/VNrhiCJd3m3lBVMIL+7BasBY
        mtdKh7277p2s6Qo46VYr45UwD0jQ4qjTYeZpx90=
X-Google-Smtp-Source: APiQypL9Dl/SneveyzRqSdEaEYpGDY+MVwEwFsVFpofdeFfpbHH1pm3Qqsf2iB3/M2GGhFUDXTeDDO3qeXfrNAk9FcU=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr1755267uad.25.1588311792545;
 Thu, 30 Apr 2020 22:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200427003019.2401592-1-masahiroy@kernel.org> <20200427080600.GC11787@willie-the-truck>
In-Reply-To: <20200427080600.GC11787@willie-the-truck>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 May 2020 14:42:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-O6C0WO3d0bx+sWCzJF5YmOVcnPYMFMX0wTz6y+C0pA@mail.gmail.com>
Message-ID: <CAK7LNAT-O6C0WO3d0bx+sWCzJF5YmOVcnPYMFMX0wTz6y+C0pA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unused AS assignment
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 5:06 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Apr 27, 2020 at 09:30:19AM +0900, Masahiro Yamada wrote:
> > $(AS) is not used anywhere, hence commit aa824e0c962b ("kbuild: remove
> > AS variable") killed it.
> >
> > Remove the left-over code in arch/{arm,arm64}/Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/arm/Makefile   | 2 --
> >  arch/arm64/Makefile | 2 --
> >  2 files changed, 4 deletions(-)
>
> Acked-by: Will Deacon <will@kernel.org>
>
> (If you post the arm64 part as a separate patch, I can pick it up)


This is just a trivial cleanup patch.
So, I do not split it per-arch.


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada

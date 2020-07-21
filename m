Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B39F20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="uBaNnnrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGUESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:18:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1970C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so19712028wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvGyIvK+jrRG641iFQvvM5qkEd++webDM8jQoP8KAeg=;
        b=uBaNnnrbr/RkUKhJ8oRD3GenYZDoDi3q/cqa9bMRN3VnTE7n0oVpoEM5ltsbsNG8Mm
         YcZInye9jRD0m9OFGBAkKqGWKhFHt8PV0DNN4kVcv9nfxOyCwTQh2MH+0lATLa8FrwiB
         ZtX2A8eEdOIhIHU8iLdL+xj18YaTplTCST6hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvGyIvK+jrRG641iFQvvM5qkEd++webDM8jQoP8KAeg=;
        b=iiEVQ96ubnTP+YmFoiLpZL98sZMg64FwmVz/CmxLHEAbtYU2Msqxw+oZf20OqZaaHV
         4IRTRfz9een1M60ai8YlyngBd46jVxOAfYPmxlA4AZkOzC7XGUvhpUZi6XKVrrw4chE9
         7AVxHSbcO6IuJuGaKU1mbYyxmfYjcx2PKkq+UJCejkOsVHWQcTSIhAy3XbX7PH/jEKVA
         opzadhL6TcSwhWFkBrecW/ejHgS/L2Mfq6AUIglZZWMOQnL2AmT65hD7FDr3i0HuE9H0
         ya38+PCpFxbVMdvZtAhEDfsE8pYBrBwbhrSBWdFVrsffjdD/eAIyy8aDipCbRwCspJSd
         dzkg==
X-Gm-Message-State: AOAM5310vbY4Syr8pYBrvavRxuQ6j4JnmTxghN2TXBUL0s95UYDlhsnv
        Kz1UDgglPoSeiAsuW8X/eipR1IvVyMTlSjJug4MR
X-Google-Smtp-Source: ABdhPJyUUhI7rmyfgcUYhyAD8KTuWvoSFWEvFQf8q1YY7LKIYYImAXJmzUf5VpYShW70wWOsiDP1Rz6WLyDpwhLoHxY=
X-Received: by 2002:adf:a35e:: with SMTP id d30mr11992031wrb.53.1595305113513;
 Mon, 20 Jul 2020 21:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
 <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com> <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
In-Reply-To: <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jul 2020 21:18:21 -0700
Message-ID: <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 2:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Thu, Jul 16, 2020 at 11:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Jul 17, 2020 at 1:41 AM Atish Patra <atish.patra@wdc.com> wrote:
> > > > +#define DTB_EARLY_SIZE         SZ_1M
> > > > +static char early_dtb[DTB_EARLY_SIZE] __initdata;
> > >
> > > Hardcoding the size in .bss seems slightly problematic both for
> > > small and for big systems. On machines with very little memory,
> > > this can lead to running out of free pages before .initdata gets freed,
> > > and it increases the size of the uncompressed vmlinux file by quite
> > > a bit.
> > >
> > > On some systems, the 1MB limit may get too small. While most dtbs
> > > would fall into the range between 10KB and 100KB, it can also be
> > > much larger than that, e.g. when there are DT properties that include
> > > blobs like device firmware that gets loaded into hardware by a kernel
> > > driver.
> > >
> > I was not aware that we can do such things. Is there a current example of that ?
>
> I worked on a product in the distant past where the host firmware
> included the ethernet controller firmware as a DT property[1] to get around
> restrictions on redistributing the blob in the linux-firmware package.
>
> For the .dts files we distribute with the kernel, that would not make
> sense, and I don't know of any current machines that do this in their
> system firmware.
>
> > > Is there anything stopping you from parsing the FDT in its original
> > > location without the extra copy before it gets unflattened?
> >
> > That's what the original code was doing. A fixmap entry was added to
> > map the original fdt
> > location to a virtual so that parse_dtb can be operated on a virtual
> > address. But we can't map
> > both FDT & early ioremap within a single PMD region( 2MB ). That's why
> > we removed the DT
> > mapping from the fixmap to .bss section. The other alternate option is
> > to increase the fixmap space to 4MB which seems more fragile.
>
> Could the original location just be part of the regular linear mapping of all
> RAM?

No. Because we don't map the entire RAM until setup_vm_final().
We need to parse DT before setup_vm_final() to get the memblocks and
reserved memory regions.

I'm not too familiar with the early mapping code myself, so it may not
> be possible, but that would be the most logical place where I'd put it.
>
>         Arnd
>
> [1] drivers/net/ethernet/toshiba/spider_net.c



-- 
Regards,
Atish

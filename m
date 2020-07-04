Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E50C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7D2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593870489;
	bh=lhucP/HCCR3lZo4NjvytE2zGTrqbmNig18IoNllNa9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BjBKbNuUO6U63+vYIK34svXCEKW9x2rSoiQ+nkdKe+mMNbFo+ABo0pu3MlmynKgdX
	 RMCAMj5PYCbk23790yVs4LxiLhknsTkJEJxYwU/Kb9x7cYm5YE4T3PvdT7iyNez4hE
	 rWNmgKyuHwCwSzCxEMnO5EQ6E0djB2mJg0w5UZB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGDNsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDNsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:48:04 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B606520885
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593870483;
        bh=lhucP/HCCR3lZo4NjvytE2zGTrqbmNig18IoNllNa9Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWNtdcZW/dId6+iTVGoBgb2LHpdcVvH3rQ73KDXu+3izHY6NQFGpxr0g9TVi8tAXA
         NLSnLOZG7q9uB1Qv4WKE+HDDwbOjNvIDVGoH402h9CIK7OKJIh/A3PJ0kmZ9ZBUSe7
         Snn5qjD61YP79JZ8+54sq6AakWLw/gm9Yi1XMKqU=
Received: by mail-ot1-f42.google.com with SMTP id h1so6332793otq.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 06:48:03 -0700 (PDT)
X-Gm-Message-State: AOAM532bpIeQASaDG/n7fW16DxeLRwIpEdSlTwQTCwiK02Cz3wUbBg9m
        LaQHTWZRSXqSopA3kwRAq1UJI7U1E4iZAYSHWA8=
X-Google-Smtp-Source: ABdhPJz3OgZ35puMi3EhjIgmnSCvBZOXbDyxiV4pj6KeTTvuVCfeuU00gMwCU9uDuW70WMkLEoBQ7B4UXP/803GpW/Q=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr37013644otf.77.1593870483069;
 Sat, 04 Jul 2020 06:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200623011803.91232-1-saravanak@google.com> <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
 <CAGETcx9SBOQOL+xKq_-d2egG8+jMNjPMH37tVNBxgkWBGLWhvA@mail.gmail.com> <20200704120934.GA21097@willie-the-truck>
In-Reply-To: <20200704120934.GA21097@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Jul 2020 15:47:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHLt9PojEXwXJE=DdKRkd=LL7uND4qgi6PABNUSBnkPog@mail.gmail.com>
Message-ID: <CAMj1kXHLt9PojEXwXJE=DdKRkd=LL7uND4qgi6PABNUSBnkPog@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing
 PLT counting
To:     Will Deacon <will@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jul 2020 at 14:09, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 03, 2020 at 05:47:24PM -0700, Saravana Kannan wrote:
> > On Thu, Jul 2, 2020 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Tue, 23 Jun 2020 at 03:27, Saravana Kannan <saravanak@google.com> wrote:
> > > > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > > > index 65b08a74aec6..0ce3a28e3347 100644
> > > > --- a/arch/arm64/kernel/module-plts.c
> > > > +++ b/arch/arm64/kernel/module-plts.c
> > > > @@ -253,6 +253,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> > > >         return ret;
> > > >  }
> > > >
> > > > +static bool branch_rela_needs_plt(Elf64_Sym *syms, Elf64_Rela *rela,
> > > > +                                 Elf64_Word dstidx)
> > > > +{
> > > > +
> > > > +       Elf64_Sym *s = syms + ELF64_R_SYM(rela->r_info);
> > > > +
> > > > +       if (s->st_shndx == dstidx)
> > > > +               return false;
> > > > +
> > > > +       return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26 ||
> > > > +              ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > > > +}
> > > > +
> > > > +/* Group branch PLT relas at the front end of the array. */
> > > > +static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
> > > > +                                     int numrels, Elf64_Word dstidx)
> > > > +{
> > > > +       int i = 0, j = numrels - 1;
> > > > +
> > > > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > > > +               return 0;
> > > > +
> > > > +       while (i < j) {
> > > > +               if (branch_rela_needs_plt(syms, &rela[i], dstidx))
> > > > +                       i++;
> > > > +               else if (branch_rela_needs_plt(syms, &rela[j], dstidx))
> > > > +                       swap(rela[i], rela[j]);
> > >
> > > Nit: would be slightly better to put
> > >
> > >   swap(rela[i++], rela[j]);
> > >
> > > here so the next iteration of the loop will not call
> > > branch_rela_needs_plt() on rela[i] redundantly. But the current code
> > > is also correct.
> >
> > Oh yeah, I noticed that unnecessary repeat of branch_rela_needs_plt()
> > on rela[i] when j had to be decremented, but forgot to handle it after
> > I was done with all the testing.
>
> Yeah, I guess you can decrement j as well, but I just think it makes the
> logic harder to read and more error-prone if we change it later.
>

Indeed,

  swap(rela[i++], rela[j--]);

looks even bettter!

But you're right, it's not a big deal.


> > But I did compare it to the code I had written in v1 that didn't have
> > this extra check for rela[i]. I couldn't find any measurable
> > difference in the module load time. Maybe 1ms for the worst case
> > module, but that could have been just run to run variation.
> >
> > Anyway, maybe send this as another patch since Catalin has already
> > picked this mine?
>
> I think the queued code is fine, so we don't need to micro-optimise it.
>
> Will

Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C3D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Wj9Ula7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgAJQTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:19:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45523 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgAJQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:19:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so2037303edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh6us/Go02lHef84JDI3MgwC50UfsnhAdjL91XljPeU=;
        b=Wj9Ula7TMzC62JWXNFEdOeamwpPHP716Mj1o221OqkcCZCuecYxsiEVTW1V9auuAoO
         tLr7WRRGGjVm27eIwxcfIIqWay/7axRIcySUC2se8fNXdy+9qH2nXsubbVdJtt4Y/GtX
         dR91P+hET1gBNJvMMxIlS2z66iwqWzu7wIqHtmBSWENsd63fC1iD/gncylgo4Sff7qNZ
         u31mF/3Lxq9oq+nMmSQ26gzh4SXQHuXa+KZnIprk8RYyekjZlzXFHEUlNWl5qDsNP9Pt
         Ln+LQEFihXYzUGKt6YQq4BALU7uUXrzm841ow+HziKtKil8wsCUc+yp25xjqf1sRXOqi
         Kpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh6us/Go02lHef84JDI3MgwC50UfsnhAdjL91XljPeU=;
        b=sn7P0MZf4XKErBpKj8VBOHT6ddBJ46kDFBdTO/CcEWYhWIcc+ygKJhD9ky1Yak2f37
         UIfbySJBzjHBI7jkkRzyiu67jUdtB1ftT+25GC23vBFKUSzzuXVCXXthTznQL1AlEo0n
         FodFjYqtv8sNXl/UDdK8WD3FUXVdw/UMxJvyGd+CKsiKC8+UvCwj4UvYMoJWBwQLjv8C
         e4M0siDC3mlfEYwCZVe5LLfwJZAvVapXDu8uCnnYKY2EOQP6/CIxLAhKEVpv7EuAFC/f
         oKfe+A5hieBtZMPcpqclg8rbWMul96maOonnZq3GlEOkzWSN0aDYkC1yyOGncgCFqhi7
         9x6Q==
X-Gm-Message-State: APjAAAXdygE8JxELPs1HDN7a1usTj0CKWZRWS5ByHMzLe80YrvewKwjJ
        iWjuxIxJw8kWqF1uLd4V9MTpq9ZO1DkvLwBf2U/NDw==
X-Google-Smtp-Source: APXvYqzJfshZOAokaxWuwXwiLIbWcBjZg5SzN2kuFXInd6axrGTlsjdF6UVhNJfkj9FvMVF+vmnpssugqmY4nQwGd2w=
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr1668243edb.332.1578673167364;
 Fri, 10 Jan 2020 08:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org> <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org> <20200109083254.GA7280@willie-the-truck> <20200110160549.GA25437@willie-the-truck>
In-Reply-To: <20200110160549.GA25437@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 10 Jan 2020 11:19:16 -0500
Message-ID: <CA+CK2bAy-vfoz3kgUjZB74Hrobgu-a8H4pv6RbA_tbq++NWz5g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
To:     Will Deacon <will@kernel.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:05 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jan 09, 2020 at 08:32:54AM +0000, Will Deacon wrote:
> > On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> > > On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > > > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > > > index 12a561a54128..d24b527e8c00 100644
> > > > > --- a/arch/arm64/include/asm/kexec.h
> > > > > +++ b/arch/arm64/include/asm/kexec.h
> > > > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > > > >  struct kimage_arch {
> > > > >         void *dtb;
> > > > >         unsigned long dtb_mem;
> > > > > +       /* Core ELF header buffer */
> > > > > +       void *elf_headers;
> > > > > +       unsigned long elf_headers_mem;
> > > > > +       unsigned long elf_headers_sz;
> > > > >  };
> > > >
> > > > This conflicts with the cleanup work from Pavel. Please can you check my
> > > > resolution? [1]
> > >
> > > I don't know why we need to change a type of dtb_mem,
> > > otherwise it looks good.
> > >
> > > (I also assume that you notice that kimage_arch is of no use for kexec.)
> >
> > Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
> > to drop Pavel's patch altogether in light of your changes, we can do that
> > instead.
> >
> > Thoughts?
>
> Well, I've reverted the cleanup patch so please shout if you'd prefer
> something else.

As I understand, the only concern was the type change for dtb_mem.
This was one of the review comments for my patch
https://lore.kernel.org/lkml/20191204155938.2279686-21-pasha.tatashin@soleen.com/

(I believe it was from Marc Zyngier), I add a number of new fields,
and they all should be phys_addr_t, this is why I change dtb_mem to
phys_addr_t to be consistent.

Pasha

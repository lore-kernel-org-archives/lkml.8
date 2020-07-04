Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F5BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB6D20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593864581;
	bh=X22tQmeMJ8J3B60hTKOzNA4Xdp+LVatGyVDda2h5yfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eVKzfErjFntj9GBJRH6v3BK/WNrOiZSK9rL7xNczRAZQEiyIiuUkDd75Ppan8qjT7
	 lnLL/Z/Rp1C8vzV05spn5LNsLdWRY9CrwSj1VFZSaU6AGs4TJ9O8XPv802X1rc1m96
	 zLOXLQ8C7AvMKXF/i3Ci1PZRd3qKbjhuzHghb5V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGDMJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGDMJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:09:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F26C20885;
        Sat,  4 Jul 2020 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593864579;
        bh=X22tQmeMJ8J3B60hTKOzNA4Xdp+LVatGyVDda2h5yfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esjXWAn/cWRcpXzz410rtEMYcAQdEn8CFgrY8KAcQghAJyp2xZjohPVYbxTlJp7Ou
         l+ROhInoynGXtle7oWOE61SUDm34ZjtXWXHDFlDeThvaeUr9ErOrr1tmrW+uSgZd1p
         c44hkrUSNW/tEjp4YaNrlG4n7U80WqNuRlZxBRZ0=
Date:   Sat, 4 Jul 2020 13:09:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing
 PLT counting
Message-ID: <20200704120934.GA21097@willie-the-truck>
References: <20200623011803.91232-1-saravanak@google.com>
 <CAKv+Gu8rwTntUjd83+s07n+4ki+ON0Gkqao0ZgAF9haAw71dTA@mail.gmail.com>
 <CAGETcx9SBOQOL+xKq_-d2egG8+jMNjPMH37tVNBxgkWBGLWhvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9SBOQOL+xKq_-d2egG8+jMNjPMH37tVNBxgkWBGLWhvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 05:47:24PM -0700, Saravana Kannan wrote:
> On Thu, Jul 2, 2020 at 8:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Tue, 23 Jun 2020 at 03:27, Saravana Kannan <saravanak@google.com> wrote:
> > > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > > index 65b08a74aec6..0ce3a28e3347 100644
> > > --- a/arch/arm64/kernel/module-plts.c
> > > +++ b/arch/arm64/kernel/module-plts.c
> > > @@ -253,6 +253,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> > >         return ret;
> > >  }
> > >
> > > +static bool branch_rela_needs_plt(Elf64_Sym *syms, Elf64_Rela *rela,
> > > +                                 Elf64_Word dstidx)
> > > +{
> > > +
> > > +       Elf64_Sym *s = syms + ELF64_R_SYM(rela->r_info);
> > > +
> > > +       if (s->st_shndx == dstidx)
> > > +               return false;
> > > +
> > > +       return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26 ||
> > > +              ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
> > > +}
> > > +
> > > +/* Group branch PLT relas at the front end of the array. */
> > > +static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
> > > +                                     int numrels, Elf64_Word dstidx)
> > > +{
> > > +       int i = 0, j = numrels - 1;
> > > +
> > > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > > +               return 0;
> > > +
> > > +       while (i < j) {
> > > +               if (branch_rela_needs_plt(syms, &rela[i], dstidx))
> > > +                       i++;
> > > +               else if (branch_rela_needs_plt(syms, &rela[j], dstidx))
> > > +                       swap(rela[i], rela[j]);
> >
> > Nit: would be slightly better to put
> >
> >   swap(rela[i++], rela[j]);
> >
> > here so the next iteration of the loop will not call
> > branch_rela_needs_plt() on rela[i] redundantly. But the current code
> > is also correct.
> 
> Oh yeah, I noticed that unnecessary repeat of branch_rela_needs_plt()
> on rela[i] when j had to be decremented, but forgot to handle it after
> I was done with all the testing.

Yeah, I guess you can decrement j as well, but I just think it makes the
logic harder to read and more error-prone if we change it later.

> But I did compare it to the code I had written in v1 that didn't have
> this extra check for rela[i]. I couldn't find any measurable
> difference in the module load time. Maybe 1ms for the worst case
> module, but that could have been just run to run variation.
> 
> Anyway, maybe send this as another patch since Catalin has already
> picked this mine?

I think the queued code is fine, so we don't need to micro-optimise it.

Will

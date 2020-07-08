Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30DD2220E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594198130;
	bh=v5b+eRpJRjTUvJpoBew9P5DOQzMsw60wsZb0UX7sXXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mEkBJOw8u9xMQQ0f9P0sEjOqC0T/rtvH/SEZE/5axcCvPeR3p/aO40hS7FJONbTPZ
	 tP4Q8z4+MCTKgJQm8dqlWlA/ZzmcxwaCZBS4zGeI7ejA/4NwYOBbY5gWhUGSDBphHO
	 BwSfq5a+zITUOAfL/eurbjydEgrdNtknCnz0xlzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGHIsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgGHIst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:48:49 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFA42220F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594198128;
        bh=v5b+eRpJRjTUvJpoBew9P5DOQzMsw60wsZb0UX7sXXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cvomhAG0GZfWJanHzzFwzJkezudt5a8yhvVMvUHCAtpPvdULl4qnaVApUqvFRgpSC
         YeqzgExHoFs0wagB65hJRUaQNYJ54thqnWZrOgh1+Als4gwTjgtB3hnIT2XnA6JIkh
         mVbX/DyWB5Vz5+EbNshT19F1R/4fpcwzC0f8oRl0=
Received: by mail-ot1-f48.google.com with SMTP id t18so23566860otq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:48:48 -0700 (PDT)
X-Gm-Message-State: AOAM5301o5KmTtlA1zZxDH/GvckUdU1kTaG77poDbtzs2FQc91gr32MY
        a9WNYRXt6JsB5Wakkj7jScvL/SVTDEOqHD1Qh2g=
X-Google-Smtp-Source: ABdhPJxS1ynqKGQAtbpJJ+5ir8RRkw7pnxby6VMxWNh8LxEcJeEGX4RdPUzfAeMdOx0/UT/n81JHpBhxP1bkqzj1EZY=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr8243417otr.90.1594198127882;
 Wed, 08 Jul 2020 01:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707114608.24197-1-richard.peng@oppo.com> <20200708082519.GA25634@willie-the-truck>
In-Reply-To: <20200708082519.GA25634@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Jul 2020 11:48:36 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHYODhL0TNrx7F-e4Yt++fCVO7CcL=y99cJLJZ_4zDvzw@mail.gmail.com>
Message-ID: <CAMj1kXHYODhL0TNrx7F-e4Yt++fCVO7CcL=y99cJLJZ_4zDvzw@mail.gmail.com>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
To:     Will Deacon <will@kernel.org>
Cc:     Peng Hao <richard.peng@oppo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 11:25, Will Deacon <will@kernel.org> wrote:
>
> [+Ard]
>
> On Tue, Jul 07, 2020 at 07:46:08AM -0400, Peng Hao wrote:
> > If plt_max_entries is 0, a warning is triggered.
> > WARNING: CPU: 200 PID: 3000 at arch/arm64/kernel/module-plts.c:97 module_emit_plt_entry+0xa4/0x150
>
> Which kernel are you seeing this with? There is a PLT-related change in
> for-next/core, and I'd like to rule if out if possible.
>
> > Signed-off-by: Peng Hao <richard.peng@oppo.com>
> > ---
> >  arch/arm64/kernel/module-plts.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 65b08a74aec6..1868c9ac13f2 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -79,7 +79,8 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> >       int i = pltsec->plt_num_entries;
> >       int j = i - 1;
> >       u64 val = sym->st_value + rela->r_addend;
> > -
> > +     if (pltsec->plt_max_entries == 0)
> > +             return 0;
>
> Hmm, but if there aren't any PLTs then how do we end up here?
>

Indeed. module_emit_plt_entry() is only invoked if we encounter a call
or jump relocation that is out of range, and so we failed to allocate
enough PLT entries in module_frob_arch_sections() if you are entering
module_emit_plt_entry() with max_entries set to 0x0. The only other
way to trigger this is when the .text section of your module is so
large that branches go out of range, but PLTs won't help there.

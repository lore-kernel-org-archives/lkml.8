Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49180C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1957B20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580715960;
	bh=NpQdDt5eAIvxs5CKHTDMdu6/4BKeMFFMYjFcCPrJrnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GvmPP4yh9QfZxMkl/SLIun3S2TDVSwN1k5SkuchKTqMytU8fy2ZJgk/d2yuLsROC6
	 6ilOmS/eQ8hL888iV3KQT82d5v198toRd0U+9igjufI8GUFTLe+S51I8j9L19uWgof
	 ELXNSc3XIfYWT5QuUQPwEMH/LDjColpQBoS10bBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBCHp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 02:45:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36828 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBCHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 02:45:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so15706288wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0ibKHDIVsBKCBJjNbjt+42arvSsGLtNtx2nlSMX0aLc=;
        b=RQyVnSwCFTEhcOi/JFrnlzioqqaCafWVzCju9VO+Pp1gjhiya6c1mAaxOI3e7R18aD
         Fk8QTRdJbci5xyrSi4p1NnEjTGkV7HUC3EWOtUeyXI7/j6WHbXw5i83TL62E78LlryjM
         eYLhNgHE8DuwVeXOCTS+M1WfzR6SsXEc9R2RVjC1zF84UREnZ7cUL0tX4ITUSaGVqqOs
         hBBgmbSoeUlzSTbpIunY2ctc9kd6q5g5bZr7irDGBcDU1DirrbVvBg0z96dkkzQdlYTq
         wsohw7PIStBjVViXMwVn+saejnDNYxAh+i4rbqHaYwLNoXeO6SDO9cyD7jXS+4GJrq8v
         /oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0ibKHDIVsBKCBJjNbjt+42arvSsGLtNtx2nlSMX0aLc=;
        b=ShMs2euuRRs+AscQdeiCLvr7aZLced5yDKWZ4D587cJ4cfra/stNJzbjGkX1JMvcTB
         kbkH9Zv96oLgjxb0IaZl9NHVi1c7MLOyMVRHMzabLJoge/40BSX57v+zmg0vcFyJX1Xu
         Vu0pDZEaWXTzH50HxMWGP/0yz3sIRXlKqeK/2raOIY+QI6oxjJ2arZP6zZi37LUCdQvu
         gqRzrEyZyUdAtmV7veZSg1LlE6L2d9R82DrAtPX1/t88oBWonBcPj+gUX1iJKHCA/gMa
         asBR4g2/2FauI/IfWSfQzETTjIBdViu7T2skBKQIpdpzmlrnxQZVMPO3Vca52z9gYm/3
         FbhA==
X-Gm-Message-State: APjAAAVYJEXGQuFum1V9il4fM0gv9zu/aDSk4068kLkaSraLXSPVq9bf
        SKPxBrEq6snqdHZVOQgLPHE=
X-Google-Smtp-Source: APXvYqwEdUn4tEskSoSxJcv8ORGdYJS+8fCfe65sVagaFAllx4Ca2T/sN5LRffnYTeKWEecBc66vmw==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr28104865wmf.102.1580715955463;
        Sun, 02 Feb 2020 23:45:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 25sm22289827wmi.32.2020.02.02.23.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 23:45:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 08:45:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
Message-ID: <20200203074552.GA54169@gmail.com>
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com>
 <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com>
 <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
 <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com>
 <20200202092255.GA72728@gmail.com>
 <CADDKRnAo9B=+cNO-_VbH4yADVsQqaTb61ithqxohYCwgAm6pvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnAo9B=+cNO-_VbH4yADVsQqaTb61ithqxohYCwgAm6pvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jörg Otte <jrg.otte@gmail.com> wrote:

> Am So., 2. Feb. 2020 um 10:22 Uhr schrieb Ingo Molnar <mingo@kernel.org>:
> >
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > > Hello Jörg,
> > >
> > > Could you please try whether the change below fixes the issue?
> > >
> > > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > > index 59f7f6d60cf6..ae923ee8e2b4 100644
> > > --- a/arch/x86/platform/efi/efi.c
> > > +++ b/arch/x86/platform/efi/efi.c
> > > @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
> > >                         .phys_map = efi.memmap.phys_map,
> > >                         .desc_version = efi.memmap.desc_version,
> > >                         .desc_size = efi.memmap.desc_size,
> > > -                       .size = data.desc_size * (efi.memmap.nr_map - n_removal),
> > > +                       .size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
> > >                         .flags = 0,
> >
> > Oh, I actually noticed this one, but convinced myself that it's correct,
> > because GCC didn't warn about uninitialized data.
> >
> > But maybe in this weird case data.desc_size as used within its own
> > initializer is zero?
>
> Patch makes my kernel booting again :)

Thank you! I'll send the fix to Linus later today.

	Ingo

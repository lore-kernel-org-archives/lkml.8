Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF636C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A852053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597309215;
	bh=nxJfY0GDp7W2K3CU3jLZpVw53XoSNI4mAsvj9BpugmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtSLHwsMLmFhX38J/n9hBvbUCeoHlCkc69NUv2+eplUfnMuvbx8riTkZkEzdce80D
	 WWIAs5SRKUlVYIEKWPaLZKg6mlpuUa527RklAfgfvrMxcsOgSDEMOsSomp1WaU3fOF
	 KmB373Nmqzn/ZW6j1plgPGF/m8ZrnY5COzEvEkhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMJAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMJAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:00:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8DE20771;
        Thu, 13 Aug 2020 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597309212;
        bh=nxJfY0GDp7W2K3CU3jLZpVw53XoSNI4mAsvj9BpugmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=06aQ79qZAgWaNvqgB0OTgqnkPG6MnwOgAcbZ3bzg4T0gaJY+GsoEcBFtrXPsO6gho
         PzT2SHsSVrS3t3Se8GYVNxhiA9y0k8mM3jsX/txeWROkFCQZuO2LTmVxfMRZVWHyFk
         9Bb7tSPDxOVc+duio7n5WE3Lv6Jph+Bo8mlXBu2Y=
Date:   Thu, 13 Aug 2020 10:00:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200813090006.GA9829@willie-the-truck>
References: <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812164205.GS14398@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812164205.GS14398@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:42:05PM +0100, Szabolcs Nagy wrote:
> The 08/12/2020 18:37, Ard Biesheuvel wrote:
> > On Wed, 12 Aug 2020 at 18:00, Jessica Yu <jeyu@kernel.org> wrote:
> > > +++ Szabolcs Nagy [12/08/20 15:15 +0100]:
> > > >for me it bisects to
> > > >
> > > >https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=8c803a2dd7d3d742a3d0071914f557ef465afe71
> > > >
> > > >i will have to investigate further what's going on.
> > >
> > > Thanks for the hint. I'm almost certain it's due to this excerpt from
> > > the changelog: "we now init sh_type and sh_flags for all known ABI sections
> > > in _bfd_elf_new_section_hook."
> > >
> > > Indeed, .plt and .text.* are listed as special sections in bfd/elf.c.
> > > The former requires an exact match and the latter only has to match
> > > the prefix ".text." Since the code considers ".plt" and
> > > ".text.ftrace_trampoline" special sections, their sh_type and sh_flags
> > > are now set by default. Now I guess the question is whether this can
> > > be overriden by a linker script..
> > >
> > 
> > If this is even possible to begin with, doing this in a way that is
> > portable across the various linkers that we claim to support is going
> > to be tricky.
> > 
> > I suppose this is the downside of using partially linked objects as
> > our module format - using ordinary shared libraries (along with the
> > appropriate dynamic relocations which are mostly portable across
> > architectures) would get rid of most of the PLT and trampoline issues,
> > and of a lot of complex static relocation processing code.
> > 
> > I know there is little we can do at this point, apart from ignoring
> > the permissions - perhaps we should just defer the w^x check until
> > after calling module_frob_arch_sections()?
> 
> i opened
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=26378
> 
> and waiting for binutils maintainers if this is intentional.

Thanks, Szabolcs. It's looking this is intentional behaviour (a bug fix),
so we'll have to suck it up in the module loader.

Will

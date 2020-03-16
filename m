Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04403C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6EF2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uum7lcZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbgCPSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:53:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44973 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbgCPSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:53:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so10437237pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+podwppa4DyWf53RIH1ihBDuD2KXV9T0VUiX/PfUWE=;
        b=uum7lcZ7m3pHyisa5lAVyi3JPTeHluh095pAJAZTWHTrUmZFiKCON90yLYi7WBlStz
         eV545uvi0SoXUqb3LJ37Pw+HSKWXVnq7G9xggwilOQ4R/F/WnGNAd0f4nlnqD7LrwDmR
         R6T1ayl2Po1z+F1Q7hTTAZcw/PwOVD0U3qm8d0DtnyXAHClRdOqXEmxqs5LNuRsZy5Ct
         gvYMCtiA69b727/lGknNpOk/RoKqOmMTKwt5oWBbkJWXPe0xblsqIOOTALuwbXtO/mb5
         zmhqys2BbW+l1gYBp/fs5uPx9xN8yXkwlc0HJVnR/dUEFJBV2aTnVc1EkMT8L1FWLIOe
         Ervg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+podwppa4DyWf53RIH1ihBDuD2KXV9T0VUiX/PfUWE=;
        b=HZol98qECdtIryOMjXed4uS4tXtq8d8+fuMiHNpWKwFTkY1KU9IvNf9cNx9N/9mLRx
         NRzEky3H9Jtnb1XRm4HUk6TkVR3yCY0/YcDMIGuoqiWvZCXVFN7ZEYG1PC5qB5ggOgFn
         jBNYOkGtTd6f2ynRxDWYDhEtY1KPRK4UP8HTbkxZJd+nOmJZ0Wh5RGsyxMrxlo2OtHN1
         rXZAb2PCZeGKOPv5bVinWiHLxvZ9RRUjkQ/pg+7sGs2DJCIL/jAm2rz0rCDoRRm92rC5
         MsHTwG+l5TLhez/J3ucF4BxFZ/DHLKHjJ1rDtqElmJzdfIqk/YhEnYHhj249NCVJjYdo
         zsdw==
X-Gm-Message-State: ANhLgQ3D16CAenXs4i9+jdSV+ej0baYEdrIMl4q9EdTGqvOns/duucnq
        it8C6+9alMvAIlH4z4mnPWJ3ljhBZtkNEw7bTa7GKg==
X-Google-Smtp-Source: ADFU+vuiEvgSrFq74yKR9Y9QuiYAuRxvXyqEfYI8ORBUIme0U3+TDO2heE6aW/5Wy3gfWF0it0zAoU2oquD7ucOxk8A=
X-Received: by 2002:a63:4453:: with SMTP id t19mr1082993pgk.381.1584384783613;
 Mon, 16 Mar 2020 11:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200311214601.18141-1-hdegoede@redhat.com> <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan> <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic> <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic> <20200313044235.GA1159234@rani.riverdale.lan>
 <20200313045853.GA1172167@rani.riverdale.lan>
In-Reply-To: <20200313045853.GA1172167@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Mar 2020 11:52:52 -0700
Message-ID: <CAKwvOd=mgq_wiViYPv3W3q7VN-YdPwdRKwhoW+YVpYxFdmht=w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 9:58 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Mar 13, 2020 at 12:42:36AM -0400, Arvind Sankar wrote:
> > On Thu, Mar 12, 2020 at 01:50:39PM +0100, Borislav Petkov wrote:
> > > On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
> > > > My version of this patch has already been tested this way. It is
> > >
> > > Tested with kexec maybe but if the 0day bot keeps finding breakage, that
> > > ain't good enough.
> > >
> > > > 1. Things are already broken, my patch just exposes the brokenness
> > > > of some configs, it is not actually breaking things (well it breaks
> > > > the build, changing a silent brokenness into an obvious one).
> > >
> > > As I already explained, that is not good enough.
> > >
> > > > 2. I send out the first version of this patch on 7 October 2019, it
> > > > has not seen any reaction until now. So I'm sending out new versions
> > > > quickly now that this issue is finally getting some attention...
> > >
> > > And that is never the right approach.
> > >
> > > Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
> > > them with more patchsets does not help - fixing stuff properly does.
> > >
> > > So, to sum up: if Arvind's approach is the better one, then we should do
> > > that and s390 should be fixed this way too. And all tested. And we will
> > > remove the hurry element from it all since it has not been noticed so
> > > far so it is not urgent and we can take our time and fix it properly.
> > >
> > > Ok?
> > >
> > > Thx.
> > >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > https://people.kernel.org/tglx/notes-about-netiquette
> >
> > If I could try to summarize the situation here:
> > - the purgatory requires filtering out certain CFLAGS/other settings set
> >   for the generic kernel in order to work correctly
> > - the patch proposed by Hans de Goede will detect missing filters at
> >   build time rather than when kexec is executed
> > - the filtering is currently not perfect as demonstrated by issues that
> >   0day bot is finding -- but the patchset will find these problems at
> >   build time rather than runtime
> > - there might be a slight optimization as proposed by me [1] but it
> >   might have problems as in [2] even if it seems to work
> >
> > I think the patch as of v5 [0] is useful right now, to catch CFLAGS
> > additions that aren't currently being filtered correctly. The real
> > problem is that there exist CFLAGS that should be used for all source
> > files in the kernel, and there are CFLAGS (eg tracing, stack check etc)
> > that should only be used for the kernel proper. For special
> > compilations, such as boot stubs, vdso's, purgatory we should have the
> > generic CFLAGS but not the kernel-proper CFLAGS. The issue currently is
> > that these special compilations need to filter out all the flags added
> > for kernel-proper, and this is a moving target as more tracing/sanity
> > flags get added.  Neither the solution of simply re-initializing CFLAGS
> > (which will miss generic CFLAGS) nor trying to filter out CFLAGS (which
> > will miss new kernel-proper CFLAGS) works very well. I think ideally
> > splitting these into independent variables, i.e. BASE_FLAGS that can be
> > used for everything, and KERNEL_FLAGS only to be used for the kernel
> > proper is likely eventually the better solution, rather than conflating
> > both into KBUILD_CFLAGS.

Yep, I agree with the above summary.  The conflation of flags that
shouldn't be applied to purgatory, boot, etc with flags that are
always required is currently messier than I'd like.  Will definitely
be a yak shave to detangle them.

> >
> > But to move forward incrementally, patch v5 is probably the cleanest. My
> > suggestion in [1] I'm thinking is changing things significantly for
> > kexec, by changing the purgatory from a relocatable object file into an
> > actual executable, and might have knock-on implications that need to be
> > reviewed and tested carefully before it can be merged, as shown by [2].
> >
> > [0] https://lore.kernel.org/lkml/20200312114951.56009-1-hdegoede@redhat.com/
> > [1] https://lore.kernel.org/lkml/20200312001006.GA170175@rani.riverdale.lan/
> > [2] https://lore.kernel.org/lkml/20200312182322.GA506594@rani.riverdale.lan/
>
> Cc Nick Desaulniers, Nathan Chancellor, Ard Biesheuvel, who've all been
> involved in these issue of trying to decide whether to filter out CFLAGS
> or recreate them from scratch in various places.



-- 
Thanks,
~Nick Desaulniers

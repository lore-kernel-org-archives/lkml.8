Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A579B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgERWfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgERWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:35:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B6220674;
        Mon, 18 May 2020 22:35:14 +0000 (UTC)
Date:   Mon, 18 May 2020 18:35:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau@lists.freedesktop.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t
 variables
Message-ID: <20200518183513.53b94f11@gandalf.local.home>
In-Reply-To: <CAKwvOdmXgYThHRDpt5dFZy5T1zS6MYQhcBNcq6-rsuc5fjiE6Q@mail.gmail.com>
References: <20200408205323.44490-1-natechancellor@gmail.com>
        <20200518093117.GA719849@ubuntu-s3-xlarge-x86>
        <CAKwvOdmXgYThHRDpt5dFZy5T1zS6MYQhcBNcq6-rsuc5fjiE6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 11:52:47 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Mon, May 18, 2020 at 2:31 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Apr 08, 2020 at 01:53:23PM -0700, Nathan Chancellor wrote:  
> > > When building with Clang + -Wtautological-compare and
> > > CONFIG_CPUMASK_OFFSTACK unset:
> > >
> > > arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
> > > equal to a null pointer is always false [-Wtautological-pointer-compare]
> > >         if (downed_cpus == NULL &&
> > >             ^~~~~~~~~~~    ~~~~
> > > arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
> > > equal to a null pointer is always false [-Wtautological-pointer-compare]
> > >         if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> > >             ^~~~~~~~~~~    ~~~~
> > > 2 warnings generated.
> > >
> > > Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
> > > cpumask_available to fix warnings of this nature. Use that here so that
> > > clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/982
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>  
> 
> Thanks for the patch, sorry I'm falling behind on code review!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Linus sent me a issue about this failure privately as well, and had two
solutions for it (one being identical to this one, and I shared that with
him, and another one he thought would be better, but had some issues).

Linus,

Are you OK with this patch?

-- Steve


> 
> > > ---
> > >  arch/x86/mm/mmio-mod.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> > > index 109325d77b3e..43fd19b3f118 100644
> > > --- a/arch/x86/mm/mmio-mod.c
> > > +++ b/arch/x86/mm/mmio-mod.c
> > > @@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
> > >       int cpu;
> > >       int err;
> > >
> > > -     if (downed_cpus == NULL &&
> > > +     if (!cpumask_available(downed_cpus) &&
> > >           !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
> > >               pr_notice("Failed to allocate mask\n");
> > >               goto out;
> > > @@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
> > >       int cpu;
> > >       int err;
> > >
> > > -     if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> > > +     if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
> > >               return;
> > >       pr_notice("Re-enabling CPUs...\n");
> > >       for_each_cpu(cpu, downed_cpus) {
> > >
> > > base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
> > > --
> > > 2.26.0
> > >  
> >
> > Gentle ping for acceptance, I am not sure who should take this.  
> 
> Looks like Steven or Ingo are the listed maintainers for MMIOTRACE?
> 


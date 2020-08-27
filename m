Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96132054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgH0O4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgH0O4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:56:48 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178032054F;
        Thu, 27 Aug 2020 14:56:44 +0000 (UTC)
Date:   Thu, 27 Aug 2020 15:56:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20200827145642.GO29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
 <20200827095429.GC29264@gaia>
 <CAAeHK+xHQDMsTehppknjNTEMFh18ufWB1XLUGdVFoc-QZ-mVrw@mail.gmail.com>
 <20200827131045.GM29264@gaia>
 <CAAeHK+xraz7E41b4LW6VW9xOH51UoZ+odNEDrDGtaJ71n=bQ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xraz7E41b4LW6VW9xOH51UoZ+odNEDrDGtaJ71n=bQ3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:34:42PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 3:10 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Aug 27, 2020 at 02:31:23PM +0200, Andrey Konovalov wrote:
> > > On Thu, Aug 27, 2020 at 11:54 AM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > On Fri, Aug 14, 2020 at 07:27:03PM +0200, Andrey Konovalov wrote:
> > > > > +static int do_tag_recovery(unsigned long addr, unsigned int esr,
> > > > > +                        struct pt_regs *regs)
> > > > > +{
> > > > > +     report_tag_fault(addr, esr, regs);
> > > > > +
> > > > > +     /* Skip over the faulting instruction and continue: */
> > > > > +     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > > >
> > > > Ooooh, do we expect the kernel to still behave correctly after this? I
> > > > thought the recovery means disabling tag checking altogether and
> > > > restarting the instruction rather than skipping over it.
[...]
> > > Can we disable MTE, reexecute the instruction, and then reenable MTE,
> > > or something like that?
> >
> > If you want to preserve the MTE enabled, you could single-step the
> > instruction or execute it out of line, though it's a bit more convoluted
> > (we have a similar mechanism for kprobes/uprobes).
> >
> > Another option would be to attempt to set the matching tag in memory,
> > under the assumption that it is writable (if it's not, maybe it's fine
> > to panic). Not sure how this interacts with the slub allocator since,
> > presumably, the logical tag in the pointer is wrong rather than the
> > allocation one.
> >
> > Yet another option would be to change the tag in the register and
> > re-execute but this may confuse the compiler.
> 
> Which one of these would be simpler to implement?

Either 2 or 3 would be simpler (re-tag the memory location or the
pointer) with the caveats I mentioned. Also, does the slab allocator
need to touch the memory on free with a tagged pointer? Otherwise slab
may hit an MTE fault itself.

> Perhaps we could somehow only skip faulting instructions that happen
> in the KASAN test module?.. Decoding stack trace would be an option,
> but that's a bit weird.

If you want to restrict this to the KASAN tests, just add some
MTE-specific accessors with a fixup entry similar to get_user/put_user.
__do_kernel_fault() (if actually called) will invoke the fixup code
which skips the access and returns an error. This way KASAN tests can
actually verify that tag checking works, I'd find this a lot more
useful.

-- 
Catalin

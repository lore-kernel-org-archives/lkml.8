Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA8C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854BA20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMITW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:19:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57470 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:19:22 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j29iF-0089Y1-N7; Thu, 13 Feb 2020 09:19:08 +0100
Message-ID: <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Thu, 13 Feb 2020 09:19:06 +0100
In-Reply-To: <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com> (sfid-20200213_013812_463819_2E8172A0)
References: <20200210225806.249297-1-trishalfonso@google.com>
         <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
         <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
         (sfid-20200213_013812_463819_2E8172A0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 16:37 -0800, Patricia Alfonso wrote:
> 
> > That also means if I have say 512MB memory allocated for UML, KASAN will
> > use an *additional* 64, unlike on a "real" system, where KASAN will take
> > about 1/8th of the available physical memory, right?
> > 
> Currently, the amount of shadow memory allocated is a constant based
> on the amount of user space address space in x86_64 since this is the
> host architecture I have focused on.

Right, but again like below - that's just mapped, not actually used. But
as far as I can tell, once you actually start running and potentially
use all of your mem=1024 (MB), you'll actually also use another 128MB on
the KASAN shadow, right?

Unlike, say, a real x86_64 machine where if you just have 1024 MB
physical memory, the KASAN shadow will have to fit into that as well.

> > > +# With these files removed from instrumentation, those reports are
> > > +# eliminated, but KASAN still repeatedly reports a bug on syscall_stub_data:
> > > +# ==================================================================
> > > +# BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x299/0x2bf
> > > +# Read of size 128 at addr 0000000071457c50 by task swapper/1
> > 
> > So that's actually something to fix still? Just trying to understand,
> > I'll test it later.
> > 
> Yes, I have not found a fix for these issues yet and even with these
> few files excluded from instrumentation, the syscall_stub_data error
> occurs(unless CONFIG_STACK is disabled, but CONFIG_STACK is enabled by
> default when using gcc to compile). It is unclear whether this is a
> bug that KASAN has found in UML or it is a mismatch of KASAN error
> detection on UML.

Right, ok, thanks for the explanation. I guess then stack
instrumentation should be disabled for this patch initially.

> > Heh, you *actually* based it on my patch, in git terms, not just in code
> > terms. I think you should just pick up the few lines that you need from
> > that patch and squash them into this one, I just posted that to
> > demonstrate more clearly what I meant :-)
> > 
> I did base this on your patch. I figured it was more likely to get
> merged before this patch anyway. To clarify, do you want me to include
> your constructors patch with this one as a patchset?

Well I had two patches:
 (1) the module constructors one - I guess we need to test it, but you
     can include it here if you like. I'm kinda swamped with other
     things right now, no promises I can actually test it soon, though I
     really do want to because that's the case I need :)
 (2) the [DEMO] patch - you should just take the few lines you need from
     that (in the linker script) and stick it into this patch. Don't
     even credit me for that, I only wrote it as a patch instead of a
     normal text email reply because I couldn't figure out how to word
     things in an understandable way...

Then we end up with 2 patches again, the (1) and your KASAN one. There's
no point in keeping the [DEMO] separate, and 

> > > +     if (mmap(start,
> > > +              len,
> > > +              PROT_READ|PROT_WRITE,
> > > +              MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> > > +              -1,
> > > +              0) == MAP_FAILED)
> > > +             os_info("Couldn't allocate shadow memory %s", strerror(errno));
> > 
> > If that fails, can we even continue?
> > 
> Probably not, but with this executing before main(), what is the best
> way to have an error occur? Or maybe there's a way we can just
> continue without KASAN enabled and print to the console that KASAN
> failed to initialize?

You can always "exit(17)" or something.

I'm not sure you can continue without KASAN?

Arguably it's better to fail loudly anyway if something as simple as the
mmap() here fails - after all, that probably means the KASAN offset in
Kconfig needs to be adjusted?

johannes


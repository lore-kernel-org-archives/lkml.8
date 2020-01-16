Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9531C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F9622464
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0pYzalrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgAPAne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:43:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34250 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgAPAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:43:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so17484446wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bXBKceB/4aYGxCdnYnMdpFpkIkyb6/8Oaz4zUBnhNZA=;
        b=0pYzalrPU1mpwChIqQofPH/K/okzOKQcw8OKvCpNb7+XQOB3SPdI9jix+LpqQe3EL2
         EH5LszgkacA0YoY20PgIMitOO9mKhhgRJLB5+iI/I4zu8Jet9syHJlJ+V2M0wPRc8Oj7
         hrmfQ1Zsg+TKB7Jx8gAElXv7UcNCdT3boAcZThDDGkyChICYllMhVfoBsKtYGwAKJ6Ac
         M2PtZkamUnzfAgDh4AppQzAs1nR3DVttH88vk5jS2UlNaxqXO7Tnf4U3gEhoN7MvvN4L
         zyoP6+cZ0m4B2iNeq/gyESWQmEIPGSYtH6qYFBMz5FqCZzQH21XtuJEDkYZWH9wxbg3a
         m6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bXBKceB/4aYGxCdnYnMdpFpkIkyb6/8Oaz4zUBnhNZA=;
        b=Pw24//hhC3R/kUgxVupZdLzn4lKmI875a+r0G51jeodNFkKKS+1rpZQOLZPz56I4hR
         lPMLu1X5hTu0FODB9Y4js1ExeTiawTMLmDMYt0E1LDcZQtXJMaMfgyAxVJYE3JpVCyKC
         VZFVEa+uAuN6p9NWITMEA8TbD1e6ZbcwjxCZTCBd0a47b/5BIFQTA33+jEx457m+UQDO
         shFiNNAHdkwFoiPqqmukfUQwfzXY9d42qWIXktkiv4htMcE3QAlny3+wpQPl5I7bleBv
         CN+NejQLK9Zs3nk3uBxtjuJqJVeT1VsLlfrYEb8AWYttXXEoJHypfawaDNN9BGtXZP/W
         ZE5A==
X-Gm-Message-State: APjAAAUVobhO9wwynwVjk4MnYB0v+TGKCBfcLvncH2601SR/M0kFgwlX
        onsGXCmMHzZYV7RyncotRe4NpbvpV9nv6x3Hx9GkPw==
X-Google-Smtp-Source: APXvYqxIWddVKD8tvU0H3N/Yl6PT4oY4YGlGVsesXDAiHGcG+mDDhSFJ2JDTEznmj6kkToTPlE18ajSKBFOFnQZgkTw=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr32978983wrr.309.1579135411785;
 Wed, 15 Jan 2020 16:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20191218213918.16676-1-atish.patra@wdc.com> <mhng-9ed825c6-0972-46ac-aeac-89a57bf73cac@palmerdabbelt-glaptop>
In-Reply-To: <mhng-9ed825c6-0972-46ac-aeac-89a57bf73cac@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Jan 2020 06:13:21 +0530
Message-ID: <CAAhSdy2XdD2hYiC6ib+2rnA-9WHc9RR2zMhTz4N5te21UzSa5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add support for SBI v0.2
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 2:06 AM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Wed, 18 Dec 2019 13:39:13 PST (-0800), Atish Patra wrote:
> > The Supervisor Binary Interface(SBI) specification[1] now defines a
> > base extension that provides extendability to add future extensions
> > while maintaining backward compatibility with previous versions.
> > The new version is defined as 0.2 and older version is marked as 0.1.
> >
> >
> > This series adds support v0.2 and a unified calling convention
> > implementation between 0.1 and 0.2. It also add other SBI v0.2
> > functionality defined in [2]. The base support for SBI v0.2 is already
> > available in OpenSBI v0.5. This series needs additional patches[3] in
> > OpenSBI.
> >
> > Tested on both BBL, OpenSBI with/without the above patch series.
> >
> > [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> > [2] https://github.com/riscv/riscv-sbi-doc/pull/27
> > [3] http://lists.infradead.org/pipermail/opensbi/2019-November/000738.h=
tml
> >
> > Changes from v5->v6
> > 1. Fixed few compilation issues around config.
> > 2. Fixed hart mask generation issues for RFENCE & IPI extensions.
> >
> > Changes from v4->v5
> > 1. Fixed few minor comments related to static & inline.
> > 2. Make sure that every patch is boot tested individually.
> >
> > Changes from v3->v4.
> > 1. Rebased on for-next.
> > 2. Fixed issuses with checkpatch --strict.
> > 3. Unfied all IPI/fence related functions.
> > 4. Added Hfence related SBI calls.
> >
> > Changes from v2->v3.
> > 1. Moved v0.1 extensions to a new config.
> > 2. Added support for relacement extensions of v0.1 extensions.
> >
> > Changes from v1->v2
> > 1. Removed the legacy calling convention.
> > 2. Moved all SBI related calls to sbi.c.
> > 3. Moved all SBI related macros to uapi.
> >
> > Atish Patra (5):
> > RISC-V: Mark existing SBI as 0.1 SBI.
> > RISC-V: Add basic support for SBI v0.2
> > RISC-V: Add SBI v0.2 extension definitions
> > RISC-V: Introduce a new config for SBI v0.1
> > RISC-V: Implement new SBI v0.2 extensions
> >
> > arch/riscv/Kconfig           |   6 +
> > arch/riscv/include/asm/sbi.h | 178 +++++++-----
> > arch/riscv/kernel/sbi.c      | 522 ++++++++++++++++++++++++++++++++++-
> > arch/riscv/kernel/setup.c    |   2 +
> > 4 files changed, 635 insertions(+), 73 deletions(-)
>
> Thanks.  I had a few comments on the spec, but this looks good given what=
's in
> the draft.

For the benefit of people not watching GitHub SBI spec comments, here
are my comments as replied on GitHub as well.


Palmer Dabbelt <palmerdabbelt@google.com> wrote on GitHub:
> After looking into some of the remote fence instruction stuff I really do=
n't think we're ready to define an SBI extension here. I'm specifically wor=
ried about all these fences being one-sided (ie, blocking), which probably =
isn't what you want for remote fences.

The blocking nature of remote TLB flushes is as-per expectation of
Linux kernel and it is also true for IPI based remote TLB flushes.
In trying to fix Glibc craches with OpenSBI (six months back), we
realized that non-blocking remote TLB flushes with SBI calls (or with
IPIs) causes Linux kernel to crash because if we return before TLBs
on other HARTs are updated then other HARTs can potentially do invalid
access using stale TLB enteries. Due to this reason, on architecutures
(such as ARM64) with ISA support for remote TLB flush, the remote TLB
flush instructions are defined as blocking. The IPI based remote TLB
flushes for x86_64 is also blocking.
(Refer, https://github.com/torvalds/linux/blob/master/arch/x86/mm/tlb.c#L70=
8)

> IIRC we'd decided at the Zurich workshop to stop speculatively defining S=
BI extensions until we had a corresponding ISA extension that would make th=
em somehow better to implement in M-mode than in S-mode, and I think this e=
xtension is a good one to wait on.

IIRC, (at Zurich workshop 2019) we had decided to keep remote TLB flush
calls as optional (and not remove it) so that in-future an ISA extension
can be defined and preferred over SBI call.

The rational for above (as discussed at Zurich workshop 2019) is:

1. If we don't have SBI extension and ISA extension for remote TLB
flush then Guest/VM don't have any way for remote TLB flushes. A
software emulated MMIO CLINT for Guest/VM is not a viable option
because to inject IPI to N HARTs we need to do N MMIO writes where
each MMIO write will be trap-n-emulated. This will be very slow
and not at all scalable for any hypervisor.

2. In absence of S-mode CLINT and remote TLB flush ISA extension,
the IPI based remote TLB flush will be quite slow compared to SBI
calls because each IPI call will again go through SBI call. We had
proven this fact using benchmarks as well. In fact, this performance
difference was discussed in Linux kernel mailing list long time back
(Refer https://patchwork.kernel.org/cover/10872349/). The newer SBI
RFENCE calls are even better than SBI v0.1 RFENCE calls because we
are avoiding unpriv access so with these new calls we will get even
better performance compared to IPI based remote TLB flushes.

3. The SBI extension for remote TLB flush does not remove the
possibility of defining an ISA extension in-future. In fact,
in-future the Linux kernel will decide at runtime on method to
use for remote TLB flushes as follows:
 a) First check if an ISA extension for remote TLB flush is
    available. If available then use it otherwise try step b
 b) Next check if S-mode CLINT is available. If available then
    use IPI based remote TLB flush otherwise try step c
 c) Lastly check if SBI RFENCE extension is available. If
    available then use it otherwise try step d
 d) We don't have any method for remote TLB flush so crash.

>
> Yes, that means than an SBI-0.2-clean Linux will need to handle these as =
IPIs, but I think that's actually a good thing: it avoids baking unknows in=
to the ABI, which allows us to experiment more freely and ideally figure ou=
t the right way to do this more quickly.

Please see previous comments

Regards,
Anup

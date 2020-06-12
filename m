Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0CD20836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="EEDwnHM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFLRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:43:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA90AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:43:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so9044095wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QDcRIpXupE0ceUCNKmt0N8h7jAXuVdBg0byQ2XOXOwA=;
        b=EEDwnHM7jEpcxXM5UWzDIuEAmvX/9nJFqz423nqBjytBRolI4MHoMpzNLHPK+ZQuMW
         ZJFl5rPFZ9sgsJW+WuilyyJhK8zaoIPCErD/ZJeC0hhwXty6lr2c1angrf2fb481J89M
         EFxmh/r8RDX9FKQt8aWGccUIjr90397zCJrb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QDcRIpXupE0ceUCNKmt0N8h7jAXuVdBg0byQ2XOXOwA=;
        b=ggTpTRWPR0IGVC1yM481k9Rntb2GsYA/UpK217xZv3JnWYbd3Jh3v0cghy4782g8CO
         9y4RvRXl1ZgrKc/CaC2+8pQu6pbskarRtS485xQKydr5KfgPymV57F/5k6KqTPfMkcvI
         OWjiqrB6NKBZPTaL4poICEwgIjFyEGA5/wd2qkTWHH8QhV+Y0ayoWKgVSmyfPvYdXv55
         O5cVquWSgaK1uaE/m1Jo0q/1eQq2jL9FX7wnkdWwjp7bMAzinw9mTC8lXU/oAZa9Q+Gt
         F1XwnRqju3WsmY5z8WxIDVLm7OTucZp4P20Lvpe1OCiYs84stB3k3z7Ow1rUKgc/FCo+
         d8WA==
X-Gm-Message-State: AOAM533vZqw9Pi4cyR2EnlFnEcLmrynjggwEhlFoWynN4APOPmKScyTh
        SOv0YZYCb1F9BA7iq3a8c264d3gu6gyoNIHF8pp3
X-Google-Smtp-Source: ABdhPJwMIKeqTguyJNugecOsV2hRvwUn7rirrvycI7fch9LQU6f8huN8mLNuvP4ejSItTjrz+2nPvdcNhAFsrrM+ue4=
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr61345wmj.186.1591983792118;
 Fri, 12 Jun 2020 10:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr> <CAOnJCUJSKvLDsXC8+wyO1xsZDzLJmjY2kwMKhjz0t+uS8h0pDw@mail.gmail.com>
 <7ad7057e-fdab-14ef-9bdb-c77ccefd208a@ghiti.fr> <CAOnJCUKcMmchxgeHNx997EH5JM_OAJFUDCNT6Ca2B-xHE4YT5A@mail.gmail.com>
 <36739fc4-21ea-14f4-f2a6-52614b602dea@ghiti.fr> <8867b8d5-4a15-fbc1-67e1-7fc48be6eae3@ghiti.fr>
In-Reply-To: <8867b8d5-4a15-fbc1-67e1-7fc48be6eae3@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 12 Jun 2020 10:43:00 -0700
Message-ID: <CAOnJCUJGgFKmVyvan6j9n93FJjAnsDP-QHzgTZ3kNAeJfAV_9Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] PUD/PGDIR entries for linear mapping
To:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 6:17 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 6/12/20 =C3=A0 8:59 AM, Alex Ghiti a =C3=A9crit :
> > Hi Atish,
> >
> > Le 6/11/20 =C3=A0 1:29 PM, Atish Patra a =C3=A9crit :
> >> On Wed, Jun 10, 2020 at 11:51 PM Alex Ghiti<alex@ghiti.fr>  wrote:
> >>> Hi Atish,
> >>>
> >>> Le 6/10/20 =C3=A0 2:32 PM, Atish Patra a =C3=A9crit :
> >>>> On Wed, Jun 3, 2020 at 8:36 AM Alexandre Ghiti<alex@ghiti.fr>  wrote=
:
> >>>>> This small patchset intends to use PUD/PGDIR entries for linear
> >>>>> mapping
> >>>>> in order to better utilize TLB.
> >>>>>
> >>>>> At the moment, only PMD entries can be used since on common platfor=
ms
> >>>>> (qemu/unleashed), the kernel is loaded at DRAM + 2MB which
> >>>>> dealigns virtual
> >>>>> and physical addresses and then prevents the use of PUD/PGDIR
> >>>>> entries.
> >>>>> So the kernel must be able to get those 2MB for PAGE_OFFSET to map
> >>>>> the
> >>>>> beginning of the DRAM: this is achieved in patch 1.
> >>>>>
> >>>> I don't have in depth knowledge of how mm code works so this questio=
n
> >>>> may be a completely
> >>>> stupid one :). Just for my understanding,
> >>>> As per my understanding, kernel will map those 2MB of memory but
> >>>> never use it.
> >>>> How does the kernel ensure that it doesn't allocate any memory from
> >>>> those 2MB
> >>>> memory if it is not marked as reserved?
> >>> Yes, a 1GB hugepage will cover those 2MB: I rely on the previous boot
> >>> stage to mark this region
> >>> as reserved if there is something there (like opensbi). Otherwise, th=
e
> >>> kernel will indeed try to
> >>> allocate memory from there :)
> >>>
> >> In that case, this patch mandates that the firmware region has to be
> >> mark "reserved"
> >> the device tree so that the Linux kernel doesn't try to allocate
> >> memory from there.
> >> OpenSBI is already doing it from v0.7. Thus, any user using latest
> >> OpenSBI can leverage
> >> this patch for a better TLB utilization.
> >
> >
> > Note that *currently* OpenSBI v0.7 still adds the "no-map" property
> > which prevents such optimization.
> >

Thanks for the clarification. When I said latest, I meant including
your patch in the mailing list.

> >> However, legacy previous boot stages(BBL) do not reserve this area via
> >> DT which may
> >> result in an unexpected crash. I am not sure how many developers still
> >> use BBL though.
> >>
> >> Few general suggestions to tackle this problem:
> >> 1. This mandatory requirement should be added to the booting document
> >> so that any other
> >> SBI implementation is also aware of it.
> >> 2. You may have to move the patch1 to a separate config so that any
> >> users of legacy boot stages
> >> can disable this feature.
> >
> >
> > IMHO, the region occupied by runtime services should be marked as
> > reserved in the device-tree. So it seems redundant to add this as a
> > requirement, I would rather consider its absence as a bug.
> >

I agree. I was just suggesting to document this bug :).

> > Even if I understand that this might break some system, I don't like
> > the idea of a new config to support old "buggy" bootloaders: when will
> > we be able to remove it ? We'll never know when people will stop using
> > those bootloaders, so it will stay here forever...Where can I find the

Personally, I am fine with that. However, there were few concerns in the pa=
st.
I am leaving it to Palmer to decide.

@Palmer Dabbelt : Any thoughts ?

> > boot document you are talking about ? Can we simply state here that
> > this kernel version will not be compatible with those bootloaders
> > (we'll draw an exhaustive list here) ?
>

Yes.

>
> Ok, I have just found Documentation/riscv/boot-image-header.rst: could
> we imagine doing something like incrementing the version and use that as
> a hint in the kernel not to map the 2MB offset ? That's still legacy,
> but at least it does not require to recompile a kernel as the check
> would be done at runtime.
>

I was suggesting to add a risc-v specific booting document and
document this "bug".
Documentation/riscv/boot-image-header.rst can be linked from that document =
or
the boot hader content can be included in that. No changes in code is neces=
sary.

Eventually, this booting document will also include other additional
booting constraints for RISC-V
such as minimum extension required to boot Linux, csr state upon
entering S-mode, mmu state.
>
> >
> > Alex
> >
> >
> >>> Alex
> >>>
> >>>
> >>>>> But furthermore, at the moment, the firmware (opensbi) explicitly
> >>>>> asks the
> >>>>> kernel not to map the region it occupies, which is on those common
> >>>>> platforms at the very beginning of the DRAM and then it also dealig=
ns
> >>>>> virtual and physical addresses. I proposed a patch here:
> >>>>>
> >>>>> https://github.com/riscv/opensbi/pull/167
> >>>>>
> >>>>> that removes this 'constraint' but *not* all the time as it offers
> >>>>> some
> >>>>> kind of protection in case PMP is not available. So sometimes, we m=
ay
> >>>>> have a part of the memory below the kernel that is removed creating=
 a
> >>>>> misalignment between virtual and physical addresses. So for
> >>>>> performance
> >>>>> reasons, we must at least make sure that PMD entries can be used:
> >>>>> that
> >>>>> is guaranteed by patch 1 too.
> >>>>>
> >>>>> Finally the second patch simply improves best_map_size so that
> >>>>> whenever
> >>>>> possible, PUD/PGDIR entries are used.
> >>>>>
> >>>>> Below is the kernel page table without this patch on a 6G platform:
> >>>>>
> >>>>> ---[ Linear mapping ]---
> >>>>> 0xffffc00000000000-0xffffc00176e00000 0x0000000080200000 5998M
> >>>>> PMD     D A . . . W R V
> >>>>>
> >>>>> And with this patchset + opensbi patch:
> >>>>>
> >>>>> ---[ Linear mapping ]---
> >>>>> 0xffffc00000000000-0xffffc00140000000 0x0000000080000000
> >>>>> 5G PUD     D A . . . W R V
> >>>>> 0xffffc00140000000-0xffffc00177000000 0x00000001c0000000 880M
> >>>>> PMD     D A . . . W R V
> >>>>>
> >>>>> Alexandre Ghiti (2):
> >>>>>     riscv: Get memory below load_pa while ensuring linear mapping
> >>>>> is PMD
> >>>>>       aligned
> >>>>>     riscv: Use PUD/PGDIR entries for linear mapping when possible
> >>>>>
> >>>>>    arch/riscv/include/asm/page.h |  8 ++++
> >>>>>    arch/riscv/mm/init.c          | 69
> >>>>> +++++++++++++++++++++++++++++------
> >>>>>    2 files changed, 65 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 2.20.1
> >>>>>
> >>>>>
> >>
> >



--=20
Regards,
Atish

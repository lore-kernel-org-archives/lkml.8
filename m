Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9764C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvtB0921"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFCUfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:35:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgFCUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591216513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=da+uaaQmuZ7e/4soUWoowJDZEqIwAXKMwKVX1l5cQ3s=;
        b=RvtB0921qs2cI1OmTM5ULIScvpbrQfGQkilvRI9beVEfvOoLjGwG9dKPqgfzF6viAoiMEz
        xR8O0pki5I681fI0Bu2oi6Ya+NGKVi7Fd5Z/SVUWgwmkRa2mDMVTO7rZ0a34T3ts2XhcnH
        YGM2Yg4n7fr+eksB9HUVPVF8iukZHPM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iusHehCpPY6z6bK9Q2_YyQ-1; Wed, 03 Jun 2020 16:35:12 -0400
X-MC-Unique: iusHehCpPY6z6bK9Q2_YyQ-1
Received: by mail-qv1-f69.google.com with SMTP id v15so2615718qvm.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 13:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=da+uaaQmuZ7e/4soUWoowJDZEqIwAXKMwKVX1l5cQ3s=;
        b=LIdfTsrZMcMkHo2WJy285BHC2xPvoyvVt/bei/a1DhIhqoQc1/4ggKLzbumPZmKF9V
         HZCEbI0gopbWNMls1DiX150Z1r8RFw+yMFRqGIiyKKGB/c4qH8x8l5610zED5Nt7T54t
         CPlbK/LJTh1BgADCuQAwdNcQHzVThBYipfXTKps4+gSxDPViKt5qHSjLI8RgnxyWvuIY
         3OELeFsuXVK1NibBFuZnGj5HLNMxKpPn5SkDS53pm5058pj3vJKbzQnU5v5X2qbNJJMW
         t7nt8/Ko8aKBI2nx+YqnUix0RoKmtZgoULuCnKBoTOnQuze4FFB2ju9CEaKTgmx6epcp
         5SKg==
X-Gm-Message-State: AOAM530qImMWyRHK1BCMbZvWzcBwiOzhHohQ7wsQO9hqOd2BIwip3yww
        y9fdCFmcoba6sizLt9/f1Fu8qPsr9TJCY6BZuUPqKHavVtYEer/2YEjPPVmRi8hcwm2ScSQ+YtO
        b9t/V2Cm9KMLhBtsd+lXg8Sm5WVjBlu2a6bE16aRN
X-Received: by 2002:a0c:b258:: with SMTP id k24mr1642737qve.198.1591216510305;
        Wed, 03 Jun 2020 13:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTqAdGZZcbxApjD0CbKiH72/UbZdCmG/JC1TXY4DawbQjYpP22SBs9+HPPHQJpkwQVZxS+RuBcv2xN9rd60Lw=
X-Received: by 2002:a0c:b258:: with SMTP id k24mr1642706qve.198.1591216509942;
 Wed, 03 Jun 2020 13:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com> <DM6PR18MB24258C2F2B91E4BF407421CDD2880@DM6PR18MB2425.namprd18.prod.outlook.com>
In-Reply-To: <DM6PR18MB24258C2F2B91E4BF407421CDD2880@DM6PR18MB2425.namprd18.prod.outlook.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 4 Jun 2020 02:04:58 +0530
Message-ID: <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
To:     Kamlakant Patel <kamlakantp@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamlakant,

Many thanks for having a look at the patchset.

On Wed, Jun 3, 2020 at 4:50 PM Kamlakant Patel <kamlakantp@marvell.com> wrote:
>
> Hi Bhupesh,
>
> > -----Original Message-----
> > From: kexec <kexec-bounces@lists.infradead.org> On Behalf Of Bhupesh
> > Sharma
> > Sent: Thursday, May 14, 2020 12:23 AM
> > To: linux-arm-kernel@lists.infradead.org; x86@kernel.org
> > Cc: Mark Rutland <mark.rutland@arm.com>; Kazuhito Hagio <k-
> > hagio@ab.jp.nec.com>; Steve Capper <steve.capper@arm.com>; Catalin
> > Marinas <catalin.marinas@arm.com>; bhsharma@redhat.com; Ard Biesheuvel
> > <ard.biesheuvel@linaro.org>; kexec@lists.infradead.org; linux-
> > kernel@vger.kernel.org; James Morse <james.morse@arm.com>; Dave
> > Anderson <anderson@redhat.com>; bhupesh.linux@gmail.com; Will Deacon
> > <will@kernel.org>
> > Subject: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
> >
> > vabits_actual variable on arm64 indicates the actual VA space size, and allows a
> > single binary to support both 48-bit and 52-bit VA spaces.
> >
> > If the ARMv8.2-LVA optional feature is present, and we are running with a 64KB
> > page size; then it is possible to use 52-bits of address space for both userspace
> > and kernel addresses. However, any kernel binary that supports 52-bit must also
> > be able to fall back to 48-bit at early boot time if the hardware feature is not
> > present.
> >
> > Since TCR_EL1.T1SZ indicates the size offset of the memory region addressed by
> > TTBR1_EL1 (and hence can be used for determining the vabits_actual value) it
> > makes more sense to export the same in vmcoreinfo rather than vabits_actual
> > variable, as the name of the variable can change in future kernel versions, but
> > the architectural constructs like TCR_EL1.T1SZ can be used better to indicate
> > intended specific fields to user-space.
> >
> > User-space utilities like makedumpfile and crash-utility, need to read this value
> > from vmcoreinfo for determining if a virtual address lies in the linear map range.
> >
> > While at it also add documentation for TCR_EL1.T1SZ variable being added to
> > vmcoreinfo.
> >
> > It indicates the size offset of the memory region addressed by TTBR1_EL1
> >
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Steve Capper <steve.capper@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Dave Anderson <anderson@redhat.com>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kexec@lists.infradead.org
> > Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 11 +++++++++++
> >  arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
> >  arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > index 2a632020f809..2baad0bfb09d 100644
> > --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > @@ -404,6 +404,17 @@ KERNELPACMASK
> >  The mask to extract the Pointer Authentication Code from a kernel virtual
> > address.
> >
> > +TCR_EL1.T1SZ
> > +------------
> > +
> > +Indicates the size offset of the memory region addressed by TTBR1_EL1.
> > +The region size is 2^(64-T1SZ) bytes.
> > +
> > +TTBR1_EL1 is the table base address register specified by ARMv8-A
> > +architecture which is used to lookup the page-tables for the Virtual
> > +addresses in the higher VA range (refer to ARMv8 ARM document for more
> > +details).
> > +
> >  arm
> >  ===
> >
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h
> > b/arch/arm64/include/asm/pgtable-hwdef.h
> > index 6bf5e650da78..a1861af97ac9 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -216,6 +216,7 @@
> >  #define TCR_TxSZ(x)          (TCR_T0SZ(x) | TCR_T1SZ(x))
> >  #define TCR_TxSZ_WIDTH               6
> >  #define TCR_T0SZ_MASK                (((UL(1) << TCR_TxSZ_WIDTH) - 1) <<
> > TCR_T0SZ_OFFSET)
> > +#define TCR_T1SZ_MASK                (((UL(1) << TCR_TxSZ_WIDTH) - 1) <<
> > TCR_T1SZ_OFFSET)
> >
> >  #define TCR_EPD0_SHIFT               7
> >  #define TCR_EPD0_MASK                (UL(1) << TCR_EPD0_SHIFT)
> > diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> > index 1f646b07e3e9..314391a156ee 100644
> > --- a/arch/arm64/kernel/crash_core.c
> > +++ b/arch/arm64/kernel/crash_core.c
> > @@ -7,6 +7,14 @@
> >  #include <linux/crash_core.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/memory.h>
> > +#include <asm/pgtable-hwdef.h>
> > +
> > +static inline u64 get_tcr_el1_t1sz(void);
> > +
> > +static inline u64 get_tcr_el1_t1sz(void) {
> > +     return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET; }
> >
> >  void arch_crash_save_vmcoreinfo(void)
> >  {
> > @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
> >                                               kimage_voffset);
> >       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> >                                               PHYS_OFFSET);
> > +     vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> > +                                             get_tcr_el1_t1sz());
> I tested this patch on top of upstream kernel v5.7 and I am getting "crash: cannot determine VA_BITS_ACTUAL" error with crash tool.
> I looked into crash-utility source and it is expecting tcr_el1_t1sz not TCR_EL1_T1SZ.
> Could you please check.

Indeed. As per James comments on the v5 (see [1]) where he suggested
converting ttcr_el1_t1sz into TCR_EL1_T1SZ, I made the change in v6
accordingly.

This time I haven't sent out the v6 userspace changes
(makedumpfile/crash-utility) upstream first, since we are waiting for
kernel changes to be accepted first, as we have seen in the past that
while the userspace patches have been accepted, the kernel patches
required a respin cycle, thus leading to inconsistencies, as you also
pointed out with crash-utility.

If you want, for your local testing, I can share my github branch
where I have kept the crash-utility v6 patchset ready. Please let me
know.

[1]. https://lore.kernel.org/linuxppc-dev/63d6e63c-7218-d2dd-8767-4464be83603f@arm.com/

Thanks,
Bhupesh


>
> Thanks,
> Kamlakant Patel
> >       vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> >       vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
> >
> >       system_supports_address_auth() ?
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > https://urldefense.proofpoint.com/v2/url?u=http-
> > 3A__lists.infradead.org_mailman_listinfo_kexec&d=DwICAg&c=nKjWec2b6R0m
> > OyPaz7xtfQ&r=XecQZQJWhG6-
> > mN8sWxffFOgUXg4irGP3Sjuy6RxdacQ&m=oeLdIVaWScimdfEc4dNhRI0tT24IgzG
> > 7LkpAE5P11JQ&s=LLjHpz349DuDtORX4xywCxzbGUOagoq4JXosStycqI4&e=
>


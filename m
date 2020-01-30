Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4328EC33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D5F206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H0kmFT5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Ci4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:38:56 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44756 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgA3Ciz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:38:55 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so760445qvg.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 18:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVR1nsUvA+s0Il5EaHeRxaRkecDegUphjHSyTVxP/SQ=;
        b=H0kmFT5wg6xK0knevGdhZq6KEPxr2CvGgazjfGO6/mFR7kxYaxBFiGJI6NEy01/31a
         S0P0IllTSTp2hxVHo4e3KX7MG3j4pV9hJ7Ma7Jojj4WJIsUskFSzqQLoaGXzh3sSVGQ9
         XKRCOXSm3aEu3n9qYv9afIQ489fVF2AbW/cT8KRhCIjhSKjhE47SozKBkhE2dTMlqsQb
         RU96+KWo7qr84eTowLvwgovR4iH9TqNSZU1lTIoWk69pM+VMLPTtr0+5n5fHCGBTiGFE
         1gszZ0YgxRO+GJmiUWfRXzV++JiUN5kFZN6+nHyds1TPSn7dPALxo6wARUEtpqA6+TX+
         Cl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVR1nsUvA+s0Il5EaHeRxaRkecDegUphjHSyTVxP/SQ=;
        b=VgJ852G06p1E2SvZGNNvSR6r7sP35Uioqt+os1YEJBgX/HrsCsdSKTRm0Is49N5Gs1
         6PlXQsH4Xp++iLPDu9YzPAAbEV9ixaCbRteBGTgN96bzDhmIZoyx7wtbu2WZ6twYa2DK
         g2qC+fJH4PneImQcBEGWaLGtjohG3CQgaJkEMs5E1fS510/qHTrpykFIyVUfHwzMDnAY
         lDsUybprBgMkv3BTNXvkUJfl/NRFp8KplDQCsH5loJ/6dTM+MfVW+QIfVFKf+Y9mDm9J
         rshHKNw/DLIh/FOW/3nsEOdPogekQPBMqOaT+C6YUPn1YvwMmNHWpFTUkT1EcKwzNW6r
         sYaQ==
X-Gm-Message-State: APjAAAWeOxczEoiBPZ1rTqouw/ceppF4ms6aIbvpPsFM/94C05Y/xdhu
        9K+EEHj70uT3Cm/96iQFixxOkGudgdGmmZxC9AP6UQ==
X-Google-Smtp-Source: APXvYqwvNrCWRxI0SRrw2gl1XFrxAN3MN3gTMWJ/iumpdrLBGck/yfYyoHwGK3oxng6zWVpYQPZZbjvfgF+TK5fgXAI=
X-Received: by 2002:ad4:424e:: with SMTP id l14mr2525732qvq.118.1580351934494;
 Wed, 29 Jan 2020 18:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20200109031740.29717-1-greentime.hu@sifive.com> <mhng-f4b42a19-22f3-43f3-9750-58b994e23246@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-f4b42a19-22f3-43f3-9750-58b994e23246@palmerdabbelt-glaptop1>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Thu, 30 Jan 2020 10:38:43 +0800
Message-ID: <CAHCEeh+4a0O7tpp4dRXKudc6bmdJct=-H0SrPt=HbOs00T3-Hg@mail.gmail.com>
Subject: Re: [PATCH] riscv: set pmp configuration if kernel is running in M-mode
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 3:23 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Thu, 09 Jan 2020 03:17:40 GMT (+0000), greentime.hu@sifive.com wrote:
> > When the kernel is running in S-mode, the expectation is that the
> > bootloader or SBI layer will configure the PMP to allow the kernel to
> > access physical memory.  But, when the kernel is running in M-mode and is
> > started with the ELF "loader", there's probably no bootloader or SBI layer
> > involved to configure the PMP.  Thus, we need to configure the PMP
> > ourselves to enable the kernel to access all regions.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/csr.h | 12 ++++++++++++
> >  arch/riscv/kernel/head.S     |  6 ++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index 0a62d2d68455..0f25e6c4e45c 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -72,6 +72,16 @@
> >  #define EXC_LOAD_PAGE_FAULT  13
> >  #define EXC_STORE_PAGE_FAULT 15
> >
> > +/* PMP configuration */
> > +#define PMP_R                        0x01
> > +#define PMP_W                        0x02
> > +#define PMP_X                        0x04
> > +#define PMP_A                        0x18
> > +#define PMP_A_TOR            0x08
> > +#define PMP_A_NA4            0x10
> > +#define PMP_A_NAPOT          0x18
> > +#define PMP_L                        0x80
> > +
> >  /* symbolic CSR names: */
> >  #define CSR_CYCLE            0xc00
> >  #define CSR_TIME             0xc01
> > @@ -100,6 +110,8 @@
> >  #define CSR_MCAUSE           0x342
> >  #define CSR_MTVAL            0x343
> >  #define CSR_MIP                      0x344
> > +#define CSR_PMPCFG0          0x3a0
> > +#define CSR_PMPADDR0         0x3b0
> >  #define CSR_MHARTID          0xf14
> >
> >  #ifdef CONFIG_RISCV_M_MODE
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 5c8b24bf4e4e..f8f996916c5b 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -60,6 +60,12 @@ _start_kernel:
> >       /* Reset all registers except ra, a0, a1 */
> >       call reset_regs
> >
> > +     /* Setup a PMP to permit access to all of memory. */
> > +     li a0, -1
> > +     csrw CSR_PMPADDR0, a0
> > +     li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
> > +     csrw CSR_PMPCFG0, a0
>
> These should be guarded by some sort of #ifdef CONFIG_M_MODE, as they're not
> part of S mode.

Hi Palmer,

This code segment is guarded by CONFIG_RISCV_M_MODE

#ifdef CONFIG_RISCV_M_MODE
        /* flush the instruction cache */
        fence.i

        /* Reset all registers except ra, a0, a1 */
        call reset_regs

        /* Setup a PMP to permit access to all of memory. */
        li a0, -1
        csrw CSR_PMPADDR0, a0
        li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
        csrw CSR_PMPCFG0, a0

        /*
         * The hartid in a0 is expected later on, and we have no firmware
         * to hand it to us.
         */
        csrr a0, CSR_MHARTID
#endif /* CONFIG_RISCV_M_MODE */

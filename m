Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73743C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3BB20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZpfomaTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDTTUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgDTTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:20:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5AC061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:20:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so5862555ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwYYllclEk2QodGz3ELQAydSvXneVAst3mjkOyGD1/c=;
        b=ZpfomaTmDL83rc1yC7uOa5O8bXqqAg6Nw+rKStG/6MLe5Ahm6thqlsw6U0m0vIoKwA
         YJogFfgkH/yrwMfpx9tawVDQ/4gmGism/d0omAeSujpA001TjbWaKsZ9q0gX1DA8f5Np
         HjZ1x4DlLwS3NLnnFcDHdrkzWmseO5AjhlgcizN4QhZasFqgyedyprYGzc38v8AoU1qr
         UdkNWUdhFcjHL1qqbIR2vVc5m+KT0OgcCcksyM6xucAH4VnR+DiwzVBY4ticUMPtWoQf
         SijGXDDc32DommdkB+ww4U0W50ZShxS9m3awA+CT7sTsspwYWmpyZ2mde59kPGljKGK/
         sY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwYYllclEk2QodGz3ELQAydSvXneVAst3mjkOyGD1/c=;
        b=JVDeK7x84RrNtIb9QGT33hbEytjhFhVNk0LFfc3mz9njCoaganov8lZeZk46PWgHKv
         Jbo70lBsJwdphCIat68pTvmGC+49WG4+sZBE2V481tHfy5YyFXI9tabgaAZLfS3MjtdQ
         wb8npUBDDY9GLjW0wzeFAA0olNVQQ5a6hCwVSfcdGwXWM7nlj6YZR0CPUjl8G/uXzD38
         XTAlx6aPb3VqbZsdN+OLaizz71LlnUV8T/88feXkeNjBnp2LvQSSk0fMFfmeaEx5empd
         S9AhcrMKy5zELRELlufYF99gExEEXrRihD103phFpVclmZCXJHCGRtMW4N+l9j62pyx5
         bakA==
X-Gm-Message-State: AGi0PubdOJ9+ryAOMbhrNOogbU4ScqG1kbXo1OfMIJ+DdSS1f+/4MNUe
        IerKvIi+OWY8/4cjNdmd8b3Aviey1Fb4ynYv1o3hwQ==
X-Google-Smtp-Source: APiQypJJDSopvLbi40jdqQWmMwp3P9hoeBS+hLRiVefqSg6wtQfTkOjzFk7aBXWxr9v6gi60+m1Npi6jd3/TofiSysI=
X-Received: by 2002:a2e:898b:: with SMTP id c11mr11081921lji.197.1587410411621;
 Mon, 20 Apr 2020 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
 <20200418122123.10157ddd@why> <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
 <8a03b55223b118c6fc605d7204e01460@kernel.org> <CABEDWGxLKB68iknXtK8-4ke3wGW-6RKBnDEh6rFbBekLyawVOw@mail.gmail.com>
In-Reply-To: <CABEDWGxLKB68iknXtK8-4ke3wGW-6RKBnDEh6rFbBekLyawVOw@mail.gmail.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 20 Apr 2020 12:20:00 -0700
Message-ID: <CABEDWGwgPjw_Ym-k=nuDYWoZtbq=23miJBfiS5RaqUseCOO0DA@mail.gmail.com>
Subject: Re: [PATCH] genirq/msi: Check null pointer before copying struct msi_msg
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, tglx@linutronix.de,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 9:08 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> On Mon, Apr 20, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2020-04-18 16:19, Gustavo Pimentel wrote:
> > > Hi Marc and Alan,
> > >
> > >> I'm not convinced by this. If you know that, by construction, these
> > >> interrupts are not associated with an underlying MSI, why calling
> > >> get_cached_msi_msg() the first place?
> > >>
> > >> There seem to be some assumptions in the DW EDMA driver that the
> > >> signaling would be MSI based, so maybe someone from Synopsys
> > >> (Gustavo?)
> > >> could clarify that. From my own perspective, running on an endpoint
> > >> device means that it is *generating* interrupts, and I'm not sure what
> > >> the MSIs represent here.
> > >
> > > Giving a little context to this topic.
> > >
> > > The eDMA IP present on the Synopsys DesignWare PCIe Endpoints can be
> > > configured and triggered *remotely* as well *locally*.
> > > For the sake of simplicity let's assume for now the eDMA was
> > > implemented
> > > on the EP and that is the IP that we want to configure and use.
> > >
> > > When I say *remotely* I mean that this IP can be configurable through
> > > the
> > > RC/CPU side, however, for that, it requires the eDMA registers to be
> > > exposed through a PCIe BAR on the EP. This will allow setting the SAR,
> > > DAR and other settings, also need(s) the interrupt(s) address(es) to be
> > > set as well (MSI or MSI-X only) so that it can signal through PCIe (to
> > > the RC and consecutively the associated EP driver) if the data transfer
> > > has been completed, aborted or if the Linked List consumer algorithm
> > > has
> > > passed in some linked element marked with a watermark.
> > >
> > > It was based on this case that the eDMA driver was exclusively
> > > developed.
> > >
> > > However, Alan, wants to expand a little more this, by being able to use
> > > this driver on the EP side (through
> > > pcitest/pci_endpoint_test/pci_epf_test) so that he can configure this
> > > IP
> > > *locally*.
> > > In fact, when doing this, he doesn't need to configure the interrupt
> > > address (MSI or MSI-X), because this IP provides a local interrupt line
> > > so that be connected to other blocks on the EP side.
> >
> > Right, so this confirms my hunch that the driver is being used in
> > a way that doesn't reflect the expected use case. Rather than
> > papering over the problem by hacking the core code, I'd rather see
> > the eDMA driver be updated to support both host and endpoint cases.
> > This probably boils down to a PCI vs non-PCI set of helpers.
> >
> > Alan, could you confirm whether we got it right?
>
> Thanks Marc and Gustavo. I appreciate all your comments and feedback.
>
> You both got it right. As Gustavo mentioned, I am trying to expand dw-edma
> for additional use cases.
>
> First new use case is for integration of dw-edma with pci-epf-test so the latter
> can initiate dma transfers locally from endpoint memory to host memory over the
> PCIe bus in response to a user command issued from the host-side command
> prompt using the pcitest utility. When the locally-initiated dma
> transfer completes
> in this use case on the endpoint side, dw-edma issues an interrupt to the local
> CPU on the endpoint side by way of a legacy interrupt

Although dw-edma enables and handles such interrupts, to be correct, I should
have said that in this use case Synopsys DesignWare PCI eDMA hardware issues
an interrupt to the local CPU on the endpoint side by way of a legacy interrupt.

> and pci-epf-test issues
> an interrupt toward the remote host CPU across the PCIe bus by way of legacy,
> MSI, or possibly MSI-X interrupt.
>
> Second new use case is for integration of dw-edma with pci_endpoint_test
> running on the host CPU so the latter can initiate dma transfers locally from
> host-side in response to a user command issued from the host-side command
> prompt using the pcitest utility. This use case is for host systems that have
> Synopsys DesignWare PCI eDMA hardware on the host side. When the
> locally-initiated dma transfer completes in this use case on the host-side,
> dw-edma issues a legacy interrupt to its local host CPU

Although dw-edma enables and handles such interrupts, to be correct, I should
have said that in this case the Synopsys DesignWare PCI eDMA hardware issues
a legacy interrupt to its local host CPU in this use case.

> and pci-epf-test running
> on the endpoint side issues a legacy, MSI, or possibly MSI-X interrupt
> across the
> PCIe bus toward the host CPU.
>
> When both the host and endpoint sides have the Synopsys DesignWare PCI
> eDMA hardware, more use cases become possible in which eDMA controllers
> from both systems can be engaged to move data. Embedded DMA controllers
> from other PCIe IP vendors may also be supported with additional dmaengine
> drivers under the Linux PCI Endpoint Framework with pci-epf-test, pcitest, and
> pci_endpoint_test suite as well as new PCI endpoint function drivers for such
> applications that require dma, for example nvme or virtio_net endpoint function
> drivers.
>
> I submitted a recent patch [1] and [2] which Gustavo ACk'd to decouple dw-edma
> from struct pci_dev. This enabled me to exercise dw-edma on some riscv host
> and endpoint systems that I work with.
>
> I will submit another patch to decouple dw-edma from struct msi_msg such
> that it would only call get_cached_msi_msg() on the host-side in its original
> use case with remotely initiated dma transfers using the BAR access method.

Marc, I submitted another patch [3] to modify dw-edma to check if a
struct msi_desc
entry exists before copying the contents of its struct msi_msg
pointer. This is not
exactly decoupling dw-edma from struct msi_msg as I suggested earlier but this
set of dw-edma patches should show your concern is being addressed.

>
> The crash that I reported in __get_cached_msi_msg() is probably worth fixing
> too. It seems to be low impact since get_cached_msi_msg() seems to be called
> infrequently by a few callers.
>
> Regards,
> Alan Mikhak
>
> [1] https://patchwork.kernel.org/patch/11489607/
> [2] https://patchwork.kernel.org/patch/11491757/
[3] https://patchwork.kernel.org/patch/11499551/

>
> >
> > Thanks,
> >
> >          M.
> > --
> > Jazz is not dead. It just smells funny...

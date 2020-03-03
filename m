Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED362072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583263623;
	bh=S23seZZ+F0rhstqMDwu37JiEu/Gt0WN7ghAUIOFxxME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FUaSDFryu50SB5MrM8hfoCvQH4WkF94WT7tP83Q8zLKyBRgf2zzzIqn3cqm6e/Ptd
	 1W3dlCqtjOU1xQCX6g8cz3kVKv8y1Zz6JGScNuPRWhElQQ6Yvrja/qvoCIyfZxmlQ3
	 eK8b0ivLRz3WyByHZuhD4lOXH+/begzRJLJmDtoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgCCT1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbgCCT1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:27:00 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253F42072D;
        Tue,  3 Mar 2020 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583263619;
        bh=S23seZZ+F0rhstqMDwu37JiEu/Gt0WN7ghAUIOFxxME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bT/gp7f0P3cfOffymaU/w4anjKUzVAorinFP9Qjiewkk14jyntSzvsSynt5ctPFec
         85fdsIUrh9KseU1S0jcUosx9UhH6Zqfopw7FWT5hPb0o5qeo89+39cFs3Q8kU3uQpD
         tb7Ntj+axxD+SkPVtHb0awJaPC3ATL4aZ+djYlnI=
Received: by mail-qk1-f174.google.com with SMTP id f198so4558057qke.11;
        Tue, 03 Mar 2020 11:26:59 -0800 (PST)
X-Gm-Message-State: ANhLgQ2PNBPQaGbwaCMb7qHikNM9wXINMvSonjdqUs50qnX6pSCfjXYX
        FFuT3QogF7JYvx9w54UjD0vYRdxKBAKGnSCJ5w==
X-Google-Smtp-Source: ADFU+vtjJbOMk1EoX+3tC0WiPLOyEXu84LZLuGuqJ/pkNtHGvxR+Q00nCC+1JwclklG4DfJTkGP1K7bhBzR68Gigx+M=
X-Received: by 2002:a05:620a:15a2:: with SMTP id f2mr5790107qkk.223.1583263618266;
 Tue, 03 Mar 2020 11:26:58 -0800 (PST)
MIME-Version: 1.0
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com> <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com> <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
 <20200217132133.GA27134@lst.de> <b3c56884-128e-a7e1-2e09-0e8de3c3512d@ti.com>
 <CAL_JsqLxECRKWG3SoORADtZ-gVbqCHyx9mhGzrCPO+X=--w8AQ@mail.gmail.com>
 <15d0ac5f-4919-5852-cd95-93c24d8bdbb9@ti.com> <827fa19d-1990-16bc-33f5-fc82ac0d4a8a@arm.com>
 <3d8ea578-2ecb-1126-3bf0-2dc695687245@ti.com> <e898cf0a-6f52-8550-c73e-b78bc413bcc7@ti.com>
 <98db4748-63cb-79db-50c3-a6a37d624eaa@arm.com>
In-Reply-To: <98db4748-63cb-79db-50c3-a6a37d624eaa@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Mar 2020 13:26:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zx5qkv1DZdj1p2HHz5siYZwv6WGLe1F7xw9b019UWbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+zx5qkv1DZdj1p2HHz5siYZwv6WGLe1F7xw9b019UWbQ@mail.gmail.com>
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Roger Quadros <rogerq@ti.com>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Hans Verkuil <hverkuil@xs4all.nl>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 8:06 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 03/03/2020 8:27 am, Roger Quadros wrote:
> [...]
> >> With the patch (in the end). dev->bus_dma_limit is still set to 0 and
> >> so is not being used.
> >>
> >> from of_dma_configure()
> >>          ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >> ...
> >>          /* ...but only set bus limit if we found valid dma-ranges
> >> earlier */
> >>          if (!ret)
> >>                  dev->bus_dma_limit = end;
> >>
> >> There is no other place bus_dma_limit is set. Looks like every device
> >> should inherit that
> >> from it's parent right?
> >
> > Any ideas how to expect this to work?
>
> Is of_dma_get_range() actually succeeding, or is it tripping up on some
> aspect of the DT (in which case there should be errors in the log)?
>
> Looking again at the fragment below, are you sure it's correct? It
> appears to me like it might actually be defining a 1-byte-long DMA
> range, which indeed I wouldn't really expect to work.

Indeed, though it took me a minute to see why.

>
> Robin.
>
> >>
> >> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> >> index 64a0f90f5b52..5418c31d4da7 100644
> >> --- a/arch/arm/boot/dts/dra7.dtsi
> >> +++ b/arch/arm/boot/dts/dra7.dtsi
> >> @@ -680,15 +680,22 @@
> >>           };
> >>
> >>           /* OCP2SCP3 */
> >> -        sata: sata@4a141100 {
> >> -            compatible = "snps,dwc-ahci";
> >> -            reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;

Based on this, the parent address size is 1 cell...

> >> -            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> >> -            phys = <&sata_phy>;
> >> -            phy-names = "sata-phy";
> >> -            clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
> >> -            ti,hwmods = "sata";
> >> -            ports-implemented = <0x1>;
> >> +        sata_aux_bus {
> >> +            #address-cells = <2>;
> >> +            #size-cells = <2>;
> >> +            compatible = "simple-bus";
> >> +            ranges = <0x0 0x0 0x4a140000 0x0 0x1200>;
> >> +            dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;

So this is:
child addr: 0x0 0x0
parent addr: 0x0
size: 0x0 0x1

The last cell is just ignored I guess if you aren't seeing any errors.
We check this in dtc for ranges, but not dma-ranges. So I'm fixing
that.

> >> +            sata: sata@4a141100 {
> >> +                compatible = "snps,dwc-ahci";
> >> +                reg = <0x0 0x0 0x0 0x1100>, <0x0 0x1100 0x0 0x7>;
> >> +                interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> >> +                phys = <&sata_phy>;
> >> +                phy-names = "sata-phy";
> >> +                clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
> >> +                ti,hwmods = "sata";
> >> +                ports-implemented = <0x1>;
> >> +            };
> >>           };
> >>
> >>           /* OCP2SCP1 */
> >>
> >

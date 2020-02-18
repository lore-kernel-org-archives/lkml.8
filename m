Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A2C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0153520801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582046547;
	bh=EGhAsUkIvhU8WDm8JZDsTO+dlMNKBMhJZr/j8/uNxQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O2h2LI4kpCfJHSlIolJOOpEBsCKLpOvCRatHkh2qPaLbwC/AzVKfLlYMPz1V3ioJT
	 +A5d+zrpP/BhuvZ4XyQnT5opFkVuZO36rj7aukWoLBdG4RZGMLnG1dvwlPdnRYZLg+
	 8JiqbSmLpzTmm94fx/WqaPMySV9wijHNhNIkxBLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBRRWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:22:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRRWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:22:24 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6A324658;
        Tue, 18 Feb 2020 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582046543;
        bh=EGhAsUkIvhU8WDm8JZDsTO+dlMNKBMhJZr/j8/uNxQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHCfUCqZlmGLZTpPu00SQWJCY5DLhEaTqcB7D3s+7ICahxrwiGfONT9z9IS49hboB
         2rDjl9aYLZD5+YTld9acSdIYX1LKa5lUfNh2F9VGOUfIyW8KZ4P5hWbtCe20OB2jiv
         fPm/KkQMpCIlI8I1eKtWs8Kc9mAbEUv/tblrSG2s=
Received: by mail-qt1-f172.google.com with SMTP id l21so15047675qtr.8;
        Tue, 18 Feb 2020 09:22:23 -0800 (PST)
X-Gm-Message-State: APjAAAUbViOiZoRA6FWWMzWLkR+mrqIa9/38umzkIsQbRkis6VAS64ux
        uF8YWLzGC0lgPr2Ac189RZiFhcuwjkof9jzkSg==
X-Google-Smtp-Source: APXvYqzvomkaq2cYvIcbqCikDarF6HVBOijnl9/y9umpypDYM660czkdGk1ZNY/7srJxC52TnjBfWf7DCNwvoDl6UZo=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr18308325qtp.224.1582046542695;
 Tue, 18 Feb 2020 09:22:22 -0800 (PST)
MIME-Version: 1.0
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com> <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com> <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
 <20200217132133.GA27134@lst.de> <b3c56884-128e-a7e1-2e09-0e8de3c3512d@ti.com>
In-Reply-To: <b3c56884-128e-a7e1-2e09-0e8de3c3512d@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Feb 2020 11:22:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxECRKWG3SoORADtZ-gVbqCHyx9mhGzrCPO+X=--w8AQ@mail.gmail.com>
Message-ID: <CAL_JsqLxECRKWG3SoORADtZ-gVbqCHyx9mhGzrCPO+X=--w8AQ@mail.gmail.com>
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Roger Quadros <rogerq@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Feb 18, 2020 at 2:28 AM Roger Quadros <rogerq@ti.com> wrote:
>
> Chrishtoph,
>
> The branch works fine for SATA on DRA7 with CONFIG_LPAE once I
> have the below DT fix.
>
> Do you intend to send these fixes to -stable?
>
> ------------------------- arch/arm/boot/dts/dra7.dtsi -------------------------
> index d78b684e7fca..853ecf3cfb37 100644
> @@ -645,6 +645,8 @@
>                 sata: sata@4a141100 {
>                         compatible = "snps,dwc-ahci";
>                         reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
> +                       #size-cells = <2>;
> +                       dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;

dma-ranges should be in the parent (bus) node, not the device node.

>                         interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>                         phys = <&sata_phy>;
>                         phy-names = "sata-phy";
>
>
> cheers,
> -roger
>
> On 17/02/2020 15:21, Christoph Hellwig wrote:
> > Roger,
> >
> > can you try the branch below and check if that helps?
> >
> >      git://git.infradead.org/users/hch/misc.git arm-dma-bus-limit
> >
> > Gitweb:
> >
> >      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-bus-limit
> >
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

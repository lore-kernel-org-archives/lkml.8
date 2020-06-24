Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E06320781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Vj1AKSYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbgFXPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404271AbgFXPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:15:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F20C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:15:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r8so2126946oij.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyLX8XtKSQSzf1u6tUVRGJzXgpczRRSln3I+Nwk++to=;
        b=Vj1AKSYSjNfcC1ZEGsOotC3bvnMg/g3G6pdJ1ezAjge4evUCcp6G54UVl+P0pl2XZ9
         D5PYHPbigj3NQsF43eqvZMOMXqnHeLeqmbwUWm5N4ZXQ+iaC9sLoGXyOwfQBaN/xdGxF
         EX9STuY8CFF+v0Roz73C7FMcFUfGJuvS+ppHUZc6jzJwhekuT3NkkyzQQsgpiq95a89f
         sMSbPPC9pem/c0dzqukXGni1r3DXchx1qsDuoXeJ8V6ZXR/Yw/0XxhhlW0ONpsDNdyPq
         m0oiQrwmvjNBFHhU9los18X9rXQNu4pOPm2EZCzgbGK7VOZZGektkzCEBs/Z3B/iprcG
         bvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyLX8XtKSQSzf1u6tUVRGJzXgpczRRSln3I+Nwk++to=;
        b=POurC9tfpXxZ4RfOmJ5MeWrmpI8ST3IwCuEhcqLpZEsjNq5b4vZxXg+H8AqK+R1oqC
         Mxd9VdhhATFswLt+uRq6XPfNKolAg/Vzt1QWnpn3rf9P+68WFOMLpTSB6myCra9JU1Ul
         P9eRF92syiVmRkE/cSSkhfKLMFXbtXqLuIYAuIBlUcIXOYX7r0LGm/6Uh0fgegoa+DU2
         tMEv7DYaMwY0fajaj7IhC2snmKEqOfTfNgXgq3x3VQOXm6gUAv+oO73hobgOzjeiz2tq
         1t6cm5WSEuRHfFiYEDLhK62UbbeVykxbVJPu3e6q4jup+VuA9b9Hy12jDE0AJ0IJunQU
         948w==
X-Gm-Message-State: AOAM532knFFvYLIaG5cJEjyl9Zjwn9Q0qyUw68JAA5P4o3wdiSEsfqrv
        xcg97k1hPQ4v+v/AfwSQ/fvc0VR209nJCj5hlVNDiQ==
X-Google-Smtp-Source: ABdhPJzCR3yd5XHXF9590lIiwlLynD3w2IpHXEDDTWn+2h5TtW5v8YCR6G6I4/aCJNPxCV49xX4Wa8O69i9VV7cQUtI=
X-Received: by 2002:aca:554c:: with SMTP id j73mr21109662oib.172.1593011717984;
 Wed, 24 Jun 2020 08:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200624095007.141f0357@canb.auug.org.au>
In-Reply-To: <20200624095007.141f0357@canb.auug.org.au>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 24 Jun 2020 08:15:06 -0700
Message-ID: <CAJ+vNU25ycoSGros7_SbHfZ4ShP5=oT2RMM74OtCsk6B3k2Bhg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
>
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:350.4-27: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:353.5-28: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:356.6-29: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6dl-gw53xx.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-gw53xx.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-gw53xx.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:349.14-360.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:349.14-360.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:352.15-359.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:352.15-359.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:355.22-358.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:355.22-358.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:407.4-27: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:410.5-28: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:413.6-29: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6dl-gw54xx.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-gw54xx.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-gw54xx.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:406.14-417.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:406.14-417.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:409.15-416.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:409.15-416.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:412.22-415.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:412.22-415.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:350.4-27: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:353.5-28: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:356.6-29: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6q-gw53xx.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6q-gw53xx.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6q-gw53xx.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:349.14-360.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:349.14-360.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:352.15-359.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:352.15-359.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:355.22-358.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:355.22-358.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,4,0/pcie@4,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:407.4-27: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:410.5-28: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:413.6-29: Warning (reg_format): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6q-gw54xx.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6q-gw54xx.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6q-gw54xx.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:406.14-417.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:406.14-417.5: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:409.15-416.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:409.15-416.6: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0: Relying on default #size-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:412.22-415.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0: Relying on default #address-cells value
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:412.22-415.7: Warning (avoid_default_addr_size): /soc/pcie@1ffc000/pcie@0,0,0/pcie@1,0,0/pcie@2,8,0/pcie@8,0,0: Relying on default #size-cells value
>
> Introduced by commits
>
>   26d7c769d460 ("ARM: dts: imx6qdl-gw53xx: allow boot firmware to set eth1 MAC")
>   48d799918adf ("ARM: dts: imx6qdl-gw54xx: allow boot firmware to set eth1 MAC")
>

Stephen,

Thanks for the catch - sorry about that. I will submit a new version
of those that have the missing #address-cells and #size-cells that
caused the warnings.

Tim

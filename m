Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A916C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3120B206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599143983;
	bh=MhbRvwWJNnHywACtnbf5ET9sjfMsgb9V61rFSq5rdyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SSJ0LFkyJhGJZSYyIWwTf2QpoNSVeY0+fWL7SVhnSKB83UqTgOUaV7/o9iE0pjgxJ
	 rgq59Ry6EwRQr8g96lsx7KYJuANO+jjx+DMJB9Rf4X0FkszATSFvLrzNARBl2vD8rx
	 EYbdJ4tDOxTX08POqwQ68Z4LIqk6GEUc8Syfqmso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgICOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbgICOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:35:46 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB97206EF;
        Thu,  3 Sep 2020 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599143745;
        bh=MhbRvwWJNnHywACtnbf5ET9sjfMsgb9V61rFSq5rdyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1T0430uD2S79+kbERCTjKsRHOpH+UDiH9qgJtRgAQ7SJ0tZIRKM1C5b23z5dMAtR9
         YLWNTxTFnOMKeCSmOBWX6uHi+ngM/ZfnKxifHH5tCZ992BpWUTRQ5i3QsoiuDCwW3o
         DnGXdsGsXR0nCmwv3Rg2IiSUhN2n+1I/YIzaQoeI=
Received: by mail-ot1-f52.google.com with SMTP id 109so2922288otv.3;
        Thu, 03 Sep 2020 07:35:45 -0700 (PDT)
X-Gm-Message-State: AOAM531zCMqM6PRLbZ6/NcESRsjk7iG2ZhQBq5Qywg76COGgb4EAxYO/
        VkCIs+HvYOQGqsVk7MmkD4BkBx7g+Kg1F8aI3Q==
X-Google-Smtp-Source: ABdhPJyHlJEdw5VHQQUgODncJ0OYkDXMPEq4Rvj2LgMEWbIkezHrTYKZ3HU8dnFCvqRioNojcf6d52vGY/GYDWNxQ5E=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr1743810otp.107.1599143744629;
 Thu, 03 Sep 2020 07:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200829164920.7d28e01a@DUFFMAN> <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN> <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
 <20200831234542.295b1275@DUFFMAN> <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
 <20200901164249.GA15045@e121166-lin.cambridge.arm.com> <20200901143356.0425d9ba@DUFFMAN>
 <20200902160110.GA30014@e121166-lin.cambridge.arm.com> <20200902234756.60e4c4f6@DUFFMAN>
 <20200903091901.GA9386@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200903091901.GA9386@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Sep 2020 08:35:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJwH3ZKWKYeSJYKZhaU7x59H0t=AM4nWDSmRZuSY0-DGA@mail.gmail.com>
Message-ID: <CAL_JsqJwH3ZKWKYeSJYKZhaU7x59H0t=AM4nWDSmRZuSY0-DGA@mail.gmail.com>
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 3:19 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Sep 02, 2020 at 11:47:56PM -0400, Samuel Dionne-Riel wrote:
> > On Wed, 2 Sep 2020 17:01:19 +0100
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >
> > > On Tue, Sep 01, 2020 at 02:33:56PM -0400, Samuel Dionne-Riel wrote:
> > >
> > > Please print a pointer as a pointer and print both bus and
> > > bus->parent.
> >
> > Hopefully pointer as a pointer is %px. Not sure what else, if that's
> > wrong please tell.
> >
> > ---
> > @@ -79,6 +79,8 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
> >          * do not read more than one device on the bus directly attached
> >          * to RC's downstream side.
> >          */
> > +       printk("[!!] // bus (%px) bus->parent (%px)\n", bus, bus->parent);
> > +       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
> >         if (bus->primary == rockchip->root_bus_nr && dev > 0)
> >                 return 0;
> >
> > --
> >
> > Again, two values, verified with a bit of set and `sort -u`.
> >
> > [    1.691266] [!!] // bus (ffff0000ef9ab800) bus->parent (0000000000000000)
> > [    1.691271] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> >
> > and
> >
> > [    1.697156] [!!] // bus (ffff0000ef9ac000) bus->parent (ffff0000ef9ab800)
> > [    1.697160] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> >
> > First instance of each shown here. Last time I don't think it was.
>
> Ok I think I understand what the problem is.
>
> Can you give this patch a shot please ? I think we are dereferencing
> a NULL pointer if bus is the root bus and dev == 0, we can rewrite
> the check if this patch fixes the issue.

Indeed. I checked all the other cases of pci_is_root_bus(bus->parent)
and they should be fine because they are only reached if !root_bus.

I would restructure the check like this instead:

diff --git a/drivers/pci/controller/pcie-rockchip-host.c
b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..9b485bea8b92 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -72,14 +72,14 @@ static int rockchip_pcie_valid_device(struct
rockchip_pcie *rockchip,
                                      struct pci_bus *bus, int dev)
 {
        /* access only one slot on each root port */
-       if (pci_is_root_bus(bus) && dev > 0)
-               return 0;
-
-       /*
-        * do not read more than one device on the bus directly attached
-        * to RC's downstream side.
-        */
-       if (pci_is_root_bus(bus->parent) && dev > 0)
+       if (pci_is_root_bus(bus))
+               if (dev > 0)
+                       return 0;
+       else if (pci_is_root_bus(bus->parent) && dev > 0)
+               /*
+                * do not read more than one device on the bus directly attached
+                * to RC's downstream side.
+                */
                return 0;

        return 1;


>
> -- >8 --
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 0bb2fb3e8a0b..72beda87b47f 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -79,7 +79,7 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>          * do not read more than one device on the bus directly attached
>          * to RC's downstream side.
>          */
> -       if (pci_is_root_bus(bus->parent) && dev > 0)
> +       if (bus->parent && pci_is_root_bus(bus->parent) && dev > 0)
>                 return 0;
>
>         return 1;

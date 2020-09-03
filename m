Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B0C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B562072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599148780;
	bh=ssrVCFS5h8gof597A2OnNoZV3nA0EIqkHdv3ZT/3+0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LZ6Z7SjaL3flY0k8JOp+/Jg2YnMic1ob7sDmx2mWw7Xw0iYuqOjkpS5n1JQBsGOGn
	 25F9nhY6fF6R4R4XwAOddoftK3nTrO/zfr7GZny3eeJlrx6N6aJ5Bxa67VhZVmPK97
	 ytJ8MxGdJmPwx1ayeGim2zretAZCGggDWMBWvsYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgICP7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICP7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:59:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26872072A;
        Thu,  3 Sep 2020 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599148772;
        bh=ssrVCFS5h8gof597A2OnNoZV3nA0EIqkHdv3ZT/3+0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvRaUBI81kQTHxogQ3icEMRXqgAqJmU7JUdGWwe3Jognb+vZBu+OOc7sJZMq7ZG+3
         5T+wuyfPGD6AnI3josvikLF6P6ggGrP+6hhmFw3hH4djz9BFFl+QPCI1TseC0/Ln28
         /hsOS8u9+ALcePANXixeKAc2sARS+3oyeelPJbNM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDre6-008w4q-W6; Thu, 03 Sep 2020 16:59:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 16:59:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
In-Reply-To: <CAL_JsqJwH3ZKWKYeSJYKZhaU7x59H0t=AM4nWDSmRZuSY0-DGA@mail.gmail.com>
References: <20200829164920.7d28e01a@DUFFMAN>
 <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN>
 <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
 <20200831234542.295b1275@DUFFMAN>
 <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
 <20200901164249.GA15045@e121166-lin.cambridge.arm.com>
 <20200901143356.0425d9ba@DUFFMAN>
 <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
 <20200902234756.60e4c4f6@DUFFMAN>
 <20200903091901.GA9386@e121166-lin.cambridge.arm.com>
 <CAL_JsqJwH3ZKWKYeSJYKZhaU7x59H0t=AM4nWDSmRZuSY0-DGA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <9be6848cfdbb92865417292feff03cae@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh@kernel.org, lorenzo.pieralisi@arm.com, samuel@dionne-riel.com, bhelgaas@google.com, devicetree@vger.kernel.org, frowand.list@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 15:35, Rob Herring wrote:
> On Thu, Sep 3, 2020 at 3:19 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> 
>> On Wed, Sep 02, 2020 at 11:47:56PM -0400, Samuel Dionne-Riel wrote:
>> > On Wed, 2 Sep 2020 17:01:19 +0100
>> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> >
>> > > On Tue, Sep 01, 2020 at 02:33:56PM -0400, Samuel Dionne-Riel wrote:
>> > >
>> > > Please print a pointer as a pointer and print both bus and
>> > > bus->parent.
>> >
>> > Hopefully pointer as a pointer is %px. Not sure what else, if that's
>> > wrong please tell.
>> >
>> > ---
>> > @@ -79,6 +79,8 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>> >          * do not read more than one device on the bus directly attached
>> >          * to RC's downstream side.
>> >          */
>> > +       printk("[!!] // bus (%px) bus->parent (%px)\n", bus, bus->parent);
>> > +       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
>> >         if (bus->primary == rockchip->root_bus_nr && dev > 0)
>> >                 return 0;
>> >
>> > --
>> >
>> > Again, two values, verified with a bit of set and `sort -u`.
>> >
>> > [    1.691266] [!!] // bus (ffff0000ef9ab800) bus->parent (0000000000000000)
>> > [    1.691271] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
>> >
>> > and
>> >
>> > [    1.697156] [!!] // bus (ffff0000ef9ac000) bus->parent (ffff0000ef9ab800)
>> > [    1.697160] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
>> >
>> > First instance of each shown here. Last time I don't think it was.
>> 
>> Ok I think I understand what the problem is.
>> 
>> Can you give this patch a shot please ? I think we are dereferencing
>> a NULL pointer if bus is the root bus and dev == 0, we can rewrite
>> the check if this patch fixes the issue.
> 
> Indeed. I checked all the other cases of pci_is_root_bus(bus->parent)
> and they should be fine because they are only reached if !root_bus.
> 
> I would restructure the check like this instead:
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> b/drivers/pci/controller/pcie-rockchip-host.c
> index 0bb2fb3e8a0b..9b485bea8b92 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -72,14 +72,14 @@ static int rockchip_pcie_valid_device(struct
> rockchip_pcie *rockchip,
>                                       struct pci_bus *bus, int dev)
>  {
>         /* access only one slot on each root port */
> -       if (pci_is_root_bus(bus) && dev > 0)
> -               return 0;
> -
> -       /*
> -        * do not read more than one device on the bus directly 
> attached
> -        * to RC's downstream side.
> -        */
> -       if (pci_is_root_bus(bus->parent) && dev > 0)
> +       if (pci_is_root_bus(bus))
> +               if (dev > 0)
> +                       return 0;
> +       else if (pci_is_root_bus(bus->parent) && dev > 0)

Careful here, this else is relative to the *closest* if,
and not what the indentation suggests...

> +               /*
> +                * do not read more than one device on the bus directly 
> attached
> +                * to RC's downstream side.
> +                */
>                 return 0;
> 
>         return 1;


         M.
-- 
Jazz is not dead. It just smells funny...

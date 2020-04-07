Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B7FC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA9420748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WE+MMrJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDGHbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:31:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36496 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDGHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rWh8rrEPIkDMv4VbQykebA3zv8/SWd0dZcFoD4kPIuI=; b=WE+MMrJ/4QBFfcAKqCx0/lyS8
        2aK+1lxsxR+r4wSUKpm06kagEuskFZA3GFBe+D2vT/jRALfufrBtc6c0dQkmdwLxnYlpH58ycehIq
        2cIxeAMIbUNNoKn8Knaj/rkrCn7DyD9Gr/U21BLsxgpoqK6DH5MD9mJT0vYuAsTvAdRXjqeXA5Z6q
        TnPcSOy3w28B6pWguwIt2vIzUhCpq880ySmVj0Sa329Uz2mGU7nrRWZOYDsjPi1GCwfX9IeG5rdaC
        8hTEpDtOlOEGHbUh2TWk7yO5sWRFPfmAuNXAP+nGnppfoiMT+XD3e1YO2F7rJE+MrzMegzdGgl6CZ
        DXWFYLIqA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:42612)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jLihc-0006a5-1h; Tue, 07 Apr 2020 08:31:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jLihZ-00070T-KM; Tue, 07 Apr 2020 08:31:17 +0100
Date:   Tue, 7 Apr 2020 08:31:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407073117.GH25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406201053.GA10931@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:10:53PM +0200, Corentin Labbe wrote:
> On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> > On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > > Hello
> > > > > 
> > > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > > 
> > > > > But kexec 2.0.18 fail to work:
> > > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > > 
> > > > What happens if you omit the dtb argument?
> > > > 
> > > 
> > > No change without dtb
> > > 
> > > I have also tried to add --mem-mim and --mem-max without any change.
> > > I given mem according to what I saw in /proc/iomem
> > > 20000000-9fffffff : System RAM
> > >   20008000-207fffff : Kernel code
> > >   20900000-209a0c87 : Kernel data
> > > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > > Anyway, the result is always the same.
> > 
> > The next step is to enable the early debugging - first in the
> > decompressor - add #define DEBUG to the top of
> > arch/arm/boot/compressed/head.S
> > 
> > Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> > get anything from the new kernel.
> > 
> 
> I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
> Furthermore, I have added crashkernel=128M to the cmdlist
> I have verified that the reservation is working:
> 20000000-9fffffff : System RAM
>   20008000-207fffff : Kernel code
>   20900000-209a0c87 : Kernel data
>   40000000-47ffffff : Crash kernel
> But even with this reservation, no change.

crashkernel is only necessary if you're loading a kenrel image to be
booted when the existing one has crashed. For the problem you're
seeing, it's an unnecessary additional change; please drop that.

You could try running kexec with debug enabled to see more information.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

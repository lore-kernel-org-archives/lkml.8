Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24288C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83A7206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GLQHbhag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgDGINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:13:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36996 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDGINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OgiDrl/y3vH6wAvfRgLIRdC9VWqb30+aJ0O6R1lUpLk=; b=GLQHbhagSsecX46c9NF2cLExd
        dW+puIz5U9+QhN6qsxGY2LUYZoJ/g5/re5qCnGvvTwKRMQkpMDRZ/j2kWul9Trj/qm6XZbCfHR+r8
        oGSpi5jMmpG3pzv+0SproXqgSwzp51YQbooXpA8Kf94KCdLMN42DuB7ZAAUSWyBbkbGELcJedou6W
        ow0tlXAti0+Z5f+LgX32CgFkGdryQDMiOef79anps2tBNsH5Jlrecxd22ynaEkuI5+aDgl0YFpDjb
        xB4QeHGwWU7HZvpaoI88CPysVyzc+k9uQ27MCi2rGamjoQZvjm0EfnWlWpSHM58uBjRKa9XMYXvBv
        2dY7lgGXQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:42622)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jLjLu-0006lM-S1; Tue, 07 Apr 2020 09:12:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jLjLt-00072P-G3; Tue, 07 Apr 2020 09:12:57 +0100
Date:   Tue, 7 Apr 2020 09:12:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407081257.GI25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
 <20200407080144.GA20773@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407080144.GA20773@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:01:44AM +0200, Corentin Labbe wrote:
> On Tue, Apr 07, 2020 at 08:31:17AM +0100, Russell King - ARM Linux admin wrote:
> > On Mon, Apr 06, 2020 at 10:10:53PM +0200, Corentin Labbe wrote:
> > > On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> > > > On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > > > > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > > > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > > > > Hello
> > > > > > > 
> > > > > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > > > > 
> > > > > > > But kexec 2.0.18 fail to work:
> > > > > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > > > > 
> > > > > > What happens if you omit the dtb argument?
> > > > > > 
> > > > > 
> > > > > No change without dtb
> > > > > 
> > > > > I have also tried to add --mem-mim and --mem-max without any change.
> > > > > I given mem according to what I saw in /proc/iomem
> > > > > 20000000-9fffffff : System RAM
> > > > >   20008000-207fffff : Kernel code
> > > > >   20900000-209a0c87 : Kernel data
> > > > > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > > > > Anyway, the result is always the same.
> > > > 
> > > > The next step is to enable the early debugging - first in the
> > > > decompressor - add #define DEBUG to the top of
> > > > arch/arm/boot/compressed/head.S
> > > > 
> > > > Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> > > > get anything from the new kernel.
> > > > 
> > > 
> > > I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
> > > Furthermore, I have added crashkernel=128M to the cmdlist
> > > I have verified that the reservation is working:
> > > 20000000-9fffffff : System RAM
> > >   20008000-207fffff : Kernel code
> > >   20900000-209a0c87 : Kernel data
> > >   40000000-47ffffff : Crash kernel
> > > But even with this reservation, no change.
> > 
> > crashkernel is only necessary if you're loading a kenrel image to be
> > booted when the existing one has crashed. For the problem you're
> > seeing, it's an unnecessary additional change; please drop that.
> > 
> > You could try running kexec with debug enabled to see more information.
> > 
> 
> I am already running with --debug

That was not reflected in the command lines given to kexec that you
quoted previously, so I'm now wondering if you're giving me the full
information.

In any case, based on the information you've supplied thus far, I have
no further suggetsions to make.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

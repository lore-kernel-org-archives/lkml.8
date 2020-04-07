Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7FC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BADF20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCTnUVnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgDGJc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:32:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52633 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgDGJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:32:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so1026495wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdXdseig1JC7hYsKG08hvusxa6/a4PjFvmwj1PCqWVE=;
        b=BCTnUVnY9ydPXeCcuXlX0gP4wDXnqTWOFivVKneAdskZIhsPUvZYr5mkMDIEqsWM/w
         HCM709DCJfmAemVQvDTU5wBfzxejYRXMPVjJyumfU7EWi0iAcAd8O9sg/Ymw0NJC7PJl
         0DawBQhe/fwljAQzAd9LZJ/lDTlbdDzHuQjSoTds7+4ewm4n1D/aC4qUHUvJNJU9vYOA
         CLokp0dAVLj+XswWT8qRc/x6uG1xOI1bacA/u6frv8c/HbiYv/aR5EPNja6NAn/vvtWd
         /6NB5rOf5O5YQUNz9YFfZiV3PSECfEc3wKeu90V3vbbjp4S3tzIX5WCWBiR6EvAo1bNS
         LBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdXdseig1JC7hYsKG08hvusxa6/a4PjFvmwj1PCqWVE=;
        b=LYLE/DgOJMEVUdvy63qSnAoumGwJlVlpmwSba+Gg2f0pTKorB0VEIZ52S+IhdXVQ2K
         att9M1t4vRYnnkkJAiZ5FxkL2FYsxa6Q28Ki7+BakZpmE8MXNENixxkQTXNC/H8FXzcY
         yr2+oKVn3zizghLAmdRpgxjcfEZutSXkLE/PFhLdrl9Oge7wMxDlaO4ej4h3oRpsjRM2
         gYLPdQx+fc0cCtWx5KfM4Japj1aDFGerNiBIvhr2gtjvE87PEXyXia6ZP0NxxWVJTS7S
         7J/Wy3vpwt0FxtMJb6ktIBinhkDrQC1j8oDkasgAYHuonvUegIbWV/iQ4HbXNg/Phwn2
         Oi4Q==
X-Gm-Message-State: AGi0PuYBXoT1okLCZ+ekgv3wvGORh3pc3YAO+7qqw8osVXVUxkyT/+wZ
        bmZCAjuf8m+aDeDecPxbi104CZUp
X-Google-Smtp-Source: APiQypJuZw5cMHdVTEWcphAoIqDvCosEFGkn7RmxDUYMsKdM0oKVezrFvj9Ee3UjADzAy5iZMOptOg==
X-Received: by 2002:a1c:770a:: with SMTP id t10mr1469989wmi.150.1586251976051;
        Tue, 07 Apr 2020 02:32:56 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id t67sm1487742wmt.48.2020.04.07.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:32:55 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:32:53 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407093253.GA4630@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
 <20200407080144.GA20773@Red>
 <20200407081257.GI25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407081257.GI25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:12:57AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Apr 07, 2020 at 10:01:44AM +0200, Corentin Labbe wrote:
> > On Tue, Apr 07, 2020 at 08:31:17AM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Apr 06, 2020 at 10:10:53PM +0200, Corentin Labbe wrote:
> > > > On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> > > > > On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > > > > > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > > > > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > > > > > Hello
> > > > > > > > 
> > > > > > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > > > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > > > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > > > > > 
> > > > > > > > But kexec 2.0.18 fail to work:
> > > > > > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > > > > > 
> > > > > > > What happens if you omit the dtb argument?
> > > > > > > 
> > > > > > 
> > > > > > No change without dtb
> > > > > > 
> > > > > > I have also tried to add --mem-mim and --mem-max without any change.
> > > > > > I given mem according to what I saw in /proc/iomem
> > > > > > 20000000-9fffffff : System RAM
> > > > > >   20008000-207fffff : Kernel code
> > > > > >   20900000-209a0c87 : Kernel data
> > > > > > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > > > > > Anyway, the result is always the same.
> > > > > 
> > > > > The next step is to enable the early debugging - first in the
> > > > > decompressor - add #define DEBUG to the top of
> > > > > arch/arm/boot/compressed/head.S
> > > > > 
> > > > > Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> > > > > get anything from the new kernel.
> > > > > 
> > > > 
> > > > I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
> > > > Furthermore, I have added crashkernel=128M to the cmdlist
> > > > I have verified that the reservation is working:
> > > > 20000000-9fffffff : System RAM
> > > >   20008000-207fffff : Kernel code
> > > >   20900000-209a0c87 : Kernel data
> > > >   40000000-47ffffff : Crash kernel
> > > > But even with this reservation, no change.
> > > 
> > > crashkernel is only necessary if you're loading a kenrel image to be
> > > booted when the existing one has crashed. For the problem you're
> > > seeing, it's an unnecessary additional change; please drop that.
> > > 
> > > You could try running kexec with debug enabled to see more information.
> > > 
> > 
> > I am already running with --debug
> 
> That was not reflected in the command lines given to kexec that you
> quoted previously, so I'm now wondering if you're giving me the full
> information.
> 
> In any case, based on the information you've supplied thus far, I have
> no further suggetsions to make.
> 

Sorry I have added --debug after my initial mail.
But I am surprised that no debug output like "MEMORY RANGES" is done (like I got in my first try).
I have started to patch kexec-tools to check it, and debug is enabled.
Furthermore, I got in locate_hole:237 memory_ranges=0.
So the memory region in struct kexec_info is not initialized (and so cannot be printed)


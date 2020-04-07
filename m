Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8548C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790002064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd1u5BWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDGIBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:01:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55701 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgDGIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:01:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so747327wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+sVYGdrgciOIyEUzjtYrjQlBCZb9nKDuvRS4LNAffc=;
        b=Qd1u5BWiAFEF5eIkYtQ1aW0zarMMS8/WjeHsBw0RB/FWcWrTM1Atvp8Lz3K48EdY/N
         ieEIwA2Z1hZa+6lfyxhxSt72gWI+loQE6Q6J7WS9TQq18TPhfbqbqZsvN09fPs5ZDFAh
         qOwyiyAOMfsviVHWPPLwZC3R9ipYE1vcsLYNTCuXl9mpwoDyTbJIL/3oBOX3ay6NqH9d
         XIyPzKzIYeHGYlODQVmvHgHLOjDpS3PA3Jr8e9+sa3H0KU6qU9yAuQLo4BkFYDbSNvS5
         PDJn0+/WGkqMGv/DXK31kSVhHauzwgwgY9GjcbnVCLtPtl2NyRo33U/WoA/dnTO8dYyq
         B+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+sVYGdrgciOIyEUzjtYrjQlBCZb9nKDuvRS4LNAffc=;
        b=oANNo/cEpzmPJDa83lmD8gXpemKi0DrAcxsGfeCxj+a+CUXf+BFk7T08xEL6IpZJXL
         DadYTZwzGB/t8O1gqM9r2mQ5uX13WJth06kbUZmcy4lRFodFyMG0LofArAKhhdyrX9uN
         huwm43+kO0QGJ20WOib0siZl900I/QZWS0zFVBJkWBPIkE++9qLrJ1uj1+8zUKbA7dtT
         cIFhMqliWl9+VrGwvZY12t2LWIYz9LjyL8uioxkuRRV/JbsX1qWtWHjo8GMnILHv67H3
         5P2wl8i6NZVZ/eN21FXjMIoju8MDKBZyrHsVZn7qvC+mN570IQlU3uZr+yqQDd/HORoX
         MA3Q==
X-Gm-Message-State: AGi0PuZ9p5ir7liK0my2XAGxh6JxnudGjmokdQVnYbPGWLhac2jAlEyx
        0THYCbEcCFRBNrzaXhwd8h0=
X-Google-Smtp-Source: APiQypJ9A3980VQ+KaUlU3du9ayaETdW8cUmPckCAt5+8KvV1MmMZZ85OIJta6+2YdWtSn1ALKPBfQ==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr1089001wmb.172.1586246507989;
        Tue, 07 Apr 2020 01:01:47 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k9sm12166115wrn.89.2020.04.07.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 01:01:46 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:01:44 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407080144.GA20773@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407073117.GH25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:31:17AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Apr 06, 2020 at 10:10:53PM +0200, Corentin Labbe wrote:
> > On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > > > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > > > Hello
> > > > > > 
> > > > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > > > 
> > > > > > But kexec 2.0.18 fail to work:
> > > > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > > > 
> > > > > What happens if you omit the dtb argument?
> > > > > 
> > > > 
> > > > No change without dtb
> > > > 
> > > > I have also tried to add --mem-mim and --mem-max without any change.
> > > > I given mem according to what I saw in /proc/iomem
> > > > 20000000-9fffffff : System RAM
> > > >   20008000-207fffff : Kernel code
> > > >   20900000-209a0c87 : Kernel data
> > > > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > > > Anyway, the result is always the same.
> > > 
> > > The next step is to enable the early debugging - first in the
> > > decompressor - add #define DEBUG to the top of
> > > arch/arm/boot/compressed/head.S
> > > 
> > > Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> > > get anything from the new kernel.
> > > 
> > 
> > I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
> > Furthermore, I have added crashkernel=128M to the cmdlist
> > I have verified that the reservation is working:
> > 20000000-9fffffff : System RAM
> >   20008000-207fffff : Kernel code
> >   20900000-209a0c87 : Kernel data
> >   40000000-47ffffff : Crash kernel
> > But even with this reservation, no change.
> 
> crashkernel is only necessary if you're loading a kenrel image to be
> booted when the existing one has crashed. For the problem you're
> seeing, it's an unnecessary additional change; please drop that.
> 
> You could try running kexec with debug enabled to see more information.
> 

I am already running with --debug

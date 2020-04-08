Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57226C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A420787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AIIWMkRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgDHQRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:17:05 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58940 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgDHQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PZi97pQa4y0yt53/rdrgUQ/GmiJF1/ROleWVi/yIQ98=; b=AIIWMkRBgQvSadhGLzjUFbkaT
        QkafK5gsuXUgzCcFY4doqcnrGjLv794yS+8TlFK95Bib6M3klz0o3HLBZJOgAJTvIgz8oJRbmX02L
        Ve3p8HUaglgq1lvClD2xfC3rb0/fx/iKUS8e6Yo7Q3PGnc9qTHMxhqzunFiDcO2E/5k79jV5Ossgd
        QszQo1WbmK/DtrwcWg6+bWOY06w5dMmQfS4mcxuUHtAJLYvx41WZ7RtNO/ULNZmkfzS6Bm8QRP214
        xmNMt7THfj3k3Ltcc505BPpyal0x6nG86c+loIxllbsP/OfZHVtEBqDUDXNnMJL4PjUiHlGRzq5M2
        03NMkdrFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47364)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jMDNq-0007BX-Ua; Wed, 08 Apr 2020 17:16:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jMDNp-0001xp-Af; Wed, 08 Apr 2020 17:16:57 +0100
Date:   Wed, 8 Apr 2020 17:16:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200408161657.GT25745@shell.armlinux.org.uk>
References: <20200407101912.GL25745@shell.armlinux.org.uk>
 <20200407113454.GA457@Red>
 <20200407122243.GN25745@shell.armlinux.org.uk>
 <20200407130559.GB457@Red>
 <20200407132602.GO25745@shell.armlinux.org.uk>
 <20200407134849.GC457@Red>
 <20200407181740.GP25745@shell.armlinux.org.uk>
 <20200408084029.GA1859@Red>
 <20200408093320.GQ25745@shell.armlinux.org.uk>
 <20200408152412.GA3621@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408152412.GA3621@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:24:12PM +0200, Corentin Labbe wrote:
> On Wed, Apr 08, 2020 at 10:33:20AM +0100, Russell King - ARM Linux admin wrote:
> > On Wed, Apr 08, 2020 at 10:40:29AM +0200, Corentin Labbe wrote:
> > > This is the last boot:
> > > ## Loading init Ramdisk from Legacy Image at 2a000000 ...
> > >    Image Name:   
> > >    Image Type:   ARM Linux RAMDisk Image (uncompressed)
> > >    Data Size:    8031928 Bytes = 7.7 MiB
> > >    Load Address: 00000000
> > >    Entry Point:  00000000
> > >    Verifying Checksum ... OK
> > > ## Flattened Device Tree blob at 23000000
> > >    Booting using the fdt blob at 0x23000000
> > >    Loading Ramdisk to 29857000, end 29fffeb8 ... OK
> > >    Loading Device Tree to 2984e000, end 29856fd1 ... OK
> > > Starting kernel ...
> > > ID:0x00000000 DT:0x2984E000
> > > Uncompressing Linux... done, booting the kernel.
> > > [...]
> > > fake uboot stuff
> > > [...]
> > > DEBUG: bootz: run kexec with --debug --kexec-syscall --force --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 earlyprintk ip=dhcp'
> > > Set DEBUG!
> > > main:1417 OPT_KEXEC_SYSCALL
> > > main:1422 OPT_KEXEC_SYSCALL_AUTO
> > > arch_process_options:119
> > > main:1500
> > > main:1517 res=0 do_load=1
> > > main:1519 res=0 do_kexec_file_syscall=0
> > > my_load:713
> > > Try gzip decompression.
> > > kernel: 0xb6931008 kernel_size: 0x444fc8
> > > get_memory_ranges:36
> > > MEMORY RANGES
> > > 0000000020000000-000000009fffffff (0)
> > > zImage_arm_load:423
> > > zImage header: 0x016f2818 0x00000000 0x00444fc8
> > > zImage size 0x444fc8, file size 0x444fc8
> > > zImage requires 0x00455fc8 bytes
> > >   offset 0x00006738 tag 0x5a534c4b size 8
> > > Decompressed kernel sizes:
> > >  text+data 0x00b77958 bss 0x0003d428 total 0x00bb4d80
> > > Resulting kernel space: 0x00fcd920
> > > Kernel: address=0x20008000 size=0x00fcd920
> > > Initrd: address=0x20fd6000 size=0x016a6b97
> > > DT    : address=0x2267d000 size=0x00006043
> > > kexec_load: entry = 0x20008000 flags = 0x280000
> > > nr_segments = 3
> > > segment[0].buf   = 0xb6931008
> > > segment[0].bufsz = 0x444fcc
> > > segment[0].mem   = 0x20008000
> > > segment[0].memsz = 0x445000
> > > segment[1].buf   = 0xb528a008
> > > segment[1].bufsz = 0x16a6b97
> > > segment[1].mem   = 0x20fd6000
> > > segment[1].memsz = 0x16a7000
> > > segment[2].buf   = 0x4ef88
> > > segment[2].bufsz = 0x6043
> > > segment[2].mem   = 0x2267d000
> > > segment[2].memsz = 0x7000
> > > main:1568 res=0[   32.098439] sun7i-dwmac 830000.ethernet eth0: Link is Down
> > > main:1582 res=0 do_exec=1
> > > [   32.113191] kexec_core: Starting new kernel
> > > [   32.460412] Bye!
> > > ID:0xFFFFFFFF DT:0x2267D000
> > > C:0x200080C0-0x2044CFE0->0x20B80500-0x20FC5420
> > > ID:0xFFFFFFFF DT:0x2267D000
> > > Uncompressing Linux... done, booting the kernel.
> > 
> > Okay, that looks fine:
> > - the DT is out of the way, so shouldn't be corrupted by the
> >   decompression process.
> > - the decompressor writes the kernel image to 0x20008000 to 0x20b7f958
> >   which is clear of the decompressor itself (which relocated itself
> >   to 0x20b80500).
> > - the ID doesn't matter for DT booting purposes.
> > 
> > I see you've gone back to using your own dtb rather than one derived
> > from the booting kernel. I strongly recommend against giving your own
> > dtb to kexec as if the boot loader modifies the DTB when calling the
> > first kernel (such as adding memory region information, adding MAC
> > addresses, enabling or disabling various devices) those modifications
> > will be lost if you supply your own DTB to kexec.
> > 
> > Please drop "--dtb /tmp/dtb".
> > 
> 
> Thanks it works now.
> 
> With a working setup I diffed dtb and the one given by uboot and it seems the missing node for booting was /memory.

That is more or less expected - it seems kexec never adds the /memory
nodes to the dtb.  I've no idea whether it should or should not be doing
so, and is for others to thrash out the arguments for and against what
should be modified and how.

The upshot of the existing kexec behaviour is you can't take a dtb from
the kernel build and use it with kexec.

> For booting a different kernel, I fdtput the dtb (for memory and bootargs), and it works until it try to mount the roofs which it find corrupt.

rootfs or initrd supplied to kexec?

> Since the rootfs I get by the fakeuboot is a "uboot legacy image" (rootfs.cpio.gz modified by mkimage), I drop the first 64bytes but it seems not sufficiant. (even if file say it is a good rootfs.cpio.gz)
> Or perhaps the kernel get an invalid initrd address.

Yep, the file given via --initrd or --ramdisk is loaded exactly as-is
into memory, no parsing of the file is done.  Neither the kernel, nor
kexec, does any u-boot parsing of the initrd/ramdisk file; they are
not u-boot.

If you want to try giving the kernel a bit more space, you can try
--image-size=$((0x01000000)) to see whether that affects the ramdisk
image problem - if it does, it means we're still not properly
calculating the space the kernel needs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

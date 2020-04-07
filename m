Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6EF20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m5BFSB4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgDGKCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:02:16 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38286 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDGKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2wR2xqOs8l+OydThwaZ/J8QQDNxkPOYEU/7GzqzAa3M=; b=m5BFSB4gVHf+ffBnIzdw2gzUY
        wYLYy5Y0VK2BwlAyzTKiAhBnFbd4tft0EP3wZxXv1Vn+oKtv6/Q9jbMnoqA64m5cNzOeU9H6FkysY
        /BApbRWhjPi3yuFLOZpGvw+24y0Y7sz50JPO3tw+6r+GHd9VPv0T4Yh4nfRnFtJVPjkcPs2sPUctL
        HktSJN0U63pN2g7MioenRIARxbvLaCNvEJInUlMTLmLWjDaB/AMU8rbmCg/VZJB+FEDVMzQcTB8YI
        30jZXG3OvCyhOrHD8nZ2rxDyl+oS4PtHG5NB8e5uFJILtGl5xdF6Dx89XcFBFmY17Hh1ZmQnDvQbK
        SmW2L+DCQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:35146)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jLl3U-0007DE-Og; Tue, 07 Apr 2020 11:02:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jLl3T-0007DO-VB; Tue, 07 Apr 2020 11:02:03 +0100
Date:   Tue, 7 Apr 2020 11:02:03 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407100203.GK25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406082720.GA31279@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> Hello
> 
> I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> 
> But kexec 2.0.18 fail to work:
> kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'

As I mentioned in my other reply, this apparent "kexec" command line
does not seem to reflect the arguments you actually used to invoke
the kexec output below.

> syscall kexec_file_load not available.

This message is produced by do_kexec_file_load().  This function is only
invoked if the do_kexec_file_syscall flag in main() is set.  This flag
is only set if one of:

	--kexec-file-syscall
	--kexec-syscall
	--kexec-syscall-auto
	-s
	-c
	-a

are provided on the kexec command line.  Your command line above does
not contain any of those arguments, so either the command line is not
what you used, or you are using a patched kexec, or your compiler is
grossly miscompiling kexec.

> Try gzip decompression.
> kernel: 0xb6535008 kernel_size: 0x853200
> MEMORY RANGES
> 0000000020000000-000000009fffffff (0)

Then there's the debug output, which is only produced if the
kexec_debug global is set, which in turn is only set if --debug or -d
is supplied on the kexec command line - which again, your kexec
command line does not contain this.

> zImage header: 0x016f2818 0x00000000 0x00853200
> zImage size 0x853200, file size 0x853200
> zImage requires 0x00864200 bytes
>   offset 0x0000bae4 tag 0x5a534c4b size 8
> Decompressed kernel sizes:
>  text+data 0x0158b3a0 bss 0x000632f0 total 0x015ee690
> Resulting kernel space: 0x01def5a0
> Kernel: address=0x20008000 size=0x01def5a0
> Initrd: address=0x21df8000 size=0x0090b6fa
> DT    : address=0x22704000 size=0x00005c09
> kexec_load: entry = 0x20008000 flags = 0x280000
> nr_segments = 3
> segment[0].buf   = 0xb6535008
> segment[0].bufsz = 0x853204
> segment[0].mem   = 0x20008000
> segment[0].memsz = 0x854000
> segment[1].buf   = 0xb5c29008
> segment[1].bufsz = 0x90b6fa
> segment[1].mem   = 0x21df8000
> segment[1].memsz = 0x90c000
> segment[2].buf   = 0x4db50
> segment[2].bufsz = 0x5c09
> segm[   71.039126] kexec_core: Starting new kernel
> ent[2].mem   = 0[   71.044712] Disabling non-boot CPUs ...
> x22704000
> segment[2].memsz = 0x6000
> [   71.489070] Bye!
> 
> 
> I have tried also kexec-2.0.20
> Try gzip decompression.
> zImage header: 0x00000000 0x000019b4 0x00001000
> zImage requires 0x008641c0 bytes
> Could not find a free area of memory of 0x86c1c0 bytes...
> Cannot load /tmp/kernel

kexec 2.0.20 doesn't appear to have changed anything to do with how
allocations are done.  The above output looks even more strange and
confusing.  "zImage header" is produced by debugging prints, which
imply that kexec_debug was set.

However, the "MEMORY RANGES" output is missing - this has not gone
away with kexec 2.0.20, it's still there, and works for me (I've
just built and tested kexec 2.0.20).

Also, the values on the "zImage header" line are completely messed
up; the first should be the zImage magic value and it is not - that
suggests that the file being loaded is not a zImage file, or is
corrupted.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

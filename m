Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC42063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbix+h57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgDGLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:35:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:35:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so3416261wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=il8xBtLW16WXNK+wuzc/LJBVTLop6QSkf7DLUFmwyOc=;
        b=gbix+h57+voX+m2naQYsbc2VTqDGxqJIJtfDRAdMEjQWNj+6xdbub1evgEdBKIjy4l
         NJDlhMZNBF7Dq22ylAC8bUOHhU1R7IBosudCpqYfuHKuSzfxyTGQFtvLMTMB8aKFMv+l
         fvFuUzu1W9uTUfHTlOKXUr/HpouS1PpVWD5oj99zc5YAcFeMk7ygHNrBrB7+VewFRrFn
         mspajw5z2zycifmDOhwYgJ8cRqd6xiUclH0M1S4z4pTrVnLFxPlRPZ0vGsK49Jo0gqb5
         xt9tt+gzswAEtNUi5Me4TtZtHEGCfjOCfCvW/T+gXLKHDHpSI9rUZ7JA8/TKpdMBMKSQ
         TTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=il8xBtLW16WXNK+wuzc/LJBVTLop6QSkf7DLUFmwyOc=;
        b=AZDkmNT6JT4waSNCT0m/EixQhWv0W78ItCDkKuCrboZV3rR/IG9ylO3yXdzI4I5GGc
         U4eC6mXCCvJGBJK0vxp+IVN4Ti+cyd6yJz7qeSNZ/nxb/rB5o77o4VbWxqER/eqAZfI/
         0DK7AmIXvzdlktRURLqRY39G6MUBzySuUgJwH6BJ8+X6bIufYHUACD5PXec7TWiZOhDA
         ZXzfTP1wP4s43QK4pDVDdX0nCKwLsbRX9mkYpIcbYiuFCC8vQf6BYzYQqcuoztTbUjC4
         JGdBH6q2KHvjFICsi3UdSAOCcCvPZbrNu+7A38/1eIERfLrkrY6mtsxLb/7uB5/xO1CU
         s2RQ==
X-Gm-Message-State: AGi0PuaRJgBLYOni0kIiNxznBbtE7y23xKGZkb21vSjdyV2lSboiuLkB
        af2wQO/nwMUnvuH6F/wm2jw=
X-Google-Smtp-Source: APiQypKQcY0oEFBY3G0p5BZU3XbBHc15vggSpsP6EgED1KHiHq8d+uNyKaSQtS/3IAs9ZBpYW6dJ6g==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr2438433wrx.188.1586259297309;
        Tue, 07 Apr 2020 04:34:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u17sm2035588wmu.31.2020.04.07.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 04:34:56 -0700 (PDT)
Date:   Tue, 7 Apr 2020 13:34:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407113454.GA457@Red>
References: <20200406082720.GA31279@Red>
 <20200407100203.GK25745@shell.armlinux.org.uk>
 <20200407101912.GL25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407101912.GL25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:19:12AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Apr 07, 2020 at 11:02:03AM +0100, Russell King - ARM Linux admin wrote:
> > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > Hello
> > > 
> > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > 
> > > But kexec 2.0.18 fail to work:
> > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > 
> > As I mentioned in my other reply, this apparent "kexec" command line
> > does not seem to reflect the arguments you actually used to invoke
> > the kexec output below.
> > 
> > > syscall kexec_file_load not available.
> > 
> > This message is produced by do_kexec_file_load().  This function is only
> > invoked if the do_kexec_file_syscall flag in main() is set.  This flag
> > is only set if one of:
> > 
> > 	--kexec-file-syscall
> > 	--kexec-syscall
> > 	--kexec-syscall-auto
> > 	-s
> > 	-c
> > 	-a
> > 
> > are provided on the kexec command line.  Your command line above does
> > not contain any of those arguments, so either the command line is not
> > what you used, or you are using a patched kexec, or your compiler is
> > grossly miscompiling kexec.
> > 
> > > Try gzip decompression.
> > > kernel: 0xb6535008 kernel_size: 0x853200
> > > MEMORY RANGES
> > > 0000000020000000-000000009fffffff (0)
> > 
> > Then there's the debug output, which is only produced if the
> > kexec_debug global is set, which in turn is only set if --debug or -d
> > is supplied on the kexec command line - which again, your kexec
> > command line does not contain this.
> > 
> > > zImage header: 0x016f2818 0x00000000 0x00853200
> > > zImage size 0x853200, file size 0x853200
> > > zImage requires 0x00864200 bytes
> > >   offset 0x0000bae4 tag 0x5a534c4b size 8
> > > Decompressed kernel sizes:
> > >  text+data 0x0158b3a0 bss 0x000632f0 total 0x015ee690
> > > Resulting kernel space: 0x01def5a0
> > > Kernel: address=0x20008000 size=0x01def5a0
> > > Initrd: address=0x21df8000 size=0x0090b6fa
> > > DT    : address=0x22704000 size=0x00005c09
> > > kexec_load: entry = 0x20008000 flags = 0x280000
> > > nr_segments = 3
> > > segment[0].buf   = 0xb6535008
> > > segment[0].bufsz = 0x853204
> > > segment[0].mem   = 0x20008000
> > > segment[0].memsz = 0x854000
> > > segment[1].buf   = 0xb5c29008
> > > segment[1].bufsz = 0x90b6fa
> > > segment[1].mem   = 0x21df8000
> > > segment[1].memsz = 0x90c000
> > > segment[2].buf   = 0x4db50
> > > segment[2].bufsz = 0x5c09
> > > segm[   71.039126] kexec_core: Starting new kernel
> > > ent[2].mem   = 0[   71.044712] Disabling non-boot CPUs ...
> > > x22704000
> > > segment[2].memsz = 0x6000
> > > [   71.489070] Bye!
> > > 
> > > 
> > > I have tried also kexec-2.0.20
> > > Try gzip decompression.
> > > zImage header: 0x00000000 0x000019b4 0x00001000
> > > zImage requires 0x008641c0 bytes
> > > Could not find a free area of memory of 0x86c1c0 bytes...
> > > Cannot load /tmp/kernel
> > 
> > kexec 2.0.20 doesn't appear to have changed anything to do with how
> > allocations are done.  The above output looks even more strange and
> > confusing.  "zImage header" is produced by debugging prints, which
> > imply that kexec_debug was set.
> > 
> > However, the "MEMORY RANGES" output is missing - this has not gone
> > away with kexec 2.0.20, it's still there, and works for me (I've
> > just built and tested kexec 2.0.20).
> > 
> > Also, the values on the "zImage header" line are completely messed
> > up; the first should be the zImage magic value and it is not - that
> > suggests that the file being loaded is not a zImage file, or is
> > corrupted.
> 
> Under a VM (the kernel doesn't have kexec support - but that's not a
> problem, because the initial loading stages are the relevant parts
> which all happen in userspace):
> 
> # build/sbin/kexec --version
> kexec-tools 2.0.20
> # build/sbin/kexec --debug --load virt-vmlinuz-5.4.0+
> Try gzip decompression.
> kernel: 0xb6a6c008 kernel_size: 0x407358
> MEMORY RANGES
> 0000000040000000-000000007fffffff (0)
> zImage header: 0x016f2818 0x00000000 0x00407358
> zImage size 0x407358, file size 0x407358
> zImage requires 0x00418358 bytes
>   offset 0x00007178 tag 0x5a534c4b size 12
> Decompressed kernel sizes:
>  text+data 0x00c2ed24 bss 0x000319ec total 0x00c60710
> Resulting kernel space: 0x0104707c
> Kernel: address=0x40008000 size=0x0104707c
> DT    : address=0x41051000 size=0x00100000
> kexec_load: entry = 0x40008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6a6c008
> segment[0].bufsz = 0x40735c
> segment[0].mem   = 0x40008000
> segment[0].memsz = 0x408000
> segment[1].buf   = 0xb696b008
> segment[1].bufsz = 0x100000
> segment[1].mem   = 0x41051000
> segment[1].memsz = 0x100000
> kexec_load failed: Function not implemented
> entry       = 0x40008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6aa0008
> segment[0].bufsz = 0x40735c
> segment[0].mem   = 0x40008000
> segment[0].memsz = 0x408000
> segment[1].buf   = 0xb699f008
> segment[1].bufsz = 0x100000
> segment[1].mem   = 0x41051000
> segment[1].memsz = 0x100000
> #
> 
> On a SolidRun Hummingboard2 (iMX6 based, which has kexec support, same
> kexec binary, first without an initrd, and then with):
> 
> # build/sbin/kexec --version
> kexec-tools 2.0.20
> # build/sbin/kexec --debug --load multi-vmlinuz-5.6.0+
> Try gzip decompression.
> kernel: 0xb6763008 kernel_size: 0x7273a8
> MEMORY RANGES
> 0000000010000000-000000004fffffff (0)
> zImage header: 0x016f2818 0x00000000 0x007273a8
> zImage size 0x7273a8, file size 0x7273a8
> zImage requires 0x007383a8 bytes
>   offset 0x00004da8 tag 0x5a534c4b size 12
> Decompressed kernel sizes:
>  text+data 0x00dbedb8 bss 0x007489f8 total 0x015077b0
> Resulting kernel space: 0x015077b0
> Kernel: address=0x10008000 size=0x015077b0
> DT    : address=0x11511000 size=0x0000b000
> kexec_load: entry = 0x10008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6763008
> segment[0].bufsz = 0x7273ac
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x728000
> segment[1].buf   = 0x1207cb0
> segment[1].bufsz = 0xb000
> segment[1].mem   = 0x11511000
> segment[1].memsz = 0xb000
> # build/sbin/kexec --unload
> # build/sbin/kexec --debug --load multi-vmlinuz-5.6.0+ --initrd /boot/initrd.img-5.4.0+
> Try gzip decompression.
> kernel: 0xb65d8008 kernel_size: 0x7273a8
> MEMORY RANGES
> 0000000010000000-000000004fffffff (0)
> zImage header: 0x016f2818 0x00000000 0x007273a8
> zImage size 0x7273a8, file size 0x7273a8
> zImage requires 0x007383a8 bytes
>   offset 0x00004da8 tag 0x5a534c4b size 12
> Decompressed kernel sizes:
>  text+data 0x00dbedb8 bss 0x007489f8 total 0x015077b0
> Resulting kernel space: 0x015077b0
> Kernel: address=0x10008000 size=0x015077b0
> Initrd: address=0x11510000 size=0x0053f46a
> DT    : address=0x11a50000 size=0x0000b044
> kexec_load: entry = 0x10008000 flags = 0x280000
> nr_segments = 3
> segment[0].buf   = 0xb65d8008
> segment[0].bufsz = 0x7273ac
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x728000
> segment[1].buf   = 0xb6098008
> segment[1].bufsz = 0x53f46a
> segment[1].mem   = 0x11510000
> segment[1].memsz = 0x540000
> segment[2].buf   = 0x993cf0
> segment[2].bufsz = 0xb044
> segment[2].mem   = 0x11a50000
> segment[2].memsz = 0xc000
> 
> On clearfog (Armada 388):
> 
> # build/sbin/kexec --debug --load multi-vmlinuz-5.6.0+
> Try gzip decompression.
> kernel: 0xb6745008 kernel_size: 0x7273a8
> MEMORY RANGES
> 0000000000000000-000000003fffffff (0)
> zImage header: 0x016f2818 0x00000000 0x007273a8
> zImage size 0x7273a8, file size 0x7273a8
> zImage requires 0x007383a8 bytes
>   offset 0x00004da8 tag 0x5a534c4b size 12
> Decompressed kernel sizes:
>  text+data 0x00dbedb8 bss 0x007489f8 total 0x015077b0
> Resulting kernel space: 0x015077b0
> Kernel: address=0x00008000 size=0x015077b0
> DT    : address=0x01511000 size=0x00007be3
> kexec_load: entry = 0x8000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6745008
> segment[0].bufsz = 0x7273ac
> segment[0].mem   = 0x8000
> segment[0].memsz = 0x728000
> segment[1].buf   = 0x1be7f68
> segment[1].bufsz = 0x7be3
> segment[1].mem   = 0x1511000
> segment[1].memsz = 0x8000
> 
> All appears to work fine.
> 

I have found a part of my problem, kexec-tool seems to always use the OPT_KEXEC_FILE_SYSCALL.
Even if I set --kexec-syscall.

On my early tries I got "syscall kexec_file_load not available."
When I did a full rebuild of my buildroot to go back to kexec-tool 2.0.18, this syscall become availlable.
The get_memory_ranges seems to be called only from my_load() which is executed when !do_kexec_file_syscall.

Since kexec-tool always set do_kexec_file_syscall, it is never called.
I have added a print for each syscal option, and it seems that OPT_KEXEC_SYSCALL_AUTO is called after the handling of OPT_KEXEC_SYSCALL.

So I have hack to always set do_kexec_file_syscall=0

So now my test go further, but the final kernel crash.
DEBUG: bootz: run kexec with /tmp/kernel --debug --kexec-syscall --force --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
Set DEBUG!
main:1417 OPT_KEXEC_SYSCALL
main:1422 OPT_KEXEC_SYSCALL_AUTO
arch_process_options:119
main:1500
main:1517 res=0 do_load=1
main:1519 res=0 do_kexec_file_syscall=0
my_load:713
Try gzip decompression.
kernel: 0xb693b008 kernel_size: 0x443ac0
get_memory_ranges:36
MEMORY RANGES
0000000020000000-000000009fffffff (0)
DEBUG: my_load:737 memory_ranges=1
zImage_arm_load:423
zImage header: 0x016f2818 0x00000000 0x00443ac0
zImage size 0x443ac0, file size 0x443ac0
zImage requires 0x00454ac0 bytes
  offset 0x00006678 tag 0x5a534c4b size 8
Decompressed kernel sizes:
 text+data 0x00b78080 bss 0x0003d3c0 total 0x00bb5440
Resulting kernel space: 0x00fccb40
DEBUG: locate_hole:237 memory_ranges=1
Check 0/1 536870912 0 type=-1610612737
Check 0/1 536870912 0
Kernel: address=0x20008000 size=0x00fccb40
DEBUG: locate_hole:237 memory_ranges=1
Check 0/1 536870912 0 type=-1610612737
Check 0/1 536870912 0
Initrd: address=0x20fd5000 size=0x0167213d
DEBUG: locate_hole:237 memory_ranges=1
Check 0/1 536870912 0 type=-1610612737
Check 0/2 536870912 0
Check 1/2 577011712 0
DT    : address=0x22648000 size=0x00006043
kexec_load: entry = 0x20008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb693b008
segment[0].bufsz = 0x443ac4
segment[0].mem   = 0x20008000
segment[0].memsz = 0x444000
segment[1].buf   = 0xb52c8008
segment[1].bufsz = 0x167213d
segment[1].mem   = 0x20fd5000
segment[1].memsz = 0x1673000
segment[2].buf   = 0x4ef88
segment[2].bufsz = 0x6043
segment[2].mem   = 0x2[   31.265096] sun7i-dwmac 830000.ethernet eth0: Link is Down
2648000
segment[2].memsz = 0x7000
main:1568 res=0
main:1582 res=0 do_exec=1
[   31.277297] kexec_core: Starting new kernel
[   31.282700] Disabling non-boot CPUs ...
[   31.692085] Bye!
C:0x200080C0-0x2044BAC0->0x20B80B00-0x20FC4500

Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E53C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55695206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZg/Dxnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHPW6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:58:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C029CC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:58:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u128so7293459pfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOXRNlotMI5ejPRaRNjrR3UNMaXtwDgX+TH3kgzT830=;
        b=PZg/DxnkJuKQ1KCn9MdungEdpFV+MuRitG1nVsyJpjtL8AvKy6rMIdovX3jvFgwF7B
         YT5HppMvjYu5CVIeqAKD6fGYbbk/V3eKB+bLbllazsoYLhBdZzGU6/jT1er+Dc1bpI84
         SqBIX4I+qVWkuDG2fcVEbI8ogZcnbXXkl7igHQInPSpWQJMFdeAe0NZLmPranK6NfW3j
         DvvymncirWRtVRTR+gRDu021mPSOpTluwDtZf5ZMv31HdhtiN3gOfD3xaH6FrUUhZiH/
         ru7AgSJU0kyCYOKwEXuC6x5Df9zMtEfFZEWEifZ967k/qHFg1YGtkGfPNaiRSZLTecz1
         dkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lOXRNlotMI5ejPRaRNjrR3UNMaXtwDgX+TH3kgzT830=;
        b=YHhJtWZNbJ9ntYYHS3eQflOG6sGLxdLxcEtv/ldJaFJhxKeOpNg1HHy1raXqyJVJsN
         DrUaMlpkZGrrxvd1O7sGDumeEpBJdIFKNxabPyoNMiCDByYEapHgHDWZzjyvywHcG8dt
         0ND7NavVwb73eIHcmnpzvWvvp3fgoiqRwZRifZOz0mCfjCzF4NSZeYXd9bKTPzxCTmk7
         uxRC9oKMap2s8eL3xe3QGy41s2JkN8F07w1NvENvsvcyYR0CiLCduvQuCkgao3Akuu5G
         FfhfsNh9UUB658UHOTIsij6MqafyfSNLI4sPEZLXN7NaVvF2ljW73NqCGr/TuoH36q0S
         fr5g==
X-Gm-Message-State: AOAM5304sf5ntUEcT/ItmhAx7mR44J685QIAw59ewDKsnL6i1pvxGFU1
        nhQnI/VoOW1eR4P6h7DyksssWDatoIw=
X-Google-Smtp-Source: ABdhPJzzRbdeiYRYWXOuQza0qTN13slBZpAdygb9PjOjJRMIi64GzaBpH1pbL+86qQuXC15TxY4ARg==
X-Received: by 2002:a05:6a00:15cb:: with SMTP id o11mr9273688pfu.263.1597618713193;
        Sun, 16 Aug 2020 15:58:33 -0700 (PDT)
Received: from debian (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id i72sm11743381pgc.70.2020.08.16.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:58:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 04:28:25 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re:..build stopped... Linux 5.9-rc1
Message-ID: <20200816225822.GA3222@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13:50 Sun 16 Aug 2020, Linus Torvalds wrote:
>This merge window felt a lot more normal than 5.8, and all the stats
>confirm thar it seems to be the usual size.
>
>The only thing that stands out is yet another AMD GPU header file
>drop, but by now that almost counts as "usual" too. It does mean that
>the diff stats are dominated by those AMD updates, and almost exactly
>half of the diff is under drivers/gpu/drm/amd/, but it's the usual big
>register definitions (presumably once more generated from the hw
>files) and doesn't really matter in the big picture.
>
>If you ignore that, stats look very normal. Even ignoring the AMD GPU
>updates, drivers are still about 60% of the patch, and it's all over.
>Outside of drivers, it's the usual mix of architecture updates,
>documentation, core networking, tooling and filesystem updates.
>
>"Normal size" is still obviously pretty big, so the appended is just
>my merge-log as usual. For details, dig down into whichever area
>excites you in the git tree...
>
>                      Linus
>

I am scared that I might have missed something very obvious ...am I?? And t=
he build abort...take a peek..

In file included from ./include/linux/scatterlist.h:9,
                 from ./include/linux/blkdev.h:25,
                 from ./include/linux/blk-cgroup.h:23,
                 from ./include/linux/writeback.h:14,
                 from ./include/linux/memcontrol.h:22,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
=2E/arch/x86/include/asm/io.h: In function =E2=80=98outb_p=E2=80=99:
=2E/arch/x86/include/asm/io.h:292:2: error: implicit declaration of functio=
n =E2=80=98slow_down_io=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  slow_down_io();       \
  ^~~~~~~~~~~~
=2E/arch/x86/include/asm/io.h:334:1: note: in expansion of macro =E2=80=98B=
UILDIO=E2=80=99
 BUILDIO(b, b, char)
 ^~~~~~~
In file included from ./arch/x86/include/asm/suspend_64.h:10,
                 from ./arch/x86/include/asm/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:19:
=2E/arch/x86/include/asm/desc.h: In function =E2=80=98__set_tss_desc=E2=80=
=99:
=2E/arch/x86/include/asm/desc.h:186:2: error: implicit declaration of funct=
ion =E2=80=98write_gdt_entry=E2=80=99; did you mean =E2=80=98find_get_entry=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  write_gdt_entry(d, entry, &tss, DESC_TSS);
  ^~~~~~~~~~~~~~~
  find_get_entry
=2E/arch/x86/include/asm/desc.h: In function =E2=80=98force_reload_TR=E2=80=
=99:
=2E/arch/x86/include/asm/desc.h:296:2: error: implicit declaration of funct=
ion =E2=80=98load_TR_desc=E2=80=99; did you mean =E2=80=98local_dec=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
  load_TR_desc();
  ^~~~~~~~~~~~
  local_dec
=2E/arch/x86/include/asm/desc.h: In function =E2=80=98clear_LDT=E2=80=99:
=2E/arch/x86/include/asm/desc.h:358:2: error: implicit declaration of funct=
ion =E2=80=98set_ldt=E2=80=99; did you mean =E2=80=98set_bit=E2=80=99? [-We=
rror=3Dimplicit-function-declaration]
  set_ldt(NULL, 0);
  ^~~~~~~
  set_bit
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Er=
ror 1

~Bhaskar
>---
>
>Al Viro (6):
>    ptrace regset updates
>    init and set_fs() cleanups
>    fdpick coredump update
>    mount leak fix
>    misc vfs updates
>    regset conversion fix
>
>Alex Williamson (1):
>    VFIO updates
>
>Alexandre Belloni (1):
>    RTC updates
>
>Andreas Gruenbacher (1):
>    gfs2 updates
>
>Andrew Morton (3):
>    misc updates
>    more updates
>    even more updates
>
>Andy Shevchenko (1):
>    x86 platform driver updates
>
>Arnaldo Carvalho de Melo (2):
>    perf tools updates
>    more perf tools updates
>
>Arnd Bergmann (5):
>    ARM defconfig updates
>    ARM SoC DT updates
>    ARM SoC updates
>    ARM SoC driver updates
>    new ARM SoC support
>
>Benson Leung (1):
>    chrome platform updates
>
>Bjorn Andersson (3):
>    rpmsg update
>    remoteproc updates
>    hwspinlock updates
>
>Bjorn Helgaas (1):
>    PCI updates
>
>Casey Schaufler (1):
>    smack updates
>
>Catalin Marinas (3):
>    arm64 and cross-arch updates
>    arm64 fixes
>    arm64 fix
>
>Christian Brauner (4):
>    thread updates
>    fork cleanups
>    checkpoint-restore updates
>    close_range() implementation
>
>Christoph Hellwig (2):
>    uuid update
>    dma-mapping updates
>
>Chuck Lever (1):
>    NFS server updates
>
>Corey Minyard (1):
>    IPMI updates
>
>Damien Le Moal (1):
>    zonefs update
>
>Daniel Lezcano (1):
>    thermal updates
>
>Darrick Wong (3):
>    iomap updates
>    xfs updates
>    xfs fixes
>
>Dave Airlie (2):
>    drm updates
>    drm fixes
>
>David Miller (2):
>    networking updates
>    networking fixes
>
>David Sterba (2):
>    btrfs updates
>    more btrfs updates
>
>David Teigland (1):
>    dlm updates
>
>Dmitry Torokhov (1):
>    input updates
>
>Dominique Martinet (1):
>    9p updates
>
>Eric Biederman (1):
>    execve updates
>
>Eric Biggers (2):
>    fscrypt updates
>    fsverity update
>
>Gao Xiang (1):
>    erofs updates
>
>Geert Uytterhoeven (1):
>    m68k updates
>
>Greg KH (5):
>    char/misc driver updates
>    driver core updates
>    USB/Thunderbolt updates
>    staging/IIO driver updates
>    tty/serial updates
>
>Greg Ungerer (1):
>    m68knommu updates
>
>Guenter Roeck (1):
>    hwmon updates
>
>Guo Ren (1):
>    arch/csky updates
>
>Heiko Carstens (2):
>    s390 updates
>    more s390 updates
>
>Helge Deller (2):
>    parisc updates
>    more parisc updates
>
>Herbert Xu (2):
>    crypto updates
>    crypto fix
>
>Ilya Dryomov (1):
>    ceph updates
>
>Ingo Molar (1):
>    x86 cpu updates
>
>Ingo Molnar (26):
>    irq fixes
>    debugobjects cleanup
>    header cleanup
>    RCU updates
>    locking updates
>    objtool updates
>    perf event updates
>    scheduler updates
>    x86/alternatives update
>    x86 asm updates
>    x86 boot updates
>    x86 build updates
>    x86 cleanups
>    x86 debug fixlets
>    x86 FPU selftest
>    x86 microcode update
>    x86 MSR filtering
>    x86 mmm update
>    x86 platform updates
>    x86 timer update
>    x86 RAS updates
>    sched/fifo updates
>    locking fixlets
>    perf fixes
>    scheduler fixes
>    x86 fixes
>
>Jaegeuk Kim (1):
>    f2fs updates
>
>James Bottomley (2):
>    SCSI updates
>    more SCSI updates
>
>James Morris (1):
>    security subsystem updates
>
>Jan Kara (2):
>    ext2, udf, reiserfs, quota cleanups and minor fixes
>    fsnotify updates
>
>Jarkko Sakkinen (1):
>    tpm updates
>
>Jason Gunthorpe (2):
>    hmm updates
>    rdma updates
>
>Jassi Brar (1):
>    mailbox updates
>
>Jeff Layton (1):
>    file locking fix
>
>Jens Axboe (6):
>    core block updates
>    io_uring updates
>    block driver updates
>    block stacking updates
>    block fixes
>    io_uring fixes
>
>Jessica Yu (1):
>    module updates
>
>Jiri Kosina (1):
>    HID updates
>
>Joerg Roedel (1):
>    iommu updates
>
>Jonathan Corbet (2):
>    documentation updates
>    documentation fixes
>
>Juergen Gross (2):
>    xen updates
>    more xen updates
>
>Julia Lawall (1):
>    coccinelle updates
>
>Kees Cook (8):
>    pstore update
>    gcc plugin updates
>    automatic variable initialization updates
>    tasklets API update
>    uninitialized_var() macro removal
>    seccomp updates
>    seccomp fix
>    sysfs module section fix
>
>Lee Jones (2):
>    backlight updates
>    MFD updates
>
>Linus Walleij (2):
>    GPIO updates
>    pin control updates
>
>Mark Brown (3):
>    regulator updates
>    spi updates
>    regmap updates
>
>Masahiro Yamada (2):
>    Kbuild updates
>    Kconfig updates
>
>Mauro Carvalho Chehab (1):
>    media updates
>
>Max Filippov (1):
>    Xtensa updates
>
>Michael Ellerman (2):
>    powerpc updates
>    powerpc fix
>
>Michael Tsirkin (1):
>    virtio updates
>
>Miguel Ojeda (1):
>    auxdisplay update
>
>Mike Marshall (1):
>    orangefs updates
>
>Mike Rapoport (1):
>    unicore32 removal
>
>Mike Snitzer (1):
>    device mapper updates
>
>Mimi Zohar (1):
>    integrity updates
>
>Miquel Raynal (1):
>    mtd updates
>
>Namjae Jeon (1):
>    exfat updates
>
>Palmer Dabbelt (2):
>    RISC-V updates
>    RISC-V fix
>
>Paolo Bonzini (2):
>    KVM updates
>    more KVM updates
>
>Paul Moore (2):
>    selinux updates
>    audit updates
>
>Pavel Machek (1):
>    LED updates
>
>Petr Mladek (2):
>    printk updates
>    livepatching updates
>
>Rafael Wysocki (5):
>    power management updates
>    ACPI updates
>    more power management updates
>    one more power management update
>    more ACPI updates
>
>Rich Felker (1):
>    arch/sh updates
>
>Richard Weinberger (2):
>    mtd fix
>    JFFS2, UBI and UBIFS updates
>
>Rob Herring (2):
>    Devicetree updates
>    devicetree fixes
>
>Russell King (1):
>    ARM updates
>
>Sebastian Reichel (1):
>    power supply and reset updates
>
>Shuah Khan (1):
>    kunit updates
>
>Stafford Horne (1):
>    OpenRISC updates
>
>Stephen Boyd (2):
>    clk updates
>    more clk updates
>
>Steve French (2):
>    cifs updates
>    cifs fixes
>
>Steven Rostedt (2):
>    tracing updates
>    ktest updates
>
>Takashi Iwai (2):
>    sound updates
>    sound fixes
>
>Thierry Reding (1):
>    pwm updates
>
>Thomas Bogendoerfer (1):
>    MIPS upates
>
>Thomas Gleixner (9):
>    irq updates
>    timer updates
>    generic kernel entry/exit code
>    x86 conversion to generic entry code
>    x86 fsgsbase
>    locking updates
>    irq fixes
>    more timer updates
>    timekeeping updates
>
>Tony Luck (2):
>    EDAC updates
>    edac fix
>
>Trond Myklebust (1):
>    NFS client updates
>
>Ulf Hansson (1):
>    MMC updates
>
>Vinod Koul (1):
>    dmaengine updates
>
>Vishal Verma (1):
>    libnvdimm updayes
>
>Wei Liu (2):
>    hyperv updates
>    hyper-v fixes
>
>Wim Van Sebroeck (1):
>    watchdog updates
>
>Wolfram Sang (1):
>    i2c updates

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl85ugsACgkQsjqdtxFL
KRU7Vwf+IsuvK+fNgLsCAreVdPnXmcpZdUDY7Xl9HLvaMnD4LO+FvbeQLPSTSTag
kznC+krtIwRfatTnZnijXWmQAx58nsEhiDB2I2CYBj/w7/LqQLY0gR5qzVuE7cYx
adOgn2WOUAN9yYsX6iy+NmLCeokuwC1EDesX6mqG0mSewcHbcJRaxMeao68U8ZCx
/p0WIoL0SttPvrszJ00eVGRCPz9uUUSzIY6J+DOYq9XM4fT99w+MPW8wOlolNGAa
2GCGIo2uTR4S6EM91vVBcbAd+ehU4LhYBuiDZr2z9R0crpMPnwOPB+zB1kNrqUdj
7NKkRBFAfJ3tuvYGPzU9h56E3nsaaw==
=lquD
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

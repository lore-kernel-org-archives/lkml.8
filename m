Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1532DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E9E2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592167471;
	bh=cYBAlyvekvqVJtv4GZpu81pbFUR7ABTm6SQiDtmKdi8=;
	h=From:Date:Subject:To:List-ID:From;
	b=XMy+rO9PAMiu0iSLAFuAyFCB9b1ta8rLdNzLnNVo42bXjNJ63V4jhpR9+GxmWwLb7
	 sixPSsmFcG5SF4UEDw0otXJEKWTKQl2ccs53RK2W69vxE1E5wpevlQez7WQZF54aN5
	 G3b7iroVR89pRqdeE8mumZ2GRdZfbcYcc27eCqHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgFNUoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgFNUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:44:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A0C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 13:44:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so16758849ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=JWiGHh85Vp2aOJC15SDiLEnNtIgQoR7n+vQ/phijqLo=;
        b=AxIN+9n7VNV/MPMf9h4BRU9uRyE7bamV6zKXHoehrqoNHXi++D9O8wP3PIh+stWdZA
         kBg1kJotmBeNTs7964ZX4Ge9CPTWbpvypaup0zHGEqrHjn6Fe5EYAW3hrd/1YMQsURga
         0RBpkp6UDggrjkppQXtx+mHkjdiIgeFco9waQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JWiGHh85Vp2aOJC15SDiLEnNtIgQoR7n+vQ/phijqLo=;
        b=Fg8dmjEN/grtaR3BjRP690YjXq6+O8WKOS/fF9cnfIaRw2a15er9eoCa8n/0oKEMlJ
         51eSk2Rky8pNIoB2qYJEGOYeVpz0GMmHFUjwKp67ukghdGNxfPcSCjl6p1HRuWiz1aOZ
         kEGQWwHn/afDIv0liJs9VaNcXyDm++T4nhnPzqnqEOV7iODy/hULttsWXzmBil3SkRES
         sHANuGNp6aqODyJ/IJrsSLtk9gI6SXEAisNt5Vu4aCoHPvFYvpG6ElRc//Y846/WDRMm
         1VhiGRzDEjFCHWi/vyxeSrQRu8XaByvTgejiQl/Vrb8BMRaBdVO5Z/boSryFygCAVnuE
         GzbA==
X-Gm-Message-State: AOAM531W7q3hIJl54LZMXbZIEgEk1BJ2a2iKCU+EvMibSvIOL3tTsL0k
        7kYkqco6uoCS1B767zLrkMFZbDHT/oI=
X-Google-Smtp-Source: ABdhPJzAE3FjlM4cr7VXxmSzN0uTlEy7HZf7n4SufN3Zq4bWgoskPkAH8V7JkmzYgWsU3H7rpyVNPQ==
X-Received: by 2002:a2e:1413:: with SMTP id u19mr11423215ljd.64.1592167466222;
        Sun, 14 Jun 2020 13:44:26 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b6sm459826lfe.28.2020.06.14.13.44.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 13:44:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x27so8303746lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 13:44:24 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr3019776lfl.152.1592167464253;
 Sun, 14 Jun 2020 13:44:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 13:44:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
Message-ID: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
Subject: Linux 5.8-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I didn't really expect this, but 5.8 looks to be one of our biggest
releases of all time.

As of -rc1, it's right up there with v4.9, which has long been our
biggest release by quite a bit in number of commits. Yes, 5.8-rc1 has
a couple fewer commits than 4.9-rc1 did, but in many ways it's a much
more comprehensive release despite that.

The 4.9 kernel was artificially big partly because of the greybus
subsystem that was merged in that release, but also because v4.8 had
had a longer rc series and thus there was more pent up development. In
5.8, we have no sign of those kinds of issues making the release
bigger - there's just simply a lot of development in there.

And there are other kernel releases that have had more new lines -
v4.12 ends up being the undisputed size champion in that regard,
simply because it had a _huge_ number of new lines due to lots of
register descriptions for the AMD GPU drivers. Other kernels have been
similarly big due to particular subsystems (v4.2 had another AMD GPU
driver line count bump, 2.6.29 had a big staging driver additions,
etc).

But again, 5.8 is up there with the best, despite not really having
any single thing that stands out. Yes, there's a couple of big driver
changes (habanalabs and atomisp) that are certainly part of it, but
it's not nearly as one-sided as some of the other historical big
releases have been.

The development is really all over the place: there's tons of fairly
fundamental core work and cleanups, but there is also lots of
filesystem work and obviously all the usual driver updates too. Plus
documentation and archiecture work.

In fact, while 5.8-rc1 is "up there with the best" when it comes to
both number of commits and number of new lines, it's actually the
outstanding champion when it comes to number of files changed.  And
again, that's not because of some single tree-wide simple scripting
thing (the kernels with lots of SPDX license line changes have a lot
of files changed), but simply because of lots and lots of development
work.

So in the 5.8 merge window we have modified about 20% of all the files
in the kernel source repository. That's really a fairly big
percentage, and while some of it _is_ scripted, on the whole it's
really just the same pattern: 5.8 has simply seen a lot of
development.

IOW, 5.8 looks big. Really big.

In pure numbers: over 14k non-merge commits (over 15k counting
merges),  ~800k new lines, and over 14 thousand files changed.

It's worth noting that despite the size, it doesn't necessarily look
like a particularly troublesome release at least so far. Yes, the pure
size made this merge window a bit more stressful than I like, because
I _really_ like to have a few days of calm at the end to look at some
of the pull requests in more detail. This time around that never
really happened. But I only really had two pull requests I ended up
wanting to go through in more detail, so it all worked out fine.

So the pure size of this merge window did make me (once again)
consider making it more of a hard rule that pull requests with new
features (as opposed to the second wave of pull requests with just
fixes) absolutely _have_ to come in during the first week of the merge
window, but honestly, _most_ of the pull requests did in fact do that.
No, not all, and it could have been a bit more organized, and maybe I
got snippy with somebody, but on the whole things were pretty smooth
despite the large size.

Famous last words. Let's see what happens during the rest of this release.

But at least right now, while 5.8 looks like a very large release, I
don't get the feeling that it's particularly troublesome.

Knock wood.

Appended is the merge-log as usual. If you didn't get the idea yet
(IT'S BIG!) the shortlog would be much too unwieldly, even more so
than usual.

              Linus

---

Al Viro (16):
    uaccess/csum updates
    uaccess/access_ok updates
    uaccess/readdir updates
    uaccess/__put-user updates
    uaccess/__copy_from_user updates
    uaccess/__copy_to_user updates
    uaccess/coredump updates
    vfs updates
    ia64 build regression fix
    splice updates
    comedi uaccess cleanups
    misc uaccess updates
    i915 uaccess updates
    sysctl fixes
    vfs fixes
    epoll update

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (7):
    updates
    more updates
    yet more updates
    still more updates
    even more updates
    some more updates
    updates

Andy Shevchenko (1):
    x86 platform driver updates

Anna Schumaker (1):
    NFS client updates

Arnaldo Carvalho de Melo (1):
    perf tooling updates

Arnd Bergmann (4):
    ARM SoC updates
    ARM defconfig updates
    ARM/SoC driver updates
    ARM devicetree updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Boris Brezillon (1):
    i3c update

Borislav Petkov (4):
    EDAC updates
    x86 microcode update
    x86 cache resource control updates
    READ_IMPLIES_EXEC changes

Bruce Fields (1):
    nfsd updates

Casey Schaufler (1):
    smack updates

Christian Brauner (1):
    thread updates

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping helpers

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    zonefs update

Dan Williams (1):
    libnvdimm updates

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (6):
    xfs updates
    DAX updates part one
    DAX updates part two
    DAX updates part three
    xfs fix
    iomap fix

Dave Airlie (4):
    drm updates
    drm fixes
    drm msm updates
    drm fixes

David Howells (4):
    keyring updates
    AFS updates
    AFS fixes
    notification queue

David Kleikamp (1):
    JFS update

David Miller (4):
    networking updates
    sparc updates
    networking fixes
    networking fixes

David Sterba (2):
    btrfs updates
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia updates

Dominique Martinet (1):
    9p update

Eric Biederman (4):
    proc updates
    execve updates
    proc fix
    proc fix

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB/PHY driver updates
    tty/serial driver updates
    staging/IIO driver updates
    driver core updates
    char/misc driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Helge Deller (1):
    parsic updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (16):
    kprobes updates
    RCU updates
    locking updates
    objtool updates
    perf updates
    EFI updates
    SMP updates
    x86 boot updates
    x86 build updates
    x86 cleanups
    x86 cpu updates
    x86 FPU updates
    x86 platform updates
    x86 vdso updates
    scheduler updates
    x86 mm updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

James Morris (1):
    lockdown update

Jan Kara (2):
    fsnotify updates
    ext2 and reiserfs cleanups

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    hmm updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi update

Jens Axboe (5):
    block updates
    block driver updates
    io_uring updates
    block fixes
    io_uring fixes

Jessica Yu (1):
    module updates

Jiri Kosina (2):
    HID updates
    livepatching updates

Joerg Roedel (2):
    iommu updates
    iommu driver directory structure cleanup

John Johansen (1):
    apparmor updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (1):
    pstore updates

Lee Jones (2):
    MFD updates
    backlight updates

Ley Foon Tan (1):
    nios2 update

Linus Walleij (2):
    GPIO updates
    pin control updates

Mark Brown (3):
    regmap updates
    spi updates
    regulator updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Matt Turner (1):
    alpha updates

Mauro Carvalho Chehab (2):
    media updates
    more media updates

Max Filippov (1):
    Xtensa updates

Micah Morton (1):
    SafeSetID update

Michael Ellerman (2):
    powerpc updates
    powerpc fix

Michael Tsirkin (1):
    virtio updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    overlayfs updates
    fuse updates

Mimi Zohar (2):
    integrity updates
    integrity fix

Namjae Jeon (1):
    exfat update

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (2):
    kvm updates
    more KVM updates

Paul Moore (2):
    audit updates
    SELinux updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    printk fix

Rafael Wysocki (5):
    power management updates
    ACPI updates
    PNP update
    more power management updates
    more ACPI updates

Rich Felker (1):
    arch/sh updates

Richard Weinberger (3):
    MTD updates
    UBI update
    UML updates

Rob Herring (2):
    devicetree updates
    Devicetree fixes

Russell King (2):
    ARM updates
    ARM fixes

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    kselftest updates
    Kunit updates

Stafford Horne (1):
    OpenRISC update

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    more cifs updates

Steven Rostedt (1):
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Tetsuo Handa (1):
    tomoyo update

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (10):
    irq updates
    timer updates
    x86 timer updates
    x86 srbds fixes
    timer fix
    more x86 updates
    atomics rework
    the Kernel Concurrency Sanitizer
    x86 entry updates
    x86 RAS updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (1):
    s390 updates

Vinod Koul (1):
    dmaengine updates

Wei Liu (1):
    hyper-v updates

Will Deacon (3):
    arm64 updates
    READ/WRITE_ONCE rework
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

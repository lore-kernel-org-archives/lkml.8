Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5DFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42020656
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gG8rSShq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDLUKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:10:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0DC0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:10:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m2so5116067lfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h/xo1DIPZ+/A/KGPGq5wZd14Nm4+Ob6KQ9hjw7rXChg=;
        b=gG8rSShqCXgR7aEPinormz3bBM2tgPi3y93xwWxRJfxu5Xi08zrIAhcqL5jmpo0bSa
         UJpAdYcyX/L3AM6KZsTlPlwEmGpJuU5wY3tiw6zPXZcySs7fb+nWEP3TVQedl5WFgTBi
         nj3u5zWBc6D54J6vEAeTxVYob1LolodG9hido=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h/xo1DIPZ+/A/KGPGq5wZd14Nm4+Ob6KQ9hjw7rXChg=;
        b=eB6TOFKXEsdqFkg7jeIFp/BrGHrEiDHsL3dettIIBGSoayb9ovX1wxen7gKtWyrEna
         /tVbWEKT8LYAxb1z0NZl9knIra5sZH6pX3NbDFxuySw/yD1bB5laJxxDeiVaP1P8/6IE
         UsptljkKQAfq/e1UMxkSDQ8cfpEMQZ7eYaqLp89WzCMFpDE7VXahtV5RZFkG7WUt2Gbq
         4XlYGGvsbspO9V5aKWv/VDHaLPKX5YeE+gbgcPukisLrVL1XNI2gY2hCAlZ5LvswB+yO
         hgJUv/oB8FjqtpI8SCxBVNNo5e4KqrUeH6U/u7RvWd7vqVlK9rhUA9cw75ojFz+EBvM3
         afxA==
X-Gm-Message-State: AGi0PubC3s0GthJgACGN9cpNY04bhvOtOqv3ntdykPk5NwifBp0w/mmv
        sWvtmF8baTBbAa2ciEbJ+Cblo7pvUVI=
X-Google-Smtp-Source: APiQypIXJTV+1qujN05tqZJyhysXW8mb3s9EzIdwx79bGPPwwcYSdb0vD6ntkTbAojd95O98SyQMjw==
X-Received: by 2002:ac2:551e:: with SMTP id j30mr8817755lfk.179.1586722206331;
        Sun, 12 Apr 2020 13:10:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t12sm6360713lfq.71.2020.04.12.13.10.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 13:10:05 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s13so5107451lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:10:05 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr2226755lfk.192.1586722204998;
 Sun, 12 Apr 2020 13:10:04 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Apr 2020 13:09:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0F0fnOQA3dr_-QCdjc_FTTk3ccPFLU33zr3zLD9FQ7Q@mail.gmail.com>
Message-ID: <CAHk-=wh0F0fnOQA3dr_-QCdjc_FTTk3ccPFLU33zr3zLD9FQ7Q@mail.gmail.com>
Subject: Linux 5.7-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday afternoon, and it's been two weeks since the merge window
opened, so here we are. Maybe an hour or two early, because it's
Easter Sunday, and I may be socially distancing but we're still doing
the usual Finnish Easter dinner with lamb, m=C3=A4mma and pasha... I may
not be religious, but tradition is tradition. Thanks to the social
distancing, this year we'll have to forgo trying to force-feed our
poor American friends m=C3=A4mma, which never really works out anyway. In
fact, I think I can hear the sighs of relief from miles away.

Back to the kernel.

Things looked pretty normal, in fact I felt things worked smoother
than they often do, with the bulk of the big pull requests all coming
in the first week, just the way I prefer it. Yes, I had a fair number
of pulls the second week too, but a lot of them were smaller
subsystems, or follow-ups, or fixes. Keeping people inside may have
helped.

That said, we did have a couple of hiccups due to linux-next not
having had some of the syzbot testing that it normally has, so
immediately when things hit my tree, a few alarm bells rang. That
certainly wasn't optimal. But it got sorted out quickly enough that it
didn't end up being all that painful, and hopefully we'll avoid the
lack of test coverage in the future. At least there's a cunning plan
for that. Knock wood.

And things look normal stat-wise. Not the biggest kernel, not the
smallest, and the distribution of patches looks fairly regular too:
about 60% drivers (all over - it's the merge window, after all) with
the rest being architecture updates (x86 and arm stand out, but
there's a little bit of everything), Documentation updates (more rst
conversions, but also just regular updates), filesystem work (pathname
lookup cleanups and the new exfat filesystem stand out), networking
and "misc core kernel" work.

As always, there's much too much new stuff to list with a shortlog, so
appended is my mergelog.

I did have a request from the kernel technical advisory board (aka
TAB) to mention that if anyone's had (or is predicting) disruptions to
their kernel work from COVID-19 that they'd like help solving (finding
backup maintainers, etc), the kernel TAB has offered to help however
they can. If this would be useful, please contact them at:
tab@lists.linux-foundation.org

Anything else?

Oh, yeah. Go test.

                 Linus

---

Al Viro (3):
    vfs pathwalk sanitizing
    exfat filesystem
    vfs pathwalk fix

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (3):
    updates
    more updates
    yet more updates

Andy Shevchenko (1):
    x86 platform driver updates

Arnd Bergmann (4):
    ARM SoC updates
    ARM driver updates
    ARM defconfig updates
    ARM devicetree updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    remoteproc updates
    hwspinlock updates

Bjorn Helgaas (1):
    pci updates

Bob Peterson (1):
    gfs2 updates

Boris Brezillon (1):
    i3c updates

Borislav Petkov (2):
    EDAC updates
    RAS updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (1):
    thread updates

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm and dax updates

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (5):
    iomap updates
    hibernation fix
    xfs updates
    iomap fix
    more xfs updates

Dave Airlie (4):
    drm updates
    drm hugepage support
    drm fixes
    more drm fixes

David Howells (1):
    keyrings fixes

David Miller (4):
    networking updates
    networking fixes
    IDE update
    sparc update

David Sterba (1):
    btrfs updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia updates

Dominique Martinet (2):
    9p updates
    9p documentation update

Eric Biederman (2):
    exec/proc updates
    proc fix

Eric Biggers (1):
    fscrypt updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    USB / PHY updates
    driver core updates
    staging and IIO driver updates
    tty/serial updates
    SPDX updates
    char/misc driver updates

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    csky updates

Helge Deller (1):
    parisc updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (14):
    objtool updates
    RCU updates
    EFI updates
    locking updates
    perf updates
    scheduler updates
    x86 boot updates
    x86 build updates
    x86 cleanups
    x86 fpu updates
    misc x86 updates
    x86 mm updates
    x86 vmware updates
    x86 fix

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

James Morris (1):
    security subsystem updates

Jan Kara (2):
    ext2/udf updates
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    hmm updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (7):
    libata updates
    block updates
    block driver updates
    io_uring updates
    io_uring fixes
    block fixes
    libata fixes

Jessica Yu (1):
    module updates

Jiri Kosina (2):
    trivial tree updates
    HID updates

Joerg Roedel (1):
    iommu updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (2):
    documentation updates
    Documentation fixes

Juergen Gross (2):
    xen updates
    more xen updates

Kees Cook (2):
    seccomp updates
    pstore updates

Lee Jones (2):
    backlight updates
    mfd updates

Ley Foon Tan (1):
    nios2 updates

Linus Walleij (2):
    pin control updates
    GPIO updates

Mark Brown (2):
    regma: update
    spi and regulator updates

Masahiro Yamada (2):
    Kbuild updates
    more Kbuild updates

Matthew Wilcox (1):
    XArray updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (2):
    powerpc updates
    more powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (2):
    device mapper updates
    device mapper fixes

Miklos Szeredi (1):
    overlayfs update

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    MTD updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul Moore (2):
    audit updates
    SELinux updates

Pavel Machek (1):
    LED updates

Rafael Wysocki (7):
    power management updates
    ACPI updates
    PNP subsystem updates
    more power management updates
    more ACPI updates
    yet more power management updates
    yet more ACPI updates

Richard Weinberger (2):
    UML updates
    UBI and UBIFS updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset changes

Shuah Khan (2):
    kselftest update
    kunit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (1):
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (2):
    ext4 updates
    /dev/random updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (15):
    irq updates
    core SMP updates
    NOHZ update
    timekeeping and timer updates
    x86 entry code updates
    x86 splitlock updates
    x86 timer updates
    irq fixes
    timer fixes
    more perf updates
    locking fixes
    perf fixes
    scheduler fixes/updates
    time(keeping) updates
    x86 fixes

Tony Luck (1):
    ia64 updates

Trond Myklebust (2):
    NFS client updates
    NFS client bugfix

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vineet Gupta (1):
    ARC updates

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

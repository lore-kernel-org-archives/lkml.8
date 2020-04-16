Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B125C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EF8206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lglq4zhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392705AbgDPRDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732667AbgDPRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:03:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C3C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:03:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r7so8564523ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbeLxo73NH77r68D3ullEkGVb9CgBQ2dP7I8rPq0gBs=;
        b=lglq4zhgkl9AFMiztMa/60ASuCavgd7BeXA1U/yykbdwX8EvR3U55v42PeKXS9/HjK
         U7pfVJciaVw3V1yhUfvwfi7XX18EnNu4VKtwdEMTWcf2lqatT/ghwWPMZq9wCxha1EE+
         7hEheLmvRDX9HxLAphuWGJBlR/7gfGSKyO8pnVRdA0RAUGTlwaz5t2hOykPCR/Uq5Fiq
         6vPevB89+ypqtYR+WWEj+moMOnu9ZjzncRc2LabOgoswbgurcZ1Mq6v7rzYgMf7LS7Fz
         HcakLEfNWcDGbahcoXgi6i9rD3biVQnWmvuivnfm2cXHWQUwTojpBQj7gWBhl3i0N1/t
         Qcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbeLxo73NH77r68D3ullEkGVb9CgBQ2dP7I8rPq0gBs=;
        b=Ya3pEu9fQNaai6J3uEbzv6hzXyRfF3wLr0nFt1TGfVn0t5nUxctsOrJOzg+rXsce05
         czGeTob5PiSj06VIG5AW0pB7QR2QD4heuYdgzdtXsFFfAdOsBLnu2THR/fAITKcT3HAz
         598xb4KAEj0Fv8BRAPCIOZ2tlWyKIWLZ/1cM/guRAE26bVJnKD5+22f4h/mvCYAghEVb
         9pQzG85MhzC8qBogdBn0RLtJ5Jl1rWdJQ95GGCjLgT/W+d74X3AdsdUB3/vS8txZdN47
         5JXNRSYRu1D070aLfWSmZVBo5Uud9QhKD4lpwF/LSmYnFtDhOZB05/TJLzY/po/a/SoY
         zLDg==
X-Gm-Message-State: AGi0Pubxlm6T/KtsHg0lyAhx6+QN0l3AE+drevBwE+QSYoVCSfNwg+bm
        ceTjWZF1BzGHUW/2/X6t4k7SSBPiBbcoQ6AlEax4sg==
X-Google-Smtp-Source: APiQypIgAYo0tcs0mvZyrFJ0IfPRE7Z5YfjzA0P0F0vr9dOwcIYigV95sjzKOcQ2uMBapEh8+yyey9Uer4dhCviCNLc=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr6819492ljo.168.1587056623096;
 Thu, 16 Apr 2020 10:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200406160914.14698-1-rminnich@google.com> <CACRpkdYVwFiCf5MJGLEyhxL8omxr9Tav=8Le_zEX-D89SXjV1Q@mail.gmail.com>
 <CAP6exY+pDg8rAi4RZw5s5jZh1awtWg6_Q5=tm6RYC4c+XZz+cQ@mail.gmail.com>
In-Reply-To: <CAP6exY+pDg8rAi4RZw5s5jZh1awtWg6_Q5=tm6RYC4c+XZz+cQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 19:03:31 +0200
Message-ID: <CACRpkdYVL+DtxgXk5F=jH8dPD=6qu=DbekOYZmTx9vu7L=MScw@mail.gmail.com>
Subject: Re: [PATCH] mtd: parsers: Support '[]' for id in mtdparts
To:     ron minnich <rminnich@gmail.com>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Ronald Minnich <rminnich@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 4:55 PM ron minnich <rminnich@gmail.com> wrote:
> On Thu, Apr 16, 2020 at 2:51 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > I suppose the use case is using PCI-based MTD devices for testing
> > something android images on desktops? I'm surprised it didn't
> > come up earlier.
>
> Thanks. In this case it's for systems that companies are deploying
> into their data centers, using linuxboot (linuxboot.org) and Intel
> chipsets. On Intel  chipsets, there is a 64 MiB SPI part, but only 16
> MiB is directly addressable.

Aha, now I get the use case.

> Linux goes in the memory-addressable part of the SPI, and UEFI loads
> it into RAM, since to UEFI the kernel is just another UEFI driver --
> in fact in most cases we replace the UEFI shell with Linux.
>
> But we need a file system, and with the huge amount of drivers that
> come with UEFI there's not much room in the top 16M. (we're working to
> fix that glitch, a process we call DXE-ectomy, but it takes time).
>
> We wish to place a file system in the low 48 MiB -- lots of room there.
>
> So what one can do is put a squashfs-formatted file system in that low
> part of SPI, and, using this mtdparts capability, point the kernel at
> it ("root=/dev/mtd1 mtdparts=[a:b.c]etc.etc"). It's a lifesaver for
> those of us using u-root for our userland.

This makes a lot of sense.

Something I have had ideas about upstreaming is the partition
splitter and automatic rootfs configuration from OpenWrt.
Is this something you would have an interest in for your type
of deployments?

I post some of my (never finished) commit text for your reference:

What the MTD partition splitter code does is to take a
partition, already covering an even number of erase blocks
in the flash, and subdivide it at erase block granularity
into sub-partitions.

This structure is created when the raw images are produced
during compilation of a system: scripts that are aware
of the geometry of the flash (such as erase block size)
will catenate the different parts into a compound
partition that can later be split.

The typical consituents of a split partition are:

 [kernel (z)Image]       "kernel"
 squashfs rootfs         "rootfs"
 JFFS2 writeable area    "rootfs_data"

In the simplified case only the squashfs and JFFS2 are
combined into one split partition, let's say this
partition is named "firmware" (a common convention).

The typical scenario for the above layout is:

- Begin compiling the flash image with the kernel image,
  pad that up to the end of the current erase block
- Catenate the squashfs and pad that up to the end of
  the current erase block
- Catenate a JFFS2 emtpy filesystem" marker at the
  beginning of the next erase block

When the splitter examines this, it will split this
"firmware" partition into a kernel partion, a
squashfs "rootfs" partition, and a partition with just
empty space named "rootfs_data", while still keeping
the overarching "firmware" partition in place.

When the kernel boots, it will mount the squashfs "rootfs"
partition as root filesystem, and then when the system
properly comes up mount the "rootfs_data" partition with
overlayfs so that the root filesystem becomes writeable,
while keeping all the read-only content in the squashfs
and all modifications in the JFFS2 partition.

This way all the available flash memory in the "firmware"
partition is used pretty optimally: "kernel" can grow
to the size it needs (such as a new kernel version taking
up more space) same for the squashfs "rootfs" after it.
Whatever remains after the kernel and the rootfs can be
used for storing data.

When the device kernel and rootfs needs to be upgraded,
it can simply unmount the filesystems and overwrite and
erase the "firmware" partition with the new version,
and the whole system is dynamically repartitioned with
the new images: if they grew over a flash block boundary
then the filesystem will be augmented upwards.

Yours,
Linus Walleij

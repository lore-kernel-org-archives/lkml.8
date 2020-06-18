Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0176207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgFRUTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:19:18 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46743 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFRUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:19:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id k13so4296564vsm.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSwSY8YJQIddJ59Vrp95WbPXR1QMxnWBM80612/bTbE=;
        b=DE+ukfd4xUqVOnGkKq5Y7ilLdjL+IRKIYLiXZB04jtJfNf5fdNhmUyEu2rEEHfZ3FD
         B4BriUOowRgRPQc32LdHKFVaEZl1qMNiYNKgszsUiqtGKanTORkKZC+yJTd4m0cexSro
         2Sm1XWkvqg5QfF5Ckeiw98FXCRgQwrlKIagsDKobsVYablSJJBPiLFPfIKcvp2GXadJ4
         0VnkIiMMWO9+3pQKu0bbPRvvaOyaWZqoKeMl0WlGldhPNC7ecDA5nLDk7u5meWCL2g1P
         yas51LfWvp54/j597XdPot+BUzKYcPy7zdyoc7tWaxM46+ZV4rOX3Q0AoILUPyBdsTlX
         QzWQ==
X-Gm-Message-State: AOAM5304uk5dsslETChKa/cZStScOaudG+NfDa7zvJZmmlgUcqiu+Zjs
        XYMGy+rhDWDNqClMNjPLEmKDgTMSh1GmR7n7PSQ=
X-Google-Smtp-Source: ABdhPJxxiADmycRfXrdHbDVvri9Z01+pfe+180opoCNTMkKQRieFT1HVfW4arAxR78ynemYMFpQ3OldW4Yi7x3AX38U=
X-Received: by 2002:a67:800f:: with SMTP id b15mr5034663vsd.220.1592511553876;
 Thu, 18 Jun 2020 13:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200618200106.GF27951@zn.tnic>
In-Reply-To: <20200618200106.GF27951@zn.tnic>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 18 Jun 2020 16:19:02 -0400
Message-ID: <CAKb7UviibvRfqJgtLkePEuXFa6mQfi4h=7eeW+YQxB-StVjjrA@mail.gmail.com>
Subject: Re: [Nouveau] 2dd4d163cd9c ("drm/nouveau: remove open-coded version
 of remove_conflicting_pci_framebuffers()")
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

There was a fixup to that patch that you'll also have to revert first
-- 7dbbdd37f2ae7dd4175ba3f86f4335c463b18403. I guess there's some
subtle difference between the old open-coded logic and the helper,
they were supposed to be identical.

Cheers,

  -ilia

On Thu, Jun 18, 2020 at 4:09 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> my test box won't boot 5.8-rc1 all the way but stops at
>
> ...
> fb0: switching to nouveaufb from EFI VGA
> <-- EOF
>
> I've bisected it to the commit in $Subject, see below. Unfortunately, it
> doesn't revert cleanly so I can't really do the final test of reverting
> it ontop of 5.8-rc1 to confirm that this one is really causing it.
>
> Any ideas?
>
> GPU is:
>
> [    5.678614] fb0: switching to nouveaufb from EFI VGA
> [    5.685577] Console: switching to colour dummy device 80x25
> [    5.691865] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
> [    5.814409] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
> [    5.823559] nouveau 0000:03:00.0: fb: 512 MiB DDR3
> [    6.096680] [TTM] Zone  kernel: Available graphics memory: 8158364 KiB
> [    6.103327] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    6.109951] [TTM] Initializing pool allocator
> [    6.114405] [TTM] Initializing DMA pool allocator
> [    6.119256] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
> [    6.124285] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
> [    6.129677] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
> [    6.135534] nouveau 0000:03:00.0: DRM: DCB version 4.0
> [    6.140755] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
> [    6.147273] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
> [    6.153782] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
> [    6.160292] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
> [    6.166810] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
> [    6.173306] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
> [    6.179829] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
> [    6.185553] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
> [    6.196145] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copies
> [    6.233659] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    6.311939] nouveau 0000:03:00.0: DRM: allocated 1920x1080 fb: 0x70000, bo (____ptrval____)
> [    6.320736] fbcon: nouveaudrmfb (fb0) is primary device
> [    6.392722] tsc: Refined TSC clocksource calibration: 3591.346 MHz
> [    6.392788] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33c46403b59, max_idle_ns: 440795293818 ns
> [    6.392930] clocksource: Switched to clocksource tsc
> [    6.509946] Console: switching to colour frame buffer device 240x67
> [    6.546287] nouveau 0000:03:00.0: fb0: nouveaudrmfb frame buffer device
> [    6.555021] [drm] Initialized nouveau 1.3.1 20120801 for 0000:03:00.0 on minor 0
>
> Thx.
>
> git bisect start
> # good: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
> git bisect good 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
> # bad: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
> git bisect bad b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> # bad: [ee01c4d72adffb7d424535adf630f2955748fa8b] Merge branch 'akpm' (patches from Andrew)
> git bisect bad ee01c4d72adffb7d424535adf630f2955748fa8b
> # bad: [16d91548d1057691979de4686693f0ff92f46000] Merge tag 'xfs-5.8-merge-8' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> git bisect bad 16d91548d1057691979de4686693f0ff92f46000
> # good: [cfa3b8068b09f25037146bfd5eed041b78878bee] Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> git bisect good cfa3b8068b09f25037146bfd5eed041b78878bee
> # good: [3fd911b69b3117e03181262fc19ae6c3ef6962ce] Merge tag 'drm-misc-next-2020-05-07' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect good 3fd911b69b3117e03181262fc19ae6c3ef6962ce
> # bad: [1966391fa576e1fb2701be8bcca197d8f72737b7] mm/migrate.c: attach_page_private already does the get_page
> git bisect bad 1966391fa576e1fb2701be8bcca197d8f72737b7
> # good: [43c8546bcd854806736d8a635a0d696504dd4c21] drm/amdgpu: Add a UAPI flag for user to call mem_sync
> git bisect good 43c8546bcd854806736d8a635a0d696504dd4c21
> # good: [6cf991611bc72c077f0cc64e23987341ad7ef41e] Merge tag 'drm-intel-next-2020-05-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
> git bisect good 6cf991611bc72c077f0cc64e23987341ad7ef41e
> # bad: [dc455f4c888365595c0a13da445e092422d55b8d] drm/nouveau/dispnv50: fix runtime pm imbalance on error
> git bisect bad dc455f4c888365595c0a13da445e092422d55b8d
> # bad: [2dd4d163cd9c15432524aa9863155bc03a821361] drm/nouveau: remove open-coded version of remove_conflicting_pci_framebuffers()
> git bisect bad 2dd4d163cd9c15432524aa9863155bc03a821361
> # good: [c41219fda6e04255c44d37fd2c0d898c1c46abf1] Merge tag 'drm-intel-next-fixes-2020-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
> git bisect good c41219fda6e04255c44d37fd2c0d898c1c46abf1
> # good: [fd44028ff145ffb2d03c877d74f479da04ac2c62] drm/nouveau/acr: ensure falcon providing acr functions is bootstrapped first
> git bisect good fd44028ff145ffb2d03c877d74f479da04ac2c62
> # good: [fa4f4c213f5f7807360c41f2501a3031a9940f3a] drm/nouveau/kms: Support NVIDIA format modifiers
> git bisect good fa4f4c213f5f7807360c41f2501a3031a9940f3a
> # good: [d2bcfce7f8a4ba8df28d3bebb81225bd7f9c046f] drm/nouveau/ibus: use nvkm_subdev_new_()
> git bisect good d2bcfce7f8a4ba8df28d3bebb81225bd7f9c046f
> # good: [fb172f5fe880cd0ddb4370b2fcc9ad4848c98bbb] drm/nouveau/gr/gk20a: move MODULE_FIRMWARE firmware definitions
> git bisect good fb172f5fe880cd0ddb4370b2fcc9ad4848c98bbb
> # first bad commit: [2dd4d163cd9c15432524aa9863155bc03a821361] drm/nouveau: remove open-coded version of remove_conflicting_pci_framebuffers()
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C499C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF4E207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bWCUkrrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgH2SgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:36:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F5C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:36:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x77so1404950lfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icLKDV8D8uy7RG9J3/pLpKnzDkPQio45tcIrc2kZq9Q=;
        b=bWCUkrrk2Gr2vrKrFoJRWmxmcHSwCcc/RSDvJnq/Ae/djf+FQT3l4VxQNXUVZPVBpd
         Virca7hu0T9GIjXyXseFx9Z6zr3I8MQIM0NjXjVnJ6R8hzK0mQHSlFbsEK9viHfYjB2c
         VulE0non3w6FKfzRJ5f46YbjfqO/yfVowUypSLgAUfa3WAQzsHqSU/8GMAioR/q6BWl3
         qDV8UPjepyZ1i1Jt9sZeGoiJIZxT0U5EaLpwMsNi7rTpr4T4BL8mwU/X7xZCwe/Jw9yI
         NPcMsVMdOd6JPjVSEXE/uZyOAhfutIQRuK9oIsdUJHkGOSHpw9TUFiFza8gle9cmeQFr
         zNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icLKDV8D8uy7RG9J3/pLpKnzDkPQio45tcIrc2kZq9Q=;
        b=EGYxx/lbnrnNVM3bB55Y3XnNbw0WKaQKWDWruvIR+WkxLqwlmsTVmwn/fLOERlj7PP
         THa1E9BL/J3JTOe+QsdinMTDKAiRafTPVYL+9vuVDNe1x0aRMotWB5EPO0x8LG6tsAXW
         d4eTJuXviytmyyhADGLTPwhuMqw+FLg9K9lDSFkkcOiSp8GX6nr0JkTDnimb5irqCAH8
         XZToszF9pgRT1GSUrfh2tjNluD9fmIlO3rL7MmnGlljhl67CIKmAlmgPfdLYhSHjcIR6
         dR2pYvcsw/WACey2D/8KktGLwyTwSXhnjenPxZEfLT5j3absURkkdfMQq4w/hquT2ZIa
         rdcg==
X-Gm-Message-State: AOAM5338qK01bWXS25DnPtPMD+ujRN2wPktyQW5htvTQk0D/EaG+FHfT
        gEZn0Y2eZ5W/9i8x0sb3VxC1XaplmGmecjrqDeEhtNsPKw==
X-Google-Smtp-Source: ABdhPJze0wbalBOnhxKkynPjaZs1iKM2h+2Rditv7AgVNQnWxGJRZTXwg7VnM0gpy8QXNuGygLO1vLMHGcjU8RIabeY=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr2096791lfn.94.1598726160312;
 Sat, 29 Aug 2020 11:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
 <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com> <20200829175735.GA16416@lst.de>
In-Reply-To: <20200829175735.GA16416@lst.de>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Sat, 29 Aug 2020 20:35:34 +0200
Message-ID: <CAEJqkgjz2wHAOVfHTw0V1fU8nOR70WZtuY9vJKywrUkJetC=TQ@mail.gmail.com>
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Exner <dex@dragonslave.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gabriel C <crazy@frugalware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 29. Aug. 2020 um 19:57 Uhr schrieb Christoph Hellwig <hch@lst.de>:
>
> On Sat, Aug 29, 2020 at 10:54:47AM -0700, Linus Torvalds wrote:
> > Just adding Christoph to the participants list, since at a guess it's
> > due to his changes whether they came from the nvme side or the dma
> > side..
> >
> > Christoph?
>
> This kinda looks like the sqsize regression we had in earlier 5.9-rc,
> but that should have been fixed in -rc2 with

git tag --contains 7442ddcedc344b6fa073692f165dffdd1889e780
returns nothing, that commit only exits in master, so probably in -rc3.

>
> 7442ddcedc344b6fa073692f165dffdd1889e780
> Author: John Garry <john.garry@huawei.com>
> Date:   Fri Aug 14 23:34:25 2020 +0800
>
>     nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth
>
> Daniel, can you double check that you don't have that commit?
>
> >
> >                   Linus
> >
> > On Sat, Aug 29, 2020 at 10:06 AM Daniel Exner <dex@dragonslave.de> wrote:
> > >
> > > Hi,
> > >
> > > (please keep me in the loop, as I'm currently not suscribed)
> > >
> > > both 5.9-rc1 and -rc2 fail to boot with my TOSHIBA-RD400 NVME:
> > >
> > > [    1.015590] ------------[ cut here ]------------
> > > [    1.015594] WARNING: CPU: 7 PID: 99 at mm/page_alloc.c:4864
> > > __alloc_pages_nodemask+0x299/0x330
> > > [    1.015594] Modules linked in: syscopyarea xhci_pci(+)
> > > xhci_pci_renesas sysfillrect xhci_hcd nvme aesni_intel(+) crypto_simd
> > > sysimgblt fb_sys_fops cryptd nvme_core t10_pi glue_helper drm hwmon
> > > scsi_mod agpgart i2c_core usbcore video wmi button dm_mirror
> > > dm_region_hash dm_log dm_mod unix ipv6 autofs4
> > > [    1.015602] CPU: 7 PID: 99 Comm: kworker/u16:1 Not tainted
> > > 5.9.0-rc2-dirty #12
> > > [    1.015603] Hardware name: To Be Filled By O.E.M. To Be Filled By
> > > O.E.M./Z170 Gaming K6, BIOS P7.50 10/18/2018
> > > [    1.015607] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> > > [    1.015608] RIP: 0010:__alloc_pages_nodemask+0x299/0x330
> > > [    1.015609] Code: 66 0f 85 46 ff ff ff e8 24 46 dd ff e9 3c ff ff ff
> > > e8 4b 4f fc ff 48 89 c7 e9 ad fe ff ff 81 e5 00 20 00 00 0f 85 7b ff ff
> > > ff <0f> 0b e9 74 ff ff ff 31 c0 e9 1b fe ff ff 65 48 8b 04 25 00 6d 01
> > > [    1.015610] RSP: 0000:ffffb3ed002abcb8 EFLAGS: 00010246
> > > [    1.015611] RAX: 0000000000000000 RBX: ffff9c8e827c4118 RCX:
> > > 0000000000000000
> > > [    1.015611] RDX: 0000000000000000 RSI: 0000000000000034 RDI:
> > > 0000000000000cc0
> > > [    1.015612] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > > ffffffffffffffff
> > > [    1.015612] R10: 0000000000000006 R11: ffffb3ee002abb97 R12:
> > > 0000000000000000
> > > [    1.015613] R13: 0000000000000000 R14: ffff9c8e921060b0 R15:
> > > 0000000000000cc0
> > > [    1.015614] FS:  0000000000000000(0000) GS:ffff9c8e96bc0000(0000)
> > > knlGS:0000000000000000
> > > [    1.015615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    1.015615] CR2: 0000559988e2f4d8 CR3: 00000008433e4004 CR4:
> > > 00000000003706e0
> > > [    1.015616] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > 0000000000000000
> > > [    1.015617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > 0000000000000400
> > > [    1.015617] Call Trace:
> > > [    1.015621]  dma_direct_alloc_pages+0x1e9/0x2c0
> > > [    1.015623]  ? pci_alloc_irq_vectors_affinity+0xa5/0x100
> > > [    1.015626]  nvme_alloc_queue+0x10a/0x170 [nvme]
> > > [    1.015629]  nvme_reset_work+0x70b/0x12b0 [nvme]
> > > [    1.015631]  ? nvme_irq_check+0x30/0x30 [nvme]
> > > [    1.015634]  process_one_work+0x1da/0x3d0
> > > [    1.015636]  worker_thread+0x4a/0x3c0
> > > [    1.015637]  ? process_one_work+0x3d0/0x3d0
> > > [    1.015638]  kthread+0x114/0x160
> > > [    1.015640]  ? kthread_park+0x90/0x90
> > > [    1.015641]  ret_from_fork+0x22/0x30
> > > [    1.015643] ---[ end trace 268d4f4db1ef121e ]---
> > >
> > >
> > > Resulting in:
> > > [    1.015644] nvme nvme0: Removing after probe failure status: -12
> > >
> > > If you need more infos I can try to provide them.
> > >
> > > Greetings
> > > Daniel
> > >
> > >
> > >
> ---end quoted text---

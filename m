Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7043C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D060A2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgH2R5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:57:40 -0400
Received: from verein.lst.de ([213.95.11.211]:44941 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgH2R5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:57:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 076EB68C4E; Sat, 29 Aug 2020 19:57:36 +0200 (CEST)
Date:   Sat, 29 Aug 2020 19:57:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Exner <dex@dragonslave.de>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        crazy@frugalware.org
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
Message-ID: <20200829175735.GA16416@lst.de>
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de> <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 10:54:47AM -0700, Linus Torvalds wrote:
> Just adding Christoph to the participants list, since at a guess it's
> due to his changes whether they came from the nvme side or the dma
> side..
> 
> Christoph?

This kinda looks like the sqsize regression we had in earlier 5.9-rc,
but that should have been fixed in -rc2 with

7442ddcedc344b6fa073692f165dffdd1889e780
Author: John Garry <john.garry@huawei.com>
Date:   Fri Aug 14 23:34:25 2020 +0800

    nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth

Daniel, can you double check that you don't have that commit?

> 
>                   Linus
> 
> On Sat, Aug 29, 2020 at 10:06 AM Daniel Exner <dex@dragonslave.de> wrote:
> >
> > Hi,
> >
> > (please keep me in the loop, as I'm currently not suscribed)
> >
> > both 5.9-rc1 and -rc2 fail to boot with my TOSHIBA-RD400 NVME:
> >
> > [    1.015590] ------------[ cut here ]------------
> > [    1.015594] WARNING: CPU: 7 PID: 99 at mm/page_alloc.c:4864
> > __alloc_pages_nodemask+0x299/0x330
> > [    1.015594] Modules linked in: syscopyarea xhci_pci(+)
> > xhci_pci_renesas sysfillrect xhci_hcd nvme aesni_intel(+) crypto_simd
> > sysimgblt fb_sys_fops cryptd nvme_core t10_pi glue_helper drm hwmon
> > scsi_mod agpgart i2c_core usbcore video wmi button dm_mirror
> > dm_region_hash dm_log dm_mod unix ipv6 autofs4
> > [    1.015602] CPU: 7 PID: 99 Comm: kworker/u16:1 Not tainted
> > 5.9.0-rc2-dirty #12
> > [    1.015603] Hardware name: To Be Filled By O.E.M. To Be Filled By
> > O.E.M./Z170 Gaming K6, BIOS P7.50 10/18/2018
> > [    1.015607] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> > [    1.015608] RIP: 0010:__alloc_pages_nodemask+0x299/0x330
> > [    1.015609] Code: 66 0f 85 46 ff ff ff e8 24 46 dd ff e9 3c ff ff ff
> > e8 4b 4f fc ff 48 89 c7 e9 ad fe ff ff 81 e5 00 20 00 00 0f 85 7b ff ff
> > ff <0f> 0b e9 74 ff ff ff 31 c0 e9 1b fe ff ff 65 48 8b 04 25 00 6d 01
> > [    1.015610] RSP: 0000:ffffb3ed002abcb8 EFLAGS: 00010246
> > [    1.015611] RAX: 0000000000000000 RBX: ffff9c8e827c4118 RCX:
> > 0000000000000000
> > [    1.015611] RDX: 0000000000000000 RSI: 0000000000000034 RDI:
> > 0000000000000cc0
> > [    1.015612] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > ffffffffffffffff
> > [    1.015612] R10: 0000000000000006 R11: ffffb3ee002abb97 R12:
> > 0000000000000000
> > [    1.015613] R13: 0000000000000000 R14: ffff9c8e921060b0 R15:
> > 0000000000000cc0
> > [    1.015614] FS:  0000000000000000(0000) GS:ffff9c8e96bc0000(0000)
> > knlGS:0000000000000000
> > [    1.015615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.015615] CR2: 0000559988e2f4d8 CR3: 00000008433e4004 CR4:
> > 00000000003706e0
> > [    1.015616] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [    1.015617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [    1.015617] Call Trace:
> > [    1.015621]  dma_direct_alloc_pages+0x1e9/0x2c0
> > [    1.015623]  ? pci_alloc_irq_vectors_affinity+0xa5/0x100
> > [    1.015626]  nvme_alloc_queue+0x10a/0x170 [nvme]
> > [    1.015629]  nvme_reset_work+0x70b/0x12b0 [nvme]
> > [    1.015631]  ? nvme_irq_check+0x30/0x30 [nvme]
> > [    1.015634]  process_one_work+0x1da/0x3d0
> > [    1.015636]  worker_thread+0x4a/0x3c0
> > [    1.015637]  ? process_one_work+0x3d0/0x3d0
> > [    1.015638]  kthread+0x114/0x160
> > [    1.015640]  ? kthread_park+0x90/0x90
> > [    1.015641]  ret_from_fork+0x22/0x30
> > [    1.015643] ---[ end trace 268d4f4db1ef121e ]---
> >
> >
> > Resulting in:
> > [    1.015644] nvme nvme0: Removing after probe failure status: -12
> >
> > If you need more infos I can try to provide them.
> >
> > Greetings
> > Daniel
> >
> >
> >
---end quoted text---

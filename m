Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC3C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD321204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598723711;
	bh=BGJZlXwn4CCLBtt8khRqtqmmfbY6SyXTytafW0FFu0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rSjaspmjl3V8272+RP9WYgYyyvyhsT/QkwK6K2oB08Pf4NCMjTFxEkj4MChFS4H5i
	 5W7wggUIxgFoeeNRl9eMtZCKeSAgovOdYP4TZH+dFTWUVHeqUa96TWsx58Hdg/Emf5
	 o1LW1PmWrJaxeZrkdIusrLM2BEGG9KII+fBuy1IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgH2RzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgH2RzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:55:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0968C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:55:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so2303302ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTWvNY56gqlA8wKXcW9AXFAxtItYK614cQxD1T0zFHw=;
        b=ALF1fzHu/ArCUgGW+gpE09S+ummMSP9BqvOV63UoyhiKvSNRe9Xx0xaOohRAuG4biL
         XgeJKSPnR484JrlsuoIO43ToJSPCc8L3HfhadupW1dnSeT6t/WKVNYAgMajinr0EmfDW
         +h3VX+qzEhDPMDUvdxyNTXSMndrzN+MBBcOsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTWvNY56gqlA8wKXcW9AXFAxtItYK614cQxD1T0zFHw=;
        b=oWjzfRWl1D5Wd89Fg06iq2zTQnUSGy4YFRb3ayFNx9o/ahkojb3yAW/VRg/vFIYsbJ
         ksjOP8FW5f65/QlMMQO+JqpYPjnd0DjwuPWO0pF3nwIVzGpccYczMmomx/SyfsTRge+v
         z28e1u00CpIZATc0nxDTx3EMGf98OrGjHAObj11bGsTdbEZCjdBL4LFIMTeqPxngEo5/
         nsUlPOJL2CEM9VS1slp7cD/BjY8vm4B3wjYYWX+Bv472rK8oHtZKM2g+BxsULTuzxH8A
         VFFxcqVqwNNCZ+hgIRnQzUaTkpsTfc4JUX8ym6ncxmnMTXFsNE5HnszBocjo4HTZkqA4
         sWjQ==
X-Gm-Message-State: AOAM53197aqYLdM8JIk94WAeZxWXrqbF7V7kEypFLA1a4PAQIZpFgHtN
        W9O8ElavBFnbUCQDNz082SHhPxb8lSGHtw==
X-Google-Smtp-Source: ABdhPJxhO2l/RFRwSYXfWfJSNsPJnkeQBszd9MCEAv/DFAPrhfEMRsPANk4wVDtingV9SLRFKstkhw==
X-Received: by 2002:a2e:90d6:: with SMTP id o22mr1773384ljg.71.1598723705322;
        Sat, 29 Aug 2020 10:55:05 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t13sm759471lfg.53.2020.08.29.10.55.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 10:55:04 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 12so1346174lfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:55:03 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr2024311lfl.30.1598723703483;
 Sat, 29 Aug 2020 10:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
In-Reply-To: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Aug 2020 10:54:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
Message-ID: <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
To:     Daniel Exner <dex@dragonslave.de>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        crazy@frugalware.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just adding Christoph to the participants list, since at a guess it's
due to his changes whether they came from the nvme side or the dma
side..

Christoph?

                  Linus

On Sat, Aug 29, 2020 at 10:06 AM Daniel Exner <dex@dragonslave.de> wrote:
>
> Hi,
>
> (please keep me in the loop, as I'm currently not suscribed)
>
> both 5.9-rc1 and -rc2 fail to boot with my TOSHIBA-RD400 NVME:
>
> [    1.015590] ------------[ cut here ]------------
> [    1.015594] WARNING: CPU: 7 PID: 99 at mm/page_alloc.c:4864
> __alloc_pages_nodemask+0x299/0x330
> [    1.015594] Modules linked in: syscopyarea xhci_pci(+)
> xhci_pci_renesas sysfillrect xhci_hcd nvme aesni_intel(+) crypto_simd
> sysimgblt fb_sys_fops cryptd nvme_core t10_pi glue_helper drm hwmon
> scsi_mod agpgart i2c_core usbcore video wmi button dm_mirror
> dm_region_hash dm_log dm_mod unix ipv6 autofs4
> [    1.015602] CPU: 7 PID: 99 Comm: kworker/u16:1 Not tainted
> 5.9.0-rc2-dirty #12
> [    1.015603] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./Z170 Gaming K6, BIOS P7.50 10/18/2018
> [    1.015607] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> [    1.015608] RIP: 0010:__alloc_pages_nodemask+0x299/0x330
> [    1.015609] Code: 66 0f 85 46 ff ff ff e8 24 46 dd ff e9 3c ff ff ff
> e8 4b 4f fc ff 48 89 c7 e9 ad fe ff ff 81 e5 00 20 00 00 0f 85 7b ff ff
> ff <0f> 0b e9 74 ff ff ff 31 c0 e9 1b fe ff ff 65 48 8b 04 25 00 6d 01
> [    1.015610] RSP: 0000:ffffb3ed002abcb8 EFLAGS: 00010246
> [    1.015611] RAX: 0000000000000000 RBX: ffff9c8e827c4118 RCX:
> 0000000000000000
> [    1.015611] RDX: 0000000000000000 RSI: 0000000000000034 RDI:
> 0000000000000cc0
> [    1.015612] RBP: 0000000000000000 R08: 0000000000000000 R09:
> ffffffffffffffff
> [    1.015612] R10: 0000000000000006 R11: ffffb3ee002abb97 R12:
> 0000000000000000
> [    1.015613] R13: 0000000000000000 R14: ffff9c8e921060b0 R15:
> 0000000000000cc0
> [    1.015614] FS:  0000000000000000(0000) GS:ffff9c8e96bc0000(0000)
> knlGS:0000000000000000
> [    1.015615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.015615] CR2: 0000559988e2f4d8 CR3: 00000008433e4004 CR4:
> 00000000003706e0
> [    1.015616] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    1.015617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    1.015617] Call Trace:
> [    1.015621]  dma_direct_alloc_pages+0x1e9/0x2c0
> [    1.015623]  ? pci_alloc_irq_vectors_affinity+0xa5/0x100
> [    1.015626]  nvme_alloc_queue+0x10a/0x170 [nvme]
> [    1.015629]  nvme_reset_work+0x70b/0x12b0 [nvme]
> [    1.015631]  ? nvme_irq_check+0x30/0x30 [nvme]
> [    1.015634]  process_one_work+0x1da/0x3d0
> [    1.015636]  worker_thread+0x4a/0x3c0
> [    1.015637]  ? process_one_work+0x3d0/0x3d0
> [    1.015638]  kthread+0x114/0x160
> [    1.015640]  ? kthread_park+0x90/0x90
> [    1.015641]  ret_from_fork+0x22/0x30
> [    1.015643] ---[ end trace 268d4f4db1ef121e ]---
>
>
> Resulting in:
> [    1.015644] nvme nvme0: Removing after probe failure status: -12
>
> If you need more infos I can try to provide them.
>
> Greetings
> Daniel
>
>
>

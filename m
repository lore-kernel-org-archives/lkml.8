Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A4C22527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsZoRHSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgA0VpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:45:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39041 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0VpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:45:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so9550580qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4TngApiMU3Ggk82EVjVUYHpRuc+h+FvC9YbID07SdBM=;
        b=NsZoRHSSGnAGb8b3mytFOgWJMmcPG8iIs3RfTcK3FBZTL2g72gZI1mV7UzCKeYYDnH
         ZphVWyxB4FuD4+Y3H3D8Vcs4wUANah09Vj6lgghkV0waN9UqZocNttbZqlsJUKM1o/Xx
         87LGaRd0a/ldNQQWXjWuSreBJfmlZdoUbedKemPGXWAfCSK0iVcFMPuP41VUey3AsI7i
         5NhN4bLrq5B0fzZdh58cuOGSHuvySdR7ORJ47lZU9j4QhihC6Dn51bDb0XnMMFtk6RLa
         PoPfhYGqWxfCcwmr3RugbKYtVVI/r/P1EqAsgGHpTgfdEsYuvtP2dnVQmvMATpBuQFGH
         wMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4TngApiMU3Ggk82EVjVUYHpRuc+h+FvC9YbID07SdBM=;
        b=WTL9/M2Tl8wj9jpcOGkuEpAKX99ygdBWZ0+99vXWml4VnNRd2rsgMqRzIHZeYHvflC
         22PZ9E7eqy6/xz1oZkvXnykanXnn2vm3xDGxsCioAprXgb149Q8nf4QuG9RzOfHXzh5o
         xUk5OsEGIDBx3mbthZDglRAIicjM57H8WMRv+Inq06dFni+B7CzKR9L7BW4DxqdPrXEo
         l0GEHlkk8P05csxTrYYM7Xwu4D/nsCKBKQoyyz7NCLvzVb/Sp9ij2UcOSGU4u/RfCB9N
         sDm9JyFdK1cJHF1MMIqAJAD7fesiWZF00OBv13XFMzW5gNsdGUlGm+fCoKofH9SdS2pb
         FwwQ==
X-Gm-Message-State: APjAAAV3Yw6aU7bRlaa5jMShQICdwahcxlezf0nUkBDyiDv4B8tw8NNP
        1yDm0uaW3SOm9p6d9diYFy2I8KoYXvGZBzsG9seWhR3qT3k=
X-Google-Smtp-Source: APXvYqwClzg99Hr7ZZnQ9e1NsfHB5b0VOFtGR99+k1QDjCe59mjCVJKC1msW6MTU7QVzmi37sGNKgHDDv4762n75vVI=
X-Received: by 2002:a37:a558:: with SMTP id o85mr19344534qke.435.1580161498458;
 Mon, 27 Jan 2020 13:44:58 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZsZaT1vYdyb0n=MeXj4Wge+8a88XDO8yvJ36bPYEUyUXw@mail.gmail.com>
In-Reply-To: <CAA85sZsZaT1vYdyb0n=MeXj4Wge+8a88XDO8yvJ36bPYEUyUXw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 27 Jan 2020 22:44:47 +0100
Message-ID: <CAA85sZtoW7c94+w6+2xmNrS8YchnDYrgm0rLJ8N3pe03S56dPw@mail.gmail.com>
Subject: Re: [5.5] new issue with RoCE
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And it went boom!

On Mon, Jan 27, 2020 at 10:38 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Hi, Since updating to 5.5 I've hit a new issue - testing mlx5 cards from work =)
>
> On client. multiple:
> [ 1546.585378] ------------[ cut here ]------------
> [ 1546.585386] WARNING: CPU: 3 PID: 4576 at
> drivers/iommu/dma-iommu.c:471 __iommu_dma_unmap+0x10a/0x120
> [ 1546.585386] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs mlx5_ib
> amdgpu chaoskey mfd_core gpu_sched ttm mlx5_core sp5100_tco ccp
> rpcrdma ib_ipoib
> [ 1546.585394] CPU: 3 PID: 4576 Comm: kworker/3:1H Not tainted 5.5.0 #248
> [ 1546.585395] Hardware name: System manufacturer System Product
> Name/Pro WS X570-ACE, BIOS 1201 11/18/2019
> [ 1546.585398] Workqueue: ib-comp-wq ib_cq_poll_work
> [ 1546.585401] RIP: 0010:__iommu_dma_unmap+0x10a/0x120
> [ 1546.585402] Code: c0 74 0b 48 89 e6 4c 89 f7 e8 e2 b2 9b 00 48 c7
> 44 24 08 00 00 00 00 48 c7 44 24 10 00 00 00 00 48 c7 04 24 ff ff ff
> ff eb 90 <0f> 0b eb 82 e8 cd 3f 93 ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 66 90
> [ 1546.585403] RSP: 0018:ffffa1e188c97da8 EFLAGS: 00010206
> [ 1546.585405] RAX: 0000000000004000 RBX: 0000000000003000 RCX: 0000000000000001
> [ 1546.585405] RDX: 0000000000000002 RSI: ffffffffffffe000 RDI: ffffa1e188c97d18
> [ 1546.585406] RBP: ffffffff00000000 R08: ffff8a0d8794e010 R09: 0000000000002000
> [ 1546.585407] R10: 0000000000000001 R11: 000ffffffffff000 R12: 0000000000003000
> [ 1546.585407] R13: ffff8a0ff3ce6000 R14: ffff8a0ff98a7620 R15: ffff8a0dcd11a000
> [ 1546.585409] FS:  0000000000000000(0000) GS:ffff8a0ffeac0000(0000)
> knlGS:0000000000000000
> [ 1546.585410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1546.585410] CR2: 00007f7473740000 CR3: 000000074371a000 CR4: 0000000000340ee0
> [ 1546.585411] Call Trace:
> [ 1546.585426]  rpcrdma_mr_put+0x11b/0x120 [rpcrdma]
> [ 1546.585429]  __ib_process_cq+0x76/0xd0
> [ 1546.585430]  ib_cq_poll_work+0x34/0xc0
> [ 1546.585433]  process_one_work+0x1e2/0x3c0
> [ 1546.585436]  worker_thread+0x4a/0x3d0
> [ 1546.585438]  kthread+0xfb/0x130
> [ 1546.585440]  ? process_one_work+0x3c0/0x3c0
> [ 1546.585441]  ? kthread_park+0x90/0x90
> [ 1546.585443]  ret_from_fork+0x22/0x40
> [ 1546.585446] ---[ end trace edc64661ebf52144 ]---
>
> On server, multiple:
> [ 1141.838449] infiniband mlx5_1: dump_cqe:270:(pid 715): dump error cqe
> [ 1141.838463] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 1141.838469] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 1141.838475] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 1141.838481] 00000030: 00 00 00 00 00 00 88 13 08 00 09 57 2c 66 e0 d2
> (pid increasing and last bytes seems to increase as well)
>
> No error from a user perspective... yet though...

Ended up with:
[ 1986.986757] kernel BUG at lib/sg_pool.c:116!
[ 1986.986770] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1986.986778] CPU: 14 PID: 1488 Comm: nfsd Tainted: G           O
 5.5.0 #244
[ 1986.986785] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./X370 Taichi, BIOS P5.60 06/27/2019
[ 1986.986797] RIP: 0010:sg_alloc_table_chained+0x6a/0xa0
[ 1986.986804] Code: e8 5b b4 f8 ff 85 c0 75 23 48 83 c4 10 5d 41 5c
c3 45 31 e4 31 d2 eb cc 89 77 0c 89 77 08 48 8b 3f e8 0a b4 f8 ff 31
c0 eb df <0f> 0b 44 3b 65 0c 73 d7 48 c7 c1 b0 5f 67 af 44 89 e2 be 80
00 00
[ 1986.986817] RSP: 0018:ffffaee183737d80 EFLAGS: 00010246
[ 1986.986823] RAX: 0000000080000000 RBX: ffffa33fb76bc678 RCX: 0000000000000080
[ 1986.986829] RDX: ffffa33f1b07a078 RSI: 0000000000000000 RDI: ffffa33f1b07a068
[ 1986.986834] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1986.986839] R10: 000000031d2f5000 R11: ffffa33edd250010 R12: ffffa33f1b07a000
[ 1986.986844] R13: ffffa33fb76bc670 R14: ffffa33f1b08f000 R15: ffffa33f2534e000
[ 1986.986849] FS:  0000000000000000(0000) GS:ffffa33fdeb80000(0000)
knlGS:0000000000000000
[ 1986.986855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1986.986859] CR2: 00007f1261c03ecc CR3: 00000003d5b9a000 CR4: 00000000003406e0
[ 1986.986864] Call Trace:
[ 1986.986873]  svc_rdma_get_rw_ctxt+0xb7/0xf0 [rpcrdma]
[ 1986.986880]  svc_rdma_build_read_chunk+0x88/0x270 [rpcrdma]
[ 1986.986887]  svc_rdma_recv_read_chunk+0x1bc/0x270 [rpcrdma]
[ 1986.987236]  ? schedule_timeout+0x172/0x2c0
[ 1986.987737]  svc_rdma_recvfrom+0x520/0x620 [rpcrdma]
[ 1986.988406]  svc_recv+0x62b/0x790
[ 1986.989067]  ? svc_xprt_release+0xb1/0xf0
[ 1986.989726]  nfsd+0xd5/0x140
[ 1986.990374]  kthread+0xf1/0x130
[ 1986.991022]  ? nfsd_destroy+0x80/0x80
[ 1986.991668]  ? kthread_park+0x80/0x80
[ 1986.992310]  ret_from_fork+0x22/0x40
[ 1986.992941] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm mlx5_ib
ib_uverbs ib_core chaoskey mlx5_core ixgbe igb ccp mdio btrfs
[ 1986.993623] ---[ end trace 265c4eaf19cfe871 ]---
[ 1986.994264] RIP: 0010:sg_alloc_table_chained+0x6a/0xa0
[ 1986.994914] Code: e8 5b b4 f8 ff 85 c0 75 23 48 83 c4 10 5d 41 5c
c3 45 31 e4 31 d2 eb cc 89 77 0c 89 77 08 48 8b 3f e8 0a b4 f8 ff 31
c0 eb df <0f> 0b 44 3b 65 0c 73 d7 48 c7 c1 b0 5f 67 af 44 89 e2 be 80
00 00
[ 1986.995650] RSP: 0018:ffffaee183737d80 EFLAGS: 00010246
[ 1986.996366] RAX: 0000000080000000 RBX: ffffa33fb76bc678 RCX: 0000000000000080
[ 1986.997072] RDX: ffffa33f1b07a078 RSI: 0000000000000000 RDI: ffffa33f1b07a068
[ 1986.997800] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1986.998503] R10: 000000031d2f5000 R11: ffffa33edd250010 R12: ffffa33f1b07a000
[ 1986.999192] R13: ffffa33fb76bc670 R14: ffffa33f1b08f000 R15: ffffa33f2534e000
[ 1986.999889] FS:  0000000000000000(0000) GS:ffffa33fdeb80000(0000)
knlGS:0000000000000000
[ 1987.000589] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1987.001293] CR2: 00007f1261c03ecc CR3: 00000003d5b9a000 CR4: 00000000003406e0

Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35951C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0600622527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB01MG2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0Vil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:38:41 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44917 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Vil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:38:41 -0500
Received: by mail-qt1-f181.google.com with SMTP id w8so8619649qts.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gteg+LRHEQ6WvPtBTR5Cz8934VfzcQRBaiqPpyJWENU=;
        b=aB01MG2dfMwOK38q/2fHUyClLJk3TaFLf9N3YYhTtAiIlLk5iDLp3ji/aC0F8pSl5o
         wV8TNRARkGkaM/7sKWP4y6LQXg7uGfHhLb+aJHRrcIXIZ79mk8JQZlr06VN9TGcc6l5f
         wJqK8HzMXmRbeo6thzW92N1gHfQwR1ubQDhe2Orw/bF2ZPlWgM/jwnyXoM3gMyf29TLB
         zBCZ1lnpdsYu7geWaF0/8ImiXQ019psWS1TwmV3j1UA3sWKribEbPxHjAdzex/lh8tO3
         1xj2DilCfy2jQD99jPUJjAUvFJRx7b+LzWeXETyY1/JY6oxqrxxWH8G1bL1pVOCCvC41
         m9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gteg+LRHEQ6WvPtBTR5Cz8934VfzcQRBaiqPpyJWENU=;
        b=NtZKaVLPGsKCex8MeEiCkBMDtvY5+dnV9KQ+2YCoG6EVpfh3/O2pdjdzLLRmwNNRTf
         E77Rzwsl+TGR5MavindX34WFk1MnV3e0WOBLqWFx7Lht9ZggzC8ua7RgdJFSK60K/LQa
         3vap0o0JeY6J5RB1QN0yZPFwnHRA/WYO6civgUOjBu9HjW/fDVdND/WG7152ifKsQjOI
         NOYZwTm5Ud7sBG1Wqi1W2UecIkP4DCjfhLQ6xk5Q0TTpXiHnxS3R2bhy+Tb5PCERRwDN
         qsEC7reP/0L2oF7mc65kaSmZ8H/QSBe1utOh+/CI9K7zZhtUYUkbpXEYdfihqzJZT2bI
         lhVA==
X-Gm-Message-State: APjAAAWbP4IXeuxmfld5Nt8D/qcgLe9CkJDGdCmHSfyOLlg5WU8bNose
        hPScs8CUwmOob1sVfuglkNe9VVn/Ue862LFmxPwS1azjDzo=
X-Google-Smtp-Source: APXvYqxKva92QyMFBNYwHAk8ERYHUQaMkBqT76M+P+RAzHcBlNKHR3rAJ1SfDyssKxYR6pE8JftYwrGYi2BSs47MqBU=
X-Received: by 2002:ac8:5410:: with SMTP id b16mr17398104qtq.45.1580161119531;
 Mon, 27 Jan 2020 13:38:39 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 27 Jan 2020 22:38:28 +0100
Message-ID: <CAA85sZsZaT1vYdyb0n=MeXj4Wge+8a88XDO8yvJ36bPYEUyUXw@mail.gmail.com>
Subject: [5.5] new issue with RoCE
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Since updating to 5.5 I've hit a new issue - testing mlx5 cards from work =)

On client. multiple:
[ 1546.585378] ------------[ cut here ]------------
[ 1546.585386] WARNING: CPU: 3 PID: 4576 at
drivers/iommu/dma-iommu.c:471 __iommu_dma_unmap+0x10a/0x120
[ 1546.585386] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs mlx5_ib
amdgpu chaoskey mfd_core gpu_sched ttm mlx5_core sp5100_tco ccp
rpcrdma ib_ipoib
[ 1546.585394] CPU: 3 PID: 4576 Comm: kworker/3:1H Not tainted 5.5.0 #248
[ 1546.585395] Hardware name: System manufacturer System Product
Name/Pro WS X570-ACE, BIOS 1201 11/18/2019
[ 1546.585398] Workqueue: ib-comp-wq ib_cq_poll_work
[ 1546.585401] RIP: 0010:__iommu_dma_unmap+0x10a/0x120
[ 1546.585402] Code: c0 74 0b 48 89 e6 4c 89 f7 e8 e2 b2 9b 00 48 c7
44 24 08 00 00 00 00 48 c7 44 24 10 00 00 00 00 48 c7 04 24 ff ff ff
ff eb 90 <0f> 0b eb 82 e8 cd 3f 93 ff 66 66 2e 0f 1f 84 00 00 00 00 00
66 90
[ 1546.585403] RSP: 0018:ffffa1e188c97da8 EFLAGS: 00010206
[ 1546.585405] RAX: 0000000000004000 RBX: 0000000000003000 RCX: 0000000000000001
[ 1546.585405] RDX: 0000000000000002 RSI: ffffffffffffe000 RDI: ffffa1e188c97d18
[ 1546.585406] RBP: ffffffff00000000 R08: ffff8a0d8794e010 R09: 0000000000002000
[ 1546.585407] R10: 0000000000000001 R11: 000ffffffffff000 R12: 0000000000003000
[ 1546.585407] R13: ffff8a0ff3ce6000 R14: ffff8a0ff98a7620 R15: ffff8a0dcd11a000
[ 1546.585409] FS:  0000000000000000(0000) GS:ffff8a0ffeac0000(0000)
knlGS:0000000000000000
[ 1546.585410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1546.585410] CR2: 00007f7473740000 CR3: 000000074371a000 CR4: 0000000000340ee0
[ 1546.585411] Call Trace:
[ 1546.585426]  rpcrdma_mr_put+0x11b/0x120 [rpcrdma]
[ 1546.585429]  __ib_process_cq+0x76/0xd0
[ 1546.585430]  ib_cq_poll_work+0x34/0xc0
[ 1546.585433]  process_one_work+0x1e2/0x3c0
[ 1546.585436]  worker_thread+0x4a/0x3d0
[ 1546.585438]  kthread+0xfb/0x130
[ 1546.585440]  ? process_one_work+0x3c0/0x3c0
[ 1546.585441]  ? kthread_park+0x90/0x90
[ 1546.585443]  ret_from_fork+0x22/0x40
[ 1546.585446] ---[ end trace edc64661ebf52144 ]---

On server, multiple:
[ 1141.838449] infiniband mlx5_1: dump_cqe:270:(pid 715): dump error cqe
[ 1141.838463] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1141.838469] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1141.838475] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1141.838481] 00000030: 00 00 00 00 00 00 88 13 08 00 09 57 2c 66 e0 d2
(pid increasing and last bytes seems to increase as well)

No error from a user perspective... yet though...

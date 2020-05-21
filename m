Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965B7206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvsQpDAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgEUWWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUWWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:22:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3043AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:22:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id be9so7859012edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FDUtER/lAZTg+MBn1fXfZZ4rMzE6FaJzE4Mw9aw7xqU=;
        b=nvsQpDAbB8hFGoNpmqufscrM9qdy/idWMwmQEYeBub/HFAD2bCCRvV4Z59Q2CO2odG
         gTvK1kLgpB68csGb02tvwsLGi+J5WuYtjO+19EkYHow0ePIS20cKeQB1MLvR4PTV8QjA
         9WimumV5M1Q5ASpTQwpOFiDFnzC4Cv6WG3EsklEqO7YfPY+u2DJyrx78ZV6+uiC6PTBW
         pCU7rThIQLwN16Q0BQ2bCR26qs5SLNwiYnFwvynDkCdiEMIDwG7SeKtJTr2U2u4hZGVU
         WctENE90zE2cKJr90RUSfiuLG+ato4+IuHCel+8T4Nr1c+Fmz5SUDtSWlKA05xYV21oE
         necg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FDUtER/lAZTg+MBn1fXfZZ4rMzE6FaJzE4Mw9aw7xqU=;
        b=B0AXKIIoOYFQdJ8h1mSRhFhp4frMJyIaH/uNZ0Vcro6IeTWeiRDPY7lpSb4/CctEuR
         83Kvqzqzmt3IRbCobGflTxmu/Hb8rbF0whbNk7tGhNyKISKhZVaRgFiaVKLJuZjSpEjP
         qLqM8hZ7DggtWxGsL4t1bXeae9S93DWRaRIHbCUEfwZynpRlTErklHWFUYxyJePm0EOJ
         /uqerdl1SRGkyo/O4Z1uBSVfceLPKZCQ7hViJY5Q15L0Jc79Z8FeF6/YoEvggGULbskp
         2ix9eGCbnd4KONFYQWPiDGrws4uPh4cNDY4PhV3Z0oKI0Arai5RYX3DwLoNrt/+dMLMQ
         yz5g==
X-Gm-Message-State: AOAM533F8zkMN2Ik3gkKQsM/BE0N2obC1VraZrcmkoUJjGaf5jajh78a
        Xoq1TX33lYW4mChCYlC0zGm/WgANHaFbxVUUTho8zQ==
X-Google-Smtp-Source: ABdhPJyphfV1QCeLNVMCTEmFft48dEsTlZ547P6YHvbzY1SGdFXhX03ZpCGDVgKpTe9u65dJiS7yR5o3twJCUAGIjVo=
X-Received: by 2002:a50:a365:: with SMTP id 92mr799750edn.220.1590099721483;
 Thu, 21 May 2020 15:22:01 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 May 2020 08:21:50 +1000
Message-ID: <CAPM=9tyy5vubggbcj32bGpA_h6yDaBNM3QeJPySTzci-etfBZw@mail.gmail.com>
Subject: lockdep trace with xfs + mm in it from 5.7.0-rc5
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        darrick.wong@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just updated a rawhide VM to the Fedora 5.7.0-rc5 kernel, did some
package building,

got the below trace, not sure if it's known and fixed or unknown.

Dave.

  725.862536] ======================================================
[  725.862564] WARNING: possible circular locking dependency detected
[  725.862591] 5.7.0-0.rc5.20200515git1ae7efb38854.1.fc33.x86_64 #1 Not tainted
[  725.862612] ------------------------------------------------------
[  725.862630] kswapd0/159 is trying to acquire lock:
[  725.862645] ffff9b38d01a4470 (&xfs_nondir_ilock_class){++++}-{3:3},
at: xfs_ilock+0xde/0x2c0 [xfs]
[  725.862718]
               but task is already holding lock:
[  725.862735] ffffffffbbb8bd00 (fs_reclaim){+.+.}-{0:0}, at:
__fs_reclaim_acquire+0x5/0x30
[  725.862762]
               which lock already depends on the new lock.

[  725.862785]
               the existing dependency chain (in reverse order) is:
[  725.862806]
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  725.862824]        fs_reclaim_acquire+0x34/0x40
[  725.862839]        __kmalloc+0x4f/0x270
[  725.862878]        kmem_alloc+0x93/0x1d0 [xfs]
[  725.862914]        kmem_alloc_large+0x4c/0x130 [xfs]
[  725.862945]        xfs_attr_copy_value+0x74/0xa0 [xfs]
[  725.862984]        xfs_attr_get+0x9d/0xc0 [xfs]
[  725.863021]        xfs_get_acl+0xb6/0x200 [xfs]
[  725.863036]        get_acl+0x81/0x160
[  725.863052]        posix_acl_xattr_get+0x3f/0xd0
[  725.863067]        vfs_getxattr+0x148/0x170
[  725.863081]        getxattr+0xa7/0x240
[  725.863093]        path_getxattr+0x52/0x80
[  725.863111]        do_syscall_64+0x5c/0xa0
[  725.863133]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  725.863149]
               -> #0 (&xfs_nondir_ilock_class){++++}-{3:3}:
[  725.863177]        __lock_acquire+0x1257/0x20d0
[  725.863193]        lock_acquire+0xb0/0x310
[  725.863207]        down_write_nested+0x49/0x120
[  725.863242]        xfs_ilock+0xde/0x2c0 [xfs]
[  725.863277]        xfs_reclaim_inode+0x3f/0x400 [xfs]
[  725.863312]        xfs_reclaim_inodes_ag+0x20b/0x410 [xfs]
[  725.863351]        xfs_reclaim_inodes_nr+0x31/0x40 [xfs]
[  725.863368]        super_cache_scan+0x190/0x1e0
[  725.863383]        do_shrink_slab+0x184/0x420
[  725.863397]        shrink_slab+0x182/0x290
[  725.863409]        shrink_node+0x174/0x680
[  725.863927]        balance_pgdat+0x2d0/0x5f0
[  725.864389]        kswapd+0x21f/0x510
[  725.864836]        kthread+0x131/0x150
[  725.865277]        ret_from_fork+0x3a/0x50
[  725.865707]
               other info that might help us debug this:

[  725.866953]  Possible unsafe locking scenario:

[  725.867764]        CPU0                    CPU1
[  725.868161]        ----                    ----
[  725.868531]   lock(fs_reclaim);
[  725.868896]                                lock(&xfs_nondir_ilock_class);
[  725.869276]                                lock(fs_reclaim);
[  725.869633]   lock(&xfs_nondir_ilock_class);
[  725.869996]
                *** DEADLOCK ***

[  725.871061] 4 locks held by kswapd0/159:
[  725.871406]  #0: ffffffffbbb8bd00 (fs_reclaim){+.+.}-{0:0}, at:
__fs_reclaim_acquire+0x5/0x30
[  725.871779]  #1: ffffffffbbb7cef8 (shrinker_rwsem){++++}-{3:3}, at:
shrink_slab+0x115/0x290
[  725.872167]  #2: ffff9b39f07a50e8
(&type->s_umount_key#56){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0
[  725.872560]  #3: ffff9b39f077f258
(&pag->pag_ici_reclaim_lock){+.+.}-{3:3}, at:
xfs_reclaim_inodes_ag+0x82/0x410 [xfs]
[  725.873013]
               stack backtrace:
[  725.873811] CPU: 3 PID: 159 Comm: kswapd0 Not tainted
5.7.0-0.rc5.20200515git1ae7efb38854.1.fc33.x86_64 #1
[  725.874249] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29
04/01/2014
[  725.875158] Call Trace:
[  725.875625]  dump_stack+0x8b/0xc8
[  725.876090]  check_noncircular+0x134/0x150
[  725.876547]  __lock_acquire+0x1257/0x20d0
[  725.877019]  lock_acquire+0xb0/0x310
[  725.877517]  ? xfs_ilock+0xde/0x2c0 [xfs]
[  725.877988]  down_write_nested+0x49/0x120
[  725.878473]  ? xfs_ilock+0xde/0x2c0 [xfs]
[  725.878955]  ? xfs_reclaim_inode+0x3f/0x400 [xfs]
[  725.879448]  xfs_ilock+0xde/0x2c0 [xfs]
[  725.879925]  xfs_reclaim_inode+0x3f/0x400 [xfs]
[  725.880414]  xfs_reclaim_inodes_ag+0x20b/0x410 [xfs]
[  725.880876]  ? sched_clock_cpu+0xc/0xb0
[  725.881343]  ? mark_held_locks+0x2d/0x80
[  725.881798]  ? _raw_spin_unlock_irqrestore+0x46/0x60
[  725.882268]  ? lockdep_hardirqs_on+0x11e/0x1b0
[  725.882734]  ? try_to_wake_up+0x249/0x820
[  725.883234]  xfs_reclaim_inodes_nr+0x31/0x40 [xfs]
[  725.883700]  super_cache_scan+0x190/0x1e0
[  725.884180]  do_shrink_slab+0x184/0x420
[  725.884653]  shrink_slab+0x182/0x290
[  725.885129]  shrink_node+0x174/0x680
[  725.885596]  balance_pgdat+0x2d0/0x5f0
[  725.886074]  kswapd+0x21f/0x510
[  725.886540]  ? finish_wait+0x90/0x90
[  725.887013]  ? balance_pgdat+0x5f0/0x5f0
[  725.887477]  kthread+0x131/0x150
[  725.887937]  ? __kthread_bind_mask+0x60/0x60
[  725.888410]  ret_from_fork+0x3a/0x50

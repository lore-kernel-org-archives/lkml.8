Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4EBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC23A20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaNR1TLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGMWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGMWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:24:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02279C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:24:46 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c139so13862245qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OcHsM2BvDJutedC1r/JVX8yoOxfS5PqyzzhHipn6B9A=;
        b=JaNR1TLSKZ1KaEsgcdcLgp0I8nK+ZjumVOIMW8Hlc2bTvH20yd13nv5rKA1NOBNCXa
         ho6iUoOSbxkFc3KdcwwFzzhuynWrfY8Fr5bnFExJPPir5EX7bm7wgYZVpIO6O3Ec7dY6
         n1FqlBf/yRFC2XfQ/eqbcQCQqaubqUGSJ8fPEA0yYVhiwfQ8b4M8zqLB5eA6rn2JnNfZ
         T8dOjaoKqAi5G3qcf6yhQivmskrCoBomsaR11sO1CYo10Ya/KKLnR5ZCB2fl1mPX+Xy7
         BKgNP7Wj2Ce3wz/NW9PlTc7UoPLbJT0ppESPCvgkzws7shU+PDoThWTK6/Yn0qMNH/ZC
         7J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OcHsM2BvDJutedC1r/JVX8yoOxfS5PqyzzhHipn6B9A=;
        b=gLf65f61NSWsw8p6cf08AwXqECyAlSnUjLPsfjlx4pzETtrtht/Qar5cmuZD6olVdi
         Hqj/W6X0Tbva9WCVR844SbH/3OAltOrzUumWhgECokR+OtNe3nQDYqELhms5J14khDd5
         +7D97QR61eVpI1SBMwKItgWCu+6LpxRHCle8XB883zQSSDXUw7poZ0bu9pSJrTJLnwHh
         7RStqO7cn/t9zx9pMV6bHenO2AjUidG1Z7ADLvWT7fIocl9W2Phy/UE703cXgBMyf7R/
         cFOWZY32SM9YzA9CffrmTC9oiOvT9BEK8UJszAY3ZFYN63XDAfHOeSb72Y+iFPQG4Txf
         NIRw==
X-Gm-Message-State: AOAM532/jzYrdC+rQW9O0t2t0PdeHDoty7lqw5nQKOXnEXSwbJFgRtAj
        hdnxcciQLViA0ttJSp5M9OfTOVVzU6MxhBlJwAs=
X-Google-Smtp-Source: ABdhPJzIBhaNuCKwKcWrv7zpOoTN6FH3FI/H6EL1Q9xcFhfLzY8lI+cZI4JnEdCE/gbdEzrIDbPfRFI0JZgpGMSxSVQ=
X-Received: by 2002:a37:7dc3:: with SMTP id y186mr1598119qkc.160.1594679085217;
 Mon, 13 Jul 2020 15:24:45 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Mon, 13 Jul 2020 17:24:34 -0500
Message-ID: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
Subject: F2FS Segmentation Fault
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I won't re-format unless I hear something within a few days in case
you want me to try something.

Preface: There was a notable power outage a couple of nights ago.
When the power returned, everything seemed fine. No issues during
bootup or anything.
Then today, I went to open an application and my system started
schitzing out with programs suddenly closing(/crashing?).
I switched tty and tried to log in but was unable to even be allowed
to enter in my password.
I switched to another and tried logging in as root which succeeded (somehow).
I looked at the journal and saw an entry saying something about
/bin/login not being a valid exec format.
I went to reboot and when it got to fsck part of initramfs, it failed
and I was kicked to root.
I ran fsck and saw a bunch of issues, but I guess nothing could get
resolved enough to let me reboot.
Oh, in case you're wondering, my / (system) is on a 64GB SDHC card.
I just happened to also have an older / system on my mechanical drive
using BTRFS which I could boot to (which I'm on now).
I ran fsck from this older system and it seems I got the same results:

*****
Info: Fix the reported corruption.
Info: Force to fix corruption
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 124168159 (60628 MB)
Info: MKFS version
  "Linux version 5.1.15.a-1-hardened (builduser@slave-1) (gcc version
9.1.0 (GCC)) #1 SMP PREEMPT Thu Jun 27 11:33:04 CEST 2019"
Info: FSCK version
  from "Linux version 4.19.13-dirty (userName@computerName) (gcc
version 8.2.1 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST
2018"
    to "Linux version 4.19.13-dirty (userName@computerName) (gcc
version 8.2.1 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST
2018"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 124168152 (60628 MB)
Info: CKPT version = 63f2b4a
Info: checkpoint state = 55 :  crc fsck compacted_summary unmount

NID[0x18eca] is unreachable, blkaddr:0xcf1d9d3c
NID[0x18ecb] is unreachable, blkaddr:0x5db5f91f
NID[0x18ecc] is unreachable, blkaddr:0x4653d
NID[0x18ee3] is unreachable, blkaddr:0x144dc401
NID[0x18ee4] is unreachable, blkaddr:0x558cfba9
NID[0x18ee5] is unreachable, blkaddr:0x45553
NID[0x18f78] is unreachable, blkaddr:0x560555ac
NID[0x18f79] is unreachable, blkaddr:0x58cccb0d
NID[0x18f7a] is unreachable, blkaddr:0x53d84
NID[0x4d621] is unreachable, blkaddr:0x4fc1d
NID[0x4d622] is unreachable, blkaddr:0x4fc1e
NID[0x7fa32] is unreachable, blkaddr:0x20b0ca3a
NID[0x7fa33] is unreachable, blkaddr:0xf71b60
[FSCK] Unreachable nat entries                        [Fail] [0xd]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x4f6]
[FSCK] valid_block_count matching with CP             [Fail] [0x736fcb]
[FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x70327]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x70334]
[FSCK] valid_inode_count matched with CP              [Fail] [0x6f09e]
[FSCK] free segment_count matched with CP             [Ok..] [0x3bfc]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

Do you want to restore lost files into ./lost_found/? [Y/N] Y
Segmentation fault
*****

*****
       Message: Process 3425 (fsck.f2fs) of user 0 dumped core.

                Stack trace of thread 3425:
                #0  0x000055f8515739c8 n/a (fsck.f2fs)
                #1  0x000055f851575261 n/a (fsck.f2fs)
                #2  0x000055f851572c56 n/a (fsck.f2fs)
                #3  0x000055f85156a3f0 n/a (fsck.f2fs)
                #4  0x00007f51420feee3 __libc_start_main (libc.so.6)
                #5  0x000055f85156a95e n/a (fsck.f2fs)
*****

So if you want more information or need me to try something, let me
know soon if you would. Otherwise, I'll just be reformatting my card
in a few days.
It just could've been a fluke occurred because of the power outage but
didn't manifest itself until today.

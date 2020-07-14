Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948F421897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594685030;
	bh=4pPr2/y8YAMk6RVGxMO6eEw96Gv8CjodrwPyWqn/7iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EnJk9neLMpGpGNXLSrBGC2Wo9J+OBpRvabIQw+gzOdtzUGzVq2SAak/cuclqUGa5Z
	 YferuzIq6YTjhVruwrcX1ClFzFvzVUn6H48mRbC+J8AwZnlwgxV0APYGf2n54/iJji
	 7VkmFB6Xwa2E2N3gYS0vdCjAb2CPeZenpt6SBYs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGNADt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGNADs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:03:48 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A928C21883;
        Tue, 14 Jul 2020 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594685027;
        bh=4pPr2/y8YAMk6RVGxMO6eEw96Gv8CjodrwPyWqn/7iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnfHrFUdNDRkhM/bWkMZb6NLfKjAuXUOxdkLzyGc0rwLDnBxDWUj2C0W/wTtvCHbt
         tlVR6rmLf0hIhla/vgYrSIrtfKQBhDgFB5kL8wRS16bqr0Nvfu98uYErrtB7QWlXrV
         QD5gvSB62063agESki3dhmqpi41MZKnqNm5fj3tw=
Date:   Mon, 13 Jul 2020 17:03:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: F2FS Segmentation Fault
Message-ID: <20200714000347.GA19314@google.com>
References: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 07/13, Nathan Royce wrote:
> I won't re-format unless I hear something within a few days in case
> you want me to try something.
> 
> Preface: There was a notable power outage a couple of nights ago.
> When the power returned, everything seemed fine. No issues during
> bootup or anything.
> Then today, I went to open an application and my system started
> schitzing out with programs suddenly closing(/crashing?).
> I switched tty and tried to log in but was unable to even be allowed
> to enter in my password.
> I switched to another and tried logging in as root which succeeded (somehow).
> I looked at the journal and saw an entry saying something about
> /bin/login not being a valid exec format.
> I went to reboot and when it got to fsck part of initramfs, it failed
> and I was kicked to root.
> I ran fsck and saw a bunch of issues, but I guess nothing could get
> resolved enough to let me reboot.
> Oh, in case you're wondering, my / (system) is on a 64GB SDHC card.
> I just happened to also have an older / system on my mechanical drive
> using BTRFS which I could boot to (which I'm on now).
> I ran fsck from this older system and it seems I got the same results:
> 
> *****
> Info: Fix the reported corruption.
> Info: Force to fix corruption
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 124168159 (60628 MB)
> Info: MKFS version
>   "Linux version 5.1.15.a-1-hardened (builduser@slave-1) (gcc version
> 9.1.0 (GCC)) #1 SMP PREEMPT Thu Jun 27 11:33:04 CEST 2019"
> Info: FSCK version
>   from "Linux version 4.19.13-dirty (userName@computerName) (gcc
> version 8.2.1 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST
> 2018"
>     to "Linux version 4.19.13-dirty (userName@computerName) (gcc
> version 8.2.1 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST
> 2018"
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 124168152 (60628 MB)
> Info: CKPT version = 63f2b4a
> Info: checkpoint state = 55 :  crc fsck compacted_summary unmount
> 
> NID[0x18eca] is unreachable, blkaddr:0xcf1d9d3c
> NID[0x18ecb] is unreachable, blkaddr:0x5db5f91f
> NID[0x18ecc] is unreachable, blkaddr:0x4653d
> NID[0x18ee3] is unreachable, blkaddr:0x144dc401
> NID[0x18ee4] is unreachable, blkaddr:0x558cfba9
> NID[0x18ee5] is unreachable, blkaddr:0x45553
> NID[0x18f78] is unreachable, blkaddr:0x560555ac
> NID[0x18f79] is unreachable, blkaddr:0x58cccb0d
> NID[0x18f7a] is unreachable, blkaddr:0x53d84
> NID[0x4d621] is unreachable, blkaddr:0x4fc1d
> NID[0x4d622] is unreachable, blkaddr:0x4fc1e
> NID[0x7fa32] is unreachable, blkaddr:0x20b0ca3a
> NID[0x7fa33] is unreachable, blkaddr:0xf71b60
> [FSCK] Unreachable nat entries                        [Fail] [0xd]
> [FSCK] SIT valid block bitmap checking                [Fail]
> [FSCK] Hard link checking for regular file            [Ok..] [0x4f6]
> [FSCK] valid_block_count matching with CP             [Fail] [0x736fcb]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x70327]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x70334]
> [FSCK] valid_inode_count matched with CP              [Fail] [0x6f09e]
> [FSCK] free segment_count matched with CP             [Ok..] [0x3bfc]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Fail]
> 
> Do you want to restore lost files into ./lost_found/? [Y/N] Y

Could you try to say "N" here to move forward to fix the corrupted metadata?

Thanks,

> Segmentation fault
> *****
> 
> *****
>        Message: Process 3425 (fsck.f2fs) of user 0 dumped core.
> 
>                 Stack trace of thread 3425:
>                 #0  0x000055f8515739c8 n/a (fsck.f2fs)
>                 #1  0x000055f851575261 n/a (fsck.f2fs)
>                 #2  0x000055f851572c56 n/a (fsck.f2fs)
>                 #3  0x000055f85156a3f0 n/a (fsck.f2fs)
>                 #4  0x00007f51420feee3 __libc_start_main (libc.so.6)
>                 #5  0x000055f85156a95e n/a (fsck.f2fs)
> *****
> 
> So if you want more information or need me to try something, let me
> know soon if you would. Otherwise, I'll just be reformatting my card
> in a few days.
> It just could've been a fluke occurred because of the power outage but
> didn't manifest itself until today.

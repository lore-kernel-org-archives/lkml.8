Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F61C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D320707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="pLTDMon2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBVSRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:17:25 -0500
Received: from vps.xff.cz ([195.181.215.36]:60410 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVSRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1582395442; bh=suxoEwt8e8jS978/t9nJc104HLzrfI3py7ofhb2URzg=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=pLTDMon250VccTlIOi5v38+nk/pSvANYqAVbP2pOnl5f0TC/P3K5IdzRkqyLkPbUJ
         TIay3vUQgeONr004eve9HWcOwRrjmYLMM29S5GeFaEjvI6aQLAob14XUtp5/1ArkMl
         uXiUOrhrtoWnEZrxM5Nlq/UEjdSi4HAuw5CCG7fk=
Date:   Sat, 22 Feb 2020 19:17:21 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Writes stoped working on f2fs after the compression support was added
Message-ID: <20200222181721.tzrrohep5l3yklpf@core.my.home>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20200222044617.pfrhnz2iavkrtdn6@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222044617.pfrhnz2iavkrtdn6@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I observe hung background f2fs task on 5.6-rc2+ shortly after boot, leading to
panics. I use f2fs as rootfs. See below for stack trace. The reads continue to
work (if I disable panic on hung task). But sync blocks, writes block, etc.

It does not happen on all my f2fs filesystems, so it may depend on workload
or my particular filesystem state. It happens on two separate devices though,
both 32-bit, and doesn't happen on a 64-bit device. (might be a false lead,
though)

I went through the f2fs-for-5.6 tag/branch and reverted each patch right
down to:

  4c8ff7095bef64fc47e996a938f7d57f9e077da3 f2fs: support data compression

I could still reproduce the issue.

After reverting the data compression too, I could no longer reproduce the
issue. Perhaps not very helpful, since that patch is huge.

I tried to collect some information. Some ftrace logs, etc. Not sure what would
help debug this. Let me know if I can help debug this more.

Symptoms look the same as this issue:

  https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15298.html

ftrace: https://megous.com/dl/tmp/f2fs-debug-info.txt

longer ftrace: https://megous.com/dl/tmp/f2fs-debug-info-full.txt

/dev/root / f2fs rw,lazytime,relatime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,fastboot,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,fsync_mode=posix 0 0

thank you and regards,
	Ondrej

f2fs/status:

=====[ partition info(mmcblk0p2). #0, RW, CP: Good]=====
[SB: 1] [CP: 2] [SIT: 2] [NAT: 34] [SSA: 15] [MAIN: 7414(OverProv:248 Resv:129)]

Utilization: 17% (634784 valid blocks, 3172662 discard blocks)
  - Node: 57661 (Inode: 57305, Other: 356)
  - Data: 577123
  - Inline_xattr Inode: 2586
  - Inline_data Inode: 922
  - Inline_dentry Inode: 166
  - Compressed Inode: 0, Blocks: 0
  - Orphan/Append/Update Inode: 0, 0, 0

Main area: 7414 segs, 7414 secs 7414 zones
  - COLD  data: 6041, 6041, 6041
  - WARM  data: 141, 141, 141
  - HOT   data: 137, 137, 137
  - Dir   dnode: 44, 44, 44
  - File   dnode: 24, 24, 24
  - Indir nodes: 2, 2, 2

  - Valid: 1097
  - Dirty: 136
  - Prefree: 0
  - Free: 6181 (6181)

CP calls: 18 (BG: 0)
  - cp blocks : 126
  - sit blocks : 21
  - nat blocks : 16
  - ssa blocks : 0
GC calls: 1 (BG: 1)
  - data segments : 1 (1)
  - node segments : 0 (0)
Try to move 265 blocks (BG: 265)
  - data blocks : 265 (265)
  - node blocks : 0 (0)
Skipped : atomic write 0 (0)
BG skip : IO: 13, Other: 0

Extent Cache:
  - Hit Count: L1-1:619 L1-2:0 L2:0
  - Hit Ratio: 42% (619 / 1463)
  - Inner Struct Count: tree: 2349(0), node: 1183

Balancing F2FS Async:
  - DIO (R:    0, W:    0)
  - IO_R (Data:    0, Node:    0, Meta:    0
  - IO_W (CP:    1, Data:    0, Flush: (   0    2    1), Discard: (   0    0)) cmd:   13 undiscard:  36
  - inmem:    0, atomic IO:    0 (Max.    0), volatile IO:    0 (Max.    0)
  - nodes:   18 in 4219
  - dents:    1 in dirs:   1 (   4)
  - datas:  267 in files:   0
  - quota datas:    0 in quota files:   0
  - meta:    0 in  301
  - imeta:    2
  - NATs:        43/     4294
  - SITs:         4/     7414
  - free_nids:      3217/  3902615
  - alloc_nids:         0

Distribution of User Blocks: [ valid | invalid | free ]
  [--------|-|-----------------------------------------]

IPU: 15 blocks
SSR: 0 blocks in 0 segments
LFS: 67 blocks in 0 segments

BDF: 99, avg. vblocks: 455

Memory: 20583 KB
  - static: 2194 KB
  - cached: 308 KB
  - paged : 18080 KB



dmesg:

[  246.758021] INFO: task kworker/u16:1:58 blocked for more than 122 seconds.
[  246.758040]       Not tainted 5.6.0-rc2-00590-g9983bdae4974e #11
[  246.758044] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.758052] kworker/u16:1   D    0    58      2 0x00000000
[  246.758090] Workqueue: writeback wb_workfn (flush-179:0)
[  246.758099] Backtrace:
[  246.758121] [<c0912b90>] (__schedule) from [<c0913234>] (schedule+0x78/0xf4)
[  246.758130]  r10:da644000 r9:00000000 r8:da645a60 r7:da283e10 r6:00000002 r5:da644000
[  246.758132]  r4:da4d3600
[  246.758148] [<c09131bc>] (schedule) from [<c017ec74>] (rwsem_down_write_slowpath+0x24c/0x4c0)
[  246.758152]  r5:00000001 r4:da283e00
[  246.758161] [<c017ea28>] (rwsem_down_write_slowpath) from [<c0915f2c>] (down_write+0x6c/0x70)
[  246.758167]  r10:da283e00 r9:da645d80 r8:d9ed0000 r7:00000001 r6:00000000 r5:eff213b0
[  246.758169]  r4:da283e00
[  246.758187] [<c0915ec0>] (down_write) from [<c0435b80>] (f2fs_write_single_data_page+0x608/0x7ac)
[  246.758190]  r5:eff213b0 r4:da283c60
[  246.758198] [<c0435578>] (f2fs_write_single_data_page) from [<c0435fd8>] (f2fs_write_cache_pages+0x2b4/0x7c4)
[  246.758204]  r10:da645c28 r9:da283d60 r8:da283c60 r7:0000000f r6:da645d80 r5:00000001
[  246.758206]  r4:eff213b0
[  246.758214] [<c0435d24>] (f2fs_write_cache_pages) from [<c043682c>] (f2fs_write_data_pages+0x344/0x35c)
[  246.758220]  r10:00000000 r9:d9ed002c r8:d9ed0000 r7:00000004 r6:da283d60 r5:da283c60
[  246.758223]  r4:da645d80
[  246.758238] [<c04364e8>] (f2fs_write_data_pages) from [<c0267ee8>] (do_writepages+0x3c/0xd4)
[  246.758244]  r10:0000000a r9:c0e03d00 r8:00000c00 r7:c0264ddc r6:da645d80 r5:da283d60
[  246.758246]  r4:da283c60
[  246.758254] [<c0267eac>] (do_writepages) from [<c0310cbc>] (__writeback_single_inode+0x44/0x454)
[  246.758259]  r7:da283d60 r6:da645eac r5:da645d80 r4:da283c60
[  246.758266] [<c0310c78>] (__writeback_single_inode) from [<c03112d0>] (writeback_sb_inodes+0x204/0x4b0)
[  246.758272]  r10:0000000a r9:c0e03d00 r8:da283cc8 r7:da283c60 r6:da645eac r5:da283d08
[  246.758274]  r4:d9dc9848
[  246.758281] [<c03110cc>] (writeback_sb_inodes) from [<c03115cc>] (__writeback_inodes_wb+0x50/0xe4)
[  246.758287]  r10:da3797a8 r9:c0e03d00 r8:d9dc985c r7:da645eac r6:00000000 r5:d9dc9848
[  246.758289]  r4:da5a8800
[  246.758296] [<c031157c>] (__writeback_inodes_wb) from [<c03118f4>] (wb_writeback+0x294/0x338)
[  246.758302]  r10:fffbf200 r9:da644000 r8:c0e04e64 r7:d9dc9848 r6:d9dc9874 r5:da645eac
[  246.758305]  r4:d9dc9848
[  246.758312] [<c0311660>] (wb_writeback) from [<c0312dac>] (wb_workfn+0x35c/0x54c)
[  246.758318]  r10:da5f2005 r9:d9dc984c r8:d9dc9948 r7:d9dc9848 r6:00000000 r5:d9dc9954
[  246.758321]  r4:000031e6
[  246.758334] [<c0312a50>] (wb_workfn) from [<c014f2b8>] (process_one_work+0x214/0x544)
[  246.758340]  r10:da5f2005 r9:00000200 r8:00000000 r7:da5f2000 r6:ef044400 r5:da5eb000
[  246.758343]  r4:d9dc9954
[  246.758350] [<c014f0a4>] (process_one_work) from [<c014f634>] (worker_thread+0x4c/0x574)
[  246.758357]  r10:ef044400 r9:c0e03d00 r8:ef044418 r7:00000088 r6:ef044400 r5:da5eb014
[  246.758359]  r4:da5eb000
[  246.758368] [<c014f5e8>] (worker_thread) from [<c01564fc>] (kthread+0x144/0x170)
[  246.758374]  r10:ec9e5e90 r9:dabf325c r8:da5eb000 r7:da644000 r6:00000000 r5:da5fe000
[  246.758377]  r4:dabf3240
[  246.758386] [<c01563b8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[  246.758391] Exception stack(0xda645fb0 to 0xda645ff8)
[  246.758397] 5fa0:                                     00000000 00000000 00000000 00000000
[  246.758402] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  246.758407] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  246.758413]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b8
[  246.758416]  r4:da5fe000

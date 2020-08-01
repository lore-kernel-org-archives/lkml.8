Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995B72076C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596309746;
	bh=rlJCylVlbM081y0pIpdhVynEEDi6K6/kpXHr8d9UHEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PcSx8WCaBqfDu8FH94/dIy8/B+08H55OSy287SvvhzE8GTYPnmVEvZqZVpWvmhrf/
	 MSxGikkJY6QytOBeU6EvpfYEv7VvDo9STChKZ/3IhvPT1o9lhOVReUJ2YX9wp6Hg34
	 LjQVUGdv84JfZNVvOX5W5ZLg043qlwepbYsrDc3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgHATWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHATWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:22:24 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F339A2072A;
        Sat,  1 Aug 2020 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596309744;
        bh=rlJCylVlbM081y0pIpdhVynEEDi6K6/kpXHr8d9UHEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXs88p0vT78AeUBfiYw4ecuojQwqW7RQIwdGaq5zHnOt/Xk0bht+cXArc8r0yS37C
         FepRy3DZXvmKBeom6+9IA0fvWhROfWXWP3bl18s7dbqrYViDMR6TSZFEfN4ePsU5C1
         Km/H82F0sTXO8CAK7CgkJXxr+BJsq4Ia7IxkGZV0=
Date:   Sat, 1 Aug 2020 12:22:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: fix deadlock between quota writes and checkpoint
Message-ID: <20200801192222.GA85352@sol.localdomain>
References: <20200729070244.584518-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729070244.584518-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:02:44AM -0700, Jaegeuk Kim wrote:
> f2fs_write_data_pages(quota_mapping)
>  __f2fs_write_data_pages             f2fs_write_checkpoint
>   * blk_start_plug(&plug);
>   * add bio in write_io[DATA]
>                                       - block_operations
>                                       - skip syncing quota by
>                                                 >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
>                                       - down_write(&sbi->node_write);
>   - f2fs_write_single_data_page
>     - f2fs_do_write_data_page
>       - f2fs_outplace_write_data
>         - do_write_page
>            - f2fs_allocate_data_block
>             - down_write(node_write)
>                                       - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8c782d3f324f0..99c8061da55b9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>  		if (type == F2FS_DIRTY_META)
>  			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
>  							FS_CP_META_IO);
> +		else if (type == F2FS_WB_CP_DATA)
> +			f2fs_submit_merged_write(sbi, DATA);
>  		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>  	}
>  	finish_wait(&sbi->cp_wait, &wait);

This patch is causing the following WARNING when I try to run xfstests:

[   20.157753] ------------[ cut here ]------------
[   20.158393] do not call blocking ops when !TASK_RUNNING; state=2 set at [<0000000096354225>] prepare_to_wait+0xcd/0x430
[   20.159858] WARNING: CPU: 1 PID: 1152 at kernel/sched/core.c:7142 __might_sleep+0x149/0x1a0
[   20.160762] Modules linked in:
[   20.161119] CPU: 1 PID: 1152 Comm: umount Not tainted 5.8.0-rc7-next-20200731 #1
[   20.161924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20200516_175120-felixonmars2 04/01/2014
[   20.163110] RIP: 0010:__might_sleep+0x149/0x1a0
[   20.163709] Code: 65 48 8b 1c 25 c0 ed 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06 00 75 2b 48 8b 73 10 48 c7 c7 a0 bc 66 83 e8 0
[   20.166083] RSP: 0018:ffffc900015a7868 EFLAGS: 00010286
[   20.166759] RAX: 0000000000000000 RBX: ffff88806805c500 RCX: 0000000000000000
[   20.167658] RDX: 0000000000000004 RSI: 0000000000000008 RDI: fffff520002b4eff
[   20.168557] RBP: ffffc900015a7898 R08: 0000000000000001 R09: ffff88806d32f44f
[   20.169481] R10: ffffed100da65e89 R11: 1ffff1100d00b9a1 R12: ffffffff83674ba0
[   20.170389] R13: 00000000000005fa R14: 0000000000000000 R15: ffff8880638200a0
[   20.171291] FS:  00007f3da4b2f080(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
[   20.172311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.173061] CR2: 000055734e8b2638 CR3: 0000000067069000 CR4: 00000000003506e0
[   20.173965] Call Trace:
[   20.174295]  ? lockdep_hardirqs_on_prepare.part.0+0x22f/0x430
[   20.175022]  down_write+0x77/0x150
[   20.175464]  ? rwsem_down_read_slowpath+0xd40/0xd40
[   20.176110]  __submit_merged_write_cond+0x191/0x310
[   20.176739]  f2fs_submit_merged_write+0x18/0x20
[   20.177323]  f2fs_wait_on_all_pages+0x269/0x2d0
[   20.177899]  ? block_operations+0x980/0x980
[   20.178441]  ? __kasan_check_read+0x11/0x20
[   20.178975]  ? finish_wait+0x260/0x260
[   20.179488]  ? percpu_counter_set+0x147/0x230
[   20.180049]  do_checkpoint+0x1757/0x2a50
[   20.180558]  f2fs_write_checkpoint+0x840/0xaf0
[   20.181126]  f2fs_sync_fs+0x287/0x4a0
[   20.181602]  ? kill_f2fs_super+0x310/0x310
[   20.182127]  ? dput+0x3bf/0x570
[   20.182565]  sync_filesystem+0x165/0x200
[   20.183075]  generic_shutdown_super+0x69/0x320
[   20.183651]  kill_block_super+0x97/0xe0
[   20.184144]  kill_f2fs_super+0x21f/0x310
[   20.184656]  ? f2fs_dquot_commit+0xc0/0xc0
[   20.185179]  ? kfree+0xcc/0x320
[   20.185594]  ? unregister_shrinker+0x163/0x220
[   20.186185]  deactivate_locked_super+0x7b/0xf0
[   20.186763]  deactivate_super+0x71/0x80
[   20.187262]  cleanup_mnt+0x362/0x540
[   20.187722]  __cleanup_mnt+0xd/0x10
[   20.188172]  task_work_run+0xca/0x170
[   20.188647]  exit_to_user_mode_loop+0x98/0xa0
[   20.189226]  exit_to_user_mode_prepare+0xb4/0x110
[   20.189838]  syscall_exit_to_user_mode+0x37/0x90
[   20.190435]  do_syscall_64+0x3f/0x50
[   20.190895]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   20.191539] RIP: 0033:0x7f3da4f55507
[   20.192000] Code: 19 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 8
[   20.194359] RSP: 002b:00007ffc043b0018 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   20.195319] RAX: 0000000000000000 RBX: 000055fbd27c6970 RCX: 00007f3da4f55507
[   20.196239] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055fbd27cacd0
[   20.197142] RBP: 0000000000000000 R08: 000055fbd27cac40 R09: 00007f3da4fd6e80
[   20.198042] R10: 0000000000000000 R11: 0000000000000246 R12: 000055fbd27cacd0
[   20.198942] R13: 00007f3da507b1c4 R14: 000055fbd27c6a68 R15: 000055fbd27c6b80
[   20.199866] irq event stamp: 4503
[   20.200307] hardirqs last  enabled at (4511): [<ffffffff81358743>] console_unlock+0x4d3/0x630
[   20.201381] hardirqs last disabled at (4518): [<ffffffff813583e6>] console_unlock+0x176/0x630
[   20.202479] softirqs last  enabled at (4010): [<ffffffff83200ebf>] asm_call_on_stack+0xf/0x20
[   20.203556] softirqs last disabled at (3549): [<ffffffff83200ebf>] asm_call_on_stack+0xf/0x20
[   20.204631] ---[ end trace 6d3d87d9846869f6 ]---


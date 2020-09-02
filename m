Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ECB2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599036945;
	bh=UytGhyK+yOhfkTyS2iKXKPDJvAcI/XC1T++7dxAXO90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZiSvWCkO9fgVw0itKmP1jFgZrGk0sK1QiQf1GrYInW7B4jxGwRF0l1ZGp648sGPaL
	 pHvMbgneD/Sp5gK63YZpyiUCSVmhMMe/CpPcyBFiaLvp1UwasmVsMojANBzdQYJOOp
	 lVBQ/NTZcg194Uq/+e+iHHnKPqGVExX+VwddMcow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBIzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBIz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:55:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F542078B;
        Wed,  2 Sep 2020 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599036926;
        bh=UytGhyK+yOhfkTyS2iKXKPDJvAcI/XC1T++7dxAXO90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtaOZ5Syt7wB41u7vyhLvbsKq/NmpW486LxJzmcQUn2JdwgX1S92kmg6pb09cufOh
         m4guALdG8zhYPKH0/BKZ/DIX8QQCB1/pcZSPOpK2xYbQk+d6JxT1rBx9rzDzS6X0ue
         DBBeYkzsDOmJClfeYypPIWbLuggvdBuU5KFhv92g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH rdma-next 3/4] gcov: Protect from uninitialized number of functions provided by GCC 10.2
Date:   Wed,  2 Sep 2020 11:55:12 +0300
Message-Id: <20200902085513.748149-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902085513.748149-1-leon@kernel.org>
References: <20200902085513.748149-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The kernel compiled with GCC 10.2.1 and KASAN together with GCOV enabled
produces the following splat while reloading modules. The very similar
trace was reported by Colin [1].

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 296 at mm/page_alloc.c:4859 __alloc_pages_nodemask+0x670/0x3190
 Modules linked in: mlx5_ib(-) mlx5_core mlxfw ptp ib_ipoib pps_core rdma_ucm rdma_cm iw_cm ib_cm ib_umad  ib_uverbs ib_core
 CPU: 0 PID: 296 Comm: modprobe Tainted: G    B             5.9.0-rc1+ #1860
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04 /01/2014
 RIP: 0010:__alloc_pages_nodemask+0x670/0x3190
 Code: e9 af fc ff ff 48 83 05 fd 28 90 05 01 81 e7 00 20 00 00 48 c7 44 24 28 00 00 00 00 0f 85 fb fd ff  ff 48 83 05 f0 28 90 05 01 <0f> 0b 48 83 05 ee 28 90 05 01 48 83 05 ee 28 90 05 01 e9 dc fd ff
 RSP: 0018:ffff88805f7ffa28 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff1100befff5e
 RDX: 0000000000000000 RSI: 0000000000000017 RDI: 0000000000000000
 RBP: 000000050695a900 R08: ffff888060fc7900 R09: ffff888060fc793b
 R10: ffffed100c1f8f27 R11: ffffed100c1f8f28 R12: 0000000000040dc0
 R13: 000000050695a900 R14: 0000000000000017 R15: 0000000000000001
 FS:  00007f521f695740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f31b013f000 CR3: 000000006637e001 CR4: 0000000000370eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? __kmalloc_track_caller+0x17a/0x570
  ? gcov_info_dup+0xfe/0x730
  ? gcov_event+0x88d/0xd30
  ? gcov_module_notifier+0xe9/0x100
  ? blocking_notifier_call_chain+0x75/0xc0
  ? __x64_sys_delete_module+0x326/0x5a0
  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ? mark_lock+0xba0/0xba0
  ? mark_lock+0xba0/0xba0
  ? notifier_call_chain+0xeb/0x170
  ? blocking_notifier_call_chain+0x75/0xc0
  ? __x64_sys_delete_module+0x326/0x5a0
  ? do_syscall_64+0x45/0x70
  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ? warn_alloc+0x130/0x130
  ? lock_acquire+0x1f2/0xa30
  ? fs_reclaim_acquire+0x1f/0x70
  ? fs_reclaim_release+0x1f/0x50
  ? __kasan_check_read+0x1d/0x30
  ? reacquire_held_locks+0x420/0x420
  ? reacquire_held_locks+0x420/0x420
  kmalloc_order+0x3f/0xc0
  kmalloc_order_trace+0x24/0x220
  __kmalloc+0x41b/0x5a0
  ? gcov_info_dup+0xfe/0x730
  ? memcpy+0x73/0xa0
  gcov_info_dup+0x176/0x730
  gcov_event+0x88d/0xd30
  gcov_module_notifier+0xe9/0x100
  notifier_call_chain+0xeb/0x170
  blocking_notifier_call_chain+0x75/0xc0
  __x64_sys_delete_module+0x326/0x5a0
  ? do_init_module+0x810/0x810
  ? syscall_enter_from_user_mode+0x40/0x420
  ? trace_hardirqs_on+0x45/0xb0
  ? syscall_enter_from_user_mode+0x40/0x420
  do_syscall_64+0x45/0x70
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f521f7c531b
 Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffe1bd4af48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000561a3eae0910 RCX: 00007f521f7c531b
 RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000561a3eae0978
 RBP: 0000561a3eae0910 R08: 1999999999999999 R09: 0000000000000000
 R10: 00007f521f839ac0 R11: 0000000000000206 R12: 0000000000000000
 R13: 0000561a3eae0978 R14: 0000000000000000 R15: 0000561a3eae84d0
 irq event stamp: 326464
 hardirqs last  enabled at (326463): [<ffffffff832ecdde>] _raw_spin_unlock_irqrestore+0x8e/0xb0
 hardirqs last disabled at (326464): [<ffffffff832ec994>] _raw_spin_lock_irqsave+0x34/0xa0
 hardirqs last disabled at (326464): [<ffffffff832ec994>] _raw_spin_lock_irqsave+0x34/0xa0
 softirqs last  enabled at (320794): [<ffffffff83600931>] __do_softirq+0x931/0xbc4
 softirqs last disabled at (320789): [<ffffffff83400f2f>] asm_call_on_stack+0xf/0x20
 ---[ end trace 065ea9cc2ba144a6 ]---

This trace is seen because n_function value provided by GCC through
__gcov_init() is ridiculously high, in my case it was 2698213824,
which probably means that the field is not initialized.

In order to overcome this, fail allocation silently and rely on GCOV print later:
 gcov: could not save data for '/home/leonro/src/kernel/drivers/infiniband/hw/mlx5/std_types.gcda' (out of memory)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=208885#c1
Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/gcov/gcc_4_7.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 318211deb903..f2856896d12f 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -287,8 +287,9 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 	if (!dup->filename)
 		goto err_free;

-	dup->functions = kcalloc(info->n_functions,
-				 sizeof(struct gcov_fn_info *), GFP_KERNEL);
+	dup->functions =
+		kcalloc(info->n_functions, sizeof(struct gcov_fn_info *),
+			GFP_KERNEL | __GFP_NOWARN);
 	if (!dup->functions)
 		goto err_free;

--
2.26.2


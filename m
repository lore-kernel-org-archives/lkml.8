Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ACC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0027207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgH2OMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:12:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgH2OMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:12:50 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.209])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kC1b4-0000vj-B7; Sat, 29 Aug 2020 14:12:46 +0000
Subject: Re: [RFC PATCH -rc] gcov: Protect from uninitialized number of
 functions provided by GCC
To:     Leon Romanovsky <leon@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200827133932.3338519-1-leon@kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <673c4817-496d-47dd-f9b9-2644e0526bcb@canonical.com>
Date:   Sat, 29 Aug 2020 15:12:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827133932.3338519-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2020 14:39, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The kernel compiled with GCC 10.2.1 and KASAN together with GCOV enabled
> produces the following splats while reloading modules.
> 
> First splat [1] is generated due to the situation that gcov_info can be both
> user and kernel pointer, the memcpy() during kmemdup() causes to this.
> As a possible solution copy fields manually.
> 
> Second splat [2] is seen because n_function provided by GCC through
> __gcov_init() is ridiculously high, in my case it was 2698213824.
> IMHO it means that this field is not initialized, but I'm not sure.
> 
> [1]
>  ==================================================================
>  BUG: KASAN: global-out-of-bounds in kmemdup+0x43/0x70
>  Read of size 120 at addr ffffffffa0d2c780 by task modprobe/296
> 
>  CPU: 0 PID: 296 Comm: modprobe Not tainted 5.9.0-rc1+ #1860
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04 /01/2014
>  Call Trace:
>   ? dump_stack+0x128/0x1af
>   ? print_address_description.constprop.0+0x2c/0x3f0
>   ? _raw_spin_lock_irqsave+0x34/0xa0
>   ? __kasan_check_read+0x1d/0x30
>   ? kmemdup+0x43/0x70
>   ? kmemdup+0x43/0x70
>   ? gcov_info_dup+0x2d/0x730
>   ? __kasan_check_write+0x20/0x30
>   ? __mutex_unlock_slowpath+0x10d/0x740
>   ? gcov_event+0x88d/0xd30
>   ? gcov_module_notifier+0xe9/0x100
>   ? notifier_call_chain+0xeb/0x170
>   ? blocking_notifier_call_chain+0x75/0xc0
>   ? __x64_sys_delete_module+0x326/0x5a0
>   ? do_init_module+0x810/0x810
>   ? syscall_enter_from_user_mode+0x40/0x420
>   ? trace_hardirqs_on+0x45/0xb0
>   ? syscall_enter_from_user_mode+0x40/0x420
>   ? do_syscall_64+0x45/0x70
>   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>  The buggy address belongs to the variable:
>   __gcov_.uverbs_attr_get_obj+0x60/0xfffffffffff778e0 [mlx5_ib]
> 
>  Memory state around the buggy address:
>   ffffffffa0d2c680: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9
>   ffffffffa0d2c700: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
>  >ffffffffa0d2c780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
>                                                               ^
>   ffffffffa0d2c800: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
>   ffffffffa0d2c880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ==================================================================
>  Disabling lock debugging due to kernel taint
>  gcov: could not save data for '/home/leonro/src/kernel/drivers/infiniband/hw/mlx5/std_types.gcda' (out o
> f memory)
> 
> [2]
> Colin has similar error [3].
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 296 at mm/page_alloc.c:4859 __alloc_pages_nodemask+0x670/0x3190
>  Modules linked in: mlx5_ib(-) mlx5_core mlxfw ptp ib_ipoib pps_core rdma_ucm rdma_cm iw_cm ib_cm ib_umad  ib_uverbs ib_core
>  CPU: 0 PID: 296 Comm: modprobe Tainted: G    B             5.9.0-rc1+ #1860
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04 /01/2014
>  RIP: 0010:__alloc_pages_nodemask+0x670/0x3190
>  Code: e9 af fc ff ff 48 83 05 fd 28 90 05 01 81 e7 00 20 00 00 48 c7 44 24 28 00 00 00 00 0f 85 fb fd ff  ff 48 83 05 f0 28 90 05 01 <0f> 0b 48 83 05 ee 28 90 05 01 48 83 05 ee 28 90 05 01 e9 dc fd ff
>  RSP: 0018:ffff88805f7ffa28 EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff1100befff5e
>  RDX: 0000000000000000 RSI: 0000000000000017 RDI: 0000000000000000
>  RBP: 000000050695a900 R08: ffff888060fc7900 R09: ffff888060fc793b
>  R10: ffffed100c1f8f27 R11: ffffed100c1f8f28 R12: 0000000000040dc0
>  R13: 000000050695a900 R14: 0000000000000017 R15: 0000000000000001
>  FS:  00007f521f695740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f31b013f000 CR3: 000000006637e001 CR4: 0000000000370eb0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   ? __kmalloc_track_caller+0x17a/0x570
>   ? gcov_info_dup+0xfe/0x730
>   ? gcov_event+0x88d/0xd30
>   ? gcov_module_notifier+0xe9/0x100
>   ? blocking_notifier_call_chain+0x75/0xc0
>   ? __x64_sys_delete_module+0x326/0x5a0
>   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ? mark_lock+0xba0/0xba0
>   ? mark_lock+0xba0/0xba0
>   ? notifier_call_chain+0xeb/0x170
>   ? blocking_notifier_call_chain+0x75/0xc0
>   ? __x64_sys_delete_module+0x326/0x5a0
>   ? do_syscall_64+0x45/0x70
>   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ? warn_alloc+0x130/0x130
>   ? lock_acquire+0x1f2/0xa30
>   ? fs_reclaim_acquire+0x1f/0x70
>   ? fs_reclaim_release+0x1f/0x50
>   ? __kasan_check_read+0x1d/0x30
>   ? reacquire_held_locks+0x420/0x420
>   ? reacquire_held_locks+0x420/0x420
>   kmalloc_order+0x3f/0xc0
>   kmalloc_order_trace+0x24/0x220
>   __kmalloc+0x41b/0x5a0
>   ? gcov_info_dup+0xfe/0x730
>   ? memcpy+0x73/0xa0
>   gcov_info_dup+0x176/0x730
>   gcov_event+0x88d/0xd30
>   gcov_module_notifier+0xe9/0x100
>   notifier_call_chain+0xeb/0x170
>   blocking_notifier_call_chain+0x75/0xc0
>   __x64_sys_delete_module+0x326/0x5a0
>   ? do_init_module+0x810/0x810
>   ? syscall_enter_from_user_mode+0x40/0x420
>   ? trace_hardirqs_on+0x45/0xb0
>   ? syscall_enter_from_user_mode+0x40/0x420
>   do_syscall_64+0x45/0x70
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f521f7c531b
>  Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffe1bd4af48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 0000561a3eae0910 RCX: 00007f521f7c531b
>  RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000561a3eae0978
>  RBP: 0000561a3eae0910 R08: 1999999999999999 R09: 0000000000000000
>  R10: 00007f521f839ac0 R11: 0000000000000206 R12: 0000000000000000
>  R13: 0000561a3eae0978 R14: 0000000000000000 R15: 0000561a3eae84d0
>  irq event stamp: 326464
>  hardirqs last  enabled at (326463): [<ffffffff832ecdde>] _raw_spin_unlock_irqrestore+0x8e/0xb0
>  hardirqs last disabled at (326464): [<ffffffff832ec994>] _raw_spin_lock_irqsave+0x34/0xa0
>  hardirqs last disabled at (326464): [<ffffffff832ec994>] _raw_spin_lock_irqsave+0x34/0xa0
>  softirqs last  enabled at (320794): [<ffffffff83600931>] __do_softirq+0x931/0xbc4
>  softirqs last disabled at (320789): [<ffffffff83400f2f>] asm_call_on_stack+0xf/0x20
>  ---[ end trace 065ea9cc2ba144a6 ]---
> 
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=208885#c1
> Cc: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> I have a strong feeling that this solution is not correct, but don't
> know how to do it right. The problem exists and reproducable in seconds.
> ---
>  kernel/gcov/gcc_4_7.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index 908fdf5098c3..357ef839cdd3 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -275,20 +275,23 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
>  	size_t fi_size; /* function info size */
>  	size_t cv_size; /* counter values size */
> 
> -	dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
> +	dup = kzalloc(sizeof(*dup), GFP_KERNEL);
>  	if (!dup)
>  		return NULL;
> 
> -	dup->next = NULL;
> -	dup->filename = NULL;
> -	dup->functions = NULL;
> +	dup->version = info->version;
> +	dup->stamp = info->stamp;
> +	for (fi_idx = 0; i < GCOV_COUNTERS; i++)

This loop refers to i as a counter but it's not declared.


> +		dup->merge[i] = info->merge[i];
> +	dup->n_functions = info->n_functions;
> 
> -	dup->filename = kstrdup(info->filename, GFP_KERNEL);
> +	dup->filename = kstrdup_const(info->filename, GFP_KERNEL);
>  	if (!dup->filename)
>  		goto err_free;
> 
> -	dup->functions = kcalloc(info->n_functions,
> -				 sizeof(struct gcov_fn_info *), GFP_KERNEL);
> +	dup->functions =
> +		kcalloc(info->n_functions, sizeof(struct gcov_fn_info *),
> +			GFP_KERNEL | __GFP_NOWARN);
>  	if (!dup->functions)
>  		goto err_free;
> 
> @@ -359,7 +362,7 @@ void gcov_info_free(struct gcov_info *info)
> 
>  free_info:
>  	kfree(info->functions);
> -	kfree(info->filename);
> +	kfree_const(info->filename);
>  	kfree(info);
>  }
> 
> --
> 2.26.2
> 


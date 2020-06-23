Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D96FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3278920724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgFWLhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:37:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:47116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732502AbgFWLfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:35:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC79DAEE6;
        Tue, 23 Jun 2020 11:35:20 +0000 (UTC)
Subject: Re: [mm, slab/slub] 7b39adbb1b: WARNING:at_mm/slab.h:#kmem_cache_free
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200623090213.GW5535@shao2-debian>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d6e6b64c-2870-1fbb-bca2-a27732af1ec3@suse.cz>
Date:   Tue, 23 Jun 2020 13:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623090213.GW5535@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 11:02 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-6):
> 
> commit: 7b39adbb1b1d3e73df9066a8d1e93a83c18d7730 ("mm, slab/slub: improve error reporting and overhead of cache_from_obj()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------------+------------+------------+
> |                                                        | 5a2a0a5f04 | 7b39adbb1b |
> +--------------------------------------------------------+------------+------------+
> | boot_successes                                         | 4          | 0          |
> | boot_failures                                          | 4          | 8          |
> | WARNING:at_kernel/trace/trace.c:#trace_find_next_entry | 4          | 4          |
> | EIP:trace_find_next_entry                              | 4          | 4          |
> | WARNING:at_mm/slab.h:#kmem_cache_free                  | 0          | 8          |
> | EIP:kmem_cache_free                                    | 0          | 8          |
> +--------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    3.251054] WARNING: CPU: 0 PID: 8 at mm/slab.h:298 kmem_cache_free+0x5/0x170

So this is due to the latest fixups.

Roman suggested VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS)); which triggered here.
For Kees, the cache_from_obj() is again shared between SLAB and SLUB and is
testing kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS).

However under CONFIG_SLAB, SLAB_DEBUG_FLAGS doesn't include SLAB_CONSISTENCY_CHECKS.

I think I'll need to move the VM_WARN_ON_ONCE() under #ifdef CONFIG_SLUB ?

> [    3.251054] Modules linked in:
> [    3.251054] CPU: 0 PID: 8 Comm: kdevtmpfs Not tainted 5.8.0-rc1-00277-g7b39adbb1b1d3 #1
> [    3.251054] EIP: kmem_cache_free+0x5/0x170
> [    3.251054] Code: 9f 8c 89 f8 e8 cc 58 fd ff 0f 0b 8d 78 ff e9 77 ff ff ff e8 2d d3 90 00 8d b4 26 00 00 00 00 8d b6 00 00 00 00 66 66 66 66 90 <0f> 0b 85 c0 0f 84 a6 00 00 00 8b 0d 64 50 b7 8c 85 c9 0f 84 33 01
> [    3.251054] EAX: 80090780 EBX: 802b4000 ECX: 00000000 EDX: 802b4000
> [    3.251054] ESI: 802b4000 EDI: 80305e04 EBP: 80305df4 ESP: 80305dec
> [    3.251054] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [    3.251054] CR0: 80050033 CR2: ffffffff CR3: 0ceb2000 CR4: 000406b0
> [    3.251054] Call Trace:
> [    3.251054]  ? putname+0x5c/0x60
> [    3.251054]  filename_lookup+0xde/0x1a0
> [    3.251054]  ? rcu_read_lock_sched_held+0x20/0x50
> [    3.251054]  ? strncpy_from_user+0x21/0x1a0
> [    3.251054]  user_path_at_empty+0x2a/0x40
> [    3.251054]  do_mount+0x5d/0x9b0
> [    3.251054]  devtmpfsd+0x69/0x2c0
> [    3.251054]  ? sched_clock_cpu+0x44/0xc0
> [    3.251054]  ? _raw_spin_unlock_irqrestore+0x2a/0x72
> [    3.251054]  ? trace_hardirqs_on+0xbf/0x270
> [    3.251054]  ? __kthread_parkme+0x5a/0x80
> [    3.251054]  kthread+0xf0/0x120
> [    3.251054]  ? public_dev_mount+0x40/0x40
> [    3.251054]  ? kthread_create_worker_on_cpu+0x20/0x20
> [    3.251054]  ret_from_fork+0x19/0x30
> [    3.251054] irq event stamp: 41
> [    3.251054] hardirqs last  enabled at (41): [<8ba11885>] set_root+0x95/0x190
> [    3.251054] hardirqs last disabled at (40): [<8ba11856>] set_root+0x66/0x190
> [    3.251054] softirqs last  enabled at (0): [<8b87027b>] copy_process+0x3eb/0x15b0
> [    3.251054] softirqs last disabled at (0): [<00000000>] 0x0
> [    3.251054] ---[ end trace e72be312a52f9020 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.8.0-rc1-00277-g7b39adbb1b1d3 .config
> 	make HOSTCC=gcc-6 CC=gcc-6 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 


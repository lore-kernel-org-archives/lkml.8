Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B7C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C4A206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgD1KTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:19:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27146 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727803AbgD1KTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:19:12 -0400
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800"; 
   d="scan'208";a="90644596"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Apr 2020 18:19:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 9B64B4BCC8A9;
        Tue, 28 Apr 2020 18:19:06 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Apr 2020 18:19:06 +0800
Message-ID: <5EA80319.7080005@cn.fujitsu.com>
Date:   Tue, 28 Apr 2020 18:19:05 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
References: <20200424223630.224895-1-joel@joelfernandes.org>
In-Reply-To: <20200424223630.224895-1-joel@joelfernandes.org>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 9B64B4BCC8A9.AE109
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Thanks for your quick fix.

Unfortunately, it fixes my original panic but introduces other
issues(two wanings and one panic) on my arm64 vm, as below:
--------------------------------------------------------------------
[ 3465.434942] ------------[ cut here ]------------
[ 3465.435481] refcount_t: addition on 0; use-after-free.
[ 3465.437071] WARNING: CPU: 1 PID: 6708 at lib/refcount.c:25
refcount_warn_saturate+0x9c/0x140
[ 3465.437720] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
virtio_blk
[ 3465.439787] CPU: 1 PID: 6708 Comm: rmmod Tainted: G           O
5.6.0-rc7+ #18
[ 3465.440316] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[ 3465.440967] pstate: 40000005 (nZcv daif -PAN -UAO)
[ 3465.441297] pc : refcount_warn_saturate+0x9c/0x140
[ 3465.441592] lr : refcount_warn_saturate+0x9c/0x140
[ 3465.441919] sp : fffffe001382fd70
[ 3465.442160] x29: fffffe001382fd70 x28: fffffc004876d200
[ 3465.442649] x27: 0000000000000000 x26: 0000000000000000
[ 3465.443071] x25: 0000000000000000 x24: fffffe00115bbbf0
[ 3465.443670] x23: 0000000000000000 x22: 0000000000000200
[ 3465.444194] x21: fffffe0011273988 x20: fffffc0063fdd228
[ 3465.444576] x19: fffffc0063fdd200 x18: 0000000000000010
[ 3465.444939] x17: 0000000000000000 x16: 0000000000000000
[ 3465.445329] x15: ffffffffffffffff x14: fffffe0011273988
[ 3465.445698] x13: fffffe009382fa97 x12: fffffe001382fa9f
[ 3465.446116] x11: fffffe00112b0000 x10: fffffe001382fa20
[ 3465.446498] x9 : 00000000ffffffd0 x8 : 6572662d72657466
[ 3465.446941] x7 : 0000000000000149 x6 : fffffe001127cf50
[ 3465.447375] x5 : fffffe001127c000 x4 : 0000000000000000
[ 3465.447757] x3 : fffffe001127cf50 x2 : 0000000000000000
[ 3465.448161] x1 : 2e36d2803fe6b700 x0 : 0000000000000000
[ 3465.448702] Call trace:
[ 3465.448979]  refcount_warn_saturate+0x9c/0x140
[ 3465.449330]  kthread_stop+0x48/0x278
[ 3465.450144]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
[ 3465.450625]  __arm64_sys_delete_module+0x14c/0x298
[ 3465.450998]  do_el0_svc+0xf8/0x1e0
[ 3465.451372]  el0_sync_handler+0x134/0x1bc
[ 3465.451701]  el0_sync+0x140/0x180
[ 3465.452099] ---[ end trace 1a8ec2201af5e8c7 ]---
[ 3465.478208] ------------[ cut here ]------------
[ 3465.478696] WARNING: CPU: 1 PID: 6708 at kernel/kthread.c:400
__kthread_bind_mask+0x34/0x90
[ 3465.479210] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
virtio_blk
[ 3465.480509] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
5.6.0-rc7+ #18
[ 3465.480966] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[ 3465.481465] pstate: 40000005 (nZcv daif -PAN -UAO)
[ 3465.481821] pc : __kthread_bind_mask+0x34/0x90
[ 3465.482129] lr : __kthread_bind_mask+0x30/0x90
[ 3465.482419] sp : fffffe001382fd30
[ 3465.482639] x29: fffffe001382fd30 x28: fffffc004876d200
[ 3465.483017] x27: 0000000000000000 x26: 0000000000000000
[ 3465.483385] x25: 0000000000000000 x24: fffffe00115bbbf0
[ 3465.483795] x23: 0000000000000000 x22: 0000000000000200
[ 3465.484251] x21: fffffe0010a9cb88 x20: 0000000000000040
[ 3465.484599] x19: fffffc0063fdd200 x18: 0000000000000010
[ 3465.484957] x17: 0000000000000000 x16: 0000000000000000
[ 3465.485347] x15: ffffffffffffffff x14: fffffe0011273988
[ 3465.485714] x13: fffffe009382fa97 x12: fffffe001382fa9f
[ 3465.486210] x11: fffffe00112b0000 x10: fffffe001382fa20
[ 3465.486599] x9 : 00000000ffffffd0 x8 : 6572662d72657466
[ 3465.487039] x7 : 0000000000000149 x6 : fffffe001127cf50
[ 3465.487447] x5 : fffffe001127c000 x4 : 0000000000000001
[ 3465.487868] x3 : fffffe001127cf50 x2 : 2e36d2803fe6b700
[ 3465.488252] x1 : 0000000000000000 x0 : 0000000000000000
[ 3465.488628] Call trace:
[ 3465.488851]  __kthread_bind_mask+0x34/0x90
[ 3465.489192]  kthread_unpark+0xa0/0xb0
[ 3465.489456]  kthread_stop+0x8c/0x278
[ 3465.489736]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
[ 3465.490216]  __arm64_sys_delete_module+0x14c/0x298
[ 3465.490594]  do_el0_svc+0xf8/0x1e0
[ 3465.490850]  el0_sync_handler+0x134/0x1bc
[ 3465.491157]  el0_sync+0x140/0x180
[ 3465.491413] ---[ end trace 1a8ec2201af5e8c8 ]---
[ 3465.504614] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 3465.505340] Mem abort info:
[ 3465.505553]   ESR = 0x96000006
[ 3465.505855]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 3465.506234]   SET = 0, FnV = 0
[ 3465.506525]   EA = 0, S1PTW = 0
[ 3465.506786] Data abort info:
[ 3465.507037]   ISV = 0, ISS = 0x00000006
[ 3465.507304]   CM = 0, WnR = 0
[ 3465.507685] user pgtable: 64k pages, 42-bit VAs, pgdp=0000000082450000
[ 3465.508225] [0000000000000000] pgd=0000000000000000,
pud=0000000000000000, pmd=0000000000000000
[ 3465.509049] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[ 3465.509527] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
virtio_blk
[ 3465.510964] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
5.6.0-rc7+ #18
[ 3465.511527] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[ 3465.512031] pstate: 60000085 (nZCv daIf -PAN -UAO)
[ 3465.512392] pc : __list_add_valid+0x18/0xa0
[ 3465.512740] lr : wait_for_completion+0xc8/0x178
[ 3465.513085] sp : fffffe001382fd00
[ 3465.513362] x29: fffffe001382fd00 x28: fffffc004876d200
[ 3465.513769] x27: 0000000000000000 x26: 0000000000000000
[ 3465.514205] x25: 0000000000000000 x24: fffffc0076e616c8
[ 3465.514638] x23: fffffe001382fd68 x22: 0000000000000000
[ 3465.515030] x21: fffffe0011273988 x20: fffffc0076e616c0
[ 3465.515444] x19: fffffc0076e616b8 x18: 0000000000000010
[ 3465.515826] x17: 0000000000000000 x16: 0000000000000000
[ 3465.516184] x15: ffffffffffffffff x14: fffffe0011273988
[ 3465.516584] x13: fffffe009382fa97 x12: fffffe001382fa9f
[ 3465.516976] x11: fffffe00112b0000 x10: fffffe001382fa20
[ 3465.517351] x9 : 00000000ffffffd0 x8 : 6572662d72657466
[ 3465.517750] x7 : 0000000000000149 x6 : fffffe001127cf50
[ 3465.518169] x5 : 0000000000000001 x4 : fffffc0076e616c8
[ 3465.518454] x3 : fffffe0010128b38 x2 : 0000000000000000
[ 3465.518711] x1 : 0000000000000000 x0 : fffffe001382fd68
[ 3465.518985] Call trace:
[ 3465.519157]  __list_add_valid+0x18/0xa0
[ 3465.519351]  wait_for_completion+0xc8/0x178
[ 3465.519578]  kthread_stop+0x9c/0x278
[ 3465.519779]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
[ 3465.520109]  __arm64_sys_delete_module+0x14c/0x298
[ 3465.520342]  do_el0_svc+0xf8/0x1e0
[ 3465.520520]  el0_sync_handler+0x134/0x1bc
[ 3465.520718]  el0_sync+0x140/0x180
[ 3465.521177] Code: 910003fd f9400442 eb01005f 54000141 (f9400041)
[ 3465.522258] ---[ end trace 1a8ec2201af5e8c9 ]---
[ 3465.522746] Kernel panic - not syncing: Fatal exception
[ 3465.523242] SMP: stopping secondary CPUs
[ 3465.523898] Kernel Offset: disabled
[ 3465.524423] CPU features: 0x10002,20006082
[ 3465.524939] Memory Limit: none
[ 3465.525534] ---[ end Kernel panic - not syncing: Fatal exception ]---
--------------------------------------------------------------------

I am looking into these issues.

Thanks,
Xiao Yang
On 2020/4/25 6:36, Joel Fernandes (Google) wrote:
> Kthread running the test needs to be stopped or it can continue
> executing code unloaded by module causing a crash.
> 
> Suggested-by: Steven Rostedt<rostedt@goodmis.org>
> Reported-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Link: http://lore.kernel.org/r/5EA2B0C8.2080706@cn.fujitsu.com
> Signed-off-by: Joel Fernandes (Google)<joel@joelfernandes.org>
> ---
>   kernel/trace/preemptirq_delay_test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 31c0fad4cb9e1..1c28ca20e30b6 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -145,10 +145,10 @@ static struct attribute_group attr_group = {
>   };
> 
>   static struct kobject *preemptirq_delay_kobj;
> +static struct task_struct *test_task;
> 
>   static int __init preemptirq_delay_init(void)
>   {
> -	struct task_struct *test_task;
>   	int retval;
> 
>   	test_task = preemptirq_start_test();
> @@ -171,6 +171,9 @@ static int __init preemptirq_delay_init(void)
>   static void __exit preemptirq_delay_exit(void)
>   {
>   	kobject_put(preemptirq_delay_kobj);
> +
> +	if (test_task)
> +		kthread_stop(test_task);
>   }
> 
>   module_init(preemptirq_delay_init)




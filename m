Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF35C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007AC206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RUTdzgKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgD1OPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727790AbgD1OPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:15:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1FC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:15:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so21917970qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7s/7Vjw6g2zA5npweMsCK0LTF4wKgThg/6bGGoKfXk=;
        b=RUTdzgKZd+abhNlA7E9ZioIWRIRfoQKBIs3QtShE0Tye1VtXQ2pSrrAHEKEeVuDHv5
         6pv2E8U7vQBvdRt/g0w0YLkHfLWtUR5DA1YH35xmZuGw6ZVpssJtmt7+6AkBphC6U92x
         MfZWGCHlQGwJDgwI5E4t2SYBgDtraej4yaWUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7s/7Vjw6g2zA5npweMsCK0LTF4wKgThg/6bGGoKfXk=;
        b=oLQkpHmPNJuwzRYnquCedQkcQUPyY+z12gW9daszmoTZEONHI4olQb8tBL4iKa7uNn
         TEvC60u9zzZ9AhMUsYHjgTK5Hc5/RhyDa/9sDAV9cU6y41TRfG6ZidO6hiLlqgZ5+z3o
         3ZnyHeVHtd+9OEzlgeAQp4NWAgwPNOuIDLCB3dfsjqL12jMasKzh9Gdw/spDIFFg+QnT
         oZ5TAcPaf1YhK7gqvlxnyLpgbPR0sy+uyU/EcZOrRgCrUMvLEQj9U46Emwf/1B0ksVGl
         z58eBE3uQzgVob6CVm/jjIwELydGj3VCxHQ26HdFIt9eFwNMDZKJ8BhUdKxCXoe6++rQ
         nN5w==
X-Gm-Message-State: AGi0PuZXmBbPyYD5H+D7TQ2O7f3DhkwMgdJ0DMPA0dKvMp8o6y+AZ3Sk
        VBd4vaAPKWiz476SshX/0apNOw==
X-Google-Smtp-Source: APiQypK/rLWPeTwFwXcY0qLjYvtvIRdmUnIKnW22lkr+KYpr1PiAQirlgXifLOI3vWgjxgmk7ehoJw==
X-Received: by 2002:a37:a70d:: with SMTP id q13mr16390880qke.413.1588083306601;
        Tue, 28 Apr 2020 07:15:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n10sm13220013qkk.105.2020.04.28.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:15:06 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:15:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200428141505.GA141102@google.com>
References: <20200424223630.224895-1-joel@joelfernandes.org>
 <5EA80319.7080005@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EA80319.7080005@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 06:19:05PM +0800, Xiao Yang wrote:
> Hi Joel,
> 
> Thanks for your quick fix.
> 
> Unfortunately, it fixes my original panic but introduces other
> issues(two wanings and one panic) on my arm64 vm, as below:
> --------------------------------------------------------------------
> [ 3465.434942] ------------[ cut here ]------------
> [ 3465.435481] refcount_t: addition on 0; use-after-free.
> [ 3465.437071] WARNING: CPU: 1 PID: 6708 at lib/refcount.c:25
> refcount_warn_saturate+0x9c/0x140
> [ 3465.437720] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.439787] CPU: 1 PID: 6708 Comm: rmmod Tainted: G           O
> 5.6.0-rc7+ #18
> [ 3465.440316] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.440967] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 3465.441297] pc : refcount_warn_saturate+0x9c/0x140
> [ 3465.441592] lr : refcount_warn_saturate+0x9c/0x140
> [ 3465.441919] sp : fffffe001382fd70
> [ 3465.442160] x29: fffffe001382fd70 x28: fffffc004876d200
> [ 3465.442649] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.443071] x25: 0000000000000000 x24: fffffe00115bbbf0
> [ 3465.443670] x23: 0000000000000000 x22: 0000000000000200
> [ 3465.444194] x21: fffffe0011273988 x20: fffffc0063fdd228
> [ 3465.444576] x19: fffffc0063fdd200 x18: 0000000000000010
> [ 3465.444939] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.445329] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.445698] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.446116] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.446498] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.446941] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.447375] x5 : fffffe001127c000 x4 : 0000000000000000
> [ 3465.447757] x3 : fffffe001127cf50 x2 : 0000000000000000
> [ 3465.448161] x1 : 2e36d2803fe6b700 x0 : 0000000000000000
> [ 3465.448702] Call trace:
> [ 3465.448979]  refcount_warn_saturate+0x9c/0x140
> [ 3465.449330]  kthread_stop+0x48/0x278
> [ 3465.450144]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.450625]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.450998]  do_el0_svc+0xf8/0x1e0
> [ 3465.451372]  el0_sync_handler+0x134/0x1bc
> [ 3465.451701]  el0_sync+0x140/0x180
> [ 3465.452099] ---[ end trace 1a8ec2201af5e8c7 ]---
> [ 3465.478208] ------------[ cut here ]------------
> [ 3465.478696] WARNING: CPU: 1 PID: 6708 at kernel/kthread.c:400
> __kthread_bind_mask+0x34/0x90
> [ 3465.479210] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.480509] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
> 5.6.0-rc7+ #18
> [ 3465.480966] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.481465] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 3465.481821] pc : __kthread_bind_mask+0x34/0x90
> [ 3465.482129] lr : __kthread_bind_mask+0x30/0x90
> [ 3465.482419] sp : fffffe001382fd30
> [ 3465.482639] x29: fffffe001382fd30 x28: fffffc004876d200
> [ 3465.483017] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.483385] x25: 0000000000000000 x24: fffffe00115bbbf0
> [ 3465.483795] x23: 0000000000000000 x22: 0000000000000200
> [ 3465.484251] x21: fffffe0010a9cb88 x20: 0000000000000040
> [ 3465.484599] x19: fffffc0063fdd200 x18: 0000000000000010
> [ 3465.484957] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.485347] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.485714] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.486210] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.486599] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.487039] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.487447] x5 : fffffe001127c000 x4 : 0000000000000001
> [ 3465.487868] x3 : fffffe001127cf50 x2 : 2e36d2803fe6b700
> [ 3465.488252] x1 : 0000000000000000 x0 : 0000000000000000
> [ 3465.488628] Call trace:
> [ 3465.488851]  __kthread_bind_mask+0x34/0x90
> [ 3465.489192]  kthread_unpark+0xa0/0xb0
> [ 3465.489456]  kthread_stop+0x8c/0x278
> [ 3465.489736]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.490216]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.490594]  do_el0_svc+0xf8/0x1e0
> [ 3465.490850]  el0_sync_handler+0x134/0x1bc
> [ 3465.491157]  el0_sync+0x140/0x180
> [ 3465.491413] ---[ end trace 1a8ec2201af5e8c8 ]---
> [ 3465.504614] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [ 3465.505340] Mem abort info:
> [ 3465.505553]   ESR = 0x96000006
> [ 3465.505855]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 3465.506234]   SET = 0, FnV = 0
> [ 3465.506525]   EA = 0, S1PTW = 0
> [ 3465.506786] Data abort info:
> [ 3465.507037]   ISV = 0, ISS = 0x00000006
> [ 3465.507304]   CM = 0, WnR = 0
> [ 3465.507685] user pgtable: 64k pages, 42-bit VAs, pgdp=0000000082450000
> [ 3465.508225] [0000000000000000] pgd=0000000000000000,
> pud=0000000000000000, pmd=0000000000000000
> [ 3465.509049] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [ 3465.509527] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.510964] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
> 5.6.0-rc7+ #18
> [ 3465.511527] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.512031] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [ 3465.512392] pc : __list_add_valid+0x18/0xa0
> [ 3465.512740] lr : wait_for_completion+0xc8/0x178
> [ 3465.513085] sp : fffffe001382fd00
> [ 3465.513362] x29: fffffe001382fd00 x28: fffffc004876d200
> [ 3465.513769] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.514205] x25: 0000000000000000 x24: fffffc0076e616c8
> [ 3465.514638] x23: fffffe001382fd68 x22: 0000000000000000
> [ 3465.515030] x21: fffffe0011273988 x20: fffffc0076e616c0
> [ 3465.515444] x19: fffffc0076e616b8 x18: 0000000000000010
> [ 3465.515826] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.516184] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.516584] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.516976] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.517351] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.517750] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.518169] x5 : 0000000000000001 x4 : fffffc0076e616c8
> [ 3465.518454] x3 : fffffe0010128b38 x2 : 0000000000000000
> [ 3465.518711] x1 : 0000000000000000 x0 : fffffe001382fd68
> [ 3465.518985] Call trace:
> [ 3465.519157]  __list_add_valid+0x18/0xa0
> [ 3465.519351]  wait_for_completion+0xc8/0x178
> [ 3465.519578]  kthread_stop+0x9c/0x278
> [ 3465.519779]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.520109]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.520342]  do_el0_svc+0xf8/0x1e0
> [ 3465.520520]  el0_sync_handler+0x134/0x1bc
> [ 3465.520718]  el0_sync+0x140/0x180
> [ 3465.521177] Code: 910003fd f9400442 eb01005f 54000141 (f9400041)
> [ 3465.522258] ---[ end trace 1a8ec2201af5e8c9 ]---
> [ 3465.522746] Kernel panic - not syncing: Fatal exception
> [ 3465.523242] SMP: stopping secondary CPUs
> [ 3465.523898] Kernel Offset: disabled
> [ 3465.524423] CPU features: 0x10002,20006082
> [ 3465.524939] Memory Limit: none
> [ 3465.525534] ---[ end Kernel panic - not syncing: Fatal exception ]---
> --------------------------------------------------------------------
> 
> I am looking into these issues.

I am wondering if it is because in your test, the kthread exits too quickly.
We have these comments in kthread_stop():
 * If threadfn() may call do_exit() itself, the caller must ensure
 * task_struct can't go away.

Does the below diff on top of the previous patch help?

---8<-----------------------

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 1c28ca20e30b6..8051946a18989 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -152,6 +152,8 @@ static int __init preemptirq_delay_init(void)
 	int retval;
 
 	test_task = preemptirq_start_test();
+	get_task_struct(test_task);
+
 	retval = PTR_ERR_OR_ZERO(test_task);
 	if (retval != 0)
 		return retval;
@@ -172,8 +174,10 @@ static void __exit preemptirq_delay_exit(void)
 {
 	kobject_put(preemptirq_delay_kobj);
 
-	if (test_task)
+	if (test_task) {
 		kthread_stop(test_task);
+		put_task_struct(test_task);
+	}
 }
 
 module_init(preemptirq_delay_init)

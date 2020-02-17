Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD7C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9D52067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581929147;
	bh=yOBu5rdAUdS/7lXgd6eB1Dwr/nOsyB/I+rSJt2CANv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sd0d7kRpP2ruKmAuT6aZpeOEhi6IjoDxZ/yxeS+VrUYOVmP+VrRTx+d1vuKnTQsEp
	 EDU0AkJnjtoPlCL287XwGIWpVAqVqAtFfGEcsytnjGTAWSFtBfj3Zxmhd5NOUy/2f0
	 T+6Jp5Mnl9umgcqyIUTY5fCz/6d5gFjznZZu7KlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgBQIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgBQIpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:45:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D402064C;
        Mon, 17 Feb 2020 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581929144;
        bh=yOBu5rdAUdS/7lXgd6eB1Dwr/nOsyB/I+rSJt2CANv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AoGMZhjLfX1byI7vfKYHY346jALeDEHd33a80UDV7U2vW67UTi/qIdyep4DRFilmj
         g5S+wV+pn8/7NH8VTSPPtE8uZDFAtxo6vF3e/BGxlQS6T+zx0Z3SWz66Hruyz2FSQD
         km+UYbh1AlBDSFNMbiPpXEdlgRspatEMIiRhhirM=
Date:   Mon, 17 Feb 2020 17:45:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tracing] 1b6c0739c6:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-Id: <20200217174541.3e7b67d5d44bde945e32815f@kernel.org>
In-Reply-To: <20200217003444.GE14493@shao2-debian>
References: <20200217003444.GE14493@shao2-debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm investigating this issue. This seems that my fix is not enough, there seems some other issues still in the test module.

Thank you,

On Mon, 17 Feb 2020 08:34:44 +0800
kernel test robot <lkp@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 1b6c0739c611f3b5373e27571cc93064c423731d ("tracing: Skip software disabled event at __synth_event_trace_end()")
> https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-Skip-software-disabled-event-at-__synth_event_trace_end/20200215-100354
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------------------------------------------------------+------------+------------+
> |                                                                             | 7276531d40 | 1b6c0739c6 |
> +-----------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                              | 22         | 0          |
> | boot_failures                                                               | 0          | 22         |
> | BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c | 0          | 6          |
> | initcall_synth_event_gen_test_init_returned_with_preemption_imbalance       | 0          | 22         |
> | WARNING:at_init/main.c:#do_one_initcall                                     | 0          | 22         |
> | RIP:do_one_initcall                                                         | 0          | 22         |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c        | 0          | 16         |
> +-----------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> [    6.998544] BUG: sleeping function called from invalid context at mm/page_alloc.c:4695
> [    7.000227] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [    7.001487] no locks held by swapper/0/1.
> [    7.002172] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc6-00098-g1b6c0739c611f #2
> [    7.003522] Call Trace:
> [    7.003962]  dump_stack+0x57/0x75
> [    7.004179]  ___might_sleep+0x111/0x120
> [    7.004179]  __might_sleep+0x68/0x70
> [    7.004179]  __alloc_pages_nodemask+0xe9/0x250
> [    7.004179]  ? test_empty_synth_event+0x1f/0x222
> [    7.004179]  slob_new_pages+0x13/0xa0
> [    7.004179]  slob_alloc+0x2b8/0x2e0
> [    7.004179]  ? test_empty_synth_event+0x1f/0x222
> [    7.004179]  __kmalloc+0x1cd/0x1f0
> [    7.004179]  ? test_empty_synth_event+0x222/0x222
> [    7.004179]  ? do_early_param+0x92/0x92
> [    7.004179]  test_empty_synth_event+0x1f/0x222
> [    7.004179]  ? print_synth_event+0x2c0/0x2c0
> [    7.004179]  ? test_empty_synth_event+0x222/0x222
> [    7.004179]  synth_event_gen_test_init+0x1d/0x3bd
> [    7.004179]  ? init_tracepoints+0x28/0x28
> [    7.004179]  ? do_early_param+0x92/0x92
> [    7.004179]  ? proc_create_data+0x3b/0x50
> [    7.004179]  ? proc_create+0xf/0x20
> [    7.004179]  do_one_initcall+0xae/0x210
> [    7.004179]  kernel_init_freeable+0x1e4/0x25c
> [    7.004179]  ? rest_init+0x140/0x140
> [    7.004179]  kernel_init+0x9/0x100
> [    7.004179]  ret_from_fork+0x35/0x40
> [    7.026429] ------------[ cut here ]------------
> [    7.027238] initcall synth_event_gen_test_init+0x0/0x3bd returned with preemption imbalance 
> [    7.028721] WARNING: CPU: 0 PID: 1 at init/main.c:1159 do_one_initcall+0x1c4/0x210
> [    7.030508] Modules linked in:
> [    7.031114] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.5.0-rc6-00098-g1b6c0739c611f #2
> [    7.032901] RIP: 0010:do_one_initcall+0x1c4/0x210
> [    7.033805] Code: 40 00 00 00 48 c7 c6 a6 7a e2 81 e8 86 91 70 00 fb 80 7d a0 00 74 1d 48 8d 55 a0 4c 89 e6 48 c7 c7 b0 7e e2 81 e8 fc b2 09 00 <0f> 0b eb 06 41 bd ff ff ff ff 48 83 c4 40 44 89 e8 5b 41 5c 41 5d
> [    7.035098] RSP: 0000:ffffc90000013e98 EFLAGS: 00010292
> [    7.035098] RAX: 0000000000000050 RBX: 0000000000000000 RCX: 0000000000000000
> [    7.035098] RDX: 0000000000000000 RSI: 00000001a2f14e6c RDI: ffffffff82054880
> [    7.035098] RBP: ffffc90000013ef8 R08: 0000000000000001 R09: 0000000000000001
> [    7.035098] R10: 0000000000000010 R11: 0000000000000000 R12: ffffffff824b1bab
> [    7.035098] R13: 0000000000000000 R14: 0000000000000007 R15: ffffffff8248f6fd
> [    7.035098] FS:  0000000000000000(0000) GS:ffff888236a00000(0000) knlGS:0000000000000000
> [    7.035098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.035098] CR2: 0000000000000000 CR3: 0000000002012000 CR4: 00000000000406f0
> [    7.035098] Call Trace:
> [    7.035098]  kernel_init_freeable+0x1e4/0x25c
> [    7.035098]  ? rest_init+0x140/0x140
> [    7.035098]  kernel_init+0x9/0x100
> [    7.035098]  ret_from_fork+0x35/0x40
> [    7.035098] ---[ end trace 0953bc968f723b18 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.5.0-rc6-00098-g1b6c0739c611f .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> lkp
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

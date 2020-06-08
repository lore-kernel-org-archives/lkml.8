Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ED4206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgFHICs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:02:48 -0400
Received: from foss.arm.com ([217.140.110.172]:49430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgFHICs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:02:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D1F1F1;
        Mon,  8 Jun 2020 01:02:47 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17873F6CF;
        Mon,  8 Jun 2020 01:02:44 -0700 (PDT)
Subject: Re: [x86] 24256c140e:
 dmesg.UBSAN:array-index-out-of-bounds_in_arch/x86/mm/dump_pagetables.c
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jan Beulich <jbeulich@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200607072749.GW12456@shao2-debian>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2a7426e7-1331-4836-ddcc-5e117fe79b08@arm.com>
Date:   Mon, 8 Jun 2020 09:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607072749.GW12456@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2020 08:27, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 24256c140e59c3431af4918fd4ec892102cbc2f3 ("x86: mm: ptdump: calculate effective permissions correctly")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This was reported earlier[1] by Qian Cai and I posted a fix[2]. Linus' 
tree has the fixed commit[3].

Steve

[1] 
https://lore.kernel.org/lkml/20200522180741.GB1337@Qians-MacBook-Air.local/

[2] 
https://lore.kernel.org/linux-mm/430c8ab4-e7cd-6933-dde6-087fac6db872@arm.com/

[3] 1494e0c38ee9 ("x86: mm: ptdump: calculate effective permissions 
correctly")

> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    8.785395] UBSAN: array-index-out-of-bounds in arch/x86/mm/dump_pagetables.c:285:27
> [    8.787718] index -1 is out of range for type 'pgprotval_t [5]'
> [    8.789278] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc7-00027-g24256c140e59c #1
> [    8.791350] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    8.793505] Call Trace:
> [    8.794221]  dump_stack+0x6c/0x94
> [    8.795140]  ubsan_epilogue+0x8/0x3e
> [    8.796132]  __ubsan_handle_out_of_bounds+0x48/0x53
> [    8.797362]  ? is_visible+0x2b/0x32
> [    8.798231]  ? atomic_try_cmpxchg+0x4c/0x57
> [    8.799203]  note_page+0x37/0x80b
> [    8.800138]  ? __up_read+0x352/0x37b
> [    8.801124]  ptdump_walk_pgd+0x57/0x60
> [    8.802145]  ptdump_walk_pgd_level_core+0x72/0x9f
> [    8.803369]  ? ptdump_walk_pgd_level_debugfs+0x18/0x18
> [    8.804613]  ? ptdump_walk_pgd_level_core+0x9f/0x9f
> [    8.805779]  ptdump_walk_pgd_level_checkwx+0x1d/0x21
> [    8.806873]  mark_rodata_ro+0x9f/0xa6
> [    8.807821]  ? rest_init+0x7f/0x164
> [    8.808808]  kernel_init+0x44/0xf7
> [    8.809735]  ? rest_init+0x164/0x164
> [    8.810708]  ret_from_fork+0x19/0x24
> 
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-5.7.0-rc7-00027-g24256c140e59c .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 


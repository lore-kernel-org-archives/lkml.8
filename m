Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E421C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D4020737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGQIHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:07:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:43096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgGQIHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:07:51 -0400
IronPort-SDR: lY88EXfJinOBNj/YVxtEA9Qj4YNXCJ4W+tNto1uaiMalH4v8bf/rcupsfecH/7uAQ3iUeDNeP5
 ZJlZS4qf+WYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137670258"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="137670258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 01:07:50 -0700
IronPort-SDR: nwd7jPJHwVPkxZaosK2NPWshU/1YIuZs/EX9Bl/nY2WbjNHt1AGhV6tHybdW217GnnQHy9ljc7
 Gxhm11TQxhmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="430773818"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2020 01:07:48 -0700
Subject: Re: [LKP] Re: db57e98d87 ("mm/sparse.c: fix ALIGN() without power of
 2 in .."): BUG: kernel reboot-without-warning in early-boot stage, last
 printk: early console in setup code
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
References: <20200716083159.GH3874@shao2-debian>
 <20200716150613.409103a2d1e4c3f5f63652b8@linux-foundation.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <699f0838-14d9-9a3b-4265-c05d4793a1c3@intel.com>
Date:   Fri, 17 Jul 2020 16:07:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200716150613.409103a2d1e4c3f5f63652b8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/20 6:06 AM, Andrew Morton wrote:
> On Thu, 16 Jul 2020 16:32:00 +0800 kernel test robot <lkp@intel.com> wrote:
>
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit db57e98d87908b8837352abe08515e42752270c1
>> Author:     Lecopzer Chen <lecopzer.chen@mediatek.com>
>> AuthorDate: Mon Sep 23 15:36:24 2019 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Tue Sep 24 15:54:09 2019 -0700
>>
>>      mm/sparse.c: fix ALIGN() without power of 2 in sparse_buffer_alloc()
> Are we sure about this?  That patch is a year old - has something
> in the test setup changed to make it visible at this late stage?

Hi Andrew,

The issue can be reproduced if CONFIG_SPARSEMEM_VMEMMAP is not set
$ grep CONFIG_SPARSEMEM .config
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
# CONFIG_SPARSEMEM_VMEMMAP is not set

$ 
./reproduce-yocto-vm-yocto-23:20200619042212:x86_64-randconfig-r025-20200618:5.3.0-11836-gdb57e98d87908:1 
vmlinuz-5.3.0-11836-gdb57e98d87908
early console in setup code

and kernel can boot if enable CONFIG_SPARSEMEM_VMEMMAP
$ grep CONFIG_SPARSEMEM .config
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y

$ 
./reproduce-yocto-vm-yocto-23:20200619042212:x86_64-randconfig-r025-20200618:5.3.0-11836-gdb57e98d87908:1 
vmlinuz-5.3.0-11836-gdb57e98d87908.CONFIG_SPARSEMEM_VMEMMAP | head
early console in setup code
[    0.000000] Linux version 5.3.0-11836-gdb57e98d87908 
(kbuild@6c2adaf8a115) (clang version 12.0.0 
(git://gitmirror/llvm_project ed6b578040a85977026c93bf4188f996148f3218)) 
#1 SMP Fri Jul 17 15:41:47 CST 2020
[    0.000000] Command line: root=/dev/ram0 hung_task_panic=1 debug 
apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 
net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 
nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 
drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 
earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw 
rcuperf.shutdown=0 watchdog_thresh=60
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: 256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
qemu-system-x86_64: terminating on signal 2

Best Regards,
Rong Chen

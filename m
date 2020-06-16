Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0D20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFPCu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:50:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:22554 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFPCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:50:28 -0400
IronPort-SDR: mFmmbHKG9SBBc40uMzDjCJR0OCap/SchHUTMi2ZuL1Y+AZJXMOJYLzj4UMOej+hzYEi+IJmXZE
 9kh46i7dgXlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 19:50:27 -0700
IronPort-SDR: EooRz/LA+ATGqtDCneDKtobTGFprX0pDFQt4zaWlIbGdGmDApuNBSJoM7oNEJMR3+VMawXixMT
 XZpPyokdgYdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="261998340"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2020 19:50:23 -0700
Subject: Re: [kmemleak] b751c52bb5: BUG:kernel_hang_in_boot_stage
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200610075156.GE12456@shao2-debian>
 <20200610105640.GB26099@gaia>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <9bc70c0d-00b3-ff5a-e8bd-d4315e367fad@intel.com>
Date:   Tue, 16 Jun 2020 10:50:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200610105640.GB26099@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/20 6:56 PM, Catalin Marinas wrote:
> On Wed, Jun 10, 2020 at 03:51:56PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: b751c52bb587ae66f773b15204ef7a147467f4c7 ("kmemleak: increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> [...]
>> BUG: kernel hang in boot stage
>>
>> To reproduce:
>>
>>          # build kernel
>> 	cd linux
>> 	cp config-5.3.0-11789-gb751c52bb587a .config
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> I've never tried kmemleak on i386.
>
> Anyway, I'm not sure what caused the hang (or whether it's a hang at
> all) but I suspect prior to the above commit, kmemleak probably just
> disabled itself (early log  buffer exceeded). So the bug may have been
> there already, only that kmemleak started working and tripped over it
> when the log buffer increased.

Hi,

Sorry for the late, I can reproduce the problem with command "bin/lkp 
qemu -k <bzImage> job-script",
and the kernel hangs:

[    0.333897] -----------------------------------------------------
[    0.334561]                                  |block | try |context|
[    0.335170] -----------------------------------------------------
[    0.335760]                           context:  ok  |  ok  |  ok |
[    0.337995]                               try:  ok  |  ok  |  ok |
[    0.340089]                             block:  ok  |  ok  |  ok |
[    0.342175]                          spinlock:  ok  |  ok  |  ok |
[    0.344481] -------------------------------------------------------
[    0.345068] Good, all 261 testcases passed! |
[    0.345514] ---------------------------------
KVM internal error. Suberror: 3
extra data[0]: 80000b0e
extra data[1]: 31
extra data[2]: 182
extra data[3]: bfff0
EAX=00000000 EBX=00200297 ECX=00000000 EDX=ffffffff
ESI=d2e997c0 EDI=d2e997f0 EBP=d2bbb038 ESP=c00bfff4
EIP=f4dccd57 EFL=00210046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
FS =00d8 23331000 ffffffff 00809300 DPL=0 DS16 [-WA]
GS =00e0 f6422900 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 ffffffff 00c00000
TR =0080 ff403000 0000206b 00008b00 DPL=0 TSS32-busy
GDT=     ff401000 000000ff
IDT=     ff400000 000007ff
CR0=80050033 CR2=00000000 CR3=130fc000 CR4=00000690
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00

>
> Is there a chance that the kernel got much slower with kmemleak enabled
> and the test scripts timed out?
no, the parent commit log is:

[    0.313845] -----------------------------------------------------
[    0.314608]                                  |block | try |context|
[    0.315314] -----------------------------------------------------
[    0.315974]                           context:  ok  |  ok  |  ok |
[    0.318261]                               try:  ok  |  ok  |  ok |
[    0.320478]                             block:  ok  |  ok  |  ok |
[    0.322562]                          spinlock:  ok  |  ok  |  ok |
[    0.324825] -------------------------------------------------------
[    0.325403] Good, all 261 testcases passed! |
[    0.325809] ---------------------------------
[    0.326221] kmemleak: Early log buffer exceeded (401), please 
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.327065] ACPI: Core revision 20190816
[    0.327585] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604467 ns
[    0.328545] APIC: Switch to symmetric I/O mode setup
[    0.329009] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.329572] masked ExtINT on CPU#0
[    0.330686] ENABLING IO-APIC IRQs
[    0.331001] init IO_APIC IRQs
[    0.331274]  apic 0 pin 0 not connected

>
> Does this problem still exist with the latest mainline?
yes, still in v5.7.

Best Regards,
Rong Chen

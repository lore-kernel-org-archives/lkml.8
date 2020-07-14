Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B292C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8383221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNE72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:59:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:50970 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgGNE7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 00:59:21 -0400
IronPort-SDR: cxGku1djESIpdHyaRTrkUcc0Q6J0fEIY2HD5qXA0XNOIn17hKhwRMVz8CNKeBD11paiKb92VOM
 qwhZxaHjTIOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150239337"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="xz'?scan'208";a="150239337"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 21:58:31 -0700
IronPort-SDR: zlZxuVCPGU4WnhqO0gO/9ZoUQMMSIAiw5fNh7s3Xl2MoRxPluqkdmAXnjml4OfP6Soy+h7MSkY
 iF1e6geva/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="xz'?scan'208";a="390376119"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2020 21:58:28 -0700
Date:   Tue, 14 Jul 2020 12:58:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [percpu] 264b0d2bee: PANIC:double_fault
Message-ID: <20200714045801.GY3874@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="32KBALpRDK42x9o9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32KBALpRDK42x9o9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with clang-11):

commit: 264b0d2bee148073c117e7bbbde5be7125a53be1 ("percpu: Separate decrypted varaibles anytime encryption can be enabled")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+---------------------------------------------------------------------------------------------+------------+------------+
|                                                                                             | becef184df | 264b0d2bee |
+---------------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                              | 24         | 0          |
| boot_failures                                                                               | 0          | 24         |
| PANIC:double_fault                                                                          | 0          | 10         |
| double_fault:#[##]                                                                          | 0          | 10         |
| RIP:__this_cpu_preempt_check                                                                | 0          | 10         |
| RIP:kvm_read_and_reset_pf_reason                                                            | 0          | 11         |
| RIP:kvm_guest_apic_eoi_write                                                                | 0          | 10         |
| RIP:console_unlock                                                                          | 0          | 2          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt                                       | 0          | 10         |
| BUG:stack_guard_page_was_hit_at(____ptrval____)(stack_is(____ptrval____)..(____ptrval____)) | 0          | 14         |
| RIP:error_entry                                                                             | 0          | 13         |
| Kernel_panic-not_syncing:Fatal_exception                                                    | 0          | 14         |
| RIP:__memset                                                                                | 0          | 5          |
| RIP:preempt_count_add                                                                       | 0          | 1          |
| RIP:free_unref_page_prepare                                                                 | 0          | 1          |
| RIP:__change_page_attr_set_clr                                                              | 0          | 2          |
| RIP:do_async_page_fault                                                                     | 0          | 1          |
+---------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>


[   29.589431]      nameserver0=10.0.2.3
[   29.597508] Freeing unused decrypted memory: 2040K
[   29.599738] Freeing unused kernel image (initmem) memory: 1456K
[   29.603593] Write protecting the kernel read-only data: 59392k
[   29.606862] Freeing unused kernel image (text/rodata gap) memory: 2044K
[   29.610719] traps: PANIC: double fault, error_code: 0x0
[   29.610725] double fault: 0000 [#1] PREEMPT KASAN PTI
[   29.610731] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-11726-g264b0d2bee148 #1
[   29.610733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   29.610744] RIP: 0010:__this_cpu_preempt_check+0x0/0x1ad
[   29.610749] Code: 0b 85 e8 a5 bc 6f ff e9 21 ff ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 6e ff ff ff 4c 89 ff e8 87 bc 6f ff e9 61 ff ff ff <55> 41 57 41 56 41 54 53 50 8b 05 ea aa d3 02 a9 ff ff ff 7f 74 0d
[   29.610751] RSP: 0018:ffffc90000000000 EFLAGS: 00010046
[   29.610755] RAX: 0000000083a00ab7 RBX: ffffc90000000038 RCX: ffffffff83a00ab7
[   29.610757] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e3c0
[   29.610759] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610761] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610762] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610765] FS:  0000000000000000(0000) GS:ffffffff84a87000(0000) knlGS:0000000000000000
[   29.610767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.610769] CR2: ffffc8fffffffff8 CR3: 0000000004a36000 CR4: 00000000000406f0
[   29.610775] Call Trace:
[   29.610780]  <IRQ>
[   29.610786]  kvm_read_and_reset_pf_reason+0xd/0x47
[   29.610790]  do_async_page_fault+0x12/0x8b
[   29.610795]  async_page_fault+0x39/0x40
[   29.610799] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610802] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610804] RSP: 0018:ffffc900000000e8 EFLAGS: 00010086
[   29.610807] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610809] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610811] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610813] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610814] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610818]  ? native_iret+0x7/0x7
[   29.610822]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610825]  do_async_page_fault+0x12/0x8b
[   29.610828]  async_page_fault+0x39/0x40
[   29.610831] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610834] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610836] RSP: 0018:ffffc900000001c8 EFLAGS: 00010082
[   29.610838] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610840] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610842] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610844] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610846] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610849]  ? native_iret+0x7/0x7
[   29.610853]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610856]  do_async_page_fault+0x12/0x8b
[   29.610859]  async_page_fault+0x39/0x40
[   29.610862] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610865] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610866] RSP: 0018:ffffc900000002a8 EFLAGS: 00010086
[   29.610869] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610871] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610873] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610875] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610876] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610880]  ? native_iret+0x7/0x7
[   29.610884]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610886]  do_async_page_fault+0x12/0x8b
[   29.610890]  async_page_fault+0x39/0x40
[   29.610893] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610895] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610897] RSP: 0018:ffffc90000000388 EFLAGS: 00010082
[   29.610900] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610902] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610903] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610905] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610907] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610911]  ? native_iret+0x7/0x7
[   29.610914]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610916]  do_async_page_fault+0x12/0x8b
[   29.610919]  async_page_fault+0x39/0x40
[   29.610923] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610925] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610927] RSP: 0018:ffffc90000000468 EFLAGS: 00010082
[   29.610929] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610931] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610933] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610935] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610936] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610940]  ? native_iret+0x7/0x7
[   29.610944]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610946]  do_async_page_fault+0x12/0x8b
[   29.610949]  async_page_fault+0x39/0x40
[   29.610953] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610955] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610957] RSP: 0018:ffffc90000000548 EFLAGS: 00010086
[   29.610959] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610962] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610964] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610966] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610967] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.610971]  ? native_iret+0x7/0x7
[   29.610974]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610977]  do_async_page_fault+0x12/0x8b
[   29.610980]  async_page_fault+0x39/0x40
[   29.610983] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.610986] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.610988] RSP: 0018:ffffc90000000628 EFLAGS: 00010082
[   29.610990] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.610992] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.610994] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.610996] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.610998] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611001]  ? native_iret+0x7/0x7
[   29.611005]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611007]  do_async_page_fault+0x12/0x8b
[   29.611010]  async_page_fault+0x39/0x40
[   29.611013] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611016] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611017] RSP: 0018:ffffc90000000708 EFLAGS: 00010086
[   29.611020] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611022] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611024] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611026] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611028] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611031]  ? native_iret+0x7/0x7
[   29.611035]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611037]  do_async_page_fault+0x12/0x8b
[   29.611040]  async_page_fault+0x39/0x40
[   29.611043] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611046] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611047] RSP: 0018:ffffc900000007e8 EFLAGS: 00010086
[   29.611050] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611052] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611054] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611056] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611057] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611061]  ? native_iret+0x7/0x7
[   29.611064]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611067]  do_async_page_fault+0x12/0x8b
[   29.611070]  async_page_fault+0x39/0x40
[   29.611073] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611075] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611077] RSP: 0018:ffffc900000008c8 EFLAGS: 00010082
[   29.611080] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611082] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611083] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611085] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611087] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611090]  ? native_iret+0x7/0x7
[   29.611094]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611097]  do_async_page_fault+0x12/0x8b
[   29.611100]  async_page_fault+0x39/0x40
[   29.611103] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611105] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611107] RSP: 0018:ffffc900000009a8 EFLAGS: 00010086
[   29.611110] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611112] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611113] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611115] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611117] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611120]  ? native_iret+0x7/0x7
[   29.611124]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611126]  do_async_page_fault+0x12/0x8b
[   29.611129]  async_page_fault+0x39/0x40
[   29.611133] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611136] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611137] RSP: 0018:ffffc90000000a88 EFLAGS: 00010082
[   29.611140] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611142] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611144] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611146] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611148] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611151]  ? native_iret+0x7/0x7
[   29.611155]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611157]  do_async_page_fault+0x12/0x8b
[   29.611161]  async_page_fault+0x39/0x40
[   29.611164] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611166] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611168] RSP: 0018:ffffc90000000b68 EFLAGS: 00010082
[   29.611170] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611173] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611174] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611176] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611178] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611181]  ? native_iret+0x7/0x7
[   29.611185]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611187]  do_async_page_fault+0x12/0x8b
[   29.611190]  async_page_fault+0x39/0x40
[   29.611194] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611197] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611198] RSP: 0018:ffffc90000000c48 EFLAGS: 00010086
[   29.611201] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611203] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611204] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611206] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611208] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611211]  ? native_iret+0x7/0x7
[   29.611215]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611218]  do_async_page_fault+0x12/0x8b
[   29.611221]  async_page_fault+0x39/0x40
[   29.611224] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611226] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611228] RSP: 0018:ffffc90000000d28 EFLAGS: 00010082
[   29.611230] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611233] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611234] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611236] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611238] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611241]  ? native_iret+0x7/0x7
[   29.611245]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611248]  do_async_page_fault+0x12/0x8b
[   29.611250]  async_page_fault+0x39/0x40
[   29.611254] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611256] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611258] RSP: 0018:ffffc90000000e08 EFLAGS: 00010086
[   29.611260] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611262] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611264] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611266] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611268] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611271]  ? native_iret+0x7/0x7
[   29.611275]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611277]  do_async_page_fault+0x12/0x8b
[   29.611280]  async_page_fault+0x39/0x40
[   29.611283] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611286] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611287] RSP: 0018:ffffc90000000ee8 EFLAGS: 00010086
[   29.611290] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611292] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611294] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611296] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611298] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611301]  ? native_iret+0x7/0x7
[   29.611304]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611307]  do_async_page_fault+0x12/0x8b
[   29.611309]  async_page_fault+0x39/0x40
[   29.611312] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611315] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611316] RSP: 0018:ffffc90000000fc8 EFLAGS: 00010082
[   29.611319] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611321] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611322] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611324] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611326] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611329]  ? native_iret+0x7/0x7
[   29.611333]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611335]  do_async_page_fault+0x12/0x8b
[   29.611338]  async_page_fault+0x39/0x40
[   29.611341] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611344] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611345] RSP: 0018:ffffc900000010a8 EFLAGS: 00010086
[   29.611347] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611349] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611351] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611353] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611355] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611358]  ? native_iret+0x7/0x7
[   29.611361]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611364]  do_async_page_fault+0x12/0x8b
[   29.611367]  async_page_fault+0x39/0x40
[   29.611370] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611373] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611374] RSP: 0018:ffffc90000001188 EFLAGS: 00010082
[   29.611377] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611379] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611381] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611383] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611385] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611388]  ? native_iret+0x7/0x7
[   29.611391]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611394]  do_async_page_fault+0x12/0x8b
[   29.611397]  async_page_fault+0x39/0x40
[   29.611400] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611403] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611404] RSP: 0018:ffffc90000001268 EFLAGS: 00010082
[   29.611407] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611409] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611411] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611412] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611414] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611417]  ? native_iret+0x7/0x7
[   29.611421]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611424]  do_async_page_fault+0x12/0x8b
[   29.611427]  async_page_fault+0x39/0x40
[   29.611430] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611432] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611434] RSP: 0018:ffffc90000001348 EFLAGS: 00010086
[   29.611436] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611439] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611441] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611443] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611445] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611448]  ? native_iret+0x7/0x7
[   29.611451]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611454]  do_async_page_fault+0x12/0x8b
[   29.611457]  async_page_fault+0x39/0x40
[   29.611460] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611462] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611464] RSP: 0018:ffffc90000001428 EFLAGS: 00010082
[   29.611467] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611469] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611470] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611472] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611474] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611478]  ? native_iret+0x7/0x7
[   29.611481]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611483]  do_async_page_fault+0x12/0x8b
[   29.611486]  async_page_fault+0x39/0x40
[   29.611489] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611491] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611492] RSP: 0018:ffffc90000001508 EFLAGS: 00010086
[   29.611494] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611496] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611497] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611499] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611501] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611504]  ? native_iret+0x7/0x7
[   29.611508]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611510]  do_async_page_fault+0x12/0x8b
[   29.611513]  async_page_fault+0x39/0x40
[   29.611516] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611519] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611521] RSP: 0018:ffffc900000015e8 EFLAGS: 00010086
[   29.611524] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611526] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611527] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611529] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611531] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611534]  ? native_iret+0x7/0x7
[   29.611537]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611540]  do_async_page_fault+0x12/0x8b
[   29.611543]  async_page_fault+0x39/0x40
[   29.611547] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611549] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611551] RSP: 0018:ffffc900000016c8 EFLAGS: 00010082
[   29.611553] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611555] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611557] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611558] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611560] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611563]  ? native_iret+0x7/0x7
[   29.611567]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611569]  do_async_page_fault+0x12/0x8b
[   29.611573]  async_page_fault+0x39/0x40
[   29.611576] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611579] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611580] RSP: 0018:ffffc900000017a8 EFLAGS: 00010086
[   29.611583] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611585] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611587] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611589] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611591] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611595]  ? native_iret+0x7/0x7
[   29.611599]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611601]  do_async_page_fault+0x12/0x8b
[   29.611604]  async_page_fault+0x39/0x40
[   29.611608] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611610] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611612] RSP: 0018:ffffc90000001888 EFLAGS: 00010082
[   29.611614] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611617] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611619] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611621] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611623] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611626]  ? native_iret+0x7/0x7
[   29.611630]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611633]  do_async_page_fault+0x12/0x8b
[   29.611636]  async_page_fault+0x39/0x40
[   29.611639] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611665] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611667] RSP: 0018:ffffc90000001968 EFLAGS: 00010082
[   29.611670] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611672] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611674] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611676] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611678] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611682]  ? native_iret+0x7/0x7
[   29.611686]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611689]  do_async_page_fault+0x12/0x8b
[   29.611692]  async_page_fault+0x39/0x40
[   29.611695] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611698] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611700] RSP: 0018:ffffc90000001a48 EFLAGS: 00010086
[   29.611703] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611705] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611707] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611709] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611711] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611715]  ? native_iret+0x7/0x7
[   29.611719]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611722]  do_async_page_fault+0x12/0x8b
[   29.611725]  async_page_fault+0x39/0x40
[   29.611729] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611732] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611734] RSP: 0018:ffffc90000001b28 EFLAGS: 00010082
[   29.611736] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611738] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611740] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611742] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611744] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611748]  ? native_iret+0x7/0x7
[   29.611752]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611755]  do_async_page_fault+0x12/0x8b
[   29.611758]  async_page_fault+0x39/0x40
[   29.611762] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611765] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611766] RSP: 0018:ffffc90000001c08 EFLAGS: 00010086
[   29.611769] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611771] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611773] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611775] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611777] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611781]  ? native_iret+0x7/0x7
[   29.611785]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611788]  do_async_page_fault+0x12/0x8b
[   29.611791]  async_page_fault+0x39/0x40
[   29.611794] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611797] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611799] RSP: 0018:ffffc90000001ce8 EFLAGS: 00010086
[   29.611802] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611804] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611806] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611808] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611810] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611814]  ? native_iret+0x7/0x7
[   29.611817]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611820]  do_async_page_fault+0x12/0x8b
[   29.611824]  async_page_fault+0x39/0x40
[   29.611827] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611830] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611832] RSP: 0018:ffffc90000001dc8 EFLAGS: 00010082
[   29.611834] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611837] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611838] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611840] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611843] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611846]  ? native_iret+0x7/0x7
[   29.611850]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611853]  do_async_page_fault+0x12/0x8b
[   29.611856]  async_page_fault+0x39/0x40
[   29.611860] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611863] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611864] RSP: 0018:ffffc90000001ea8 EFLAGS: 00010086
[   29.611867] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611869] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611871] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611873] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611875] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611878]  ? native_iret+0x7/0x7
[   29.611882]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611885]  do_async_page_fault+0x12/0x8b
[   29.611888]  async_page_fault+0x39/0x40
[   29.611892] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611894] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611896] RSP: 0018:ffffc90000001f88 EFLAGS: 00010082
[   29.611899] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611901] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611903] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611905] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611907] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611910]  ? native_iret+0x7/0x7
[   29.611915]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611918]  do_async_page_fault+0x12/0x8b
[   29.611921]  async_page_fault+0x39/0x40
[   29.611925] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611927] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611929] RSP: 0018:ffffc90000002068 EFLAGS: 00010082
[   29.611932] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611934] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611935] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611937] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611939] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611943]  ? native_iret+0x7/0x7
[   29.611946]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611949]  do_async_page_fault+0x12/0x8b
[   29.611952]  async_page_fault+0x39/0x40
[   29.611956] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611958] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611960] RSP: 0018:ffffc90000002148 EFLAGS: 00010086
[   29.611963] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611965] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.611967] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.611969] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.611972] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.611975]  ? native_iret+0x7/0x7
[   29.611979]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611982]  do_async_page_fault+0x12/0x8b
[   29.611986]  async_page_fault+0x39/0x40
[   29.611989] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.611992] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.611994] RSP: 0018:ffffc90000002228 EFLAGS: 00010082
[   29.611996] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.611998] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612001] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612003] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612005] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612008]  ? native_iret+0x7/0x7
[   29.612012]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612015]  do_async_page_fault+0x12/0x8b
[   29.612018]  async_page_fault+0x39/0x40
[   29.612022] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612025] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612027] RSP: 0018:ffffc90000002308 EFLAGS: 00010086
[   29.612030] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612032] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612034] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612036] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612038] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612041]  ? native_iret+0x7/0x7
[   29.612045]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612048]  do_async_page_fault+0x12/0x8b
[   29.612051]  async_page_fault+0x39/0x40
[   29.612055] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612057] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612059] RSP: 0018:ffffc900000023e8 EFLAGS: 00010086
[   29.612062] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612064] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612066] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612068] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612070] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612073]  ? native_iret+0x7/0x7
[   29.612077]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612080]  do_async_page_fault+0x12/0x8b
[   29.612083]  async_page_fault+0x39/0x40
[   29.612086] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612089] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612091] RSP: 0018:ffffc900000024c8 EFLAGS: 00010082
[   29.612093] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612095] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612097] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612100] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612102] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612105]  ? native_iret+0x7/0x7
[   29.612109]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612112]  do_async_page_fault+0x12/0x8b
[   29.612116]  async_page_fault+0x39/0x40
[   29.612119] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612122] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612124] RSP: 0018:ffffc900000025a8 EFLAGS: 00010086
[   29.612127] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612129] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612131] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612133] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612135] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612138]  ? native_iret+0x7/0x7
[   29.612142]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612145]  do_async_page_fault+0x12/0x8b
[   29.612148]  async_page_fault+0x39/0x40
[   29.612152] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612155] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612157] RSP: 0018:ffffc90000002688 EFLAGS: 00010082
[   29.612159] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612162] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612163] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612165] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612167] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612171]  ? native_iret+0x7/0x7
[   29.612175]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612178]  do_async_page_fault+0x12/0x8b
[   29.612181]  async_page_fault+0x39/0x40
[   29.612184] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612187] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612189] RSP: 0018:ffffc90000002768 EFLAGS: 00010082
[   29.612192] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612194] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612196] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612198] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612200] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612203]  ? native_iret+0x7/0x7
[   29.612207]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612210]  do_async_page_fault+0x12/0x8b
[   29.612213]  async_page_fault+0x39/0x40
[   29.612217] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612219] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612221] RSP: 0018:ffffc90000002848 EFLAGS: 00010086
[   29.612224] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612226] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612228] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612230] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612232] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612236]  ? native_iret+0x7/0x7
[   29.612240]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612242]  do_async_page_fault+0x12/0x8b
[   29.612246]  async_page_fault+0x39/0x40
[   29.612249] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612252] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612253] RSP: 0018:ffffc90000002928 EFLAGS: 00010082
[   29.612256] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612258] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612260] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612262] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612264] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612268]  ? native_iret+0x7/0x7
[   29.612272]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612274]  do_async_page_fault+0x12/0x8b
[   29.612278]  async_page_fault+0x39/0x40
[   29.612281] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612284] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612286] RSP: 0018:ffffc90000002a08 EFLAGS: 00010086
[   29.612289] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612291] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612293] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612295] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612297] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612300]  ? native_iret+0x7/0x7
[   29.612304]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612307]  do_async_page_fault+0x12/0x8b
[   29.612310]  async_page_fault+0x39/0x40
[   29.612314] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612316] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612318] RSP: 0018:ffffc90000002ae8 EFLAGS: 00010086
[   29.612321] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612323] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612324] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612327] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612329] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612332]  ? native_iret+0x7/0x7
[   29.612336]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612339]  do_async_page_fault+0x12/0x8b
[   29.612342]  async_page_fault+0x39/0x40
[   29.612346] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612349] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612350] RSP: 0018:ffffc90000002bc8 EFLAGS: 00010082
[   29.612353] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612355] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612357] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612359] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612361] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612365]  ? native_iret+0x7/0x7
[   29.612369]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612371]  do_async_page_fault+0x12/0x8b
[   29.612375]  async_page_fault+0x39/0x40
[   29.612378] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612381] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612383] RSP: 0018:ffffc90000002ca8 EFLAGS: 00010086
[   29.612385] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612388] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612389] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612392] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612394] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612397]  ? native_iret+0x7/0x7
[   29.612401]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612404]  do_async_page_fault+0x12/0x8b
[   29.612407]  async_page_fault+0x39/0x40
[   29.612411] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612414] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612415] RSP: 0018:ffffc90000002d88 EFLAGS: 00010082
[   29.612418] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612420] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612421] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612423] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612425] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612429]  ? native_iret+0x7/0x7
[   29.612433]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612436]  do_async_page_fault+0x12/0x8b
[   29.612439]  async_page_fault+0x39/0x40
[   29.612443] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612445] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612447] RSP: 0018:ffffc90000002e68 EFLAGS: 00010082
[   29.612450] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612452] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612454] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612456] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612458] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612462]  ? native_iret+0x7/0x7
[   29.612466]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612468]  do_async_page_fault+0x12/0x8b
[   29.612472]  async_page_fault+0x39/0x40
[   29.612476] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612478] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612480] RSP: 0018:ffffc90000002f48 EFLAGS: 00010086
[   29.612483] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612485] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612487] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612489] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612491] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612495]  ? native_iret+0x7/0x7
[   29.612498]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612501]  do_async_page_fault+0x12/0x8b
[   29.612505]  async_page_fault+0x39/0x40
[   29.612509] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612511] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612513] RSP: 0018:ffffc90000003028 EFLAGS: 00010082
[   29.612515] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612517] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612519] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612521] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612522] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612526]  ? native_iret+0x7/0x7
[   29.612530]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612532]  do_async_page_fault+0x12/0x8b
[   29.612535]  async_page_fault+0x39/0x40
[   29.612538] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612541] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612542] RSP: 0018:ffffc90000003108 EFLAGS: 00010086
[   29.612545] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612547] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612549] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612550] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612552] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612555]  ? native_iret+0x7/0x7
[   29.612559]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612561]  do_async_page_fault+0x12/0x8b
[   29.612564]  async_page_fault+0x39/0x40
[   29.612567] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612570] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612571] RSP: 0018:ffffc900000031e8 EFLAGS: 00010086
[   29.612574] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612576] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612578] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612580] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612582] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612585]  ? native_iret+0x7/0x7
[   29.612589]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612591]  do_async_page_fault+0x12/0x8b
[   29.612594]  async_page_fault+0x39/0x40
[   29.612597] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612600] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612601] RSP: 0018:ffffc900000032c8 EFLAGS: 00010082
[   29.612604] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612606] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612608] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612609] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612611] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612613]  ? native_iret+0x7/0x7
[   29.612617]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612619]  do_async_page_fault+0x12/0x8b
[   29.612622]  async_page_fault+0x39/0x40
[   29.612625] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612628] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612629] RSP: 0018:ffffc900000033a8 EFLAGS: 00010086
[   29.612632] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612634] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612635] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612637] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612639] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612642]  ? native_iret+0x7/0x7
[   29.612645]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612647]  do_async_page_fault+0x12/0x8b
[   29.612650]  async_page_fault+0x39/0x40
[   29.612653] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612656] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612657] RSP: 0018:ffffc90000003488 EFLAGS: 00010082
[   29.612660] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612662] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612664] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612665] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612667] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612670]  ? native_iret+0x7/0x7
[   29.612674]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612676]  do_async_page_fault+0x12/0x8b
[   29.612679]  async_page_fault+0x39/0x40
[   29.612682] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612685] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612687] RSP: 0018:ffffc90000003568 EFLAGS: 00010082
[   29.612689] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612691] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612693] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612694] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612697] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612699]  ? native_iret+0x7/0x7
[   29.612703]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612705]  do_async_page_fault+0x12/0x8b
[   29.612708]  async_page_fault+0x39/0x40
[   29.612711] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612713] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612714] RSP: 0018:ffffc90000003648 EFLAGS: 00010086
[   29.612716] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612718] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612719] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612720] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612722] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612724]  ? native_iret+0x7/0x7
[   29.612727]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612730]  do_async_page_fault+0x12/0x8b
[   29.612732]  async_page_fault+0x39/0x40
[   29.612735] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612737] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612739] RSP: 0018:ffffc90000003728 EFLAGS: 00010082
[   29.612741] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612743] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612744] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612746] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612748] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612750]  ? native_iret+0x7/0x7
[   29.612754]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612757]  do_async_page_fault+0x12/0x8b
[   29.612760]  async_page_fault+0x39/0x40
[   29.612763] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612765] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612767] RSP: 0018:ffffc90000003808 EFLAGS: 00010086
[   29.612769] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612771] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612773] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612774] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612776] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612780]  ? native_iret+0x7/0x7
[   29.612783]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612786]  do_async_page_fault+0x12/0x8b
[   29.612789]  async_page_fault+0x39/0x40
[   29.612792] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612795] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612796] RSP: 0018:ffffc900000038e8 EFLAGS: 00010086
[   29.612799] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612801] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612803] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612805] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612807] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612810]  ? native_iret+0x7/0x7
[   29.612813]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612816]  do_async_page_fault+0x12/0x8b
[   29.612818]  async_page_fault+0x39/0x40
[   29.612821] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612824] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612825] RSP: 0018:ffffc900000039c8 EFLAGS: 00010082
[   29.612828] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612830] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612831] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612833] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612835] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612838]  ? native_iret+0x7/0x7
[   29.612841]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612843]  do_async_page_fault+0x12/0x8b
[   29.612846]  async_page_fault+0x39/0x40
[   29.612849] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612851] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612852] RSP: 0018:ffffc90000003aa8 EFLAGS: 00010086
[   29.612854] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612856] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612858] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612860] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612862] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612865]  ? native_iret+0x7/0x7
[   29.612869]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612871]  do_async_page_fault+0x12/0x8b
[   29.612874]  async_page_fault+0x39/0x40
[   29.612878] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612880] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612882] RSP: 0018:ffffc90000003b88 EFLAGS: 00010082
[   29.612884] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612886] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612888] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612890] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612892] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612895]  ? native_iret+0x7/0x7
[   29.612898]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612901]  do_async_page_fault+0x12/0x8b
[   29.612904]  async_page_fault+0x39/0x40
[   29.612907] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612910] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612911] RSP: 0018:ffffc90000003c68 EFLAGS: 00010082
[   29.612914] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612916] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612918] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612920] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612922] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612925]  ? native_iret+0x7/0x7
[   29.612928]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612931]  do_async_page_fault+0x12/0x8b
[   29.612934]  async_page_fault+0x39/0x40
[   29.612937] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612939] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612941] RSP: 0018:ffffc90000003d48 EFLAGS: 00010086
[   29.612944] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612946] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612948] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612950] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612951] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612955]  ? native_iret+0x7/0x7
[   29.612958]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612961]  do_async_page_fault+0x12/0x8b
[   29.612964]  async_page_fault+0x39/0x40
[   29.612967] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612969] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612971] RSP: 0018:ffffc90000003e28 EFLAGS: 00010082
[   29.612973] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.612975] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.612976] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.612978] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.612979] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.612982]  ? native_iret+0x7/0x7
[   29.612986]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612989]  do_async_page_fault+0x12/0x8b
[   29.612992]  async_page_fault+0x39/0x40
[   29.612995] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.612997] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.612998] RSP: 0018:ffffc90000003f08 EFLAGS: 00010086
[   29.613001] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613003] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613005] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613007] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613009] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613012]  ? native_iret+0x7/0x7
[   29.613015]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613018]  do_async_page_fault+0x12/0x8b
[   29.613021]  async_page_fault+0x39/0x40
[   29.613024] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613026] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613028] RSP: 0018:ffffc90000003fe8 EFLAGS: 00010086
[   29.613031] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613033] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613034] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613036] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613038] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613042]  ? native_iret+0x7/0x7
[   29.613045]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613048]  do_async_page_fault+0x12/0x8b
[   29.613051]  async_page_fault+0x39/0x40
[   29.613055] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613057] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613058] RSP: 0018:ffffc900000040c8 EFLAGS: 00010082
[   29.613061] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613063] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613065] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613067] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613069] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613072]  ? native_iret+0x7/0x7
[   29.613075]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613078]  do_async_page_fault+0x12/0x8b
[   29.613081]  async_page_fault+0x39/0x40
[   29.613084] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613087] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613088] RSP: 0018:ffffc900000041a8 EFLAGS: 00010086
[   29.613091] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613093] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613095] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613097] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613099] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613102]  ? native_iret+0x7/0x7
[   29.613105]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613108]  do_async_page_fault+0x12/0x8b
[   29.613111]  async_page_fault+0x39/0x40
[   29.613115] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613117] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613119] RSP: 0018:ffffc90000004288 EFLAGS: 00010082
[   29.613121] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613123] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613125] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613127] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613129] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613132]  ? native_iret+0x7/0x7
[   29.613135]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613138]  do_async_page_fault+0x12/0x8b
[   29.613141]  async_page_fault+0x39/0x40
[   29.613144] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613147] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613148] RSP: 0018:ffffc90000004368 EFLAGS: 00010082
[   29.613151] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613153] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613155] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613157] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613159] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613162]  ? native_iret+0x7/0x7
[   29.613165]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613168]  do_async_page_fault+0x12/0x8b
[   29.613171]  async_page_fault+0x39/0x40
[   29.613174] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613176] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613178] RSP: 0018:ffffc90000004448 EFLAGS: 00010086
[   29.613180] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613182] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613184] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613186] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613188] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613191]  ? native_iret+0x7/0x7
[   29.613195]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613197]  do_async_page_fault+0x12/0x8b
[   29.613200]  async_page_fault+0x39/0x40
[   29.613203] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613206] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613207] RSP: 0018:ffffc90000004528 EFLAGS: 00010082
[   29.613209] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613211] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613213] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613215] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613217] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613220]  ? native_iret+0x7/0x7
[   29.613224]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613227]  do_async_page_fault+0x12/0x8b
[   29.613230]  async_page_fault+0x39/0x40
[   29.613233] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613235] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613237] RSP: 0018:ffffc90000004608 EFLAGS: 00010086
[   29.613239] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613241] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613244] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613245] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613247] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613251]  ? native_iret+0x7/0x7
[   29.613254]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613257]  do_async_page_fault+0x12/0x8b
[   29.613260]  async_page_fault+0x39/0x40
[   29.613263] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613266] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613267] RSP: 0018:ffffc900000046e8 EFLAGS: 00010086
[   29.613270] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613272] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613274] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613276] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613278] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613281]  ? native_iret+0x7/0x7
[   29.613284]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613287]  do_async_page_fault+0x12/0x8b
[   29.613290]  async_page_fault+0x39/0x40
[   29.613293] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613295] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613297] RSP: 0018:ffffc900000047c8 EFLAGS: 00010082
[   29.613299] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613301] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613303] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613305] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613307] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613311]  ? native_iret+0x7/0x7
[   29.613314]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613316]  do_async_page_fault+0x12/0x8b
[   29.613319]  async_page_fault+0x39/0x40
[   29.613322] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613325] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613326] RSP: 0018:ffffc900000048a8 EFLAGS: 00010086
[   29.613329] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613331] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613333] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613335] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613337] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613340]  ? native_iret+0x7/0x7
[   29.613344]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613346]  do_async_page_fault+0x12/0x8b
[   29.613349]  async_page_fault+0x39/0x40
[   29.613352] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613354] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613356] RSP: 0018:ffffc90000004988 EFLAGS: 00010082
[   29.613358] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613360] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613362] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613364] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613366] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613369]  ? native_iret+0x7/0x7
[   29.613373]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613375]  do_async_page_fault+0x12/0x8b
[   29.613378]  async_page_fault+0x39/0x40
[   29.613381] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613384] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613385] RSP: 0018:ffffc90000004a68 EFLAGS: 00010082
[   29.613388] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613390] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613392] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613393] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613395] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613399]  ? native_iret+0x7/0x7
[   29.613402]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613405]  do_async_page_fault+0x12/0x8b
[   29.613408]  async_page_fault+0x39/0x40
[   29.613411] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613413] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613415] RSP: 0018:ffffc90000004b48 EFLAGS: 00010086
[   29.613417] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613419] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613421] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613423] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613425] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613428]  ? native_iret+0x7/0x7
[   29.613431]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613434]  do_async_page_fault+0x12/0x8b
[   29.613437]  async_page_fault+0x39/0x40
[   29.613440] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613443] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613444] RSP: 0018:ffffc90000004c28 EFLAGS: 00010082
[   29.613447] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613449] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613451] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613453] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613454] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613458]  ? native_iret+0x7/0x7
[   29.613461]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613464]  do_async_page_fault+0x12/0x8b
[   29.613467]  async_page_fault+0x39/0x40
[   29.613470] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613472] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613474] RSP: 0018:ffffc90000004d08 EFLAGS: 00010086
[   29.613476] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613478] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613480] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613482] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613484] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613487]  ? native_iret+0x7/0x7
[   29.613490]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613493]  do_async_page_fault+0x12/0x8b
[   29.613496]  async_page_fault+0x39/0x40
[   29.613499] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613502] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613503] RSP: 0018:ffffc90000004de8 EFLAGS: 00010086
[   29.613506] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613507] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613509] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613511] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613513] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613516]  ? native_iret+0x7/0x7
[   29.613520]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613523]  do_async_page_fault+0x12/0x8b
[   29.613525]  async_page_fault+0x39/0x40
[   29.613528] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613531] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613533] RSP: 0018:ffffc90000004ec8 EFLAGS: 00010082
[   29.613535] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613537] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613539] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613541] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613543] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613546]  ? native_iret+0x7/0x7
[   29.613550]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613552]  do_async_page_fault+0x12/0x8b
[   29.613555]  async_page_fault+0x39/0x40
[   29.613558] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613561] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613562] RSP: 0018:ffffc90000004fa8 EFLAGS: 00010086
[   29.613565] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613567] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613568] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613570] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613572] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613576]  ? native_iret+0x7/0x7
[   29.613579]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613582]  do_async_page_fault+0x12/0x8b
[   29.613585]  async_page_fault+0x39/0x40
[   29.613588] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613590] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613592] RSP: 0018:ffffc90000005088 EFLAGS: 00010082
[   29.613594] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613596] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613598] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613600] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613602] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613605]  ? native_iret+0x7/0x7
[   29.613609]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613611]  do_async_page_fault+0x12/0x8b
[   29.613614]  async_page_fault+0x39/0x40
[   29.613617] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613620] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613621] RSP: 0018:ffffc90000005168 EFLAGS: 00010082
[   29.613624] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613626] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613628] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613630] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613632] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613635]  ? native_iret+0x7/0x7
[   29.613638]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613641]  do_async_page_fault+0x12/0x8b
[   29.613644]  async_page_fault+0x39/0x40
[   29.613647] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613650] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613651] RSP: 0018:ffffc90000005248 EFLAGS: 00010086
[   29.613654] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613656] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613658] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613660] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613661] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613665]  ? native_iret+0x7/0x7
[   29.613668]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613671]  do_async_page_fault+0x12/0x8b
[   29.613674]  async_page_fault+0x39/0x40
[   29.613677] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613679] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613681] RSP: 0018:ffffc90000005328 EFLAGS: 00010082
[   29.613683] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613685] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613687] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613689] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613690] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613694]  ? native_iret+0x7/0x7
[   29.613697]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613700]  do_async_page_fault+0x12/0x8b
[   29.613703]  async_page_fault+0x39/0x40
[   29.613706] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613708] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613710] RSP: 0018:ffffc90000005408 EFLAGS: 00010086
[   29.613712] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613714] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613716] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613717] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613719] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613722]  ? native_iret+0x7/0x7
[   29.613726]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613729]  do_async_page_fault+0x12/0x8b
[   29.613731]  async_page_fault+0x39/0x40
[   29.613735] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613738] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613739] RSP: 0018:ffffc900000054e8 EFLAGS: 00010086
[   29.613742] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613743] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613745] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613747] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613749] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613752]  ? native_iret+0x7/0x7
[   29.613755]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613758]  do_async_page_fault+0x12/0x8b
[   29.613761]  async_page_fault+0x39/0x40
[   29.613764] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613766] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613767] RSP: 0018:ffffc900000055c8 EFLAGS: 00010082
[   29.613769] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613771] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613773] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613775] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613777] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613780]  ? native_iret+0x7/0x7
[   29.613783]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613786]  do_async_page_fault+0x12/0x8b
[   29.613788]  async_page_fault+0x39/0x40
[   29.613791] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613794] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613795] RSP: 0018:ffffc900000056a8 EFLAGS: 00010086
[   29.613798] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613800] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613801] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613803] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613804] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613852]  ? native_iret+0x7/0x7
[   29.613857]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613860]  do_async_page_fault+0x12/0x8b
[   29.613863]  async_page_fault+0x39/0x40
[   29.613866] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613869] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613870] RSP: 0018:ffffc90000005788 EFLAGS: 00010082
[   29.613873] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613875] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613877] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613879] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613881] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613884]  ? native_iret+0x7/0x7
[   29.613887]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613890]  do_async_page_fault+0x12/0x8b
[   29.613893]  async_page_fault+0x39/0x40
[   29.613896] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613898] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613900] RSP: 0018:ffffc90000005868 EFLAGS: 00010082
[   29.613902] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613904] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613906] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613908] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613910] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613913]  ? native_iret+0x7/0x7
[   29.613917]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613920]  do_async_page_fault+0x12/0x8b
[   29.613923]  async_page_fault+0x39/0x40
[   29.613926] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613928] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613930] RSP: 0018:ffffc90000005948 EFLAGS: 00010086
[   29.613933] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613935] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613937] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613939] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613941] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613944]  ? native_iret+0x7/0x7
[   29.613947]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613950]  do_async_page_fault+0x12/0x8b
[   29.613953]  async_page_fault+0x39/0x40
[   29.613956] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613959] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613960] RSP: 0018:ffffc90000005a28 EFLAGS: 00010082
[   29.613963] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613964] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613965] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613967] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.613969] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.613973]  ? native_iret+0x7/0x7
[   29.613978]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613980]  do_async_page_fault+0x12/0x8b
[   29.613983]  async_page_fault+0x39/0x40
[   29.613986] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.613989] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.613990] RSP: 0018:ffffc90000005b08 EFLAGS: 00010086
[   29.613993] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.613995] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.613997] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.613999] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614001] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614004]  ? native_iret+0x7/0x7
[   29.614008]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614010]  do_async_page_fault+0x12/0x8b
[   29.614013]  async_page_fault+0x39/0x40
[   29.614016] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614019] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614020] RSP: 0018:ffffc90000005be8 EFLAGS: 00010086
[   29.614022] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614024] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614025] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614027] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614029] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614033]  ? native_iret+0x7/0x7
[   29.614036]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614038]  do_async_page_fault+0x12/0x8b
[   29.614041]  async_page_fault+0x39/0x40
[   29.614044] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614046] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614048] RSP: 0018:ffffc90000005cc8 EFLAGS: 00010082
[   29.614050] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614052] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614054] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614056] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614058] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614061]  ? native_iret+0x7/0x7
[   29.614065]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614067]  do_async_page_fault+0x12/0x8b
[   29.614070]  async_page_fault+0x39/0x40
[   29.614074] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614076] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614078] RSP: 0018:ffffc90000005da8 EFLAGS: 00010086
[   29.614080] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614082] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614083] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614085] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614087] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614090]  ? native_iret+0x7/0x7
[   29.614094]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614096]  do_async_page_fault+0x12/0x8b
[   29.614100]  async_page_fault+0x39/0x40
[   29.614103] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614105] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614107] RSP: 0018:ffffc90000005e88 EFLAGS: 00010082
[   29.614110] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614112] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614113] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614116] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614117] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614121]  ? native_iret+0x7/0x7
[   29.614125]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614127]  do_async_page_fault+0x12/0x8b
[   29.614130]  async_page_fault+0x39/0x40
[   29.614133] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614136] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614137] RSP: 0018:ffffc90000005f68 EFLAGS: 00010082
[   29.614140] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614142] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614144] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614146] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614147] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614151]  ? native_iret+0x7/0x7
[   29.614154]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614157]  do_async_page_fault+0x12/0x8b
[   29.614160]  async_page_fault+0x39/0x40
[   29.614163] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614165] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614167] RSP: 0018:ffffc90000006048 EFLAGS: 00010086
[   29.614170] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614172] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614173] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614175] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614177] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614181]  ? native_iret+0x7/0x7
[   29.614184]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614187]  do_async_page_fault+0x12/0x8b
[   29.614190]  async_page_fault+0x39/0x40
[   29.614193] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614195] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614197] RSP: 0018:ffffc90000006128 EFLAGS: 00010082
[   29.614200] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614202] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614203] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614205] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614207] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614210]  ? native_iret+0x7/0x7
[   29.614214]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614216]  do_async_page_fault+0x12/0x8b
[   29.614220]  async_page_fault+0x39/0x40
[   29.614223] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614225] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614227] RSP: 0018:ffffc90000006208 EFLAGS: 00010086
[   29.614230] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614232] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614233] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614235] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614237] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614240]  ? native_iret+0x7/0x7
[   29.614243]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614246]  do_async_page_fault+0x12/0x8b
[   29.614249]  async_page_fault+0x39/0x40
[   29.614252] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614255] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614257] RSP: 0018:ffffc900000062e8 EFLAGS: 00010086
[   29.614259] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614261] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614262] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614264] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614266] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614269]  ? native_iret+0x7/0x7
[   29.614273]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614275]  do_async_page_fault+0x12/0x8b
[   29.614278]  async_page_fault+0x39/0x40
[   29.614282] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614284] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614286] RSP: 0018:ffffc900000063c8 EFLAGS: 00010082
[   29.614288] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614290] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614292] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614294] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614296] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614299]  ? native_iret+0x7/0x7
[   29.614303]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614305]  do_async_page_fault+0x12/0x8b
[   29.614308]  async_page_fault+0x39/0x40
[   29.614311] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614314] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614315] RSP: 0018:ffffc900000064a8 EFLAGS: 00010086
[   29.614318] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614320] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614322] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614324] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614326] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614329]  ? native_iret+0x7/0x7
[   29.614333]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614336]  do_async_page_fault+0x12/0x8b
[   29.614339]  async_page_fault+0x39/0x40
[   29.614342] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614345] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614346] RSP: 0018:ffffc90000006588 EFLAGS: 00010082
[   29.614349] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614350] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614352] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614354] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614356] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614359]  ? native_iret+0x7/0x7
[   29.614363]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614365]  do_async_page_fault+0x12/0x8b
[   29.614368]  async_page_fault+0x39/0x40
[   29.614372] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614374] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614376] RSP: 0018:ffffc90000006668 EFLAGS: 00010082
[   29.614378] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614380] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614382] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614384] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614386] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614390]  ? native_iret+0x7/0x7
[   29.614394]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614396]  do_async_page_fault+0x12/0x8b
[   29.614400]  async_page_fault+0x39/0x40
[   29.614403] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614406] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614407] RSP: 0018:ffffc90000006748 EFLAGS: 00010086
[   29.614410] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614412] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614414] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614415] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614417] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614420]  ? native_iret+0x7/0x7
[   29.614424]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614426]  do_async_page_fault+0x12/0x8b
[   29.614429]  async_page_fault+0x39/0x40
[   29.614432] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614435] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614436] RSP: 0018:ffffc90000006828 EFLAGS: 00010082
[   29.614439] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614441] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614443] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614444] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614446] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614450]  ? native_iret+0x7/0x7
[   29.614454]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614456]  do_async_page_fault+0x12/0x8b
[   29.614459]  async_page_fault+0x39/0x40
[   29.614462] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614464] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614466] RSP: 0018:ffffc90000006908 EFLAGS: 00010086
[   29.614468] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614470] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614472] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614474] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614476] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614479]  ? native_iret+0x7/0x7
[   29.614482]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614485]  do_async_page_fault+0x12/0x8b
[   29.614488]  async_page_fault+0x39/0x40
[   29.614491] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614493] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614494] RSP: 0018:ffffc900000069e8 EFLAGS: 00010086
[   29.614497] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614499] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614501] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614503] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614505] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614508]  ? native_iret+0x7/0x7
[   29.614512]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614514]  do_async_page_fault+0x12/0x8b
[   29.614517]  async_page_fault+0x39/0x40
[   29.614520] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614523] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614524] RSP: 0018:ffffc90000006ac8 EFLAGS: 00010082
[   29.614526] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614528] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614530] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614532] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614534] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614537]  ? native_iret+0x7/0x7
[   29.614541]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614543]  do_async_page_fault+0x12/0x8b
[   29.614546]  async_page_fault+0x39/0x40
[   29.614550] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614552] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614554] RSP: 0018:ffffc90000006ba8 EFLAGS: 00010086
[   29.614556] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614558] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614560] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614562] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614564] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614567]  ? native_iret+0x7/0x7
[   29.614570]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614573]  do_async_page_fault+0x12/0x8b
[   29.614576]  async_page_fault+0x39/0x40
[   29.614579] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614582] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614583] RSP: 0018:ffffc90000006c88 EFLAGS: 00010082
[   29.614586] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614588] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614590] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614591] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614593] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614596]  ? native_iret+0x7/0x7
[   29.614600]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614602]  do_async_page_fault+0x12/0x8b
[   29.614605]  async_page_fault+0x39/0x40
[   29.614608] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614610] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614612] RSP: 0018:ffffc90000006d68 EFLAGS: 00010082
[   29.614615] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614617] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614618] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614620] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614622] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614626]  ? native_iret+0x7/0x7
[   29.614629]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614632]  do_async_page_fault+0x12/0x8b
[   29.614635]  async_page_fault+0x39/0x40
[   29.614638] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614641] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614642] RSP: 0018:ffffc90000006e48 EFLAGS: 00010086
[   29.614645] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614647] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614649] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614651] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614652] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614655]  ? native_iret+0x7/0x7
[   29.614659]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614662]  do_async_page_fault+0x12/0x8b
[   29.614665]  async_page_fault+0x39/0x40
[   29.614668] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614671] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614673] RSP: 0018:ffffc90000006f28 EFLAGS: 00010082
[   29.614675] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614677] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614679] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614681] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614682] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614686]  ? native_iret+0x7/0x7
[   29.614689]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614692]  do_async_page_fault+0x12/0x8b
[   29.614695]  async_page_fault+0x39/0x40
[   29.614698] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614701] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614702] RSP: 0018:ffffc90000007008 EFLAGS: 00010086
[   29.614705] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614707] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614709] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614711] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614713] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614716]  ? native_iret+0x7/0x7
[   29.614720]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614722]  do_async_page_fault+0x12/0x8b
[   29.614725]  async_page_fault+0x39/0x40
[   29.614729] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614731] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614733] RSP: 0018:ffffc900000070e8 EFLAGS: 00010086
[   29.614735] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614737] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614739] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614741] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614743] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614746]  ? native_iret+0x7/0x7
[   29.614750]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614753]  do_async_page_fault+0x12/0x8b
[   29.614755]  async_page_fault+0x39/0x40
[   29.614758] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614761] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614762] RSP: 0018:ffffc900000071c8 EFLAGS: 00010082
[   29.614765] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614766] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614768] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614770] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614771] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614775]  ? native_iret+0x7/0x7
[   29.614779]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614781]  do_async_page_fault+0x12/0x8b
[   29.614785]  async_page_fault+0x39/0x40
[   29.614788] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614791] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614792] RSP: 0018:ffffc900000072a8 EFLAGS: 00010086
[   29.614794] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614796] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614797] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614799] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614801] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614804]  ? native_iret+0x7/0x7
[   29.614807]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614809]  do_async_page_fault+0x12/0x8b
[   29.614813]  async_page_fault+0x39/0x40
[   29.614816] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614818] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614820] RSP: 0018:ffffc90000007388 EFLAGS: 00010082
[   29.614822] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614824] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614826] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614827] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614829] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614833]  ? native_iret+0x7/0x7
[   29.614836]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614839]  do_async_page_fault+0x12/0x8b
[   29.614842]  async_page_fault+0x39/0x40
[   29.614846] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614849] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614850] RSP: 0018:ffffc90000007468 EFLAGS: 00010082
[   29.614853] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614855] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614857] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614858] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614860] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614863]  ? native_iret+0x7/0x7
[   29.614866]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614869]  do_async_page_fault+0x12/0x8b
[   29.614872]  async_page_fault+0x39/0x40
[   29.614875] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614877] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614879] RSP: 0018:ffffc90000007548 EFLAGS: 00010086
[   29.614882] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614884] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614885] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614887] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614889] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614892]  ? native_iret+0x7/0x7
[   29.614896]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614898]  do_async_page_fault+0x12/0x8b
[   29.614901]  async_page_fault+0x39/0x40
[   29.614904] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614907] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614908] RSP: 0018:ffffc90000007628 EFLAGS: 00010082
[   29.614911] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614913] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614915] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614917] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614918] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614922]  ? native_iret+0x7/0x7
[   29.614925]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614928]  do_async_page_fault+0x12/0x8b
[   29.614930]  async_page_fault+0x39/0x40
[   29.614934] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614936] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614938] RSP: 0018:ffffc90000007708 EFLAGS: 00010086
[   29.614941] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614943] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614944] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614946] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614948] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614951]  ? native_iret+0x7/0x7
[   29.614955]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614957]  do_async_page_fault+0x12/0x8b
[   29.614960]  async_page_fault+0x39/0x40
[   29.614963] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614965] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614967] RSP: 0018:ffffc900000077e8 EFLAGS: 00010086
[   29.614969] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614971] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.614973] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.614975] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.614976] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.614979]  ? native_iret+0x7/0x7
[   29.614983]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614985]  do_async_page_fault+0x12/0x8b
[   29.614988]  async_page_fault+0x39/0x40
[   29.614991] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.614993] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.614994] RSP: 0018:ffffc900000078c8 EFLAGS: 00010082
[   29.614997] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.614999] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615000] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615002] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615004] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615007]  ? native_iret+0x7/0x7
[   29.615011]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615013]  do_async_page_fault+0x12/0x8b
[   29.615016]  async_page_fault+0x39/0x40
[   29.615019] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615022] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615024] RSP: 0018:ffffc900000079a8 EFLAGS: 00010086
[   29.615026] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615028] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615030] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615032] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615034] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615037]  ? native_iret+0x7/0x7
[   29.615041]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615043]  do_async_page_fault+0x12/0x8b
[   29.615046]  async_page_fault+0x39/0x40
[   29.615049] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615052] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615054] RSP: 0018:ffffc90000007a88 EFLAGS: 00010082
[   29.615056] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615058] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615060] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615062] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615064] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615067]  ? native_iret+0x7/0x7
[   29.615070]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615073]  do_async_page_fault+0x12/0x8b
[   29.615076]  async_page_fault+0x39/0x40
[   29.615079] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615081] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615083] RSP: 0018:ffffc90000007b68 EFLAGS: 00010082
[   29.615085] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615087] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615089] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615091] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615093] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615096]  ? native_iret+0x7/0x7
[   29.615100]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615102]  do_async_page_fault+0x12/0x8b
[   29.615105]  async_page_fault+0x39/0x40
[   29.615109] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615111] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615113] RSP: 0018:ffffc90000007c48 EFLAGS: 00010086
[   29.615115] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615117] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615119] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615121] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615122] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615125]  ? native_iret+0x7/0x7
[   29.615129]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615131]  do_async_page_fault+0x12/0x8b
[   29.615134]  async_page_fault+0x39/0x40
[   29.615137] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615140] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615141] RSP: 0018:ffffc90000007d28 EFLAGS: 00010082
[   29.615144] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615145] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615147] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615149] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615151] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615154]  ? native_iret+0x7/0x7
[   29.615158]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615160]  do_async_page_fault+0x12/0x8b
[   29.615163]  async_page_fault+0x39/0x40
[   29.615166] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615169] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615170] RSP: 0018:ffffc90000007e08 EFLAGS: 00010086
[   29.615173] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615175] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615176] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615178] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615180] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615183]  ? native_iret+0x7/0x7
[   29.615187]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615190]  do_async_page_fault+0x12/0x8b
[   29.615193]  async_page_fault+0x39/0x40
[   29.615196] RIP: 0010:kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615199] Code: cb 00 8b 05 8f b6 74 03 85 c0 74 2c 48 c7 c7 c0 e3 e4 83 e8 d2 d8 cb 00 8b 1d 39 b6 74 03 48 c7 c7 00 e4 e4 83 e8 c0 d8 cb 00 <c7> 05 23 b6 74 03 00 00 00 00 89 d8 5b c3 31 c0 5b c3 55 41 56 53
[   29.615200] RSP: 0018:ffffc90000007ee8 EFLAGS: 00010086
[   29.615203] RAX: 0000000080010001 RBX: 0000000000000000 RCX: ffffffff83a00ab7
[   29.615205] RDX: ffffffff847da380 RSI: 0000000000000003 RDI: ffffffff83e4e400
[   29.615207] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615208] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da380
[   29.615210] R13: 0000000000000000 R14: ffffffff847da380 R15: 0000000000000000
[   29.615214]  ? native_iret+0x7/0x7
[   29.615217]  ? kvm_read_and_reset_pf_reason+0x35/0x47
[   29.615220]  do_async_page_fault+0x12/0x8b
[   29.615223]  async_page_fault+0x39/0x40
[   29.615226] RIP: 0010:kvm_guest_apic_eoi_write+0x14/0x7b
[   29.615229] Code: 38 c1 7c 8c be 08 00 00 00 4c 89 ff e8 f3 90 3b 00 e9 7a ff ff ff 41 56 53 48 c7 c7 80 a3 7d 84 be 08 00 00 00 e8 e9 68 3b 00 <48> 0f ba 35 ed b1 74 03 00 72 58 48 c7 c0 10 57 7d 84 48 c1 e8 03
[   29.615231] RSP: 0018:ffffc90000007fc0 EFLAGS: 00010056
[   29.615234] RAX: 1ffffffff08faa01 RBX: ffffffff847d5600 RCX: ffffffff8108f18a
[   29.615235] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff847da380
[   29.615237] RBP: 0000000000000000 R08: dffffc0000000000 R09: fffffbfff08fb471
[   29.615239] R10: fffffbfff08fb471 R11: 1ffffffff0c80000 R12: 0000000000000000
[   29.615241] R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
[   29.615245]  ? kvm_guest_apic_eoi_write+0x14/0x7b
[   29.615249]  smp_apic_timer_interrupt+0x81/0xeb
[   29.615253]  apic_timer_interrupt+0xf/0x20
[   29.615255]  </IRQ>
[   29.615260] RIP: 0010:console_unlock+0x5f6/0x79e
[   29.615262] Code: 03 85 c0 74 79 84 db 74 0b c6 05 9c 0d 8a 04 00 b3 01 eb 02 31 db e8 a7 3b 00 00 48 8b 44 24 30 48 89 44 24 40 ff 74 24 40 9d <89> d8 0a 44 24 07 a8 01 74 05 0f b6 db eb 15 31 db 48 c7 c7 c0 e4
[   29.615263] RSP: 0018:ffffc9000001fd30 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[   29.615266] RAX: 0000000000000246 RBX: 0000000000000000 RCX: 0000000000000002
[   29.615268] RDX: dffffc0000000000 RSI: 0000000000000780 RDI: 0000000000000001
[   29.615270] RBP: 0000000000000005 R08: dffffc0000000000 R09: ffffc9000001fc88
[   29.615271] R10: fffff52000003f93 R11: 0000000000000000 R12: 1ffffffff0997e4e
[   29.615273] R13: ffffffff84cbf2a0 R14: 0000000000000000 R15: ffffffff84cbf270
[   29.615278]  vprintk_emit+0x1fa/0x25d
[   29.615283]  printk+0x66/0x71
[   29.615288]  ? adjust_managed_page_count+0x5f/0x6a
[   29.615292]  free_reserved_area+0x1a3/0x1a5
[   29.615297]  free_kernel_image_pages+0xe/0x2b
[   29.615300]  mark_rodata_ro+0xc1/0xe6
[   29.615304]  ? rest_init+0xfe/0xfe
[   29.615307]  kernel_init+0x29/0x10b
[   29.615310]  ? rest_init+0xfe/0xfe
[   29.615313]  ret_from_fork+0x1f/0x30
[   29.615316] Modules linked in:
[   29.615324] ---[ end trace 6d4ace2332bcce47 ]---
[   29.615329] RIP: 0010:__this_cpu_preempt_check+0x0/0x1ad
[   29.615332] Code: 0b 85 e8 a5 bc 6f ff e9 21 ff ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 6e ff ff ff 4c 89 ff e8 87 bc 6f ff e9 61 ff ff ff <55> 41 57 41 56 41 54 53 50 8b 05 ea aa d3 02 a9 ff ff ff 7f 74 0d
[   29.615334] RSP: 0018:ffffc90000000000 EFLAGS: 00010046
[   29.615337] RAX: 0000000083a00ab7 RBX: ffffc90000000038 RCX: ffffffff83a00ab7
[   29.615339] RDX: ffffffff847da2c0 RSI: 0000000000000003 RDI: ffffffff83e4e3c0
[   29.615341] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   29.615343] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff847da2c0
[   29.615345] R13: 0000000000000000 R14: ffffffff847da2c0 R15: 0000000000000000
[   29.615348] FS:  0000000000000000(0000) GS:ffffffff84a87000(0000) knlGS:0000000000000000
[   29.615350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.615352] CR2: ffffc8fffffffff8 CR3: 0000000004a36000 CR4: 00000000000406f0
[   29.615361] Kernel panic - not syncing: Fatal exception in interrupt
[   29.615363] Kernel Offset: disabled

Elapsed time: 60

qemu-img create -f qcow2 disk-vm-snb-10-0 256G


To reproduce:

        # build kernel
	cd linux
	cp config-5.4.0-11726-g264b0d2bee148 .config
	make HOSTCC=clang-11 CC=clang-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
lkp


--32KBALpRDK42x9o9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-11726-g264b0d2bee148"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0 Kernel Configuration
#

#
# Compiler: clang version 11.0.0 (git://gitmirror/llvm_project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
#
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=110000
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_NFIT=y
CONFIG_NFIT_SECURITY_DEBUG=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
CONFIG_CHTCRC_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_BFQ_CGROUP_DEBUG=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=y
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
# CONFIG_TCP_CONG_ILLINOIS is not set
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_BIC=y
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
CONFIG_IPV6_FOU=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NF_CONNTRACK is not set
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_TABLES=y
# CONFIG_NF_TABLES_SET is not set
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_COUNTER=y
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_TUNNEL=y
CONFIG_NFT_OBJREF=y
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=y
CONFIG_NFT_REJECT_INET=y
# CONFIG_NFT_COMPAT is not set
CONFIG_NFT_HASH=y
CONFIG_NFT_XFRM=y
CONFIG_NFT_SOCKET=y
CONFIG_NFT_TPROXY=y
CONFIG_NF_DUP_NETDEV=y
CONFIG_NFT_DUP_NETDEV=y
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=y
CONFIG_IP_SET_HASH_IP=y
CONFIG_IP_SET_HASH_IPMARK=y
CONFIG_IP_SET_HASH_IPPORT=y
CONFIG_IP_SET_HASH_IPPORTIP=y
# CONFIG_IP_SET_HASH_IPPORTNET is not set
CONFIG_IP_SET_HASH_IPMAC=y
CONFIG_IP_SET_HASH_MAC=y
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
# CONFIG_IP_SET_HASH_NETPORT is not set
CONFIG_IP_SET_HASH_NETIFACE=y
# CONFIG_IP_SET_LIST_SET is not set
CONFIG_IP_VS=y
# CONFIG_IP_VS_IPV6 is not set
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
# CONFIG_IP_VS_PROTO_AH is not set
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
# CONFIG_IP_VS_RR is not set
# CONFIG_IP_VS_WRR is not set
CONFIG_IP_VS_LC=y
CONFIG_IP_VS_WLC=y
CONFIG_IP_VS_FO=y
CONFIG_IP_VS_OVF=y
CONFIG_IP_VS_LBLC=y
CONFIG_IP_VS_LBLCR=y
CONFIG_IP_VS_DH=y
CONFIG_IP_VS_SH=y
CONFIG_IP_VS_MH=y
# CONFIG_IP_VS_SED is not set
CONFIG_IP_VS_NQ=y

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
# CONFIG_IP_NF_TARGET_REJECT is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_RAW=y
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=y
CONFIG_NFT_DUP_IPV6=y
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES_BRIDGE=y
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=y
CONFIG_NF_LOG_BRIDGE=y
CONFIG_BRIDGE_NF_EBTABLES=y
# CONFIG_BRIDGE_EBT_BROUTE is not set
# CONFIG_BRIDGE_EBT_T_FILTER is not set
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
CONFIG_BRIDGE_EBT_IP6=y
CONFIG_BRIDGE_EBT_LIMIT=y
# CONFIG_BRIDGE_EBT_MARK is not set
CONFIG_BRIDGE_EBT_PKTTYPE=y
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
# CONFIG_BRIDGE_EBT_ARPREPLY is not set
CONFIG_BRIDGE_EBT_DNAT=y
# CONFIG_BRIDGE_EBT_MARK_T is not set
CONFIG_BRIDGE_EBT_REDIRECT=y
# CONFIG_BRIDGE_EBT_SNAT is not set
# CONFIG_BRIDGE_EBT_LOG is not set
CONFIG_BRIDGE_EBT_NFLOG=y
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_UDP is not set
# CONFIG_TIPC_CRYPTO is not set
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=y
CONFIG_ATM_BR2684_IPFILTER=y
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_ATM=y
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=y
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=y
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=y
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=y
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=y
CONFIG_NET_EMATCH_IPSET=y
CONFIG_NET_EMATCH_IPT=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=y
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=y
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
CONFIG_OPENVSWITCH=y
# CONFIG_OPENVSWITCH_VXLAN is not set
# CONFIG_OPENVSWITCH_GENEVE is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
CONFIG_6PACK=y
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
CONFIG_YAM=y
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=y
# CONFIG_CAN_GW is not set
CONFIG_CAN_J1939=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=y
# CONFIG_CAN_C_CAN_PLATFORM is not set
# CONFIG_CAN_C_CAN_PCI is not set
CONFIG_CAN_CC770=y
CONFIG_CAN_CC770_ISA=y
CONFIG_CAN_CC770_PLATFORM=y
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
CONFIG_CAN_M_CAN_PLATFORM=y
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=y
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_F81601 is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_SJA1000_ISA=y
CONFIG_CAN_SJA1000_PLATFORM=y
CONFIG_CAN_SOFTING=y
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=y
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_I2C=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
# end of Near Field Communication (NFC) devices

# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_CACHE is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_DRBD=y
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
CONFIG_VOP_BUS=y
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=y
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=y
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=y
CONFIG_IPVTAP=y
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_GTP=y
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=y
CONFIG_TAP=y
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=y
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=y
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_CAIF_DRIVERS=y
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
CONFIG_CAIF_HSI=y
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8851_MLL=y
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=y
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
# CONFIG_DWC_XLGMAC_PCI is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_MSCC_MIIM=y
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
CONFIG_ADIN_PHY=y
# CONFIG_AMD_PHY is not set
CONFIG_AQUANTIA_PHY=y
# CONFIG_AX88796B_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=y
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=y
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PLIP=y
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=y
CONFIG_PPPOE=y
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=y
# CONFIG_SLIP is not set
CONFIG_SLHC=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# end of WiMAX Wireless Broadband devices

CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
# CONFIG_HDLC_PPP is not set
CONFIG_HDLC_X25=y
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
CONFIG_LAPBETHER=y
# CONFIG_X25_ASY is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_HWSIM=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
# CONFIG_ISDN_CAPI is not set
CONFIG_MISDN=y
# CONFIG_MISDN_DSP is not set
# CONFIG_MISDN_L1OIP is not set

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
# CONFIG_MISDN_HFCMULTI is not set
# CONFIG_MISDN_AVMFRITZ is not set
# CONFIG_MISDN_SPEEDFAX is not set
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
CONFIG_N_GSM=y
# CONFIG_TRACE_SINK is not set
CONFIG_NULL_TTY=y
# CONFIG_LDISC_AUTOLOAD is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=y
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PTP_1588_CLOCK_IDTCM=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
# CONFIG_CHARGER_WILCO is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_RADIO_SI4713=y
# CONFIG_PLATFORM_SI4713 is not set
# CONFIG_I2C_SI4713 is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
CONFIG_MEDIA_ATTACH=y

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER=y

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=y
CONFIG_SPEAKUP_SYNTH_APOLLO=y
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
CONFIG_SPEAKUP_SYNTH_BNS=y
# CONFIG_SPEAKUP_SYNTH_DECTLK is not set
CONFIG_SPEAKUP_SYNTH_DECEXT=y
CONFIG_SPEAKUP_SYNTH_LTLK=y
CONFIG_SPEAKUP_SYNTH_SOFT=y
# CONFIG_SPEAKUP_SYNTH_SPKOUT is not set
# CONFIG_SPEAKUP_SYNTH_TXPRT is not set
CONFIG_SPEAKUP_SYNTH_DUMMY=y
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# end of Android

CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=y
CONFIG_UNISYS_VISORINPUT=y
CONFIG_UNISYS_VISORHBA=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_NET is not set
# CONFIG_MOST_VIDEO is not set
CONFIG_MOST_I2C=y

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

CONFIG_FIELDBUS_DEV=y
# CONFIG_KPC2000 is not set
# CONFIG_UWB is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_QLGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=y
CONFIG_ASUS_LAPTOP=y
# CONFIG_DCDBAS is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=y
CONFIG_DELL_SMO8800=y
CONFIG_DELL_RBU=y
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WIRELESS=y
CONFIG_HP_WMI=y
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_INTEL_MENLOW=y
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_XIAOMI_WMI=y
# CONFIG_MSI_WMI is not set
CONFIG_PEAQ_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_MXM_WMI is not set
CONFIG_SAMSUNG_Q10=y
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_PMC_IPC is not set
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_SURFACE_3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
CONFIG_I2C_MULTI_INSTANTIATE=y
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_SYSTEM76_ACPI is not set
CONFIG_PMC_ATOM=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
# CONFIG_CROS_EC_LIGHTBAR is not set
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=y
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
# CONFIG_WILCO_EC_TELEMETRY is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_PWM=y
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CRC is not set
CONFIG_PWM_CROS_EC=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=y
# CONFIG_BTT is not set
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
# CONFIG_FPGA_DFL_FME_REGION is not set
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_UNISYS_VISORBUS=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set
CONFIG_CRYPTO_CURVE25519_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=4
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_KASAN_STACK_ENABLE is not set
CONFIG_KASAN_STACK=0
CONFIG_KASAN_VMALLOC=y
# CONFIG_TEST_KASAN is not set
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_KUNIT=y
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_SYSCTL_KUNIT_TEST is not set
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=y
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of Kernel hacking

--32KBALpRDK42x9o9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='/lkp-src/allot/rand/vm-snb/boot.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-10'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='264b0d2bee148073c117e7bbbde5be7125a53be1'
	export kconfig='x86_64-randconfig-a005-20200507'
	export nr_vm=64
	export submit_id='5f0bd1a98d1abf292ed8efe1'
	export job_file='/lkp/jobs/scheduled/vm-snb-10/boot-1-yocto-x86_64-minimal-20190520.cgz-264b0d2bee148073c117e7bbbde5be7125a53be1-20200713-10542-1xdryci-20.yaml'
	export id='ab763de62d20f7099d19a3a70d912337931c717a'
	export queuer_version='/lkp-src'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23032
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='clang-11'
	export enqueue_time='2020-07-13 11:14:49 +0800'
	export _id='5f0bd1aa8d1abf292ed8efed'
	export _rt='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1'
	export user='lkp'
	export result_root='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1/21'
	export scheduler_version='/lkp/lkp/.src-20200711-000512'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-10/boot-1-yocto-x86_64-minimal-20190520.cgz-264b0d2bee148073c117e7bbbde5be7125a53be1-20200713-10542-1xdryci-20.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-a005-20200507
branch=linus/master
commit=264b0d2bee148073c117e7bbbde5be7125a53be1
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1/vmlinuz-5.4.0-11726-g264b0d2bee148
max_uptime=600
RESULT_ROOT=/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1/21
LKP_SERVER=inn
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=24
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-randconfig-a005-20200507/clang-11/264b0d2bee148073c117e7bbbde5be7125a53be1/vmlinuz-5.4.0-11726-g264b0d2bee148'
	export dequeue_time='2020-07-13 11:18:13 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-10/boot-1-yocto-x86_64-minimal-20190520.cgz-264b0d2bee148073c117e7bbbde5be7125a53be1-20200713-10542-1xdryci-20.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--32KBALpRDK42x9o9
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--32KBALpRDK42x9o9--

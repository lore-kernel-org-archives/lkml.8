Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7BC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B2206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCWPBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:01:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:26774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgCWPBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:01:10 -0400
IronPort-SDR: wEAdiD36GD9o81KLPyhMEeSrsQluUXcP23V2L6mxkhabW+wYzGKAQwSIoFovzfodU2/k9uJ/qe
 8YtuZTMBRW0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 08:01:09 -0700
IronPort-SDR: xOQfy8K5XD/GBlZ7JKWStXexCAJb8C+lZtzN2pJK44cWveY8AhNgNESDv/BIFavzGK8p1xtQ9G
 86unrakaIxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="237926017"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2020 08:01:07 -0700
Date:   Mon, 23 Mar 2020 08:01:08 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>
Cc:     alexander.deucher@amd.com, bigeasy@linutronix.de, bp@alien8.de,
        dave.hansen@intel.com, dvyukov@google.com, hpa@zytor.com,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, nicholas.kazlauskas@amd.com, pbonzini@redhat.com,
        riel@surriel.com, sunpeng.li@amd.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, zhan.liu@amd.com
Subject: Re: WARNING in switch_fpu_return
Message-ID: <20200323150107.GB28711@linux.intel.com>
References: <000000000000f04e43059b1ee697@google.com>
 <000000000000ac36ba05a1793693@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ac36ba05a1793693@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 03:41:03PM -0700, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit 3009afc6e39e78708d8fb444ae50544b3bcd3a3f
> Author: Sean Christopherson <sean.j.christopherson@intel.com>
> Date:   Wed Jan 22 04:43:39 2020 +0000
> 
>     KVM: x86: Use a typedef for fastop functions
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1667aa4be00000
> start commit:   bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
> dashboard link: https://syzkaller.appspot.com/bug?extid=f2ca20d4aa1408b0385a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151d549ee00000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: KVM: x86: Use a typedef for fastop functions

Ha, fat chance of that.

The offending call to switch_fpu_return() in kvm_arch_vcpu_load() was
removed by commit 2620fe268e80 ("KVM: x86: Revert "KVM: X86: Fix fpu state
crash in kvm guest"")

 RIP: 0010:__fpregs_load_activate arch/x86/include/asm/fpu/internal.h:539 [inline]
 RIP: 0010:switch_fpu_return+0x437/0x4f0 arch/x86/kernel/fpu/core.c:343
  kvm_arch_vcpu_load+0x66e/0x950 arch/x86/kvm/x86.c:3463
  vcpu_load+0x43/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:201
  kvm_unload_vcpu_mmu arch/x86/kvm/x86.c:9543 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:9558 [inline]
  kvm_arch_destroy_vm+0x184/0x5f0 arch/x86/kvm/x86.c:9663
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:816 [inline]
  kvm_put_kvm+0x5a5/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:837
  async_pf_execute+0x3bf/0x800 arch/x86/kvm/../../../virt/kvm/async_pf.c:101
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

So

#syz fix: KVM: x86: Revert "KVM: X86: Fix fpu state crash in kvm guest"

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

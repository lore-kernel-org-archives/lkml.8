Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B3C2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDTKgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:36:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:16437 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgDTKgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:36:48 -0400
IronPort-SDR: GfKZ/dBBk17DnchVmGuO4gZqdyLWHZrRBgKcW8ll2NGfyLxMbs/RfZS3452KGuCvczyUXkyMh8
 aVwc3klJlv4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 03:36:48 -0700
IronPort-SDR: i9SlA6S+Z9Yd3ZvP2m4PtHjqGxFXqbbarTfv3P4KSW0R1akYYp0RCjMsFYnEM8RBpcwPvqfUhS
 kWzphpIO4mHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="455651402"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.105])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 03:36:44 -0700
Date:   Mon, 20 Apr 2020 18:36:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [y2038] 412c53a680: will-it-scale.per_process_ops
 11.7% improvement
Message-ID: <20200420103643.GC46370@shbuild999.sh.intel.com>
References: <20200305062138.GI5972@shao2-debian>
 <20200305195317.771bd8fd1f308172d26a51fe@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305195317.771bd8fd1f308172d26a51fe@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Mar 05, 2020 at 07:53:17PM -0800, Andrew Morton wrote:
> On Thu, 5 Mar 2020 14:21:38 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
> 
> > FYI, we noticed a 11.7% improvement of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 412c53a680a97cb1ae2c0ab60230e193bee86387 ("y2038: remove unused time32 interfaces")
> 
> That patch merely removed unused code!

Sorry for the late response.

Yes, we've seen similar cases for this exact micro benchmark before,
that commit is about cpu idle driver which has no direct relation
with mmap at all. https://lkml.org/lkml/2019/9/17/966

The reason could be the changed address and cache alignment of
kernel data and code, which has been discussed for other
micro-benchmarsk, like https://lkml.org/lkml/2020/2/5/238

But for this test for mmap, we found very high lock contention for
the spinlock of per-cpu counter "vm_committed_as", the perf data is: 

    94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave                      -      -            
48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64;entry_SYSCALL_64_after_hwframe;mmap64
45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap

I think the lock contention is only necessary for accuracy of
"vm_committed_as" when overcommit policy is OVERCOMMIT_NEVER.

And with the following debug patch, the benchmark score could be
bumped to 8X~20X, and the delta caused by this "year 2038" commit
is reduced to 2%, delta for the cpuidle commit is reduced to 0.
Which means the micro benchmark is much stabler.
(the debug patch sitll has some problems)

Thanks,
Feng

--------------------------------------------
mm: util: Reduce spinlock usage for vm !OVERCOMMIT_NEVER policy

When debugging a will-it-scale performance regression we found
about 94% cpu cycles are used on
	_raw_spin_lock_irqsave <-- percpu_counter_add_batch
which is for "vm_committed_as" inside vm_acct_memory().

Actually this heavy lock contention is not always necessary. The
spinlock is only used when percpu_counter_add_batch() needs to be
very precise(needs a small batch number), while only when the vm
overcommit policy is OVERCOMMIT_NEVER, the "vm_committed_as" is
really used with high precision for sanity checking.

So adjust the batch number according to vm commit policy, to
reduce the lock contention for non OVERCOMMIT_NEVER cases.

Benchmark with the same mmap case [1] on Cascade Lake sever (48C/96T)
and Knights Mill (72C/288T) shows 1400%~2400%(10X-20X) performance
gain.

Todo: adjust the other 2 possible places which use "vm_committed_as",
one is /proc/meminfo, the other is HyperV ballon driver.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mman.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c..04d20d9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -65,7 +65,15 @@ unsigned long vm_memory_committed(void);
 
 static inline void vm_acct_memory(long pages)
 {
-	percpu_counter_add_batch(&vm_committed_as, pages, vm_committed_as_batch);
+	s32 batch = vm_committed_as_batch;
+
+	/* choose the batch number according to vm overcommit policy */
+	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
+		batch = totalram_pages() >> 6;
+	else if (sysctl_overcommit_memory == OVERCOMMIT_GUESS)
+		batch = totalram_pages() >> 8;
+
+	percpu_counter_add_batch(&vm_committed_as, pages, batch);
 }
 
 static inline void vm_unacct_memory(long pages)
-- 
2.7.4


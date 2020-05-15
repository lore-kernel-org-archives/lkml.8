Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52619C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C2206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEOJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:24:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:45578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEOJYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:24:20 -0400
IronPort-SDR: W6EVZav80yoFPmH41Cv8PmNun3rZsblxc3QQI1JtYB6nHxNk6FwL7PMlT5t1ziTKdbeNJ4TpTJ
 JDTGOZPNlWcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 02:24:19 -0700
IronPort-SDR: F0AKFMJPL4EX/lvNyOWlwpRD2P3asI/5LY0GhP76dw1Wgu9K9JrMiXpkFDbLQadd8G2afu0qL+
 HIXoBhuA3Jvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="438251000"
Received: from mgpinon-mobl.ger.corp.intel.com ([10.252.55.74])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2020 02:24:15 -0700
Message-ID: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Date:   Fri, 15 May 2020 12:24:14 +0300
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 00:52 -0400, Sasha Levin wrote:
> Benefits:
> Currently a user process that wishes to read or write the FS/GS base must
> make a system call. But recent X86 processors have added new instructions
> for use in 64-bit mode that allow direct access to the FS and GS segment
> base addresses.  The operating system controls whether applications can
> use these instructions with a %cr4 control bit.
> 
> In addition to benefits to applications, performance improvements to the
> OS context switch code are possible by making use of these instructions. A
> third party reported out promising performance numbers out of their
> initial benchmarking of the previous version of this patch series [9].
> 
> Enablement check:
> The kernel provides information about the enabled state of FSGSBASE to
> applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
> the AUX vector, the kernel has FSGSBASE instructions enabled and
> applications can use them.
> 
> Kernel changes:
> Major changes made in the kernel are in context switch, paranoid path, and
> ptrace. In a context switch, a task's FS/GS base will be secured regardless
> of its selector. In the paranoid path, GS base is unconditionally
> overwritten to the kernel GS base on entry and the original GS base is
> restored on exit. Ptrace includes divergence of FS/GS index and base
> values.
> 
> Security:
> For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
> on most kernel entries. Those patches are dependent on previous behaviors
> that users couldn't load a kernel address into the GS base. These patches
> change that assumption since the user can load any address into GS base.
> The changes to the kernel entry path in this patch series take account of
> the SWAPGS issue.
> 
> Changes from v11:
> 
>  - Rebase to v5.7-rc5, fix 32bit compilation error.
> 
> 
> Andi Kleen (2):
>   x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
>   x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
> 
> Andy Lutomirski (4):
>   x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>   x86/entry/64: Clean up paranoid exit
>   x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
>   x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
>     bit
> 
> Chang S. Bae (9):
>   x86/ptrace: Prevent ptrace from clearing the FS/GS selector
>   selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
>     write
>   x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
>   x86/entry/64: Introduce the FIND_PERCPU_BASE macro
>   x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
>   x86/entry/64: Document GSBASE handling in the paranoid path
>   x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
>   x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
>   selftests/x86/fsgsbase: Test ptracer-induced GS base write with
>     FSGSBASE
> 
> Sasha Levin (1):
>   x86/fsgsbase/64: move save_fsgs to header file
> 
> Thomas Gleixner (1):
>   Documentation/x86/64: Add documentation for GS/FS addressing mode
> 
> Tony Luck (1):
>   x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
> 
>  .../admin-guide/kernel-parameters.txt         |   2 +
>  Documentation/x86/entry_64.rst                |   9 +
>  Documentation/x86/x86_64/fsgs.rst             | 199 ++++++++++++++++++
>  Documentation/x86/x86_64/index.rst            |   1 +
>  arch/x86/entry/calling.h                      |  40 ++++
>  arch/x86/entry/entry_64.S                     | 131 +++++++++---
>  arch/x86/include/asm/fsgsbase.h               |  45 +++-
>  arch/x86/include/asm/inst.h                   |  15 ++
>  arch/x86/include/uapi/asm/hwcap2.h            |   3 +
>  arch/x86/kernel/cpu/bugs.c                    |   6 +-
>  arch/x86/kernel/cpu/common.c                  |  22 ++
>  arch/x86/kernel/process.c                     |   9 +-
>  arch/x86/kernel/process.h                     |  72 +++++++
>  arch/x86/kernel/process_64.c                  | 142 +++++++------
>  arch/x86/kernel/ptrace.c                      |  17 +-
>  tools/testing/selftests/x86/fsgsbase.c        |  24 ++-
>  16 files changed, 608 insertions(+), 129 deletions(-)
>  create mode 100644 Documentation/x86/x86_64/fsgs.rst
> 

Can you put me to the CC-loop for this patches. Some SGX-enabled
frameworks such as Graphene use out-of-tree changes to achieve this.
That's where the interest to possibly test this comes from.

Thanks.

[*] https://github.com/oscarlab/graphene

/Jarkko


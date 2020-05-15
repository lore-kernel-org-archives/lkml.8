Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F80C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7C22076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589560816;
	bh=JHixk0k5lnEC0ssp23UHR7P3Dn7qv+pHpbFSequmZUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IzzPxi7Qgww0ZXZsznbJvBsHMeotIG4dnzlTrvpP0jfoB7yzhqD2YU+4ioOr455v+
	 NIXP/ZfQ0K86qKRMV028l3kbxwv3u8nUwQ/lcj3d4Po+QqaO3KPGfH+txb2ipmRJye
	 1abH3AffbpE2PpRWXPedAP4OJx9Y0MgEskMatM/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgEOQkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgEOQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:40:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A33A206C0;
        Fri, 15 May 2020 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589560814;
        bh=JHixk0k5lnEC0ssp23UHR7P3Dn7qv+pHpbFSequmZUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLTi3ByjdSThJlmUXcNTgvjyxt3ANp8rjJATD8UTVz4pUzCQqAuJESncNdFV/+sx4
         ZFOntbPlQF29JBJZGBKpscjlsTaGHCwCtBzFhqlTvqlUFGEAFS7e/Bq+CbqQYtoaKU
         nF0xvmximP0rvqnSUDftMhza208wanYOqDZ6ZZYA=
Date:   Fri, 15 May 2020 12:40:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200515164013.GF29995@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:24:14PM +0300, Jarkko Sakkinen wrote:
>On Mon, 2020-05-11 at 00:52 -0400, Sasha Levin wrote:
>> Benefits:
>> Currently a user process that wishes to read or write the FS/GS base must
>> make a system call. But recent X86 processors have added new instructions
>> for use in 64-bit mode that allow direct access to the FS and GS segment
>> base addresses.  The operating system controls whether applications can
>> use these instructions with a %cr4 control bit.
>>
>> In addition to benefits to applications, performance improvements to the
>> OS context switch code are possible by making use of these instructions. A
>> third party reported out promising performance numbers out of their
>> initial benchmarking of the previous version of this patch series [9].
>>
>> Enablement check:
>> The kernel provides information about the enabled state of FSGSBASE to
>> applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
>> the AUX vector, the kernel has FSGSBASE instructions enabled and
>> applications can use them.
>>
>> Kernel changes:
>> Major changes made in the kernel are in context switch, paranoid path, and
>> ptrace. In a context switch, a task's FS/GS base will be secured regardless
>> of its selector. In the paranoid path, GS base is unconditionally
>> overwritten to the kernel GS base on entry and the original GS base is
>> restored on exit. Ptrace includes divergence of FS/GS index and base
>> values.
>>
>> Security:
>> For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
>> on most kernel entries. Those patches are dependent on previous behaviors
>> that users couldn't load a kernel address into the GS base. These patches
>> change that assumption since the user can load any address into GS base.
>> The changes to the kernel entry path in this patch series take account of
>> the SWAPGS issue.
>>
>> Changes from v11:
>>
>>  - Rebase to v5.7-rc5, fix 32bit compilation error.
>>
>>
>> Andi Kleen (2):
>>   x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
>>   x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
>>
>> Andy Lutomirski (4):
>>   x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>>   x86/entry/64: Clean up paranoid exit
>>   x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
>>   x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
>>     bit
>>
>> Chang S. Bae (9):
>>   x86/ptrace: Prevent ptrace from clearing the FS/GS selector
>>   selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
>>     write
>>   x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
>>   x86/entry/64: Introduce the FIND_PERCPU_BASE macro
>>   x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
>>   x86/entry/64: Document GSBASE handling in the paranoid path
>>   x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
>>   x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
>>   selftests/x86/fsgsbase: Test ptracer-induced GS base write with
>>     FSGSBASE
>>
>> Sasha Levin (1):
>>   x86/fsgsbase/64: move save_fsgs to header file
>>
>> Thomas Gleixner (1):
>>   Documentation/x86/64: Add documentation for GS/FS addressing mode
>>
>> Tony Luck (1):
>>   x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
>>
>>  .../admin-guide/kernel-parameters.txt         |   2 +
>>  Documentation/x86/entry_64.rst                |   9 +
>>  Documentation/x86/x86_64/fsgs.rst             | 199 ++++++++++++++++++
>>  Documentation/x86/x86_64/index.rst            |   1 +
>>  arch/x86/entry/calling.h                      |  40 ++++
>>  arch/x86/entry/entry_64.S                     | 131 +++++++++---
>>  arch/x86/include/asm/fsgsbase.h               |  45 +++-
>>  arch/x86/include/asm/inst.h                   |  15 ++
>>  arch/x86/include/uapi/asm/hwcap2.h            |   3 +
>>  arch/x86/kernel/cpu/bugs.c                    |   6 +-
>>  arch/x86/kernel/cpu/common.c                  |  22 ++
>>  arch/x86/kernel/process.c                     |   9 +-
>>  arch/x86/kernel/process.h                     |  72 +++++++
>>  arch/x86/kernel/process_64.c                  | 142 +++++++------
>>  arch/x86/kernel/ptrace.c                      |  17 +-
>>  tools/testing/selftests/x86/fsgsbase.c        |  24 ++-
>>  16 files changed, 608 insertions(+), 129 deletions(-)
>>  create mode 100644 Documentation/x86/x86_64/fsgs.rst
>>
>
>Can you put me to the CC-loop for this patches. Some SGX-enabled

Sure!

>frameworks such as Graphene use out-of-tree changes to achieve this.
>That's where the interest to possibly test this comes from.

Indeed, we've seen a few hacks that basically just enable FSGSBASE:

 - https://github.com/oscarlab/graphene-sgx-driver
 - https://github.com/occlum/enable_rdfsbase

And would very much like to get rid of them...

-- 
Thanks,
Sasha

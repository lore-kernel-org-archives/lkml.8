Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD605C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6622272
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgIIP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:27:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:28676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgIIPZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:25:39 -0400
IronPort-SDR: uIq3rTNVuJ8y7Pr3jPtzMCPsOHMbUdoXaJjLy9l19LXs0zkKHFlGM0SlyfcesAqWRz6Yhz2e08
 ZrXUf9jK/eMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155745164"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155745164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 08:05:33 -0700
IronPort-SDR: a9E/wRfJl3CPejgJdWj4PJk+qlLUzMJmCIWwCeXAFWaFX02JMOxs1t+3ZC+Bw9XNajrNEcf6QA
 ZENlBBtGODJQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="449229089"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 08:05:32 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/8] Add machine check recovery when copying from user space
Date:   Wed,  9 Sep 2020 08:05:26 -0700
Message-Id: <20200909150526.29481-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine check recovery from uncorrected memory errors currently focusses
primarily on errors that are detected while running in user mode. There
is a mechanism for recovering from errors in kernel code, but it is
currently only used for memcpy_mcsafe().

The existing recover actions for errors found in user mode (unmap the
page and send SIGBUS to the task) can also be applied when the error is
found while copying data from user space to the kernel.

Roadmap to this series:

0001:	Could be applied as a standalone optimization. But is essential to
	this series because mce_reign() does not have access to the
	saved registers from the CPU that hit the error. So it can't
	recompute severity correctly for this new class of recoverable
	error.

0002:	First piece of infrastructure update. Severity calculations need
	access to the saved registers. So pass pointer down the call
	chain.

0003:	Later we need to know what type of exception handler is present
	for a given kernel instruction. Rather than proliferate more
	functions like ex_has_fault_handler() for each type, replace
	with a function that looks up the handler and returns an enum
	describing the type.

0004:	Need slightly different handling for *copy_user*() faults from
	get_user() faults. Create a new exception table tag and apply
	to the copy functions.

0005:	In fixup path of copy functions avoid dealing with the tail
	when the copy took a machine check by returning that there
	are no bytes left to be copied.

0006:	For the REP MOVS copy case we need to check if %rsi is a user
	or kernel address. There's already a static function to do this.
	Make it global so x86/mce code can share the goodness.

0007:	New function to get the user virtual address that was used for
	a user access that hit a machine check. Add the code fragment
	into do_machine_check() to take recovery actions. Does nothing
	at this point because severity code to detect copy from user
	case and set the kflags MCE_IN_KERNEL_COPYIN bit is in last
	patch of series.

0008:	Finally the keystone patch that pulls all the parts together.
	An instruction decoder figures out whether an instruction
	tagged as accessing user space is reading from or writing
	to user space. The instructions in the switch were found
	experimentally by looking at what instructions in the base
	kernel are tagged in the exception table. I didn't add the
	atomic operations (0x87 = XCHG etc.) that both read and write
	user addresses. I think they should be safe, but I need a test
	case where a futex has been poisoned to check. Probably this
	switch should be expanded with all the instructions that the
	compiler could possibly generate that read from user space.

Tony Luck (4):
  x86/mce: Stop mce_reign() from re-computing severity for every CPU
  x86/mce: Provide method to find out the type of exception handle
  x86/mce: Avoid tail copy when machine check terminated a copy from
    user
  x86/mce: Decode a kernel instruction to determine if it is copying
    from user

Youquan Song (4):
  x86/mce: Pass pointer to saved pt_regs to severity calculation
    routines
  x86/mce: Add _ASM_EXTABLE_CPY for copy user access
  x86/mce: Change fault_in_kernel_space() from static to global
  x86/mce: Recover from poison found while copying from user space

 arch/x86/include/asm/asm.h         |   6 ++
 arch/x86/include/asm/extable.h     |   9 ++-
 arch/x86/include/asm/mce.h         |   1 +
 arch/x86/include/asm/traps.h       |   2 +
 arch/x86/kernel/cpu/mce/core.c     |  89 ++++++++++++++++++++-----
 arch/x86/kernel/cpu/mce/internal.h |   3 +-
 arch/x86/kernel/cpu/mce/severity.c |  49 ++++++++++++--
 arch/x86/lib/copy_user_64.S        | 103 +++++++++++++++--------------
 arch/x86/mm/extable.c              |  24 +++++--
 arch/x86/mm/fault.c                |   2 +-
 include/linux/sched.h              |   1 +
 11 files changed, 210 insertions(+), 79 deletions(-)

-- 
2.21.1


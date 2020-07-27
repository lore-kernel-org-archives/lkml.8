Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3450C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A933F206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgG0EcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:32:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:24188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgG0EcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:08 -0400
IronPort-SDR: H+RFwzZODVHqw1b8h13NIchou8UDhXUvN6KRvuX6lpAWaxBGu6c9u21yXRta+4qCx6LWKmiCm3
 gFBcss2C5Qmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="131016888"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="131016888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:32:08 -0700
IronPort-SDR: iuEOLJ5Pl9H/YE9yJqNi0fbRDikC8RMmnFw2yX4nRSoZUV4UZgGiXRjIPf7Ic3NZqfQbuDu8JM
 r7xCKdq52h3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="329550029"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2020 21:32:07 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/4] x86/cpu: Use SERIALIZE in sync_core() 
Date:   Sun, 26 Jul 2020 21:31:28 -0700
Message-Id: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent submission to LKML introduced a CPU feature flag for a new
Intel architecture Serializing Instruction, SERIALIZE [1]. Unlike the
existing Serializing Instructions, this new instruction does not have
side effects such as clobbering registers or exiting to a hypervisor.

As stated in the Intel "extensions" (ISE) manual [2], this instruction
will appear first in Sapphire Rapids and Alder Lake.

Andy Lutomirski suggested to use this instruction in sync_core() as it
serves the very purpose of this function [3].

For completeness, I picked patch #3 from Cathy's series (and has become
patch #1 here) [1]. Her series depends on such patch to build correctly.
Maybe it can be merged independently while the discussion continues?

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/kvm/1594088183-7187-1-git-send-email-cathy.zhang@intel.com/
[2]. https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
[3]. https://lore.kernel.org/kvm/CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com/

Ricardo Neri (4):
  x86/cpufeatures: Add enumeration for SERIALIZE instruction
  x86/cpu: Relocate sync_core() to sync_core.h
  x86/cpu: Refactor sync_core() for readability
  x86/cpu: Use SERIALIZE in sync_core() when available

 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/processor.h     | 64 ----------------------
 arch/x86/include/asm/special_insns.h |  4 ++
 arch/x86/include/asm/sync_core.h     | 80 ++++++++++++++++++++++++++++
 arch/x86/kernel/alternative.c        |  1 +
 arch/x86/kernel/cpu/mce/core.c       |  1 +
 drivers/misc/sgi-gru/grufault.c      |  1 +
 drivers/misc/sgi-gru/gruhandles.c    |  1 +
 drivers/misc/sgi-gru/grukservices.c  |  1 +
 9 files changed, 90 insertions(+), 64 deletions(-)

-- 
2.17.1


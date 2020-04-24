Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248BBC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB422173E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgDXTha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:37:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:23297 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgDXTh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:37:26 -0400
IronPort-SDR: vdTZamTRJD58EfvYmJSm2sEI2WjzX2pv+MOPJ4HBN1oAEsN8MutZ6JW5ZOBANuIJG+HeAEkHgr
 oWdVJMiNiSlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 12:37:26 -0700
IronPort-SDR: VkBCSJSA39UhajZzbAuq4mr1AtGY8j62MdKH+EolE8CB3POaMHM71v5sWsgyJkbL4ndJO2hrBC
 L5w5BR14Ji6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="403425639"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 12:37:22 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v4 0/3] x86/delay: Introduce TPAUSE instruction 
Date:   Fri, 24 Apr 2020 12:37:53 -0700
Message-Id: <1587757076-30337-1-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors that support the WAITPKG feature implement
the TPAUSE instruction that suspends execution in a lower power
state until the TSC (Time Stamp Counter) exceeds a certain value.

Update the udelay() function to use TPAUSE on systems where it
is available. Note that we hard code the deeper (C0.2) sleep
state because exit latency is small compared to the "microseconds"
that usleep() will delay.

ChangeLog:
- Change from v3 to v4:
  1. Add binutils version to support tpause as suggested by Peter Zijlstra.
  2. Use arch/x86/Kconfig.assembler to set up a CONFIG_AS_TPAUSE
     suggested by Tony Luck.
  3. Fix build issue for make ARCH=i386.

- Change from v2 to v3:
  1. Add Thomas' cleanup patch to this patchset.
  2. Implement use_tpause_delay() to use TPAUSE.
  3. Call use_tpause_delay() during x86_late_time_init().
  4. Use APIs lower_32_bits(), upper_32_bits() as suggested by Joe Perch.
  5. Change __tpause() argument integer type from unsigned int to u32.

- Change from v1 to v2:
  1. Change function/variable names as suggested by Thomas Gleixner i.e.
     a. Change to delay_halt_fn/delay_halt_mwaitx/delay_halt_tpause from
        wait_func/mwaitx/tpause.
     b. Change variable name loops to cycles.
     c. Change back to the original name delay_fn from delay_platform.
  2. Organize comments to use full width.
  3. Add __ro_after_init for the function pointer delay_halt_fn.
  4. Change patch titles as suggested by Thomas Gleixner.

Kyung Min Park (2):
  x86/delay: Refactor delay_mwaitx() for TPAUSE support
  x86/delay: Introduce TPAUSE delay

Thomas Gleixner (1):
  x86/delay: Preparatory code cleanup

 arch/x86/Kconfig.assembler   |   4 ++
 arch/x86/include/asm/delay.h |   4 +-
 arch/x86/include/asm/mwait.h |  24 ++++++++-
 arch/x86/kernel/time.c       |   3 ++
 arch/x86/lib/delay.c         | 114 +++++++++++++++++++++++++++++--------------
 5 files changed, 111 insertions(+), 38 deletions(-)

-- 
2.7.4


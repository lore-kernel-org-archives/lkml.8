Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC2A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDJX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:29:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:5049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgDJX3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 19:29:39 -0400
IronPort-SDR: HjnQCud3y2+J42OZu5InoA1Z1qIqYRGwhx/Vk2Zpm1Rzm+Gob45CBAo1eFdnqNRRdtv/+eJNGT
 Fe7mZk7CRGZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:29:40 -0700
IronPort-SDR: hJ5pCJ5CnIYgBpEoBX9Y69kKQ3y6hC1t8U20icqbztp7WK5k5wnxYNZIviAiAMSWDmoTx9aSoX
 ogHnzldUdIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="399057314"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2020 16:29:39 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v3 0/3] x86/delay: Introduce TPAUSE instruction 
Date:   Fri, 10 Apr 2020 16:29:52 -0700
Message-Id: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
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
- Change from v2 to v3:
  1  Add Thomas' cleanup patch to this patchset.
  2. Implement use_tpause_delay() to use TPAUSE.
  3. Call use_tpause_delay() during x86_late_time_init().
  4. Use APIs lower_32_bits(), upper_32_bits() as suggested by Joe Perch.
  5. Change __tpause() argument integer type from unsigned int to u32.

- Change from v1 to v2:
  1. Change function/variable names as suggested by Thomas i.e.
     a. Change to delay_halt_fn/delay_halt_mwaitx/delay_halt_tpause from
        wait_func/mwaitx/tpause.
     b. Change variable name loops to cycles.
     c. Change back to the original name delay_fn from delay_platform.
  2. Organize comments to use full width.
  3. Add __ro_after_init for the function pointer delay_halt_fn.
  4. Change patch titles as suggested by Thomas.

Kyung Min Park (2):
  x86/delay: Refactor delay_mwaitx() for TPAUSE support
  x86/delay: Introduce TPAUSE delay

Thomas Gleixner (1):
  x86/delay: Preparatory code cleanup

 arch/x86/include/asm/delay.h |   3 +-
 arch/x86/include/asm/mwait.h |  18 ++++++-
 arch/x86/kernel/time.c       |   3 ++
 arch/x86/lib/delay.c         | 114 +++++++++++++++++++++++++++++--------------
 4 files changed, 100 insertions(+), 38 deletions(-)

-- 
2.7.4


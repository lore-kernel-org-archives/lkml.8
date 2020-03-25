Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94BC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098EF20724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYD1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:27:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:39340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYD1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:27:02 -0400
IronPort-SDR: /5q/KG6Pa1PEwP7uIKH+WKc99hg/HsJaCaLcnf44byDueCJNcEvFzXZVEDOS/bqcUYEOH4nYYU
 F3F99vJcc+UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:27:02 -0700
IronPort-SDR: FH6bjPXY6FeAwFrnCanQrNQ0zL1VoRbz8uFRLkqKpbOuK8usTcbogX/beeL1DDcbJ0KlaP+P/E
 4mBXgbKsuZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="240289990"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2020 20:26:59 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v7 0/2] Fix and optimization of split_lock_detection
Date:   Wed, 25 Mar 2020 11:09:22 +0800
Message-Id: <20200325030924.132881-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is split from "[PATCH v6 0/8] x86/split_lock: Fix and
virtualization of split lock detection"[1]. It contains one fix for the
initialization flow of split_lock_detection and one optimiazation for
runtime TEST_CTRL MSR access.

Other patches of [1] needs more time to improve.

Thanks.

[1]: https://lore.kernel.org/kvm/20200324151859.31068-1-xiaoyao.li@intel.com/

Changes in v7:
 - only pick patch 1 and patch 2, and hold all the left.
 - Update SLD bit on each processor based on sld_state.

Changes in v6:
 - Drop the sld_not_exist flag and use X86_FEATURE_SPLIT_LOCK_DETECT to
   check whether need to init split lock detection. [tglx]
 - Use tglx's method to verify the existence of split lock detectoin.
 - small optimization of sld_update_msr() that the default value of
   msr_test_ctrl_cache has split_lock_detect bit cleared.
 - Drop the patch3 in v5 that introducing kvm_only option. [tglx]
 - Rebase patch4-8 to kvm/queue.
 - use the new kvm-cpu-cap to expose X86_FEATURE_CORE_CAPABILITIES in
   Patch 6.

Changes in v5:
 - Use X86_FEATURE_SPLIT_LOCK_DETECT flag in kvm to ensure split lock
   detection is really supported.
 - Add and export sld related helper functions in their related usecase 
   kvm patches.

Changes in v4:
 - Add patch 1 to rework the initialization flow of split lock
   detection.
 - Drop percpu MSR_TEST_CTRL cache, just use a static variable to cache
   the reserved/unused bit of MSR_TEST_CTRL. [Sean]
 - Add new option for split_lock_detect kernel param.
 - Changlog refinement. [Sean]
 - Add a new patch to enable MSR_TEST_CTRL for intel guest. [Sean]


Xiaoyao Li (2):
  x86/split_lock: Rework the initialization flow of split lock detection
  x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR

 arch/x86/kernel/cpu/intel.c | 85 +++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293EB2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgFXCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:00:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:12261 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730898AbgFXCAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:00:45 -0400
IronPort-SDR: rrS8TqHZfrqc5u3S9NZdlxRhkrtJTqaUj06dnpYqPzPtd2UAStEZksx6uJXTlKkJx/Qblr+o7D
 Bg6ZEWLSoX3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="228978274"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="228978274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 19:00:44 -0700
IronPort-SDR: nyusmRsoLpw4RhjXmgQ2g5Ff9IPLjc3Aqcjzxi8zdrmzruuMYtvvxZvnEX1FQas3QtGUjJl3yS
 ns3x6FbD8c/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="310649991"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2020 19:00:41 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH] kvm: x86: limit the maximum number of vPMU fixed counters to 3
Date:   Wed, 24 Jun 2020 09:59:28 +0800
Message-Id: <20200624015928.118614-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new Intel platforms (such as TGL) already have the
fourth fixed counter TOPDOWN.SLOTS, but it has not been
fully enabled on KVM and the host.

Therefore, we limit edx.split.num_counters_fixed to 3,
so that it does not break the kvm-unit-tests PMU test
case and bad-handled userspace.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 arch/x86/kvm/pmu.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8a294f9747aa..0a2c6d2b4650 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -604,7 +604,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		eax.split.bit_width = cap.bit_width_gp;
 		eax.split.mask_length = cap.events_mask_len;
 
-		edx.split.num_counters_fixed = cap.num_counters_fixed;
+		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = cap.bit_width_fixed;
 		edx.split.reserved = 0;
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ab85eed8a6cc..067fef51760c 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -15,6 +15,8 @@
 #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
 #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
 
+#define MAX_FIXED_COUNTERS	3
+
 struct kvm_event_hw_type_mapping {
 	u8 eventsel;
 	u8 unit_mask;
-- 
2.21.3


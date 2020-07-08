Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19AC20773
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGHHpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:45:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:6526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGHHpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:45:47 -0400
IronPort-SDR: 1TH7ZiWnXz6YvyaMjkgMNMKMejproPQnhzLcO2RnaFkmQgl5xtfkO/qmT+fLGejoAWS9CEQUnP
 u/EfmfqJ/o+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146824183"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="146824183"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:45:46 -0700
IronPort-SDR: FipVNnyyiizItsTNhBtmRKLVSIErnlGiOOG8ZI0gQZC9cTVjabJ14eM0tmizH7RYE6Zxi1gFS0
 ljEjTumUXPBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358029182"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:45:44 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH] KVM/x86: pmu: Fix #GP condition check for RDPMC emulation
Date:   Wed,  8 Jul 2020 15:44:09 +0800
Message-Id: <20200708074409.39028-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In guest protected mode, if the current privilege level
is not 0 and the PCE flag in the CR4 register is cleared,
we will inject a #GP for RDPMC usage.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/pmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b86346903f2e..d080d475c808 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -372,6 +372,11 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (!pmc)
 		return 1;
 
+	if ((kvm_x86_ops.get_cpl(vcpu) != 0) &&
+	    !(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
+	    (kvm_read_cr4(vcpu) & X86_CR0_PE))
+		return 1;
+
 	*data = pmc_read_counter(pmc) & mask;
 	return 0;
 }
-- 
2.21.3


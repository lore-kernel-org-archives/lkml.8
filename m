Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A4C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0120661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBASw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:52:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:37509 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgBASw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075449"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2020 10:52:25 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/61] KVM: x86: Check for CPUID 0xD.N support before validating array size
Date:   Sat,  1 Feb 2020 10:51:24 -0800
Message-Id: <20200201185218.24473-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that sub-leaf 1 is handled separately, verify the next sub-leaf is
needed before rejecting KVM_GET_SUPPORTED_CPUID due to an insufficiently
sized userspace array.

Note, although this is technically a bug, it's not visible to userspace
as KVM_GET_SUPPORTED_CPUID is guaranteed to fail on KVM_CPUID_SIGNATURE,
which is hardcoded to be added after leaf 0xD.  The real motivation for
the change is to tightly couple the nent/maxnent and do_host_cpuid()
sequences in preparation for future cleanup.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fc8540596386..fd9b29aa7abc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -670,13 +670,14 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 		entry[1].edx = 0;
 
 		for (idx = 2, i = 2; idx < 64; ++idx) {
-			u64 mask = ((u64)1 << idx);
+			if (!(supported & BIT_ULL(idx)))
+				continue;
 
 			if (*nent >= maxnent)
 				goto out;
 
 			do_host_cpuid(&entry[i], function, idx);
-			if (entry[i].eax == 0 || !(supported & mask))
+			if (entry[i].eax == 0)
 				continue;
 			if (WARN_ON_ONCE(entry[i].ecx & 1))
 				continue;
-- 
2.24.1


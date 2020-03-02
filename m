Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC77EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8496824677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCCAAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:00:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:25521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgCBX51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:57:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 15:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="243384650"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2020 15:57:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 09/66] KVM: x86: Refactor CPUID 0xD.N sub-leaf entry creation
Date:   Mon,  2 Mar 2020 15:56:12 -0800
Message-Id: <20200302235709.27467-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302235709.27467-1-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment the number of CPUID entries immediately after do_host_cpuid()
in preparation for moving the logic into do_host_cpuid().  Handle the
rare/impossible case of encountering a bogus sub-leaf by decrementing
the number entries on failure.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 424dde41cb5d..6e1685a16cca 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -677,6 +677,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 				goto out;
 
 			do_host_cpuid(&entry[i], function, idx);
+			++*nent;
 
 			/*
 			 * The @supported check above should have filtered out
@@ -685,12 +686,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 			 * reach this point, and they should have a non-zero
 			 * save state size.
 			 */
-			if (WARN_ON_ONCE(!entry[i].eax || (entry[i].ecx & 1)))
+			if (WARN_ON_ONCE(!entry[i].eax || (entry[i].ecx & 1))) {
+				--*nent;
 				continue;
+			}
 
 			entry[i].ecx = 0;
 			entry[i].edx = 0;
-			++*nent;
 			++i;
 		}
 		break;
-- 
2.24.1


Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB5BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC102467E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCCACT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:02:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:25519 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgCBX5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:57:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 15:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="243384677"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2020 15:57:22 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 18/66] KVM: x86: Use common loop iterator when handling CPUID 0xD.N
Date:   Mon,  2 Mar 2020 15:56:21 -0800
Message-Id: <20200302235709.27467-19-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302235709.27467-1-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __do_cpuid_func()'s common loop iterator, "i", when enumerating the
sub-leafs for CPUID 0xD now that the CPUID 0xD loop doesn't need to
manual maintain separate counts for the entries index and CPUID index.

No functional changed intended.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4bf4f7d7741e..85f292088d91 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -634,7 +634,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	case 0xd: {
-		int idx;
 		u64 supported = kvm_supported_xcr0();
 
 		entry->eax &= supported;
@@ -658,11 +657,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->ecx = 0;
 		entry->edx = 0;
 
-		for (idx = 2; idx < 64; ++idx) {
-			if (!(supported & BIT_ULL(idx)))
+		for (i = 2; i < 64; ++i) {
+			if (!(supported & BIT_ULL(i)))
 				continue;
 
-			entry = do_host_cpuid(array, function, idx);
+			entry = do_host_cpuid(array, function, i);
 			if (!entry)
 				goto out;
 
-- 
2.24.1


Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F10C3F2DC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509920870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCEBex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:34:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:31855 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCEBel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:34:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 17:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="234301756"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 17:34:39 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 5/7] KVM: x86: Add build-time assertions on validity of vendor strings
Date:   Wed,  4 Mar 2020 17:34:35 -0800
Message-Id: <20200305013437.8578-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305013437.8578-1-sean.j.christopherson@intel.com>
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add build-time assertions on the transcoded ASCII->u32 values for the
vendor strings.  The u32 values are inscrutable, and to make things
worse, the order of registers used to build the strings is B->D->C,
i.e. completely illogical.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/emulate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9cf303984fe5..7391e1471e53 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3952,6 +3952,26 @@ static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 	u32 eax, ebx, ecx, edx;
 	u64 msr = 0;
 
+	BUILD_BUG_ON(X86EMUL_CPUID_VENDOR_AuthenticAMD_ebx != *(u32 *)"Auth" ||
+		     X86EMUL_CPUID_VENDOR_AuthenticAMD_edx != *(u32 *)"enti" ||
+		     X86EMUL_CPUID_VENDOR_AuthenticAMD_ecx != *(u32 *)"cAMD");
+
+	BUILD_BUG_ON(X86EMUL_CPUID_VENDOR_AMDisbetterI_ebx != *(u32 *)"AMDi" ||
+		     X86EMUL_CPUID_VENDOR_AMDisbetterI_edx != *(u32 *)"sbet" ||
+		     X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx != *(u32 *)"ter!");
+
+	BUILD_BUG_ON(X86EMUL_CPUID_VENDOR_HygonGenuine_ebx != *(u32 *)"Hygo" ||
+		     X86EMUL_CPUID_VENDOR_HygonGenuine_edx != *(u32 *)"nGen" ||
+		     X86EMUL_CPUID_VENDOR_HygonGenuine_ecx != *(u32 *)"uine");
+
+	BUILD_BUG_ON(X86EMUL_CPUID_VENDOR_GenuineIntel_ebx != *(u32 *)"Genu" ||
+		     X86EMUL_CPUID_VENDOR_GenuineIntel_edx != *(u32 *)"ineI" ||
+		     X86EMUL_CPUID_VENDOR_GenuineIntel_ecx != *(u32 *)"ntel");
+
+	BUILD_BUG_ON(X86EMUL_CPUID_VENDOR_CentaurHauls_ebx != *(u32 *)"Cent" ||
+		     X86EMUL_CPUID_VENDOR_CentaurHauls_edx != *(u32 *)"aurH" ||
+		     X86EMUL_CPUID_VENDOR_CentaurHauls_ecx != *(u32 *)"auls");
+
 	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
 	if (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
 	    ctxt->ops->cpl(ctxt)) {
-- 
2.24.1


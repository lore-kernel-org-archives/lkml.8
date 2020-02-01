Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E6C35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A745620674
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgBASw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:52:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:37509 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgBASw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075437"
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
Subject: [PATCH 03/61] KVM: x86: Simplify handling of Centaur CPUID leafs
Date:   Sat,  1 Feb 2020 10:51:20 -0800
Message-Id: <20200201185218.24473-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the handling of the Centaur-only CPUID leaf to detect the leaf
via a runtime query instead of adding a one-off callback in the static
array.  When the callback was introduced, there were additional fields
in the array's structs, and more importantly, retpoline wasn't a thing.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f49fdd06f511..de52cbb46171 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -829,15 +829,7 @@ static int do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 func,
 	return __do_cpuid_func(entry, func, nent, maxnent);
 }
 
-struct kvm_cpuid_param {
-	u32 func;
-	bool (*qualifier)(const struct kvm_cpuid_param *param);
-};
-
-static bool is_centaur_cpu(const struct kvm_cpuid_param *param)
-{
-	return boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR;
-}
+#define CENTAUR_CPUID_SIGNATURE 0xC0000000
 
 static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
 			  int *nent, int maxnent, unsigned int type)
@@ -845,6 +837,10 @@ static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
 	u32 limit;
 	int r;
 
+	if (func == CENTAUR_CPUID_SIGNATURE &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR)
+		return 0;
+
 	r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
 	if (r)
 		return r;
@@ -896,11 +892,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 	struct kvm_cpuid_entry2 *cpuid_entries;
 	int nent = 0, r = -E2BIG, i;
 
-	static const struct kvm_cpuid_param param[] = {
-		{ .func = 0 },
-		{ .func = 0x80000000 },
-		{ .func = 0xC0000000, .qualifier = is_centaur_cpu },
-		{ .func = KVM_CPUID_SIGNATURE },
+	static const u32 funcs[] = {
+		0, 0x80000000, CENTAUR_CPUID_SIGNATURE, KVM_CPUID_SIGNATURE,
 	};
 
 	if (cpuid->nent < 1)
@@ -918,14 +911,9 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 		goto out;
 
 	r = 0;
-	for (i = 0; i < ARRAY_SIZE(param); i++) {
-		const struct kvm_cpuid_param *ent = &param[i];
-
-		if (ent->qualifier && !ent->qualifier(ent))
-			continue;
-
-		r = get_cpuid_func(cpuid_entries, ent->func, &nent,
-				   cpuid->nent, type);
+	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
+		r = get_cpuid_func(cpuid_entries, funcs[i], &nent, cpuid->nent,
+				   type);
 		if (r)
 			goto out_free;
 	}
-- 
2.24.1


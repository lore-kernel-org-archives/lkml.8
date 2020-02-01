Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCEC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A1B20661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBASw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:52:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:37509 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgBASw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075434"
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
Subject: [PATCH 02/61] KVM: x86: Refactor loop around do_cpuid_func() to separate helper
Date:   Sat,  1 Feb 2020 10:51:19 -0800
Message-Id: <20200201185218.24473-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the guts of kvm_dev_ioctl_get_cpuid()'s CPUID func loop to a
separate helper to improve code readability and pave the way for future
cleanup.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c | 45 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 47ce04762c20..f49fdd06f511 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -839,6 +839,29 @@ static bool is_centaur_cpu(const struct kvm_cpuid_param *param)
 	return boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR;
 }
 
+static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
+			  int *nent, int maxnent, unsigned int type)
+{
+	u32 limit;
+	int r;
+
+	r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
+	if (r)
+		return r;
+
+	limit = entries[*nent - 1].eax;
+	for (func = func + 1; func <= limit; ++func) {
+		if (*nent >= maxnent)
+			return -E2BIG;
+
+		r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
+		if (r)
+			break;
+	}
+
+	return r;
+}
+
 static bool sanity_check_entries(struct kvm_cpuid_entry2 __user *entries,
 				 __u32 num_entries, unsigned int ioctl_type)
 {
@@ -871,8 +894,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 			    unsigned int type)
 {
 	struct kvm_cpuid_entry2 *cpuid_entries;
-	int limit, nent = 0, r = -E2BIG, i;
-	u32 func;
+	int nent = 0, r = -E2BIG, i;
+
 	static const struct kvm_cpuid_param param[] = {
 		{ .func = 0 },
 		{ .func = 0x80000000 },
@@ -901,22 +924,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 		if (ent->qualifier && !ent->qualifier(ent))
 			continue;
 
-		r = do_cpuid_func(&cpuid_entries[nent], ent->func,
-				  &nent, cpuid->nent, type);
-
-		if (r)
-			goto out_free;
-
-		limit = cpuid_entries[nent - 1].eax;
-		for (func = ent->func + 1; func <= limit && r == 0; ++func) {
-			if (nent >= cpuid->nent) {
-				r = -E2BIG;
-				goto out_free;
-			}
-			r = do_cpuid_func(&cpuid_entries[nent], func,
-				          &nent, cpuid->nent, type);
-		}
-
+		r = get_cpuid_func(cpuid_entries, ent->func, &nent,
+				   cpuid->nent, type);
 		if (r)
 			goto out_free;
 	}
-- 
2.24.1


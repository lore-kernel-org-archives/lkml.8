Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5786C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797C820661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBASzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:55:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:57288 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgBASwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:52:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 10:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="248075598"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2020 10:52:26 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 56/61] KVM: SVM: Refactor logging of NPT enabled/disabled
Date:   Sat,  1 Feb 2020 10:52:13 -0800
Message-Id: <20200201185218.24473-57-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201185218.24473-1-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak SVM's logging of NPT enabled/disabled to handle the logging in a
single pr_info() in preparation for merging kvm_enable_tdp() and
kvm_disable_tdp() into a single function.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a27f83f7521c..80962c1eea8f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1440,16 +1440,14 @@ static __init int svm_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
-	if (npt_enabled && !npt) {
-		printk(KERN_INFO "kvm: Nested Paging disabled\n");
+	if (npt_enabled && !npt)
 		npt_enabled = false;
-	}
 
-	if (npt_enabled) {
-		printk(KERN_INFO "kvm: Nested Paging enabled\n");
+	if (npt_enabled)
 		kvm_enable_tdp();
-	} else
+	else
 		kvm_disable_tdp();
+	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
 
 	if (nrips) {
 		if (!boot_cpu_has(X86_FEATURE_NRIPS))
-- 
2.24.1


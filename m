Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC4C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FFA2076A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCOCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:13:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:41895 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgCOCNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:13:39 -0400
IronPort-SDR: 8w94JfkDG2xmB8Zj3qCbdxkKzPnQN04wZn6ZS/xI3IsK8viv/EfahGDqaeNSuSkNtHez/ghzQQ
 /+dbxaWPK9pQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2020 00:52:12 -0700
IronPort-SDR: 1kMrL2DKDmDEcoNhUZ/5FfRaCFdM0wYRIxRufPV34/znYIGFPlNv/tH9OuPwI1r/nKcOtdJx9h
 kAA2ssd+TzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,551,1574150400"; 
   d="scan'208";a="416537608"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.160])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2020 00:52:08 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com
Cc:     peterz@infradead.org, fenghua.yu@intel.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v4 06/10] kvm: x86: Emulate split-lock access as a write
Date:   Sat, 14 Mar 2020 15:34:10 +0800
Message-Id: <20200314073414.184213-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200314073414.184213-1-xiaoyao.li@intel.com>
References: <20200314073414.184213-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If split lock detect is enabled (warn/fatal), #AC handler calls die()
when split lock happens in kernel.

Malicous guest can exploit the KVM emulator to trigger split lock #AC
in kernel[1]. So just emulating the access as a write if it's a
split-lock access (the same as access spans page) to avoid malicious
attacking kernel.

More discussion can be found [2][3].

[1] https://lore.kernel.org/lkml/8c5b11c9-58df-38e7-a514-dc12d687b198@redhat.com/
[2] https://lkml.kernel.org/r/20200131200134.GD18946@linux.intel.com
[3] https://lkml.kernel.org/r/20200227001117.GX9940@linux.intel.com

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kvm/x86.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5de200663f51..1a0e6c0b1b39 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5873,6 +5873,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 {
 	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	u64 page_line_mask = PAGE_MASK;
 	gpa_t gpa;
 	char *kaddr;
 	bool exchanged;
@@ -5887,7 +5888,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	    (gpa & PAGE_MASK) == APIC_DEFAULT_PHYS_BASE)
 		goto emul_write;
 
-	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
+	if (split_lock_detect_on())
+		page_line_mask = ~(cache_line_size() - 1);
+
+	/* when write spans page or spans cache when SLD enabled */
+	if (((gpa + bytes - 1) & page_line_mask) != (gpa & page_line_mask))
 		goto emul_write;
 
 	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
-- 
2.20.1


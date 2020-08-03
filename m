Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5338B22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgHCVAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:52 -0400
Received: from 8bytes.org ([81.169.241.247]:34842 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbgHCVAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:38 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7F46C258; Mon,  3 Aug 2020 23:00:36 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 3/4] KVM: SVM: Add GHCB Accessor functions
Date:   Mon,  3 Aug 2020 23:00:33 +0200
Message-Id: <20200803210034.26386-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803210034.26386-1-joro@8bytes.org>
References: <20200803210034.26386-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Building a correct GHCB for the hypervisor requires setting valid bits
in the GHCB. Simplify that process by providing accessor functions to
set values and to update the valid bitmap and to check the valid bitmap
in KVM.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/svm.h | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 094b8f8fb1d4..50e5fa8d3249 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -341,4 +341,47 @@ struct __attribute__ ((__packed__)) vmcb {
 
 #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
 
+/* GHCB Accessor functions */
+
+#define GHCB_BITMAP_IDX(field)							\
+	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+
+#define DEFINE_GHCB_ACCESSORS(field)						\
+	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
+	{									\
+		return test_bit(GHCB_BITMAP_IDX(field),				\
+				(unsigned long *)&ghcb->save.valid_bitmap);	\
+	}									\
+										\
+	static inline void ghcb_set_##field(struct ghcb *ghcb, u64 value)	\
+	{									\
+		__set_bit(GHCB_BITMAP_IDX(field),				\
+			  (unsigned long *)&ghcb->save.valid_bitmap);		\
+		ghcb->save.field = value;					\
+	}
+
+DEFINE_GHCB_ACCESSORS(cpl)
+DEFINE_GHCB_ACCESSORS(rip)
+DEFINE_GHCB_ACCESSORS(rsp)
+DEFINE_GHCB_ACCESSORS(rax)
+DEFINE_GHCB_ACCESSORS(rcx)
+DEFINE_GHCB_ACCESSORS(rdx)
+DEFINE_GHCB_ACCESSORS(rbx)
+DEFINE_GHCB_ACCESSORS(rbp)
+DEFINE_GHCB_ACCESSORS(rsi)
+DEFINE_GHCB_ACCESSORS(rdi)
+DEFINE_GHCB_ACCESSORS(r8)
+DEFINE_GHCB_ACCESSORS(r9)
+DEFINE_GHCB_ACCESSORS(r10)
+DEFINE_GHCB_ACCESSORS(r11)
+DEFINE_GHCB_ACCESSORS(r12)
+DEFINE_GHCB_ACCESSORS(r13)
+DEFINE_GHCB_ACCESSORS(r14)
+DEFINE_GHCB_ACCESSORS(r15)
+DEFINE_GHCB_ACCESSORS(sw_exit_code)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
+DEFINE_GHCB_ACCESSORS(sw_scratch)
+DEFINE_GHCB_ACCESSORS(xcr0)
+
 #endif
-- 
2.17.1


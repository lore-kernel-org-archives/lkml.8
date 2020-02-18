Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19235C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E307124655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBRX36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:29:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:38638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgBRX34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:29:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 15:29:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="282936654"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2020 15:29:55 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] KVM: x86: Refactor R/W page helper to take the emulation context
Date:   Tue, 18 Feb 2020 15:29:44 -0800
Message-Id: <20200218232953.5724-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218232953.5724-1-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the vcpu->context derivation in emulator_read_write_onepage() in
preparation for dynamically allocating the emulation context.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 409bf35f26fd..772e704e8083 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5720,14 +5720,14 @@ static const struct read_write_emulator_ops write_emultor = {
 static int emulator_read_write_onepage(unsigned long addr, void *val,
 				       unsigned int bytes,
 				       struct x86_exception *exception,
-				       struct kvm_vcpu *vcpu,
+				       struct x86_emulate_ctxt *ctxt,
 				       const struct read_write_emulator_ops *ops)
 {
 	gpa_t gpa;
 	int handled, ret;
 	bool write = ops->write;
 	struct kvm_mmio_fragment *frag;
-	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 
 	/*
 	 * If the exit was due to a NPF we may already have a GPA.
@@ -5791,7 +5791,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 
 		now = -addr & ~PAGE_MASK;
 		rc = emulator_read_write_onepage(addr, val, now, exception,
-						 vcpu, ops);
+						 ctxt, ops);
 
 		if (rc != X86EMUL_CONTINUE)
 			return rc;
@@ -5803,7 +5803,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 	}
 
 	rc = emulator_read_write_onepage(addr, val, bytes, exception,
-					 vcpu, ops);
+					 ctxt, ops);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-- 
2.24.1


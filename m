Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C4B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDJL4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:56:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgDJL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:56:12 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMsGQ-0004bo-E8; Fri, 10 Apr 2020 13:56:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E7880100BB6;
        Fri, 10 Apr 2020 13:56:01 +0200 (CEST)
Message-Id: <20200410115517.084300242@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 10 Apr 2020 13:54:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 2/3] KVM: x86: Emulate split-lock access as a write in emulator
References: <20200410115359.242241855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

Emulate split-lock accesses as writes if split lock detection is on to
avoid #AC during emulation, which will result in a panic().  This should
never occur for a well behaved guest, but a malicious guest can
manipulate the TLB to trigger emulation of a locked instruction[1].

More discussion can be found [2][3].

[1] https://lkml.kernel.org/r/8c5b11c9-58df-38e7-a514-dc12d687b198@redhat.com
[2] https://lkml.kernel.org/r/20200131200134.GD18946@linux.intel.com
[3] https://lkml.kernel.org/r/20200227001117.GX9940@linux.intel.com

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kvm/x86.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5838,6 +5838,7 @@ static int emulator_cmpxchg_emulated(str
 {
 	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	u64 page_line_mask;
 	gpa_t gpa;
 	char *kaddr;
 	bool exchanged;
@@ -5852,7 +5853,16 @@ static int emulator_cmpxchg_emulated(str
 	    (gpa & PAGE_MASK) == APIC_DEFAULT_PHYS_BASE)
 		goto emul_write;
 
-	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
+	/*
+	 * Emulate the atomic as a straight write to avoid #AC if SLD is
+	 * enabled in the host and the access splits a cache line.
+	 */
+	if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		page_line_mask = ~(cache_line_size() - 1);
+	else
+		page_line_mask = PAGE_MASK;
+
+	if (((gpa + bytes - 1) & page_line_mask) != (gpa & page_line_mask))
 		goto emul_write;
 
 	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))


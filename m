Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC82C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D082073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258997;
	bh=TWaHQuaX+udslyLnLdBDaWL8PltVKCSg+RqVLp2g4R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPyMUaVdY26xt11n9CoEFKuiLLgsLloW7TkIKP3IvqmW75jVrss/fmzSWIAOi3zF2
	 udmV2BaLcJMVcQxQD71ZVUgdOY260KHOVds9G2D7psNi9o8lLQYlvbCzowCWLl9/Ee
	 iYKHsizMskCBa7eJnNHHd+iqPaSkwGq5QzHVPaww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgCCRvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgCCRvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:51:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D962820728;
        Tue,  3 Mar 2020 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257894;
        bh=TWaHQuaX+udslyLnLdBDaWL8PltVKCSg+RqVLp2g4R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OchWDomYLscnVZNWQHHKP3rDG+Vu18ic93epn4Tfjq9RMjTuZe5U1R2SprX9PrkKM
         3f1NW5B+eZniHz3vVTp1DzzUA6x6On++LzyhnU8DqbOSrJiI1xjsaE9O17VUTpdOG/
         EJzVfE27QFDxEsXzVe8hWKqzF2bFGHd7wx90x6sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 141/176] KVM: SVM: Override default MMIO mask if memory encryption is enabled
Date:   Tue,  3 Mar 2020 18:43:25 +0100
Message-Id: <20200303174321.097546108@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 52918ed5fcf05d97d257f4131e19479da18f5d16 upstream.

The KVM MMIO support uses bit 51 as the reserved bit to cause nested page
faults when a guest performs MMIO. The AMD memory encryption support uses
a CPUID function to define the encryption bit position. Given this, it is
possible that these bits can conflict.

Use svm_hardware_setup() to override the MMIO mask if memory encryption
support is enabled. Various checks are performed to ensure that the mask
is properly defined and rsvd_bits() is used to generate the new mask (as
was done prior to the change that necessitated this patch).

Fixes: 28a1f3ac1d0c ("kvm: x86: Set highest physical address bits in non-present/reserved SPTEs")
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1307,6 +1307,47 @@ static void shrink_ple_window(struct kvm
 	}
 }
 
+/*
+ * The default MMIO mask is a single bit (excluding the present bit),
+ * which could conflict with the memory encryption bit. Check for
+ * memory encryption support and override the default MMIO mask if
+ * memory encryption is enabled.
+ */
+static __init void svm_adjust_mmio_mask(void)
+{
+	unsigned int enc_bit, mask_bit;
+	u64 msr, mask;
+
+	/* If there is no memory encryption support, use existing mask */
+	if (cpuid_eax(0x80000000) < 0x8000001f)
+		return;
+
+	/* If memory encryption is not enabled, use existing mask */
+	rdmsrl(MSR_K8_SYSCFG, msr);
+	if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+		return;
+
+	enc_bit = cpuid_ebx(0x8000001f) & 0x3f;
+	mask_bit = boot_cpu_data.x86_phys_bits;
+
+	/* Increment the mask bit if it is the same as the encryption bit */
+	if (enc_bit == mask_bit)
+		mask_bit++;
+
+	/*
+	 * If the mask bit location is below 52, then some bits above the
+	 * physical addressing limit will always be reserved, so use the
+	 * rsvd_bits() function to generate the mask. This mask, along with
+	 * the present bit, will be used to generate a page fault with
+	 * PFER.RSV = 1.
+	 *
+	 * If the mask bit location is 52 (or above), then clear the mask.
+	 */
+	mask = (mask_bit < 52) ? rsvd_bits(mask_bit, 51) | PT_PRESENT_MASK : 0;
+
+	kvm_mmu_set_mmio_spte_mask(mask, mask, PT_WRITABLE_MASK | PT_USER_MASK);
+}
+
 static __init int svm_hardware_setup(void)
 {
 	int cpu;
@@ -1361,6 +1402,8 @@ static __init int svm_hardware_setup(voi
 		}
 	}
 
+	svm_adjust_mmio_mask();
+
 	for_each_possible_cpu(cpu) {
 		r = svm_cpu_init(cpu);
 		if (r)



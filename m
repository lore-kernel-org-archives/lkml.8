Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D172C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5220708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339381;
	bh=39WzRQPwvW5XrxKbELBSz19WS+NFf8umOaaiF2Is8OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UmXBnifMMT+ksSoO6gV5HTzfl4EN0ha9l07qANXTCjLqg796y9r/dqSlstBrUhbRH
	 ykbxWGJvPzJud658Zu8zzPr3CBuYPSajdt/nCZcDsdMgLJlxqI35dmjw2+cgGfuZmJ
	 nGGobQGlqQw4Qk7OTq4I+HI4jsHgLY2k7hWfS9pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgBJM4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgBJMlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:42 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252A420733;
        Mon, 10 Feb 2020 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338501;
        bh=39WzRQPwvW5XrxKbELBSz19WS+NFf8umOaaiF2Is8OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG8NgWcXaVBJb4mqg/bQIIvUVvMLeoG3aQmQ6RW/RTJYk89FmJUaCZJypVfA9soEW
         wK+uPUId1KLoMnVOXQH8UHTikRWdVainB2ysbJnJSczItTLDivRP2kHHoH6CEokkEo
         aMAzJd3QLNV/cSZugQgzt4lwiHFC9rlsGehca/yY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 245/367] KVM: x86: use CPUID to locate host page table reserved bits
Date:   Mon, 10 Feb 2020 04:32:38 -0800
Message-Id: <20200210122446.800976612@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 7adacf5eb2d2048045d9fd8fdab861fd9e7e2e96 upstream.

The comment in kvm_get_shadow_phys_bits refers to MKTME, but the same is actually
true of SME and SEV.  Just use CPUID[0x8000_0008].EAX[7:0] unconditionally if
available, it is simplest and works even if memory is not encrypted.

Cc: stable@vger.kernel.org
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu/mmu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -538,16 +538,20 @@ EXPORT_SYMBOL_GPL(kvm_mmu_set_mask_ptes)
 static u8 kvm_get_shadow_phys_bits(void)
 {
 	/*
-	 * boot_cpu_data.x86_phys_bits is reduced when MKTME is detected
-	 * in CPU detection code, but MKTME treats those reduced bits as
-	 * 'keyID' thus they are not reserved bits. Therefore for MKTME
-	 * we should still return physical address bits reported by CPUID.
+	 * boot_cpu_data.x86_phys_bits is reduced when MKTME or SME are detected
+	 * in CPU detection code, but the processor treats those reduced bits as
+	 * 'keyID' thus they are not reserved bits. Therefore KVM needs to look at
+	 * the physical address bits reported by CPUID.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_TME) ||
-	    WARN_ON_ONCE(boot_cpu_data.extended_cpuid_level < 0x80000008))
-		return boot_cpu_data.x86_phys_bits;
+	if (likely(boot_cpu_data.extended_cpuid_level >= 0x80000008))
+		return cpuid_eax(0x80000008) & 0xff;
 
-	return cpuid_eax(0x80000008) & 0xff;
+	/*
+	 * Quite weird to have VMX or SVM but not MAXPHYADDR; probably a VM with
+	 * custom CPUID.  Proceed with whatever the kernel found since these features
+	 * aren't virtualizable (SME/SEV also require CPUIDs higher than 0x80000008).
+	 */
+	return boot_cpu_data.x86_phys_bits;
 }
 
 static void kvm_mmu_reset_all_pte_masks(void)



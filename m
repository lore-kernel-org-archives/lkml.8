Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC764C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E7221835
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578529;
	bh=mRHbs5IOpUfsa2d3zxU/pzHYEeSBgoCFaCcWPJgVZj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NnAsx8NhrWTv8+1KXUxokjSLZ/XPvqRDoFZf9lzPIjnDwaaQmbRrvdmcbRq+7CHKb
	 S1s6tSEbwkLJ4i9d8OdT3XEPGk7oGQMpe9vz4K075RfkZGBZ7KxT6lSwakVqVuEcFi
	 PNMbchmYKrEi5qMzDj5BVMamHcTX2WypBuwHqFow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbgFSOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389958AbgFSOzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99DC52158C;
        Fri, 19 Jun 2020 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578518;
        bh=mRHbs5IOpUfsa2d3zxU/pzHYEeSBgoCFaCcWPJgVZj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooZmeHRpw8+GUbioCOHhUgymSxJKpS3Pchrp/03csYi9iPbQwNu1m7MPYJ7mTTnGr
         H+SvApWyv34D89U7aRNRt20ND1xNiUAVagAXX2FRukU47AKFnPJfRE7aUGGmBBmkVi
         7m4A+N0TN3wDg+RLQIvmVwRMIsA1Thcl0gTdgGls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 051/267] kvm: x86: Fix L1TF mitigation for shadow MMU
Date:   Fri, 19 Jun 2020 16:30:36 +0200
Message-Id: <20200619141651.334232453@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Huang <kai.huang@linux.intel.com>

[ Upstream commit 61455bf26236e7f3d72705382a6437fdfd1bd0af ]

Currently KVM sets 5 most significant bits of physical address bits
reported by CPUID (boot_cpu_data.x86_phys_bits) for nonpresent or
reserved bits SPTE to mitigate L1TF attack from guest when using shadow
MMU. However for some particular Intel CPUs the physical address bits
of internal cache is greater than physical address bits reported by
CPUID.

Use the kernel's existing boot_cpu_data.x86_cache_bits to determine the
five most significant bits. Doing so improves KVM's L1TF mitigation in
the unlikely scenario that system RAM overlaps the high order bits of
the "real" physical address space as reported by CPUID. This aligns with
the kernel's warnings regarding L1TF mitigation, e.g. in the above
scenario the kernel won't warn the user about lack of L1TF mitigation
if x86_cache_bits is greater than x86_phys_bits.

Also initialize shadow_nonpresent_or_rsvd_mask explicitly to make it
consistent with other 'shadow_{xxx}_mask', and opportunistically add a
WARN once if KVM's L1TF mitigation cannot be applied on a system that
is marked as being susceptible to L1TF.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 62f1e4663bc3..440ffe810e5d 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -479,16 +479,24 @@ static void kvm_mmu_reset_all_pte_masks(void)
 	 * If the CPU has 46 or less physical address bits, then set an
 	 * appropriate mask to guard against L1TF attacks. Otherwise, it is
 	 * assumed that the CPU is not vulnerable to L1TF.
+	 *
+	 * Some Intel CPUs address the L1 cache using more PA bits than are
+	 * reported by CPUID. Use the PA width of the L1 cache when possible
+	 * to achieve more effective mitigation, e.g. if system RAM overlaps
+	 * the most significant bits of legal physical address space.
 	 */
-	low_phys_bits = boot_cpu_data.x86_phys_bits;
-	if (boot_cpu_data.x86_phys_bits <
+	shadow_nonpresent_or_rsvd_mask = 0;
+	low_phys_bits = boot_cpu_data.x86_cache_bits;
+	if (boot_cpu_data.x86_cache_bits <
 	    52 - shadow_nonpresent_or_rsvd_mask_len) {
 		shadow_nonpresent_or_rsvd_mask =
-			rsvd_bits(boot_cpu_data.x86_phys_bits -
+			rsvd_bits(boot_cpu_data.x86_cache_bits -
 				  shadow_nonpresent_or_rsvd_mask_len,
-				  boot_cpu_data.x86_phys_bits - 1);
+				  boot_cpu_data.x86_cache_bits - 1);
 		low_phys_bits -= shadow_nonpresent_or_rsvd_mask_len;
-	}
+	} else
+		WARN_ON_ONCE(boot_cpu_has_bug(X86_BUG_L1TF));
+
 	shadow_nonpresent_or_rsvd_lower_gfn_mask =
 		GENMASK_ULL(low_phys_bits - 1, PAGE_SHIFT);
 }
-- 
2.25.1




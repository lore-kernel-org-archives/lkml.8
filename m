Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C20E206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610127;
	bh=yg3fBzSDjqtv8BD3FgS9a1YRRzrsgOLKEttaZebXg7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hnZe2tP5lgxuiOmIGvLQzaDp6NSFqBsf8x4S6Zra9nwwLaJ8+qfscPMGrOxDNzOG
	 xnOGe2KqoV60JY1DEfAi7inr96BW0yLNGmhk54lSq1IBxKSb1g1oAoQiuwONoh9ccj
	 +qfytibqtxDQbdQECYv6nAcKDNhpGT2WxlqSduh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgBMQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgBMPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:58 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D94246B1;
        Thu, 13 Feb 2020 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607377;
        bh=yg3fBzSDjqtv8BD3FgS9a1YRRzrsgOLKEttaZebXg7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvUJf+dzQv4TpsJeAn3GjHbrtuKfpn8PmVAuEEekk2qzAXzkKzutiLYJj54X7ZG46
         K8BLR8xerX2y0oF2l3FPqkS33GKDI6uU0TIMHBOtYQxKZIW9xWVHhl6+Su9+Dno2Ak
         8ls77a9Ow6zghsri8gMu+QhoJZqpJQf45LHpZaEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 73/91] KVM: x86/mmu: Apply max PA check for MMIO sptes to 32-bit KVM
Date:   Thu, 13 Feb 2020 07:20:30 -0800
Message-Id: <20200213151850.623521270@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit e30a7d623dccdb3f880fbcad980b0cb589a1da45 ]

Remove the bogus 64-bit only condition from the check that disables MMIO
spte optimization when the system supports the max PA, i.e. doesn't have
any reserved PA bits.  32-bit KVM always uses PAE paging for the shadow
MMU, and per Intel's SDM:

  PAE paging translates 32-bit linear addresses to 52-bit physical
  addresses.

The kernel's restrictions on max physical addresses are limits on how
much memory the kernel can reasonably use, not what physical addresses
are supported by hardware.

Fixes: ce88decffd17 ("KVM: MMU: mmio page fault support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 29e645c80d1a2..21fb707546b65 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5885,14 +5885,12 @@ static void kvm_set_mmio_spte_mask(void)
 	/* Set the present bit. */
 	mask |= 1ull;
 
-#ifdef CONFIG_X86_64
 	/*
 	 * If reserved bit is not supported, clear the present bit to disable
 	 * mmio page fault.
 	 */
 	if (maxphyaddr == 52)
 		mask &= ~1ull;
-#endif
 
 	kvm_mmu_set_mmio_spte_mask(mask);
 }
-- 
2.20.1




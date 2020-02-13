Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10118C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11DC2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609854;
	bh=NSl0QrEKiOkbgfri/p32nDkaFvn2spBG2s1vpvEtXyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=saNtgdO0PffLnKgHvdxOHIZHwFiFXEaUTTsRS9kwGqwMN7vfCLUJG8duBBdytBblP
	 8MaqPjZWaYFxDuAUa+zks7VVhRlfWcxtIO1UtbjmT2+nrqj5N89yVkryD364QSXmMG
	 qLyFDR8Qg4NZN51nLf7WAeQmyUD0cQNFhhQ5Y4kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgBMQEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgBMPYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:08 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D0E24690;
        Thu, 13 Feb 2020 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607447;
        bh=NSl0QrEKiOkbgfri/p32nDkaFvn2spBG2s1vpvEtXyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEGRRGCEsc1H/gdKdI3qKBm6hUdMgRSGURxG5V/w0NiKnmKinIoh+FUF9rSknmAjT
         aY8cZYVOCHQJglNRm3xdHKn8xuPvkMoX1IFFzhee7nJcR5fi9ymjxeg1iqUO2gYERJ
         FNv3UEwJBXP2dnOc7IprA8tREXPIjcSNJo5FBhSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 090/116] KVM: x86/mmu: Apply max PA check for MMIO sptes to 32-bit KVM
Date:   Thu, 13 Feb 2020 07:20:34 -0800
Message-Id: <20200213151917.983069432@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
 arch/x86/kvm/x86.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6132,14 +6132,12 @@ static void kvm_set_mmio_spte_mask(void)
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



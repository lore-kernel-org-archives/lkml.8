Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4371C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB02B20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608701;
	bh=WuqV254a5onX5HPGKhHxntSjp5QurUQnAHBFMgCKLuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iKXiehYfgrB+FpCZxNfKh2rZPkwd09o41/IyomV4jHh8j777YttxaDTRGgrosbQCu
	 VzQKbt0znfCIxGxE/tlCUpfHJW2Te6HYQurzuQB2qTYcQ6ffkYugoYtzTlr0c0/+6o
	 mNMrh0kxTwDEUr6js5sSaf3Ggcn74lFG3TljXcto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgBMPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgBMP1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:34 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6566E20661;
        Thu, 13 Feb 2020 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607654;
        bh=WuqV254a5onX5HPGKhHxntSjp5QurUQnAHBFMgCKLuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXBX8N/S92zrhlKvcsOrjzB7GY3CpPBdgsLWV28huGjhwcfiR8vfWsY2aTE/wlPlb
         ShnA2X9uduY5bTz/Ua064FHqLGHyKWmlZP8zUvAbGCj9a5/tfK74diVAvDJhIrLxOi
         bsPiCLsRtO3Q2CGjhU2V3PJDS1ZQ4FXx/PTd0KhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.4 68/96] KVM: arm/arm64: Fix young bit from mmu notifier
Date:   Thu, 13 Feb 2020 07:21:15 -0800
Message-Id: <20200213151904.946853903@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Shan <gshan@redhat.com>

commit cf2d23e0bac9f6b5cd1cba8898f5f05ead40e530 upstream.

kvm_test_age_hva() is called upon mmu_notifier_test_young(), but wrong
address range has been passed to handle_hva_to_gpa(). With the wrong
address range, no young bits will be checked in handle_hva_to_gpa().
It means zero is always returned from mmu_notifier_test_young().

This fixes the issue by passing correct address range to the underly
function handle_hva_to_gpa(), so that the hardware young (access) bit
will be visited.

Fixes: 35307b9a5f7e ("arm/arm64: KVM: Implement Stage-2 page aging")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200121055659.19560-1-gshan@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2147,7 +2147,8 @@ int kvm_test_age_hva(struct kvm *kvm, un
 	if (!kvm->arch.pgd)
 		return 0;
 	trace_kvm_test_age_hva(hva);
-	return handle_hva_to_gpa(kvm, hva, hva, kvm_test_age_hva_handler, NULL);
+	return handle_hva_to_gpa(kvm, hva, hva + PAGE_SIZE,
+				 kvm_test_age_hva_handler, NULL);
 }
 
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)



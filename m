Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E150C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F0B20814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+3c85HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgE2PmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:42:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727863AbgE2Pjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590766783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBGkYgyJ8t56KCY/g0VbmTME7lFoIVkD8I73jTWjLnc=;
        b=C+3c85HIok1oXUp92yAa4/zfjJ5PoGQcqHJL1hmj8d0tsOKM3umClK8IZTmdO7u8Qg3v57
        iAURYImgse6O9hatDJCwpANOYEU4M5b8bQ3W8f+fMJj5qu6bwJtfTyV+8UWojdJdpEGDk4
        yMt+uWYup6ofkQdaMZuJmM0Xj25bA2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-Vnng9a8hO2GtalkyuGuPUg-1; Fri, 29 May 2020 11:39:40 -0400
X-MC-Unique: Vnng9a8hO2GtalkyuGuPUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B7FC19057A1;
        Fri, 29 May 2020 15:39:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5E2D5D9D5;
        Fri, 29 May 2020 15:39:38 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 07/30] KVM: nVMX: always update CR3 in VMCS
Date:   Fri, 29 May 2020 11:39:11 -0400
Message-Id: <20200529153934.11694-8-pbonzini@redhat.com>
In-Reply-To: <20200529153934.11694-1-pbonzini@redhat.com>
References: <20200529153934.11694-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_load_mmu_pgd is delaying the write of GUEST_CR3 to prepare_vmcs02 as
an optimization, but this is only correct before the nested vmentry.
If userspace is modifying CR3 with KVM_SET_SREGS after the VM has
already been put in guest mode, the value of CR3 will not be updated.
Remove the optimization, which almost never triggers anyway.

Fixes: 04f11ef45810 ("KVM: nVMX: Always write vmcs02.GUEST_CR3 during nested VM-Enter")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b3a41645e157..7b55dc6230a9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3085,10 +3085,7 @@ void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd)
 			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 		}
 
-		/* Loading vmcs02.GUEST_CR3 is handled by nested VM-Enter. */
-		if (is_guest_mode(vcpu))
-			update_guest_cr3 = false;
-		else if (!enable_unrestricted_guest && !is_paging(vcpu))
+		if (!enable_unrestricted_guest && !is_paging(vcpu))
 			guest_cr3 = to_kvm_vmx(kvm)->ept_identity_map_addr;
 		else if (test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
 			guest_cr3 = vcpu->arch.cr3;
-- 
2.26.2



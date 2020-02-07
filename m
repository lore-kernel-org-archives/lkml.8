Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95E0217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buw6pKaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBGWfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:35:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727530AbgBGWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581114933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XsUS877THbbHLMWAH0vUYHxXn1kbs8c4Q1KcyCj1WI=;
        b=buw6pKaUW2K21G0zKLGMfDeqZ0twUHV+5ImIuJopQ0dq5/5IsNUtinMygMHIseFNN5Ausb
        RCTNt0OIp5qEPDni+AoAdNZSUiZGdrxHzC7IHW04IgrYx8MhTnOdg0QM5Tc2cYREJKrL+Q
        PrDQzaWkm1kt9OTtHcs17gycblZjLzc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-1vc9tVptN4-uofEzdw71jQ-1; Fri, 07 Feb 2020 17:35:31 -0500
X-MC-Unique: 1vc9tVptN4-uofEzdw71jQ-1
Received: by mail-qv1-f72.google.com with SMTP id f17so492311qvi.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XsUS877THbbHLMWAH0vUYHxXn1kbs8c4Q1KcyCj1WI=;
        b=MzELChex1ZYdo9DCXyQ5tbgyXF6JpN8L63DXoP/rTcDu6PUiNAkdgDbBbSByMIh5QC
         DHCDvGSD79+QmeSZLaOoAc1uIpqvPEo47NOGsvjPQVsynBjjGhXxeUA+vYSO4M8y9E+a
         hNoo6EJ2ZFIzmCJJi+DZ6tC6y7ilvcFbeCItqhR8V0CUQZXrIQz9m9/Vcbv3hDkGZTIY
         tYWeiV5Y62/9MRmj8rI8FvYxQIrBzFyX+dQ/3Qz/RcSc2iYd25y3xuVwo0ksd+sY0eVn
         XlRaDOV6yJkAqEbpnlT+6uHx7cyqKdNiQr/SvPmZsIrEmEHjDYiAfbj5AlE9evuQzm7R
         Ozjg==
X-Gm-Message-State: APjAAAVDNlkwkeUHSqKNFi2uYf5JyEpX8C/a/FQu4TZcReduqI0OiJm2
        8LdDWMxJCfG3NOUR5y4lrJMun38i0lb9F+CkJAPJzmp69euhy7d5/JdE3d3vfj3+TV8oEsHHiLx
        EqtbjEt2kL3NH84fYLA+GXzDm
X-Received: by 2002:ac8:7388:: with SMTP id t8mr598863qtp.244.1581114930699;
        Fri, 07 Feb 2020 14:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwn5fwgG8yLSUv1nZMep7TxP6EHJN2W9klV6ZqRv2GguI28ys/WxlL4swGn7j7HsjM3rXcdpw==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr598847qtp.244.1581114930463;
        Fri, 07 Feb 2020 14:35:30 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id u12sm2178736qtj.84.2020.02.07.14.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:35:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 4/4] KVM: MIPS: Define arch-specific kvm_flush_remote_tlbs()
Date:   Fri,  7 Feb 2020 17:35:20 -0500
Message-Id: <20200207223520.735523-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207223520.735523-1-peterx@redhat.com>
References: <20200207223520.735523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select HAVE_KVM_ARCH_TLB_FLUSH_ALL for MIPS to define its own
kvm_flush_remote_tlbs().  It's as simple as calling the
flush_shadow_all(kvm) hook.  Then replace all the flush_shadow_all()
calls to use this KVM generic API to do TLB flush.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/kvm/Kconfig |  1 +
 arch/mips/kvm/mips.c  | 22 ++++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index eac25aef21e0..8a06f660d39e 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_MMIO
 	select MMU_NOTIFIER
 	select SRCU
+	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	---help---
 	  Support for hosting Guest kernels.
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 1d5e7ffda746..518020b466bf 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -194,13 +194,16 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return 0;
 }
 
+void kvm_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_mips_callbacks->flush_shadow_all(kvm);
+}
+
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
 	/* Flush whole GPA */
 	kvm_mips_flush_gpa_pt(kvm, 0, ~0);
-
-	/* Let implementation do the rest */
-	kvm_mips_callbacks->flush_shadow_all(kvm);
+	kvm_flush_remote_tlbs(kvm);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
@@ -215,8 +218,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	/* Flush slot from GPA */
 	kvm_mips_flush_gpa_pt(kvm, slot->base_gfn,
 			      slot->base_gfn + slot->npages - 1);
-	/* Let implementation do the rest */
-	kvm_mips_callbacks->flush_shadow_all(kvm);
+	kvm_flush_remote_tlbs(kvm);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -258,7 +260,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 					new->base_gfn + new->npages - 1);
 		/* Let implementation do the rest */
 		if (needs_flush)
-			kvm_mips_callbacks->flush_shadow_all(kvm);
+			kvm_flush_remote_tlbs(kvm);
 		spin_unlock(&kvm->mmu_lock);
 	}
 }
@@ -1001,9 +1003,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	if (flush) {
 		slots = kvm_memslots(kvm);
 		memslot = id_to_memslot(slots, log->slot);
-
-		/* Let implementation handle TLB/GVA invalidation */
-		kvm_mips_callbacks->flush_shadow_all(kvm);
+		kvm_flush_remote_tlbs(kvm);
 	}
 
 	mutex_unlock(&kvm->slots_lock);
@@ -1024,9 +1024,7 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 	if (flush) {
 		slots = kvm_memslots(kvm);
 		memslot = id_to_memslot(slots, log->slot);
-
-		/* Let implementation handle TLB/GVA invalidation */
-		kvm_mips_callbacks->flush_shadow_all(kvm);
+		kvm_flush_remote_tlbs(kvm);
 	}
 
 	mutex_unlock(&kvm->slots_lock);
-- 
2.24.1


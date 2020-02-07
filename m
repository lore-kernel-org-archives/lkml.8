Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0339C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE32217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks60V9C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBGWfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:35:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727068AbgBGWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581114930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPutAweyqqYRiz9KxYGz1dd9ij66mBcCSHiTuUd/XC8=;
        b=Ks60V9C7YfpZmlEbttL3ixrSkZS+hsUdOOGP7GiguAhQwpPxp3WVgu+VPR2BPj4JAN0m4x
        URg87Y+Obrs1bvy6WPiFjgoLrX5Fa5i9D0rJU4E5/Nl5lIRSX727eoZXTEwhL71J1hjusg
        rZVVwjzrOhlOUbMaEwha8IRpJZBHcx4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-J0iwef4ENVye5PXgleMW9A-1; Fri, 07 Feb 2020 17:35:28 -0500
X-MC-Unique: J0iwef4ENVye5PXgleMW9A-1
Received: by mail-qt1-f198.google.com with SMTP id y3so529623qti.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPutAweyqqYRiz9KxYGz1dd9ij66mBcCSHiTuUd/XC8=;
        b=JNA18GvxcNIB9NDqehfTI5Cp3NhD5hOTjbfV/Le4g9F+r0ySoe4GuHW5e3ztg4l9NL
         /kki7nQjAf/3jbHfteKD1NPCd26v3LefSRjvksONI/3f7EUqmna3o01cbmbLLtOR9qaF
         TNMQ4laSmX/ZUO25XlDaVOoIwi5g9hk3jFvlGQ6qTS8aDGzc3FVNHlnk0Yic8o3SZNZz
         kjZinY3kv2k12vlBOe0Q9pTLOlKjVjzW0HI44aVjrciXXmW4WFvJnjjPdAjdQzc7bYy7
         p2Edn1TzGTysNX1TFA56UfPs0OemmlQTRB0szyuNJXRC8J1UAFGY1mwlfKVqepbehjgR
         LSww==
X-Gm-Message-State: APjAAAWuqeViCgaBRL3UXhVsJRLv8ZG/r9bELSfuvAFDk+IuPa0ztarV
        SEevpFWZsFaHkjYSec/M/22G70mWzXJ0BiWI1VAyGNPO671BAEuucY/JT4G+KCmDzE8lKrATR91
        12G16zI2FqqiAu8LSqrd8rFF8
X-Received: by 2002:a05:620a:ce5:: with SMTP id c5mr1099008qkj.49.1581114927308;
        Fri, 07 Feb 2020 14:35:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYCXDDBavylfK3XSW4kgxYTTnNpTKM31yKtNKqnzCOiKnqklk6yL1y/qv/w5shFGwTrtkFLw==
X-Received: by 2002:a05:620a:ce5:: with SMTP id c5mr1098986qkj.49.1581114927069;
        Fri, 07 Feb 2020 14:35:27 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id u12sm2178736qtj.84.2020.02.07.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:35:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 2/4] KVM: MIPS: Drop flush_shadow_memslot() callback
Date:   Fri,  7 Feb 2020 17:35:18 -0500
Message-Id: <20200207223520.735523-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207223520.735523-1-peterx@redhat.com>
References: <20200207223520.735523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS flush_shadow_memslot() callback is always calling the
flush_shadow_all() implementation no matter for trap-emul or VZ.
Delete it and call flush_shadow_all() instead.

This patch prepares for a further replacement of letting MIPS to use
the common kvm_flush_remote_tlbs() call in all places.

No functional change expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/include/asm/kvm_host.h | 7 -------
 arch/mips/kvm/mips.c             | 8 ++++----
 arch/mips/kvm/trap_emul.c        | 7 -------
 arch/mips/kvm/vz.c               | 7 -------
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 41204a49cf95..e95faffb23d8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -786,13 +786,6 @@ struct kvm_mips_callbacks {
 	void (*vcpu_uninit)(struct kvm_vcpu *vcpu);
 	int (*vcpu_setup)(struct kvm_vcpu *vcpu);
 	void (*flush_shadow_all)(struct kvm *kvm);
-	/*
-	 * Must take care of flushing any cached GPA PTEs (e.g. guest entries in
-	 * VZ root TLB, or T&E GVA page tables and corresponding root TLB
-	 * mappings).
-	 */
-	void (*flush_shadow_memslot)(struct kvm *kvm,
-				     const struct kvm_memory_slot *slot);
 	gpa_t (*gva_to_gpa)(gva_t gva);
 	void (*queue_timer_int)(struct kvm_vcpu *vcpu);
 	void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2606f3f02b54..1d5e7ffda746 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -216,7 +216,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	kvm_mips_flush_gpa_pt(kvm, slot->base_gfn,
 			      slot->base_gfn + slot->npages - 1);
 	/* Let implementation do the rest */
-	kvm_mips_callbacks->flush_shadow_memslot(kvm, slot);
+	kvm_mips_callbacks->flush_shadow_all(kvm);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -258,7 +258,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 					new->base_gfn + new->npages - 1);
 		/* Let implementation do the rest */
 		if (needs_flush)
-			kvm_mips_callbacks->flush_shadow_memslot(kvm, new);
+			kvm_mips_callbacks->flush_shadow_all(kvm);
 		spin_unlock(&kvm->mmu_lock);
 	}
 }
@@ -1003,7 +1003,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 		memslot = id_to_memslot(slots, log->slot);
 
 		/* Let implementation handle TLB/GVA invalidation */
-		kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
+		kvm_mips_callbacks->flush_shadow_all(kvm);
 	}
 
 	mutex_unlock(&kvm->slots_lock);
@@ -1026,7 +1026,7 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 		memslot = id_to_memslot(slots, log->slot);
 
 		/* Let implementation handle TLB/GVA invalidation */
-		kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
+		kvm_mips_callbacks->flush_shadow_all(kvm);
 	}
 
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 5a11e83dffe6..2ecb430ea0f1 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -703,12 +703,6 @@ static void kvm_trap_emul_flush_shadow_all(struct kvm *kvm)
 	kvm_flush_remote_tlbs(kvm);
 }
 
-static void kvm_trap_emul_flush_shadow_memslot(struct kvm *kvm,
-					const struct kvm_memory_slot *slot)
-{
-	kvm_trap_emul_flush_shadow_all(kvm);
-}
-
 static u64 kvm_trap_emul_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_INDEX,
 	KVM_REG_MIPS_CP0_ENTRYLO0,
@@ -1292,7 +1286,6 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
 	.flush_shadow_all = kvm_trap_emul_flush_shadow_all,
-	.flush_shadow_memslot = kvm_trap_emul_flush_shadow_memslot,
 	.gva_to_gpa = kvm_trap_emul_gva_to_gpa_cb,
 	.queue_timer_int = kvm_mips_queue_timer_int_cb,
 	.dequeue_timer_int = kvm_mips_dequeue_timer_int_cb,
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index dde20887a70d..814bd1564a79 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -3123,12 +3123,6 @@ static void kvm_vz_flush_shadow_all(struct kvm *kvm)
 	}
 }
 
-static void kvm_vz_flush_shadow_memslot(struct kvm *kvm,
-					const struct kvm_memory_slot *slot)
-{
-	kvm_vz_flush_shadow_all(kvm);
-}
-
 static void kvm_vz_vcpu_reenter(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
@@ -3185,7 +3179,6 @@ static struct kvm_mips_callbacks kvm_vz_callbacks = {
 	.vcpu_uninit = kvm_vz_vcpu_uninit,
 	.vcpu_setup = kvm_vz_vcpu_setup,
 	.flush_shadow_all = kvm_vz_flush_shadow_all,
-	.flush_shadow_memslot = kvm_vz_flush_shadow_memslot,
 	.gva_to_gpa = kvm_vz_gva_to_gpa_cb,
 	.queue_timer_int = kvm_vz_queue_timer_int_cb,
 	.dequeue_timer_int = kvm_vz_dequeue_timer_int_cb,
-- 
2.24.1


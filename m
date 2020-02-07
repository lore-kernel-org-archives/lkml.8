Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8778217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbkddzii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBGWff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:35:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727478AbgBGWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581114931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbFuDNqXWxYaO1U3b7e5Dk8u+2RlyLNa/H+l9wnHCjY=;
        b=HbkddziikS6pRakwr71b/9CxfUmxcnahygKIzkAuCnI6m3oXphQsvc1M2DqXyv0j4GMXrg
        ZYUm4PYdmQNUflTVQJ2geOGB8B+4Cke9o3wK6F/ohnhlKga1UP80UnPQCVg7H51Io8oA7W
        EokJKur+jV+P1L3KrY3VIZrN1WVh3k8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Hve1j037PW2uawZPog4XgQ-1; Fri, 07 Feb 2020 17:35:29 -0500
X-MC-Unique: Hve1j037PW2uawZPog4XgQ-1
Received: by mail-qk1-f200.google.com with SMTP id t195so458931qke.23
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbFuDNqXWxYaO1U3b7e5Dk8u+2RlyLNa/H+l9wnHCjY=;
        b=qwb4gADxnpNiJp7HKsbq/Rc3NlEbfGp8jaTBKPY0jUTPyBLMcX4qNfgWfUzhSulXny
         L++jJg0jZYs1riCZkwmqU3wozlV5431rGOTsdqnlCSZc0tEq5BHdWLMDuO/tmQzA8TPI
         erf/zF31qf7d37jyLpLwyAXAlbO6hsFwMKGmGyg0lXzbzj+xpN8S9ALMAWwU1+MGrHoH
         LPhOWAyDaqXqPo+vpI1wf4MRTyoQj5sNcft88WgGW+k1PJ8+8qUB/+2KiRh/yfV8vmw6
         FI95lw7H6PmPTb9LKOzy8ex1dPPZAueq0PKo+dA3olGDOdpptPKLjdsY/44wXrg3fpT7
         1sOQ==
X-Gm-Message-State: APjAAAXQkx1EvB+BjkHr3yJxkRno2bjvalIUlPBmcy4sDUk2j1wV9KAz
        sRb/LttC/dwwYLQlEy+3SXw+K6fp7GdF/IlVWKSBpD03XcbyX+f1HnGpp/zSuzBIxxiQiNy10Vn
        Y1aOuEJqcVKBVcTelSWqCW8tH
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr564422qtp.209.1581114929001;
        Fri, 07 Feb 2020 14:35:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOrsIOK2qFxwanpIc4DdFHwxuCz+v4A8f7plovFbmLVtbkNX/2LPWpBFah+G+L0x+fURCmIg==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr564402qtp.209.1581114928759;
        Fri, 07 Feb 2020 14:35:28 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id u12sm2178736qtj.84.2020.02.07.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:35:28 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 3/4] KVM: MIPS: Replace all the kvm_flush_remote_tlbs() references
Date:   Fri,  7 Feb 2020 17:35:19 -0500
Message-Id: <20200207223520.735523-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207223520.735523-1-peterx@redhat.com>
References: <20200207223520.735523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kvm_flush_remote_tlbs() calls in MIPS code into
kvm_flush_remote_tlbs_common().  This is to prepare that MIPS will
define its own kvm_flush_remote_tlbs() soon.

The only three references are all in the flush_shadow_all() hooks.
One of them can be directly dropped because it's exactly the
kvm_flush_remote_tlbs_common().  Since at it, refactors the other one
a bit.

No functional change expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/kvm/trap_emul.c | 8 +-------
 arch/mips/kvm/vz.c        | 7 ++-----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 2ecb430ea0f1..ced481c963be 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -697,12 +697,6 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void kvm_trap_emul_flush_shadow_all(struct kvm *kvm)
-{
-	/* Flush GVA page tables and invalidate GVA ASIDs on all VCPUs */
-	kvm_flush_remote_tlbs(kvm);
-}
-
 static u64 kvm_trap_emul_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_INDEX,
 	KVM_REG_MIPS_CP0_ENTRYLO0,
@@ -1285,7 +1279,7 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.vcpu_init = kvm_trap_emul_vcpu_init,
 	.vcpu_uninit = kvm_trap_emul_vcpu_uninit,
 	.vcpu_setup = kvm_trap_emul_vcpu_setup,
-	.flush_shadow_all = kvm_trap_emul_flush_shadow_all,
+	.flush_shadow_all = kvm_flush_remote_tlbs_common,
 	.gva_to_gpa = kvm_trap_emul_gva_to_gpa_cb,
 	.queue_timer_int = kvm_mips_queue_timer_int_cb,
 	.dequeue_timer_int = kvm_mips_dequeue_timer_int_cb,
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 814bd1564a79..91fbf6710da4 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -3105,10 +3105,7 @@ static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 
 static void kvm_vz_flush_shadow_all(struct kvm *kvm)
 {
-	if (cpu_has_guestid) {
-		/* Flush GuestID for each VCPU individually */
-		kvm_flush_remote_tlbs(kvm);
-	} else {
+	if (!cpu_has_guestid) {
 		/*
 		 * For each CPU there is a single GPA ASID used by all VCPUs in
 		 * the VM, so it doesn't make sense for the VCPUs to handle
@@ -3119,8 +3116,8 @@ static void kvm_vz_flush_shadow_all(struct kvm *kvm)
 		 * kick any running VCPUs so they check asid_flush_mask.
 		 */
 		cpumask_setall(&kvm->arch.asid_flush_mask);
-		kvm_flush_remote_tlbs(kvm);
 	}
+	kvm_flush_remote_tlbs_common(kvm);
 }
 
 static void kvm_vz_vcpu_reenter(struct kvm_run *run, struct kvm_vcpu *vcpu)
-- 
2.24.1


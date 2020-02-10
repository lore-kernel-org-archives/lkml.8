Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97997C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE020708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338786;
	bh=86r4UqeeZ+aKmHn3QahEc9xR1oMyCEz9S0COPm5NdfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZvO1hq9VpW1GDVpc+xiAJHVlndghaHp65bqQwtqoAnjfu8Veyhw6zCRrIaCeJkq75
	 Ytji+6a5JRmmMZe6oX/KVUQvhqYm/ItwNRAvh3DyDDF6MJWY544C58QcQAzk+BHFaa
	 osEUWtAtRxLSUXeG6Q1Aj2SKX908luHM7346rluE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgBJMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgBJMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:36 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F702051A;
        Mon, 10 Feb 2020 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338496;
        bh=86r4UqeeZ+aKmHn3QahEc9xR1oMyCEz9S0COPm5NdfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xl5ykg0gW2p0DRifMJDZn2UNdXaWNG9KDXeDklIaoeDmOEm4dWG1AYP4UlyTx4Ly9
         ZkWj4+Tdv9GmIXn02XTmwozwyyK0XtpLV8+m5j/FPEGHUrrZTr9Vp8kCOKiqzs2ET+
         CNVCk3N3ycGh5lx72R7fajXwrrCIBYbtWdOMnVF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 249/367] x86/KVM: Clean up hosts steal time structure
Date:   Mon, 10 Feb 2020 04:32:42 -0800
Message-Id: <20200210122447.183043847@linuxfoundation.org>
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

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit a6bd811f1209fe1c64c9f6fd578101d6436c6b6e upstream.

Now that we are mapping kvm_steal_time from the guest directly we
don't need keep a copy of it in kvm_vcpu_arch.st. The same is true
for the stime field.

This is part of CVE-2019-3016.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    3 +--
 arch/x86/kvm/x86.c              |   11 +++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -685,10 +685,9 @@ struct kvm_vcpu_arch {
 	bool pvclock_set_guest_stopped_request;
 
 	struct {
+		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache stime;
-		struct kvm_steal_time steal;
 		struct gfn_to_pfn_cache cache;
 	} st;
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2611,7 +2611,7 @@ static void record_steal_time(struct kvm
 	if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
 		kvm_vcpu_flush_tlb(vcpu, false);
 
-	vcpu->arch.st.steal.preempted = 0;
+	vcpu->arch.st.preempted = 0;
 
 	if (st->version & 1)
 		st->version += 1;  /* first time write, random junk */
@@ -2795,11 +2795,6 @@ int kvm_set_msr_common(struct kvm_vcpu *
 		if (data & KVM_STEAL_RESERVED_MASK)
 			return 1;
 
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.st.stime,
-						data & KVM_STEAL_VALID_BITS,
-						sizeof(struct kvm_steal_time)))
-			return 1;
-
 		vcpu->arch.st.msr_val = data;
 
 		if (!(data & KVM_MSR_ENABLED))
@@ -3519,7 +3514,7 @@ static void kvm_steal_time_set_preempted
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
-	if (vcpu->arch.st.steal.preempted)
+	if (vcpu->arch.st.preempted)
 		return;
 
 	if (kvm_map_gfn(vcpu, vcpu->arch.st.msr_val >> PAGE_SHIFT, &map,
@@ -3529,7 +3524,7 @@ static void kvm_steal_time_set_preempted
 	st = map.hva +
 		offset_in_page(vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS);
 
-	st->preempted = vcpu->arch.st.steal.preempted = KVM_VCPU_PREEMPTED;
+	st->preempted = vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
 
 	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, true);
 }



Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0783BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE975208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338445;
	bh=oYTQ65IeubCz9PCVytWZA5uF5Kd/jvT5kS05dJ9sBrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQfnkn/4+92vovkXRvtM+rZkwnXu/tiAqRIWz/FtqyW85vqlmjxj0mj1U6fc5Pa9C
	 wwcJyCbioDogw+f60bRp98qOTJsMTnKvRDyWMheIyBcxWZBvaTeZRncSZLqF8YL8XM
	 61BepoaUcIqMV08YOaEnUkT5izE1tpU3RA0cfS88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgBJMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgBJMiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:25 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE3C21739;
        Mon, 10 Feb 2020 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338303;
        bh=oYTQ65IeubCz9PCVytWZA5uF5Kd/jvT5kS05dJ9sBrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgBR7W30A82Riyw0TT+gSrzhTWv7bOjhrwjGosCqyXobadETaq7dQFolwYhoOxs1w
         igzKIg/ztCZuP2ZUi1qJ5FgTs7lqPL7IFOffo562QNAiLtWMrofwK7N1zPMCBIb5fF
         PF8pYWudIqjjdTnXMlend5Li6XxJHe1KLPCMnK/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 216/309] x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed
Date:   Mon, 10 Feb 2020 04:32:52 -0800
Message-Id: <20200210122427.301862098@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit b043138246a41064527cf019a3d51d9f015e9796 upstream.

There is a potential race in record_steal_time() between setting
host-local vcpu->arch.st.steal.preempted to zero (i.e. clearing
KVM_VCPU_PREEMPTED) and propagating this value to the guest with
kvm_write_guest_cached(). Between those two events the guest may
still see KVM_VCPU_PREEMPTED in its copy of kvm_steal_time, set
KVM_VCPU_FLUSH_TLB and assume that hypervisor will do the right
thing. Which it won't.

Instad of copying, we should map kvm_steal_time and that will
guarantee atomicity of accesses to @preempted.

This is part of CVE-2019-3016.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2593,45 +2593,47 @@ static void kvm_vcpu_flush_tlb(struct kv
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
+	struct kvm_host_map map;
+	struct kvm_steal_time *st;
+
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
-	if (unlikely(kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
+	/* -EAGAIN is returned in atomic context so we can just return. */
+	if (kvm_map_gfn(vcpu, vcpu->arch.st.msr_val >> PAGE_SHIFT,
+			&map, &vcpu->arch.st.cache, false))
 		return;
 
+	st = map.hva +
+		offset_in_page(vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS);
+
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
-		vcpu->arch.st.steal.preempted & KVM_VCPU_FLUSH_TLB);
-	if (xchg(&vcpu->arch.st.steal.preempted, 0) & KVM_VCPU_FLUSH_TLB)
+		st->preempted & KVM_VCPU_FLUSH_TLB);
+	if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
 		kvm_vcpu_flush_tlb(vcpu, false);
 
-	if (vcpu->arch.st.steal.version & 1)
-		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
+	vcpu->arch.st.steal.preempted = 0;
 
-	vcpu->arch.st.steal.version += 1;
+	if (st->version & 1)
+		st->version += 1;  /* first time write, random junk */
 
-	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+	st->version += 1;
 
 	smp_wmb();
 
-	vcpu->arch.st.steal.steal += current->sched_info.run_delay -
+	st->steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
 
-	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
-
 	smp_wmb();
 
-	vcpu->arch.st.steal.version += 1;
+	st->version += 1;
 
-	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, false);
 }
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -3496,18 +3498,25 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
+	struct kvm_host_map map;
+	struct kvm_steal_time *st;
+
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
 	if (vcpu->arch.st.steal.preempted)
 		return;
 
-	vcpu->arch.st.steal.preempted = KVM_VCPU_PREEMPTED;
+	if (kvm_map_gfn(vcpu, vcpu->arch.st.msr_val >> PAGE_SHIFT, &map,
+			&vcpu->arch.st.cache, true))
+		return;
+
+	st = map.hva +
+		offset_in_page(vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS);
+
+	st->preempted = vcpu->arch.st.steal.preempted = KVM_VCPU_PREEMPTED;
 
-	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
-			&vcpu->arch.st.steal.preempted,
-			offsetof(struct kvm_steal_time, preempted),
-			sizeof(vcpu->arch.st.steal.preempted));
+	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, true);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)



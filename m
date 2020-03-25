Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10173C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C660F20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wwy7zP3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCYKXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:23:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21375 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgCYKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585131827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dJAVutViyziW48uoJ1vZ2A5XPOsDEHehNDmLJL+Tn8=;
        b=Wwy7zP3z0/k4fwIzGQwZIJYkikWagSLxKdMMRtrNz/1C/tTc4tikvjRyYfuBsVi12uJoX1
        wj82fHKzhJ2KlV1CcVnjjHfAQWZX8AMTR7zc13uWaFvOe3vZxdODMqEm0XabMkFwWJeiwh
        msU1jsY8zqcwSnz1pUlC1CZS8cwWkfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-tKEs3ZJjNg-iNlkSlIBorA-1; Wed, 25 Mar 2020 06:23:46 -0400
X-MC-Unique: tKEs3ZJjNg-iNlkSlIBorA-1
Received: by mail-wm1-f71.google.com with SMTP id x26so221526wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6dJAVutViyziW48uoJ1vZ2A5XPOsDEHehNDmLJL+Tn8=;
        b=nzpMWJDORipn5oEHtXZfxlFJtk3ZumOyMOQSASudswQZNkyqxsak5norh5xVXaYv32
         my7ZM+FzNeY8Pf63oWxEBkXF5qKRveuqEwaxB9bHXVXrRVtWXI3uerys4aiXma9VLGyA
         Yjs3uHtyY3pMIW6PLR9Okp9MLV4KEd1mYBeKeojIGLJH4clLauGaem8D5AcWT+eXBK9G
         zOqR9BfX0RRsk8zHZzW+9t/cyQiuS6s74fGxuZBB/t02Edt2KZz4nxh9Ry6KNjT7d7OH
         wX9m2doQ0VPDfHu9nXVNuJZZn37MBuOKYQ0ShtJMj/MjRtwYX6l7WR0RqCDlNjppC+KE
         16Cw==
X-Gm-Message-State: ANhLgQ2eBs7GGHFtIa1upRKzIK6F0sDklZuQw0QZ6MIdineS4uy2XIPr
        Sip68kU8Vr1skvnubHbhn3eNS3x/KlMYu/ADhbiPrhuSjPU7qaZBYBt0uozOUymFgM2GK5VGzOm
        yy6lrF/Uqen5f4U7E4UnMc3Sh
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr2586483wrw.407.1585131824808;
        Wed, 25 Mar 2020 03:23:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv6n1iEZwxUl0A6R9tozXB8P4hVHaC/oMdbsftTCdWmzxPturH/edEywa0J0gSH7MPaHg0cDw==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr2586449wrw.407.1585131824427;
        Wed, 25 Mar 2020 03:23:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f207sm8902528wme.9.2020.03.25.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:23:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 14/37] KVM: x86: Move "flush guest's TLB" logic to separate kvm_x86_ops hook
In-Reply-To: <20200320212833.3507-15-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-15-sean.j.christopherson@intel.com>
Date:   Wed, 25 Mar 2020 11:23:41 +0100
Message-ID: <87369w7mxe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add a dedicated hook to handle flushing TLB entries on behalf of the
> guest, i.e. for a paravirtualized TLB flush, and use it directly instead
> of bouncing through kvm_vcpu_flush_tlb().
>
> For VMX, change the effective implementation implementation to never do
> INVEPT and flush only the current context, i.e. to always flush via
> INVVPID(SINGLE_CONTEXT).  The INVEPT performed by __vmx_flush_tlb() when
> @invalidate_gpa=false and enable_vpid=0 is unnecessary, as it will only
> flush guest-physical mappings; linear and combined mappings are flushed
> by VM-Enter when VPID is disabled, and changes in the guest pages tables
> do not affect guest-physical mappings.
>
> When EPT and VPID are enabled, doing INVVPID is not required (by Intel's
> architecture) to invalidate guest-physical mappings, i.e. TLB entries
> that cache guest-physical mappings can live across INVVPID as the
> mappings are associated with an EPTP, not a VPID.  The intent of
> @invalidate_gpa is to inform vmx_flush_tlb() that it must "invalidate
> gpa mappings", i.e. do INVEPT and not simply INVVPID.  Other than nested
> VPID handling, which now calls vpid_sync_context() directly, the only
> scenario where KVM can safely do INVVPID instead of INVEPT (when EPT is
> enabled) is if KVM is flushing TLB entries from the guest's perspective,
> i.e. is only required to invalidate linear mappings.
>
> For SVM, flushing TLB entries from the guest's perspective can be done
> by flushing the current ASID, as changes to the guest's page tables are
> associated only with the current ASID.
>
> Adding a dedicated ->tlb_flush_guest() paves the way toward removing
> @invalidate_gpa, which is a potentially dangerous control flag as its
> meaning is not exactly crystal clear, even for those who are familiar
> with the subtleties of what mappings Intel CPUs are/aren't allowed to
> keep across various invalidation scenarios.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  6 ++++++
>  arch/x86/kvm/svm.c              |  6 ++++++
>  arch/x86/kvm/vmx/vmx.c          | 13 +++++++++++++
>  arch/x86/kvm/x86.c              |  2 +-
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cdbf822c5c8b..c08f4c0bf4d1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1118,6 +1118,12 @@ struct kvm_x86_ops {
>  	 */
>  	void (*tlb_flush_gva)(struct kvm_vcpu *vcpu, gva_t addr);
>  
> +	/*
> +	 * Flush any TLB entries created by the guest.  Like tlb_flush_gva(),
> +	 * does not need to flush GPA->HPA mappings.
> +	 */
> +	void (*tlb_flush_guest)(struct kvm_vcpu *vcpu);
> +
>  	void (*run)(struct kvm_vcpu *vcpu);
>  	int (*handle_exit)(struct kvm_vcpu *vcpu,
>  		enum exit_fastpath_completion exit_fastpath);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 08568ae9f7a1..396f42753489 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5643,6 +5643,11 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
>  	invlpga(gva, svm->vmcb->control.asid);
>  }
>  
> +static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
> +{
> +	svm_flush_tlb(vcpu, false);
> +}
> +
>  static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
>  {
>  }
> @@ -7400,6 +7405,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  
>  	.tlb_flush = svm_flush_tlb,
>  	.tlb_flush_gva = svm_flush_tlb_gva,
> +	.tlb_flush_guest = svm_flush_tlb_guest,
>  
>  	.run = svm_vcpu_run,
>  	.handle_exit = handle_exit,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ba24bbda2c12..57c1cee58d18 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2862,6 +2862,18 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
>  	 */
>  }
>  
> +static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * vpid_sync_context() is a nop if vmx->vpid==0, e.g. if enable_vpid==0
> +	 * or a vpid couldn't be allocated for this vCPU.  VM-Enter and VM-Exit
> +	 * are required to flush GVA->{G,H}PA mappings from the TLB if vpid is
> +	 * disabled (VM-Enter with vpid enabled and vpid==0 is disallowed),
> +	 * i.e. no explicit INVVPID is necessary.
> +	 */
> +	vpid_sync_context(to_vmx(vcpu)->vpid);
> +}
> +
>  static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu)
>  {
>  	ulong cr0_guest_owned_bits = vcpu->arch.cr0_guest_owned_bits;
> @@ -7875,6 +7887,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.tlb_flush = vmx_flush_tlb,
>  	.tlb_flush_gva = vmx_flush_tlb_gva,
> +	.tlb_flush_guest = vmx_flush_tlb_guest,
>  
>  	.run = vmx_vcpu_run,
>  	.handle_exit = vmx_handle_exit,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f506248d61a1..0b90ec2c93cf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2725,7 +2725,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  	trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>  		st->preempted & KVM_VCPU_FLUSH_TLB);
>  	if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
> -		kvm_vcpu_flush_tlb(vcpu, false);
> +		kvm_x86_ops->tlb_flush_guest(vcpu);
>  
>  	vcpu->arch.st.preempted = 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I *think* I've commented on the previous version that we also have
hyperv-style PV TLB flush and this will likely need to be switched to
tlb_flush_guest(). What do you think about the following (very lightly
tested)?

commit 485b4a579605597b9897b3d9ec118e0f7f1138ad
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Mar 25 11:14:25 2020 +0100

    KVM: x86: make Hyper-V PV TLB flush use tlb_flush_guest()
    
    Hyper-V PV TLB flush mechanism does TLB flush on behalf of the guest
    so doing tlb_flush_all() is an overkill, switch to using tlb_flush_guest()
    (just like KVM PV TLB flush mechanism) instead. Introduce
    KVM_REQ_HV_TLB_FLUSH to support the change.
    
    Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 167729624149..8c5659ed211b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -84,6 +84,7 @@
 #define KVM_REQ_APICV_UPDATE \
 	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_TLB_FLUSH_CURRENT	KVM_ARCH_REQ(26)
+#define KVM_REQ_HV_TLB_FLUSH		KVM_ARCH_REQ(27)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a86fda7a1d03..0d051ed11f38 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1425,8 +1425,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
-	kvm_make_vcpus_request_mask(kvm,
-				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
+	kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
 				    vcpu_mask, &hv_vcpu->tlb_flush);
 
 ret_success:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 210af343eebf..5096a9b1a04e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2702,6 +2702,12 @@ static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->tlb_flush_all(vcpu);
 }
 
+static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
+{
+	++vcpu->stat.tlb_flush;
+	kvm_x86_ops->tlb_flush_guest(vcpu);
+}
+
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
 	struct kvm_host_map map;
@@ -2725,7 +2731,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 		st->preempted & KVM_VCPU_FLUSH_TLB);
 	if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
-		kvm_x86_ops->tlb_flush_guest(vcpu);
+		kvm_vcpu_flush_tlb_guest(vcpu);
 
 	vcpu->arch.st.preempted = 0;
 
@@ -8219,7 +8225,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
 			kvm_vcpu_flush_tlb_current(vcpu);
-
+		if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+			kvm_vcpu_flush_tlb_guest(vcpu);
 		if (kvm_check_request(KVM_REQ_REPORT_TPR_ACCESS, vcpu)) {
 			vcpu->run->exit_reason = KVM_EXIT_TPR_ACCESS;
 			r = 0;

-- 
Vitaly


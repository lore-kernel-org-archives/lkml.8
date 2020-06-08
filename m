Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321FF2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/pKKW7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgFHTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgFHTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:38:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E09C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:38:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so22030248ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uexpwyn2fR7P1DcGlDr4HzbFjkt5L1616WAI7BXfvnM=;
        b=r/pKKW7ldNYNP5VPsKHOOYA9uiCiJDTOjL1qxw7wXFhqNSqZZ1N8qblK6dt54QqUUg
         eEplGmu6286Pb/e7cH0KQEBvToMQkN9LykMYJFc2UusP8YNKn0WwoDVzGkPixtKEVaes
         r6rS8bP0yW00zf7RnIM5Lv+a6HudIjwQaeJ/Uqr+Mh7arJU9kgpSTBhWoZtQErrLTIJK
         VGj40ZuwLCDffy95OV2HwmhW5RuBcPx9tSextzl+ojxDZeI7tCCAME8l3os7dvTM3ek7
         7/lN68YINGXozqT3qZIVgnF8dSfTiR8QSXOvBqiB68QcMGnhB8UF56nSN/qJxbETBV9L
         LyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uexpwyn2fR7P1DcGlDr4HzbFjkt5L1616WAI7BXfvnM=;
        b=JniMn65Dey76WuwROCPlNGrYPeR0R391UgVzct4KUQODWLTe0Tm3DRagnxMykylfzB
         T8GGtQ3yfCKMb8lFWDSr0G1RFrfxXmhbHYVbNjhwZcp9ZtN0nv0gAfNxkP1saD64NXHg
         l1pR/8TGNYDFqYrRziWlEaKGVYHBYqS7cu5g++92t6PkDNzJ7DsIpfLSWowHmnTZlVyj
         UxT+5V3kPClBDewANiENZXmTmmGrEFj5VOMq5CP+bD8Yj2XGLpqYsrbOiEkccQupSvCN
         TrYJmFB5CkDkL4t2RFoC3sCpppm6OSFC6Ld1e7AOciDdn7t7lo9EwkOKZtX/6pHIOQJC
         U9nw==
X-Gm-Message-State: AOAM530+46jRAcMx+JYzsYjWdS9dHpXaEHSVzqGpuObCKuqk2KTjECCG
        SwgetN2e6iH4r05mI303/iCQIpH0QBTVbUFvO+PAdg==
X-Google-Smtp-Source: ABdhPJxrj7FJ9fJQGeJQtBPLp7ShZUPGLANThjFoma8TGVYDJ4OyyT46PEHPEWDeFlK/FK+jySaCjca8WZ7k9lXI48o=
X-Received: by 2002:a2e:a17a:: with SMTP id u26mr11302926ljl.235.1591645094413;
 Mon, 08 Jun 2020 12:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200608191857.30319-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200608191857.30319-1-sean.j.christopherson@intel.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 8 Jun 2020 12:38:03 -0700
Message-ID: <CAOQ_QsjEnvk+ci8AAjytoFd+x8x3Li+iJjfT0gd=nMP036G9VQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: nVMX: Consult only the "basic" exit reason when
 routing nested exit
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 12:19 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Consult only the basic exit reason, i.e. bits 15:0 of vmcs.EXIT_REASON,
> when determining whether a nested VM-Exit should be reflected into L1 or
> handled by KVM in L0.
>
> For better or worse, the switch statements nested_vmx_l0_wants_exit()
> and nested_vmx_l1_wants_exit() default to reflecting the VM-Exit into L1
> for any nested VM-Exit without dedicated logic.  Because the case
> statements only contain the basic exit reason, any VM-Exit with modifier
> bits set will be reflected to L1, even if KVM intended to handle it in
> L0.
>
> Practically speaking, this only affects EXIT_REASON_MCE_DURING_VMENTRY,
> i.e. a #MC that occurs on nested VM-Enter would be incorrectly routed to
> L1, as "failed VM-Entry" is the only modifier that KVM can currently
> encounter.  The SMM modifiers will never be generated as KVM doesn't
> support/employ a SMI Transfer Monitor.  Ditto for "exit from enclave",
> as KVM doesn't yet support virtualizing SGX, i.e. it's impossible to
> enter an enclave in a KVM guest (L1 or L2).
>
> Note, the original version of this fix[*] is functionally equivalent and
> far more suited to backporting as the affected code was refactored since
> the original patch was posted.
>
> [*] https://lkml.kernel.org/r/20200227174430.26371-1-sean.j.christopherson@intel.com
>
> Fixes: 644d711aa0e1 ("KVM: nVMX: Deciding if L0 or L1 should handle an L2 exit")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: stable@vger.kernel.org
> Cc: Oliver Upton <oupton@google.com>
> Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Oliver Upton <oupton@google.com>
> ---
>
> Another wounded soldier.
>
> Oliver, Krish, and Miaohe all provided reviews for v1, but I didn't feel
> comfortable adding the tags to v2 because this is far from a straight
> rebase.
>
> v2: Rebased to kvm/queue, commit fb7333dfd812 ("KVM: SVM: fix calls ...").
>
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bcb50724be38..adb11b504d5c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5672,7 +5672,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu, u32 exit_reason)
>  {
>         u32 intr_info;
>
> -       switch (exit_reason) {
> +       switch ((u16)exit_reason) {
>         case EXIT_REASON_EXCEPTION_NMI:
>                 intr_info = vmx_get_intr_info(vcpu);
>                 if (is_nmi(intr_info))
> @@ -5733,7 +5733,7 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu, u32 exit_reason)
>         struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>         u32 intr_info;
>
> -       switch (exit_reason) {
> +       switch ((u16)exit_reason) {
>         case EXIT_REASON_EXCEPTION_NMI:
>                 intr_info = vmx_get_intr_info(vcpu);
>                 if (is_nmi(intr_info))
> --
> 2.26.0
>

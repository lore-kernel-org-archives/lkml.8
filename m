Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59583C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F28218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr1JjuCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgBYNFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:05:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729179AbgBYNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582635898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wr/4QhoIdyKmpfoHFgfDcEpRgcidquLqA/yQ2x5bvuA=;
        b=gr1JjuCIbUprYNUHfYMk3EYjcDvz+TomQvTN1mdTUEBFaPYPY1A0+qi5NTmfNpiD9iu4PZ
        YhW89qWlEzrq3JWXNYO07qa4NQzxBJenqpc3vrw8OoPFOHnCeghjDPkIJtpoRJoUyD2qDB
        rapVhb7ipBZUf+tjZkFnxcffuWZFGB8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-vUM4-yfZNsW2wXoTHqlWbw-1; Tue, 25 Feb 2020 08:04:56 -0500
X-MC-Unique: vUM4-yfZNsW2wXoTHqlWbw-1
Received: by mail-wr1-f72.google.com with SMTP id u8so7272239wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Wr/4QhoIdyKmpfoHFgfDcEpRgcidquLqA/yQ2x5bvuA=;
        b=ogT7FqOnrOPauXo/sMtK3aMU5FlYm23d1bzN/ZTFeakyg9iHlUg1EhTVnW8DHYIww2
         1v1TxQRps9aACUEVq7J0UmOJtvTYnIKByJX5Lc4CWYLnyGBI/fjIoQMpY55t2SSFi1kF
         11n+AMyOhUm8s6H8SpfATI8QAE56kkcW0xhQ0+HgdErJduj2T4JWS50bjBfsq1ohUNS9
         wwCmmoRS+NZVt+iwLODYOB5ciDxBA5M31iue+Fgzn4REEiqYqHuslgY/sd1xMfuuma9c
         TJ2N7gXQVlzwtfmiisGXQstYc5BXbsv7LW5JSAV0hLfsYaLM7tDRTS0NnomhUQYG3Mbd
         yAhg==
X-Gm-Message-State: APjAAAWN1v1CKVEdemR8QyIaj2fIFbB3bJZoXQwCBYH4FSREkztTOw4u
        d697CpN0RQQvm9CPDofL2/x4uKOzevGLkF4FBkxn4k2q0fS2Kf2or57KFaxV6tCQNakexaDGe7d
        gkUYEdzubEzSTe1mhWx13IEGx
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5415527wmi.112.1582635895387;
        Tue, 25 Feb 2020 05:04:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMhQLPO2Buf1atpRVMyumAnUgxEsGE0upmjnhSgc1g1Vuy8u7WHuZjeWgOyZUChgbQ47LhCQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5415495wmi.112.1582635895060;
        Tue, 25 Feb 2020 05:04:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p5sm23402409wrt.79.2020.02.25.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:04:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: Fix some obsolete comments
In-Reply-To: <1582599915-425-1-git-send-email-linmiaohe@huawei.com>
References: <1582599915-425-1-git-send-email-linmiaohe@huawei.com>
Date:   Tue, 25 Feb 2020 14:04:53 +0100
Message-ID: <87a756n7gq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Remove some obsolete comments, fix wrong function name and description.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/svm.c        | 3 ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  arch/x86/kvm/vmx/vmx.c    | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index fd3fc9fbefff..ee114a9913eb 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -3228,9 +3228,6 @@ static int nested_svm_exit_special(struct vcpu_svm *svm)
>  	return NESTED_EXIT_CONTINUE;
>  }
>  
> -/*
> - * If this function returns true, this #vmexit was already handled
> - */
>  static int nested_svm_intercept(struct vcpu_svm *svm)
>  {

Thank you for the cleanup, I looked at nested_svm_intercept() and I see
room for improvement, e.g. (completely untested!)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 76c24b3491f6..fcb26d64d3c7 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3280,42 +3280,36 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
        case SVM_EXIT_IOIO:
                vmexit = nested_svm_intercept_ioio(svm);
                break;
-       case SVM_EXIT_READ_CR0 ... SVM_EXIT_WRITE_CR8: {
-               u32 bit = 1U << (exit_code - SVM_EXIT_READ_CR0);
-               if (svm->nested.intercept_cr & bit)
+       case SVM_EXIT_READ_CR0 ... SVM_EXIT_WRITE_CR8:
+               if (svm->nested.intercept_cr &
+                   BIT(exit_code - SVM_EXIT_READ_CR0))
                        vmexit = NESTED_EXIT_DONE;
                break;
-       }
-       case SVM_EXIT_READ_DR0 ... SVM_EXIT_WRITE_DR7: {
-               u32 bit = 1U << (exit_code - SVM_EXIT_READ_DR0);
-               if (svm->nested.intercept_dr & bit)
+       case SVM_EXIT_READ_DR0 ... SVM_EXIT_WRITE_DR7:
+               if (svm->nested.intercept_dr &
+                   BIT(exit_code - SVM_EXIT_READ_DR0))
                        vmexit = NESTED_EXIT_DONE;
                break;
-       }
-       case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f: {
-               u32 excp_bits = 1 << (exit_code - SVM_EXIT_EXCP_BASE);
-               if (svm->nested.intercept_exceptions & excp_bits) {
+       case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f:
+               if (svm->nested.intercept_exceptions &
+                   BIT(exit_code - SVM_EXIT_EXCP_BASE)) {
                        if (exit_code == SVM_EXIT_EXCP_BASE + DB_VECTOR)
                                vmexit = nested_svm_intercept_db(svm);
                        else
                                vmexit = NESTED_EXIT_DONE;
-               }
-               /* async page fault always cause vmexit */
-               else if ((exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR) &&
-                        svm->vcpu.arch.exception.nested_apf != 0)
+               } else if ((exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR) &&
+                          svm->vcpu.arch.exception.nested_apf != 0) {
+                       /* async page fault always cause vmexit */
                        vmexit = NESTED_EXIT_DONE;
+               }
                break;
-       }
-       case SVM_EXIT_ERR: {
+       case SVM_EXIT_ERR:
                vmexit = NESTED_EXIT_DONE;
                break;
-       }
-       default: {
-               u64 exit_bits = 1ULL << (exit_code - SVM_EXIT_INTR);
-               if (svm->nested.intercept & exit_bits)
+       default:
+               if (svm->nested.intercept & BIT_ULL(exit_code - SVM_EXIT_INTR))
                        vmexit = NESTED_EXIT_DONE;
        }
-       }
 
        return vmexit;
 }

Feel free to pick stuff you like and split your changes to this function
in a separate patch.

>  	u32 exit_code = svm->vmcb->control.exit_code;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0946122a8d3b..46c5f63136a8 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2960,7 +2960,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  	/*
>  	 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,
>  	 * which is reserved to '1' by hardware.  GUEST_RFLAGS is guaranteed to
> -	 * be written (by preparve_vmcs02()) before the "real" VMEnter, i.e.
> +	 * be written (by prepare_vmcs02()) before the "real" VMEnter, i.e.
>  	 * there is no need to preserve other bits or save/restore the field.
>  	 */
>  	vmcs_writel(GUEST_RFLAGS, 0);
> @@ -4382,7 +4382,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>   * Decode the memory-address operand of a vmx instruction, as recorded on an
>   * exit caused by such an instruction (run by a guest hypervisor).
>   * On success, returns 0. When the operand is invalid, returns 1 and throws
> - * #UD or #GP.
> + * #UD, #GP or #SS.

Oxford comma, anyone? :-)))

>   */
>  int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
>  			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 69948aa1b127..8d91fa9acbb2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -808,7 +808,7 @@ void update_exception_bitmap(struct kvm_vcpu *vcpu)
>  	if (to_vmx(vcpu)->rmode.vm86_active)
>  		eb = ~0;
>  	if (enable_ept)
> -		eb &= ~(1u << PF_VECTOR); /* bypass_guest_pf = 0 */
> +		eb &= ~(1u << PF_VECTOR);
>  
>  	/* When we are running a nested L2 guest and L1 specified for it a
>  	 * certain exception bitmap, we must trap the same exceptions and pass

All your changes look correct, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


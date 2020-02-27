Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474EDC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79924691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDmxdg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgB0TaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:30:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35341 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgB0TaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:30:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id u26so421089vsg.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGP2GYUfRtgo7RRpY4S9TgOhmufaENbcYOsEoqwQtQk=;
        b=IDmxdg9vhWg7nNVDjJAQX9oZMUtJh+UnTIfDe5/WrwJaTn/NLqQHmCmZa1yY2WiI+t
         xgqgPbqCPY8f+D1cscw0pITPQsvvL500u52kDVwo5/prytf1M7Y8H2cFKZd/HLdI7shb
         n3PeLbnNTcTEW2WWa2uuO+OZRz2Y4TbsVi7AEp2BHGDNAsysrj941ueRpiou/qXxNApb
         Brme32xKMSxxjlRISgmEVc9ANltBr6YhDCDHF5NCS0+u/4i6W7AX8sxqSSOhG88GuTsa
         y2Pb/LCnllmniDJTg5LxDwnXYUZKybKaRrURQfnK531RcS3icfgZDfBYs6c55a8ZedG7
         miZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGP2GYUfRtgo7RRpY4S9TgOhmufaENbcYOsEoqwQtQk=;
        b=BvcQiDs7NtSiJYud4fv1Kil/tYz5JMRUsw1QjTOBb5Ikhj2cvTwYBD7mOMWCZ5o+GM
         MyGUQKlgXhMtjA/cYADwQ8C7HVZOoY8AMN8qO7pWcRbj94ZZC+kaTUWpFWxNHwQvtR5l
         +5mkOjkEO5pD5T02X8j/VyDmTp8dWxq40gVzKebau59bdYRLOUM8DL7W/qEyzTtdjN6F
         HMNLmUnxtDW+ED2uKwz78vP9qZ+4F4zJUF2cTpf8v2FpW/hH6YmLhfdkxcwFFBqhUIyi
         yWlCLg9PUHgqfPvR98gSqraCXmezo2vFRx4fq1U1P6wykYw3NQgk7AHFcWvn+MlvK+Kh
         2N9g==
X-Gm-Message-State: ANhLgQ093oJZsHbmwphSZ1IqyTGp9h7H79xnVfUVrAcqbIVaMOKYlPGD
        u1E9ivsaTiIpH1APCEv8xnSQmwoT0oKLHCRh9xgzdQ==
X-Google-Smtp-Source: ADFU+vt2xe+yvmRwIdYwZ30bG5odphSdTakAwOaM+v3j5GhmwqZ89pGl2tR5Ne+o2eNFXVsbUmDXnaM0npZHXAi9jhs=
X-Received: by 2002:a05:6102:677:: with SMTP id z23mr571919vsf.202.1582831812647;
 Thu, 27 Feb 2020 11:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20200227172306.21426-1-mgamal@redhat.com> <20200227172306.21426-2-mgamal@redhat.com>
In-Reply-To: <20200227172306.21426-2-mgamal@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 27 Feb 2020 11:30:01 -0800
Message-ID: <CANgfPd8X_Vv7eL6ict_TBzbg6_Q5Oa9FLh_0bCWjsGSGxB6xdw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Add function to inject guest page fault
 with reserved bits set
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        Jim Mattson <jmattson@google.com>, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:23 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 14 ++++++++++++++
>  arch/x86/kvm/x86.h |  1 +
>  2 files changed, 15 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 359fcd395132..434c55a8b719 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10494,6 +10494,20 @@ u64 kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_spec_ctrl_valid_bits);
>
> +void kvm_inject_rsvd_bits_pf(struct kvm_vcpu *vcpu, gpa_t gpa)
> +{
> +       struct x86_exception fault;
> +
> +       fault.vector = PF_VECTOR;
> +       fault.error_code_valid = true;
> +       fault.error_code = PFERR_RSVD_MASK;
> +       fault.nested_page_fault = false;
> +       fault.address = gpa;
> +
> +       kvm_inject_page_fault(vcpu, &fault);
> +}
> +EXPORT_SYMBOL_GPL(kvm_inject_rsvd_bits_pf);
> +

There are calls to kvm_mmu_page_fault in arch/x86/kvm/mmu/mmu.c that
don't get the check and injected page fault in the later patches in
this series. Is the check not needed in those cases?

>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_fast_mmio);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 3624665acee4..7d8ab28a6983 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -276,6 +276,7 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
>  bool kvm_mtrr_check_gfn_range_consistency(struct kvm_vcpu *vcpu, gfn_t gfn,
>                                           int page_num);
>  bool kvm_vector_hashing_enabled(void);
> +void kvm_inject_rsvd_bits_pf(struct kvm_vcpu *vcpu, gpa_t gpa);
>  int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                             int emulation_type, void *insn, int insn_len);
>  enum exit_fastpath_completion handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu);
> --
> 2.21.1
>

Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4571C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F652078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvaTnGMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHMTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgHMTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:05:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:05:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b22so5994749oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuU3ViDe278lSw17ntg5nYTRmQsPcKzMV9Ui8nZNn08=;
        b=qvaTnGMy76pjktYEEGGOjwXIxyF2kIjefRgdP+5JsqhJredrqmgG7skH2KAZVGTbvD
         z5SdDkFCim3I4rnr+fbmjxB6H2bLvTgDt49fkIHsrxbfOq6GKLIjdbXBs41nBCA5Jknt
         wy+JHUbBYqzKHlS0u96hvD22PQ8nVP/Ncx4R8r3KDyHp4OxyPLhcPcQCgSKIFFNkM9bX
         g0KzOa6EiX7NGGUTrufTxlWTWED7H7KueZLP0PM6Qn8wi3okUzROr5WZfymEUO5g/+cD
         XkFYwzcdwMnWaXq5nrtgY0ipfOE07HHR2L84EDV84QVFPRogQpzl+r0Tgis/jvszYiLQ
         YAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuU3ViDe278lSw17ntg5nYTRmQsPcKzMV9Ui8nZNn08=;
        b=dY3j8QHr3UfdyEqwXcaZAZEEpt1ajTCI7jR3eCPDUZygQ1uTEjSg7u8laE9nNQ7EI8
         gNxc25LShcreaAEHEiWS8ImZnHsHJ6r8EFFb4HvftvzSPmD8v2XZeOazVmuoh0LwxfRo
         9eo9LgqVYjTkN4qdx2udfurcoIibVCqkb5FBbuZkwrZRmMIHeEsGBLeyO6AnCmR8HeR7
         MN45Da6Ykk2Hv9ubT1n9XTarH4+MSbVvZM0I9yX6fDONJACgFItb9lEBHRCAPxJtbH3c
         I1vXMZXvQ+cfEuybzkj+BLBjlE4qmk3zetSKa8PRTj5/2M4XmAIxY7TVCNv6hoqkOWjh
         zL4Q==
X-Gm-Message-State: AOAM530ToOy2XCgKCv5sXCdzqmQrXOspRmPIatow5Pmp6XLuNtV/eo5H
        by1PmZPykmtwDGAUm9xpdsujKAaG6nbTFqnG+fxK6Q==
X-Google-Smtp-Source: ABdhPJw5GaSIUEoCWxPsJEVVeiZAPfCUlXhncfV64G1JdmV9HhjG2Do+1NwYTyMZ14oLQH/ODwFBeqECOj8WongeEVQ=
X-Received: by 2002:aca:b942:: with SMTP id j63mr4518741oif.28.1597345505789;
 Thu, 13 Aug 2020 12:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-7-chenyi.qiang@intel.com>
In-Reply-To: <20200807084841.7112-7-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 13 Aug 2020 12:04:54 -0700
Message-ID: <CALMp9eQ=QUZ04_26eXBGHqvQYnsN6JEgiV=ZSSrE395KLX-atA@mail.gmail.com>
Subject: Re: [RFC 6/7] KVM: X86: Expose PKS to guest and userspace
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 1:47 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> Existence of PKS is enumerated via CPUID.(EAX=7H,ECX=0):ECX[31]. It is
> enabled by setting CR4.PKS when long mode is active. PKS is only
> implemented when EPT is enabled and requires the support of VM_{ENTRY,
> EXIT}_LOAD_IA32_PKRS currently.
>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

> @@ -967,7 +969,8 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  {
>         unsigned long old_cr4 = kvm_read_cr4(vcpu);
>         unsigned long pdptr_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
> -                                  X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE;
> +                                  X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE |
> +                                  X86_CR4_PKS;

This list already seems overly long, but I don't think CR4.PKS belongs
here. In volume 3 of the SDM, section 4.4.1, it says:

- If PAE paging would be in use following an execution of MOV to CR0
or MOV to CR4 (see Section 4.1.1) and the instruction is modifying any
of CR0.CD, CR0.NW, CR0.PG, CR4.PAE, CR4.PGE, CR4.PSE, or CR4.SMEP;
then the PDPTEs are loaded from the address in CR3.

CR4.PKS is not in the list of CR4 bits that result in a PDPTE load.
Since it has no effect on PAE paging, I would be surprised if it did
result in a PDPTE load.

>         if (kvm_valid_cr4(vcpu, cr4))
>                 return 1;
> @@ -1202,7 +1205,7 @@ static const u32 msrs_to_save_all[] = {
>         MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
>         MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
>         MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
> -       MSR_IA32_UMWAIT_CONTROL,
> +       MSR_IA32_UMWAIT_CONTROL, MSR_IA32_PKRS,

Should MSR_IA32_PKRS be added to the switch statement in
kvm_init_msr_list()? Something like...

case MSR_IA32_PKRS:
        if (!kvm_cpu_cap_has(X86_FEATURE_PKRS))
                continue;
        break;

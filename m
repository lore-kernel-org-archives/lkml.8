Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7AA20885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0ZQt9t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgHTV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgHTV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:26:13 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CCC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:26:12 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g1so742165oop.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqKTYOEG1DwYjtBQ9y/f511uazsbR+LoedmcdkZBfe8=;
        b=A0ZQt9t964myH4QDetGdxWQIQxuyjhjFuuRs0X8Tw9MfjlHlpxGotJl1u5n2HibBbT
         3ZO83y0aI6ZvSnSicpML6Ay5paF16ZVsmi/Hu0oFon5u+dvmENv3bfa4prfr7Gngdb61
         YNzvQsu8/TS/8KOhz1gUFCq/R0UuoKhPctdFS2XIQBIj/itrRNkQvQ4HL5ChDIvpCm0I
         NEysrGxvx7lNCL0k33dVjNO1qeLN9/UlMwDr16ARJuNsoE0JiusEDhDb7uDTlWEhuuH4
         zkmoS/vVQkIl067M9CPxnDoBM9ax7eczf8QfKkjH6rzu3arOR6z0QjXew9oHzIueoXob
         vfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqKTYOEG1DwYjtBQ9y/f511uazsbR+LoedmcdkZBfe8=;
        b=iwwZh6lUPSglUTNT0EUd57XOTWF8zHF7URg28ADwa4670KIybdYnAiygUrs6UYdnEE
         QFGBTNMhEJGB42y1ZRoNCRQuk5AWLY3VSzVSWrxJsHZZrEimj+ifmC1n5yHNL+DSBx0e
         7E7Ua3d6JLxXsdFNBOqYyw6gQjamyp7C6gXGEaoCBpOaI3W2WSN6RJskMs6jApdefiEC
         iiYfaYjhLyvDIj7SPft8A3yqP/N/Jt644MsSaWVEOQrJISx4aKwbT3PSLS7fbUESOO0K
         gbi2plVcyIdn/gIRAf+NgsguSKBKfHFDHDrUSjm83IHcNGEkstrrkKFYcxnYG9sNi/0Z
         TU1A==
X-Gm-Message-State: AOAM531FZAMjrIE6VgOYkM1pK8WVivmQRPCIgl3z/ixv++qF4KU2JM8z
        Ii7Wm0ZRVwB3PS8ECLMjk19zRPcCjpfsInR2fr5Tgw==
X-Google-Smtp-Source: ABdhPJyioHPMz5XS5FlItbQ0oss7WkHtSHvZnygv9matvE8GzQ/jiGfgLwBcuSybMid2JD/t3XGTQH9GsqJW/cvZn30=
X-Received: by 2002:a4a:d2d8:: with SMTP id j24mr443720oos.82.1597958771940;
 Thu, 20 Aug 2020 14:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200820133339.372823-1-mlevitsk@redhat.com> <20200820133339.372823-4-mlevitsk@redhat.com>
In-Reply-To: <20200820133339.372823-4-mlevitsk@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 14:26:00 -0700
Message-ID: <CALMp9eRoYLqFEGqcVf2tExGvG4bJwy6CURrHiAnYqQ9TrS4eDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] KVM: SVM: refactor msr permission bitmap allocation
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:34 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Replace svm_vcpu_init_msrpm with svm_vcpu_alloc_msrpm, that also allocates
> the msr bitmap and add svm_vcpu_free_msrpm to free it.
>
> This will be used later to move the nested msr permission bitmap allocation
> to nested.c
>
> No functional change intended.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 45 +++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d33013b9b4d7..7bb094bf6494 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -609,18 +609,29 @@ static void set_msr_interception(u32 *msrpm, unsigned msr,
>         msrpm[offset] = tmp;
>  }
>
> -static void svm_vcpu_init_msrpm(u32 *msrpm)
> +static u32 *svm_vcpu_alloc_msrpm(void)

I prefer the original name, since this function does more than allocation.

>  {
>         int i;
> +       u32 *msrpm;
> +       struct page *pages = alloc_pages(GFP_KERNEL_ACCOUNT, MSRPM_ALLOC_ORDER);
> +
> +       if (!pages)
> +               return NULL;
>
> +       msrpm = page_address(pages);
>         memset(msrpm, 0xff, PAGE_SIZE * (1 << MSRPM_ALLOC_ORDER));
>
>         for (i = 0; direct_access_msrs[i].index != MSR_INVALID; i++) {
>                 if (!direct_access_msrs[i].always)
>                         continue;
> -
>                 set_msr_interception(msrpm, direct_access_msrs[i].index, 1, 1);
>         }
> +       return msrpm;
> +}
> +
> +static void svm_vcpu_free_msrpm(u32 *msrpm)
> +{
> +       __free_pages(virt_to_page(msrpm), MSRPM_ALLOC_ORDER);
>  }
>
>  static void add_msr_offset(u32 offset)
> @@ -1172,9 +1183,7 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm;
>         struct page *vmcb_page;
> -       struct page *msrpm_pages;
>         struct page *hsave_page;
> -       struct page *nested_msrpm_pages;
>         int err;
>
>         BUILD_BUG_ON(offsetof(struct vcpu_svm, vcpu) != 0);
> @@ -1185,21 +1194,13 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>         if (!vmcb_page)
>                 goto out;
>
> -       msrpm_pages = alloc_pages(GFP_KERNEL_ACCOUNT, MSRPM_ALLOC_ORDER);
> -       if (!msrpm_pages)
> -               goto free_page1;
> -
> -       nested_msrpm_pages = alloc_pages(GFP_KERNEL_ACCOUNT, MSRPM_ALLOC_ORDER);
> -       if (!nested_msrpm_pages)
> -               goto free_page2;
> -

Reordering the allocations does seem like a functional change to me,
albeit one that should (hopefully) be benign. For example, if the
MSRPM_ALLOC_ORDER allocations fail, in the new version of the code,
the hsave_page will be cleared, but in the old version of the code, no
page would be cleared.

>         hsave_page = alloc_page(GFP_KERNEL_ACCOUNT);

Speaking of clearing pages, why not add __GFP_ZERO to the flags above
and skip the clear_page() call below?

>         if (!hsave_page)
> -               goto free_page3;
> +               goto free_page1;
>
>         err = avic_init_vcpu(svm);
>         if (err)
> -               goto free_page4;
> +               goto free_page2;
>
>         /* We initialize this flag to true to make sure that the is_running
>          * bit would be set the first time the vcpu is loaded.
> @@ -1210,11 +1211,13 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>         svm->nested.hsave = page_address(hsave_page);
>         clear_page(svm->nested.hsave);
>
> -       svm->msrpm = page_address(msrpm_pages);
> -       svm_vcpu_init_msrpm(svm->msrpm);
> +       svm->msrpm = svm_vcpu_alloc_msrpm();
> +       if (!svm->msrpm)
> +               goto free_page2;
>
> -       svm->nested.msrpm = page_address(nested_msrpm_pages);
> -       svm_vcpu_init_msrpm(svm->nested.msrpm);
> +       svm->nested.msrpm = svm_vcpu_alloc_msrpm();
> +       if (!svm->nested.msrpm)
> +               goto free_page3;
>
>         svm->vmcb = page_address(vmcb_page);
>         clear_page(svm->vmcb);
> @@ -1227,12 +1230,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>
>         return 0;
>
> -free_page4:
> -       __free_page(hsave_page);
>  free_page3:
> -       __free_pages(nested_msrpm_pages, MSRPM_ALLOC_ORDER);
> +       svm_vcpu_free_msrpm(svm->msrpm);
>  free_page2:
> -       __free_pages(msrpm_pages, MSRPM_ALLOC_ORDER);
> +       __free_page(hsave_page);
>  free_page1:
>         __free_page(vmcb_page);
>  out:

While you're here, could you improve these labels? Coding-style.rst says:

Choose label names which say what the goto does or why the goto exists.  An
example of a good name could be ``out_free_buffer:`` if the goto frees
``buffer``.
Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
renumber them if you ever add or remove exit paths, and they make correctness
difficult to verify anyway.

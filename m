Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1D02072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwanDsZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFIXD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgFIXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:03:53 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B25C08C5C3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:03:53 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id e1so122498vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPEA53MpdF9ON3exFjCberFh9r4WY/+iX04WGFZFtXU=;
        b=rwanDsZdo86Rv+vzZDRG+0C9QrHIbGQgfj2nwO+GiGBNVyLSExN93DGrkptklgs9I1
         AC0cy3+rivR0wtaNSSV9u8U2CqWzAr9cwayr0OtE6O+jC2+BtUr9VjUb8UFNbXJkVAi1
         WfJhopss4dvT37wHibefpDeELAXyANGodPwrJTtsn9yIlJTNlMVMXjXyhR/cP5akWDCP
         mjbboyehlJjrEud3b556BAnXu9H3ea7lZqMAdBWMg65r0d3SNuuwYPZvv8rUlGOJMmVx
         1rAQzDRF0wybOVz5i+mnG2dV7tbBHX6NxTZfN6sP+E0p5F7rIRZGBiMOtY3RefHOaxGa
         MGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPEA53MpdF9ON3exFjCberFh9r4WY/+iX04WGFZFtXU=;
        b=tue+a6anbwGJ/MYdJtkzWuIVtxwhKAJVNo4gruE6Ez2ODluW3YGnWn4gJkNm0EVksx
         BpuE1LnZCxAln18tZnPenpCJoCdakfFfWq4M0OtdM7FWJlDsYh7iCEOkjtJ6t2SfBdti
         2biq1JIZaibRoHTQODIjH6WUoA1tlh2jzulcuw8HY3k93bwFv+a30wYuaKKNzGpkWSfY
         3TR3Sr1eP+J9sSQu29POlm6cmPCP1MnD40CK55k7Zg4dGYymydSlwj+xfAZIqQepB7v/
         KWdF8lrgauQh6ZlB0mUaZXARkAiszXxc5q+ljMVtkLxrcHB5XTEo/5EgzS432XGfOHw8
         se7Q==
X-Gm-Message-State: AOAM531Wdt77mldwd925vLsQzobWC90Apat8KEsND0ojIhZOv37Ty2Lz
        KvikL5wAfuy9kzyknU7UvkpgqMLumDWx1co+Vdy9Wg==
X-Google-Smtp-Source: ABdhPJwvz0K9ugkUS0zUu2sV6SC9xdH2ngcwyFlRhaY+EjhyMbUztSqGBkZnAcJGtcUe/roomwm1IuKpnHfl3gWMyfI=
X-Received: by 2002:a1f:974d:: with SMTP id z74mr401275vkd.40.1591743831579;
 Tue, 09 Jun 2020 16:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-7-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-7-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 9 Jun 2020 16:03:40 -0700
Message-ID: <CANgfPd9Y9P+-got9HmtrvChmwZBe-XOA0zSSLMsPCUKcuBv4aQ@mail.gmail.com>
Subject: Re: [PATCH 06/21] KVM: x86/mmu: Move fast_page_fault() call above mmu_topup_memory_caches()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:39 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Avoid refilling the memory caches and potentially slow reclaim/swap when
> handling a fast page fault, which does not need to allocate any new
> objects.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5e773564ab20..4b4c3234d623 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4095,6 +4095,9 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>         if (page_fault_handle_page_track(vcpu, error_code, gfn))
>                 return RET_PF_EMULATE;
>
> +       if (fast_page_fault(vcpu, gpa, error_code))
> +               return RET_PF_RETRY;
> +
>         r = mmu_topup_memory_caches(vcpu);
>         if (r)
>                 return r;
> @@ -4102,9 +4105,6 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>         if (lpage_disallowed)
>                 max_level = PG_LEVEL_4K;
>
> -       if (fast_page_fault(vcpu, gpa, error_code))
> -               return RET_PF_RETRY;
> -
>         mmu_seq = vcpu->kvm->mmu_notifier_seq;
>         smp_rmb();
>
> --
> 2.26.0
>

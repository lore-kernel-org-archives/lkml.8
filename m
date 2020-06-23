Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A3B207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNUPDEbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgFWSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbgFWSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:20:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:20:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so9742949ioi.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e21GOxkW1jWzhvdZJoi4FLyBWJfKpI2RdakLYHhUv8g=;
        b=pNUPDEbsj3LXnapU8PbQOKn+BfClHZhKeHLGL9QLze3xrrlEu2kgFyDy5J3Zjxqg6f
         DhUN2qvUGcfVVUmfb+u/XQ9K7BBECK3mON0OvGtZhph9IvrdGZ1GRwEmpB5Js3bXcy3w
         oRYCC/9tx/oT5j3cgMxa/rgvpPvr23esA7MrXUPKUfqkdgZxsnf88yn+2mKsXsBcgvWy
         Fu+vnJ43vP45Cr/yWOlMqfBNEQvSPRxVxBTasneabIc+FDck/NduuOpEP8V+c8W7Jlug
         1LvSJQPGrMlvwPGNnDjB99j/x/oYPxkKv+RTMxIeaPdMPkPiFUSg9t4K4f3SGS74gfSN
         74/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e21GOxkW1jWzhvdZJoi4FLyBWJfKpI2RdakLYHhUv8g=;
        b=au8ek54ZmWm2IF9CncHAhwMmeLnGa5s+fNnWnzT9K5w4qSnJah9uWxltNJiK6JMF6T
         wE/ooENVs3gCiU477YhIQm5JYwD48vG6/9WOByHYLO3AtP1v237BHO3p1qWLEGcb5iIS
         LjB9STK2pqppHIk5Lb/hGY+HRJccuTgpHUa25qh4wKXKFbbbNwtFg/JuSMEysv5wwyb7
         pa+fJb8NF3A7Wx3OtYATzo62QweuD77JRnyU2eH8Z32ISbf6GAEK8+LNe8PBQEp0abMX
         l40+2jnibVnwJceKglwTBTVAEzT78h7csGaIlUipMQlERpMxrHN1j+ZYoskEbk5QgdX8
         Cueg==
X-Gm-Message-State: AOAM530KfsftXMy7d3VBXwYg3ORBGq3W5aLg5rs+dGszCh/IdG4KHJEo
        ADh7eF+w5XY9RT9a/f2Ba86lG4TNNCF3PWcV/l0oRA==
X-Google-Smtp-Source: ABdhPJxaGzjfNh6BQfLb1ueNVoQADHqkOg76L4JYuELLLcDhVXfOvWRjzxEf7j/9HaI/FWHPs8UFADNvMWhpXPQgEJ8=
X-Received: by 2002:a02:c785:: with SMTP id n5mr7612695jao.75.1592936441902;
 Tue, 23 Jun 2020 11:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200623115816.24132-1-xiaoyao.li@intel.com> <20200623115816.24132-2-xiaoyao.li@intel.com>
In-Reply-To: <20200623115816.24132-2-xiaoyao.li@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 23 Jun 2020 11:20:31 -0700
Message-ID: <CALMp9eRsWqM-OAKO+y7EpoX7Oq1Qee0vAzgOBpYixUVH8Df1JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: X86: Reset vcpu->arch.cpuid_nent to 0 if
 SET_CPUID fails
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:58 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> It needs to invalidate CPUID configruations if usersapce provides

Nits: configurations, userspace

> illegal input.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8a294f9747aa..1d13bad42bf9 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -207,6 +207,8 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>         kvm_apic_set_version(vcpu);
>         kvm_x86_ops.cpuid_update(vcpu);
>         r = kvm_update_cpuid(vcpu);
> +       if (r)
> +               vcpu->arch.cpuid_nent = 0;
>
>         kvfree(cpuid_entries);
>  out:
> @@ -230,6 +232,8 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>         kvm_apic_set_version(vcpu);
>         kvm_x86_ops.cpuid_update(vcpu);
>         r = kvm_update_cpuid(vcpu);
> +       if (r)
> +               vcpu->arch.cpuid_nent = 0;
>  out:
>         return r;
>  }
> --
> 2.18.2

What if vcpu->arch.cpuid_nent was greater than 0 before the ioctl in question?

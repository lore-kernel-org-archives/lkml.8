Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB330C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9325D20FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRTJ34s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHTVoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:44:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4FC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:44:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so26104otc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYwHUMqrgisA2MC9phgyUn1/pNwWsiB0gxz1VRA/k7U=;
        b=qRTJ34s9UkOAnZaN8ZPr0d9ptggsR0srmk4FHFiwxaPgrwPW65Uv4h8OJZMvJEcN4k
         atZXkG4wSxcl+XsWGOvXHY7lWD3jNyIpWol1leSAgdXjtxxffsJDaov4iQEjpoq1lf02
         OePZRyyoMmNKPmwP4/WNNuafraSZD/dPy1S+zycbpE1tr8OkfpA3JtUqhBT8YJ1/MJA0
         wplcl5+UQ8Y8vjlefu7xs+DRfdyS9fqSXXH9YnlYK3zHAtaROi2l1OzNOgnFjfGj+NI5
         rtpSrST4mPzyNubWEsIrkhHCQa38sJr6cz/40TvVG/c0xfFAsO3fC8MtFvw24bxxLrXS
         Zurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYwHUMqrgisA2MC9phgyUn1/pNwWsiB0gxz1VRA/k7U=;
        b=DcGiSwnG0h+VT4NEPBOfAUn+257zrTqx2l/OW289unYLmH+NuIzhtwNatHueaAQLow
         GzfGxElJgHbKMhvoC6XmV9qnAOOYtHg0KrJpvT5BELn2bVp0S0iKpfge3o6fW6THaqKx
         wh8h+5eGtyUcAEBjt11htr3oq1St6LBnMJcZ8dfga7ZKQy+pU9s+qdnmmNjO9CU05fIi
         +BQhoGhTa4GQEagPlt01OHGtmXn7IRauxsDbK2l9K/jQL4nAd2s0NnaGOfzoAbflYp6l
         IH9hK52tyT1GkyihJlZkbmfB1Bx7+/PwgmONpCyXkaCAAbYObBEwMqwFP9mURvjfwin+
         JlPA==
X-Gm-Message-State: AOAM532iaK5FD+UMbfVoj2qMxl+zyL3XC+kmLCdZoHWYKyMXrn1ITO3M
        Q6oug/JwxLV442SgUW9+MTtm3bPe/O0mcgdF05ldIA==
X-Google-Smtp-Source: ABdhPJwlOoE+a01uhmSNQmRIKx7rD3ktKBhwaFSOIAol1TcsX1kjG+yaIUwY1dec23S16b3xJbV9RzNwat2fKYyWVsA=
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr513440oth.295.1597959847966;
 Thu, 20 Aug 2020 14:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200820133339.372823-1-mlevitsk@redhat.com> <20200820133339.372823-5-mlevitsk@redhat.com>
In-Reply-To: <20200820133339.372823-5-mlevitsk@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 14:43:56 -0700
Message-ID: <CALMp9eRNLjj5cs1xj44WVRoKK0ZrcGXn7ffdH+bEeDHkLE9nSA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: allow kvm_x86_ops.set_efer to return a value
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
> This will be used later to return an error when setting this msr fails.
>
> For VMX, it already has an error condition when EFER is
> not in the shared MSR list, so return an error in this case.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1471,7 +1471,8 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>         efer &= ~EFER_LMA;
>         efer |= vcpu->arch.efer & EFER_LMA;
>
> -       kvm_x86_ops.set_efer(vcpu, efer);
> +       if (kvm_x86_ops.set_efer(vcpu, efer))
> +               return 1;

This seems like a userspace ABI change to me. Previously, it looks
like userspace could always use KVM_SET_MSRS to set MSR_EFER to 0 or
EFER_SCE, and it would always succeed. Now, it looks like it will fail
on CPUs that don't support EFER in hardware. (Perhaps it should fail,
but it didn't before, AFAICT.)

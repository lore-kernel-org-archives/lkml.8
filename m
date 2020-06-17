Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095662089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkZDV62X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgFQQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:48:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t8so2838643ilm.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1m1sNsxt+pmFyO9zmeOR+ZlQ1V+PNbNheSbC5K30NE=;
        b=JkZDV62Xlw71dz/JaoZYaNaeZVHyaykn5PqCcWpXFcgmP2FaVyOzYM9uQyskKGZsm8
         NIB1EC5Vekm3hgbkejg1xlC+wxcZErRmV/voBrD+Rox0gMIxeNRnYohjCCuxpqwgfapC
         4gtKysxvI2pb0Wa2kIAjzvcoi6YvsvepYEiJnXncnHVZs6d+bpUNvH67tLmllvDptL8U
         zto623piIjWSwrrrPA/TLNNT2W8cOMFeCUeAn8ZRpxgE+lM8AjFlWBxxxnrtv8evDgid
         jKiVRfng8bjGIhRloq7tdFTnaZia7MkC+cFAm89sXZRTZ/NqQ9GrhPeQEeDtNug9ipie
         RDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1m1sNsxt+pmFyO9zmeOR+ZlQ1V+PNbNheSbC5K30NE=;
        b=uUbwG/gw9j8sVC7BOzWZYsLeMP5bl8BVbJ17tEq8KM+PFb3A32aV9Q17jOaJz+hpdR
         LTZwhT/VfEtxuQNGdQ6Ngt6l0viuVb1fpTDX7VTXLOaZuBMPcjiQalmdd1CYexGAgnUI
         V5GgE4xT+k8LXVcqgRQp0c2wDftKB3IMPDIbc6+zbqjkuDg6lHkbBuovilvnlc46Txcl
         Qi+ZL63LBSTsSmTsb0lC9P76tuPHZfvs05l9OJBo/1E1Fa20AxuUOMoAzQ/v7BC7SB5/
         eJdbfHEtJqqsJorEByZpPf1fbXFrf3apGj1lmUIWT+x+fyWexaN5adqk+bpPX++ZLveq
         c/qg==
X-Gm-Message-State: AOAM533GlVtyx39vumNBwDrFy0qv24bhTR0zG6+qvQh07pFGmDJ1bW/V
        /tFCyYtSeZmKaazeURl0erZTwzmwcma+HihUN730nQ==
X-Google-Smtp-Source: ABdhPJyVtkt5I4e5RgBLgLKo2zuqJOAam0dFZZsYuMOSxQd+NK4vd4yPrgYH/ZRsMJwSuDuAD7kVSfJd9U6pUtYCN/Q=
X-Received: by 2002:a05:6e02:11a5:: with SMTP id 5mr9655996ilj.108.1592412529122;
 Wed, 17 Jun 2020 09:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200617034123.25647-1-sean.j.christopherson@intel.com> <87zh92gic9.fsf@vitty.brq.redhat.com>
In-Reply-To: <87zh92gic9.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 17 Jun 2020 09:48:38 -0700
Message-ID: <CALMp9eR-O6ikxYaqi5iYQsVp9KaHDAm_7h4f8FPvssBi2-7Eyw@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 2:19 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>
> > Remove vcpu_vmx.host_pkru, which got left behind when PKRU support was
> > moved to common x86 code.
> >
> > No functional change intended.
> >
> > Fixes: 37486135d3a7b ("KVM: x86: Fix pkru save/restore when guest CR4.PKE=0, move it to x86.c")
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> > index 8a83b5edc820..639798e4a6ca 100644
> > --- a/arch/x86/kvm/vmx/vmx.h
> > +++ b/arch/x86/kvm/vmx/vmx.h
> > @@ -288,8 +288,6 @@ struct vcpu_vmx {
> >
> >       u64 current_tsc_ratio;
> >
> > -     u32 host_pkru;
> > -
> >       unsigned long host_debugctlmsr;
> >
> >       /*
>
> (Is there a better [automated] way to figure out whether the particular
> field is being used or not than just dropping it and trying to compile
> the whole thing? Leaving #define-s, configs,... aside ...)
>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EDFC2BBD0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD4A2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oB2TnGM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBSca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:32:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00BC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:32:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g10so140898otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVlNlS2k5mluzHkbh+REDKZGmZjyzZPFj0vaaSFv3+8=;
        b=oB2TnGM1k26yck6CO7tZVUPBu1aJgr9CU5aRqsnY5enWd9YByRurbRRuj3xsheWdyH
         wWzG8GHbn7q/fUwCgV7zsqEpG20sgX4ypFqRsiKt83CyqNAYVhvRLZ1kYvcciOXwmD/M
         B4q0QSljkTKGTHuIt1hiFwS+8e6ct/8G2rBgxp4Otedd/92I+OtwuYoVh72jgwR5UCpg
         D46scCPp8a0fYralg4n0BP4tlo77WivvJTkNT1GeDS+spvPwVvOSlHoKSIA2KUVJX2hi
         7hKezmcn/9Y7YH625YATD4DCfro3YkdDT16V8XW03sPmw370l+lSlqXgjbbIuEOVyvYc
         X+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVlNlS2k5mluzHkbh+REDKZGmZjyzZPFj0vaaSFv3+8=;
        b=t9NoLPNfn5MR67z44nB0EtjSNx+dSHjwV5KSQcMB29LlchnyfzJKg47RM8ZUfkImXf
         Pckm4MRwV65X0pAU2dBmVNq4THMxeSIGWUoirxmZ2TkUoqlj8Pgqpo+9Ajza5tNLi75U
         3DMhVFA/Sh27K49nlPdjtdph6Bx9xvqNk4f5/hKATIqupbJ4jVwXXSxR2qI2wozUuHJf
         rZthUbxRv4GkfZ5V8CSH21mLmAgVzJqQj0epGxDeToY5sQwb2nPHj6w9qS3Qhfmg3ypM
         NQVujUSELN8AY7xNoq3QxwqNl1kVJFgTWbFsQM++NS85TcYLiv3uQE2zpN9xdFh05KLZ
         tEKQ==
X-Gm-Message-State: AOAM531mCiG23gRI+OCmaQpfilKC18iRPYcF3GBQwi4qnWhauNX4yvaH
        4wlwHBb9tLBRua5XOzi/eakYMBgSW1uY/Kkl8vcRRw==
X-Google-Smtp-Source: ABdhPJynpOH5BJSLtoU3ji8j/X/Rq6PhCaNm4YZ3b4i9pTummuZCDJ3bPEZ5AKeGREsQNxxcGaRpbxV1aWdjU9H1/Q0=
X-Received: by 2002:a05:6830:18ca:: with SMTP id v10mr6508725ote.295.1599071541040;
 Wed, 02 Sep 2020 11:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-4-chenyi.qiang@intel.com>
 <CALMp9eT1makVq46TB-EtTPiz=Z_2DfhudJekrtheSsmwBc4pZA@mail.gmail.com> <20200902181654.GH11695@sjchrist-ice>
In-Reply-To: <20200902181654.GH11695@sjchrist-ice>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Sep 2020 11:32:09 -0700
Message-ID: <CALMp9eSv3SrsJigB6KQg+dyS9GmYYCbC5v6QCx3f09951VZidA@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: nVMX: Update VMX controls MSR according to guest
 CPUID after setting VMX MSRs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Wed, Sep 2, 2020 at 11:16 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Aug 28, 2020 at 01:39:39PM -0700, Jim Mattson wrote:
> > On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> > >
> > > Update the fields (i.e. VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS and
> > > VM_{ENTRY, EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL) in
> > > nested MSR_IA32_VMX_TRUE_{ENTRY, EXIT}_CTLS according to guest CPUID
> > > when user space initializes the features MSRs. Regardless of the order
> > > of SET_CPUID and SET_MSRS from the user space, do the update to avoid
> > > MSR values overriding.
> > >
> > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 819c185adf09..f9664ccc003b 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -345,6 +345,7 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu);
> > >  static u32 vmx_segment_access_rights(struct kvm_segment *var);
> > >  static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
> > >                                                           u32 msr, int type);
> > > +static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu);
> > >
> > >  void vmx_vmexit(void);
> > >
> > > @@ -2161,7 +2162,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >                         return 1; /* they are read-only */
> > >                 if (!nested_vmx_allowed(vcpu))
> > >                         return 1;
> > > -               return vmx_set_vmx_msr(vcpu, msr_index, data);
> > > +               ret = vmx_set_vmx_msr(vcpu, msr_index, data);
> > > +               nested_vmx_pmu_entry_exit_ctls_update(vcpu);
> > > +               nested_vmx_entry_exit_ctls_update(vcpu);
> > > +               break;
> >
> > Now I see what you're doing. This commit should probably come before
> > the previous commit, so that at no point in the series can userspace
> > set VMX MSR bits that should be cleared based on the guest CPUID.
> >
> > There's an ABI change here: userspace may no longer get -EINVAL if it
> > tries to set an illegal VMX MSR bit. Instead, some illegal bits are
> > silently cleared. Moreover, these functions will potentially set VMX
> > MSR bits that userspace has just asked to clear.
>
> Can we simply remove nested_vmx_entry_exit_ctls_update() and
> nested_vmx_pmu_entry_exit_ctls_update()?  It's userspace's responsibility
> to present a valid vCPU model to the guest, I don't see any reason to
> silently tweak the VMX MSRs unless allowing the bogus config breaks KVM.
> E.g. there are many more controls that are non-sensical without "native"
> support for the associated feature.

We might need a test for kvm_mpx_supported() here:

/* If not VM_EXIT_CLEAR_BNDCFGS, the L2 value propagates to L1.  */
if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
        vmcs_write64(GUEST_BNDCFGS, 0);

BTW, where does the L2 value propagate to L1 if not VM_EXIT_CLEAR_BNDCFGS?

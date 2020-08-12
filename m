Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5609E2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QM7a50tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgHLScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:32:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBFEC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:32:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r21so2735179ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iq5zcoPvcN7T8KSX0uQQrVJaYxTlpMSMBxtNsvh1wuM=;
        b=QM7a50twcijnq4/3ZW/O+9xjvW93ebFFEyQqVRJLyIZ1P87M+G7Is4tYI1VD0ikr6u
         0mA8d7XC8wnH+xFw6v9UgSTx6AFTQ6x+Cj0HVkaFzv1gMKXdZD/UtV/qIhPQMljzkyib
         r3+JIXdmwd0Ii9KO7oHfZWDxU40LNTbU8dIRmN49HnESDLoEHeGphhMZz2a628D21ah+
         WtyTpWSDy8tRo5VWoi6aAcTbDWBqBTVDiDu+5yVSC3o8utQb08yOAmDEKl1NiIVD81uC
         3yaWwt2pGL3Exg+IJUwVHKZ41zPInA3Jj0/c1/smWfrWzTh3n8OB6be1rdzqp1HnCCbp
         M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iq5zcoPvcN7T8KSX0uQQrVJaYxTlpMSMBxtNsvh1wuM=;
        b=dOk9y6gVdyK4dt69BCyD6XmI5mBibbqFGHumdkcSsJ8UuhG2BRmIlYJ9fpQIOk/DN3
         aTTZY1ISuLyuNYICnJVkanVmGGsDlmvKFFPXljuzkkner0wOEupSu8Kv9BuJKTcQVCej
         jkQxkDEp0JSgZczRXm2nkDdZtBp6N6xIm0rhBbW1qK3n+bi0lqlqyhQVavJ73uGeCoMW
         zp8vhCn8d0we+zSWspXQmKcenD98GJjCNoTZZ+uJC6WQ2FkiUWOxHt3vi1Cppa1j0s9U
         vDYd4uwLb5c9qhhwHlXDqX1+7AHoGE+hxGWlgWCoH6QLCuv2rRYSXZ0yPtgN8koxStDB
         Y3IQ==
X-Gm-Message-State: AOAM530VpUX4YBxbbX2TfiKdmlej8LvD8JUGv5POUTj5sQq57qBHXIav
        cBJeEoDwRVTu6IOw1VZO8Xpmh1jzzrerv03tc8HJSQ==
X-Google-Smtp-Source: ABdhPJz+lzTrWF2UOOoonvsdqjLKtgHh00A7xdKG2eO+qCNz+TiDu0I0jrDoHcVDQ8HHjErxXT8Rxhr9INaoK8a+Jns=
X-Received: by 2002:a9d:ae9:: with SMTP id 96mr889573otq.241.1597257169977;
 Wed, 12 Aug 2020 11:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-8-chenyi.qiang@intel.com>
 <CALMp9eTAo3WO5Vk_LptTDZLzymJ_96=UhRipyzTXXLxWJRGdXg@mail.gmail.com> <20200812150017.GB6602@linux.intel.com>
In-Reply-To: <20200812150017.GB6602@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 12 Aug 2020 11:32:38 -0700
Message-ID: <CALMp9eTTZz+Wm-5onY2CF6VGHwtbaYtD9RZLyHZTUM2R4E6vbA@mail.gmail.com>
Subject: Re: [RFC 7/7] KVM: VMX: Enable PKS for nested VM
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

On Wed, Aug 12, 2020 at 8:00 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Aug 10, 2020 at 05:05:36PM -0700, Jim Mattson wrote:
> > On Fri, Aug 7, 2020 at 1:47 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> > >
> > > PKS MSR passes through guest directly. Configure the MSR to match the
> > > L0/L1 settings so that nested VM runs PKS properly.
> > >
> > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/vmx/vmcs12.c |  2 ++
> > >  arch/x86/kvm/vmx/vmcs12.h |  6 +++++-
> > >  arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
> > >  arch/x86/kvm/vmx/vmx.h    |  1 +
> > >  5 files changed, 50 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index df2c2e733549..1f9823d21ecd 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -647,6 +647,12 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
> > >                                         MSR_IA32_PRED_CMD,
> > >                                         MSR_TYPE_W);
> > >
> > > +       if (!msr_write_intercepted_l01(vcpu, MSR_IA32_PKRS))
> > > +               nested_vmx_disable_intercept_for_msr(
> > > +                                       msr_bitmap_l1, msr_bitmap_l0,
> > > +                                       MSR_IA32_PKRS,
> > > +                                       MSR_TYPE_R | MSR_TYPE_W);
> >
> > What if L1 intercepts only *reads* of MSR_IA32_PKRS?
>
> nested_vmx_disable_intercept_for_msr() handles merging L1's desires, the
> (MSR_TYPE_R | MSR_TYPE_W) param is effectively L0's desire for L2.

I should know better than to assume that a function in kvm actually
does anything like what its name implies, but I never seem to learn.
:-(

Thanks!

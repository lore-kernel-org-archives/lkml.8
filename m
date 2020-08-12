Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D83C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F8F2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:00:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:20703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgHLPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:00:20 -0400
IronPort-SDR: IikwUDF1HMG7MlLU3V4YcS6Mt9QT2M7ZS4dNHEM8HMV7wIL93IxuMWXWST5ELJQNVjqQO2yST0
 buFjnSEVTh3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133502821"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="133502821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 08:00:18 -0700
IronPort-SDR: 9q4D+x1Kp/EKv+P9zyUCPD2w7u/Pb5v4/RuScO0EhWzZ6kV5e8cW/3nTCQlRbHw/J23TG5iX9D
 tCowp42xH3MQ==
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="327218986"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 08:00:18 -0700
Date:   Wed, 12 Aug 2020 08:00:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 7/7] KVM: VMX: Enable PKS for nested VM
Message-ID: <20200812150017.GB6602@linux.intel.com>
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-8-chenyi.qiang@intel.com>
 <CALMp9eTAo3WO5Vk_LptTDZLzymJ_96=UhRipyzTXXLxWJRGdXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eTAo3WO5Vk_LptTDZLzymJ_96=UhRipyzTXXLxWJRGdXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:05:36PM -0700, Jim Mattson wrote:
> On Fri, Aug 7, 2020 at 1:47 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> >
> > PKS MSR passes through guest directly. Configure the MSR to match the
> > L0/L1 settings so that nested VM runs PKS properly.
> >
> > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > ---
> >  arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/vmx/vmcs12.c |  2 ++
> >  arch/x86/kvm/vmx/vmcs12.h |  6 +++++-
> >  arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
> >  arch/x86/kvm/vmx/vmx.h    |  1 +
> >  5 files changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index df2c2e733549..1f9823d21ecd 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -647,6 +647,12 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
> >                                         MSR_IA32_PRED_CMD,
> >                                         MSR_TYPE_W);
> >
> > +       if (!msr_write_intercepted_l01(vcpu, MSR_IA32_PKRS))
> > +               nested_vmx_disable_intercept_for_msr(
> > +                                       msr_bitmap_l1, msr_bitmap_l0,
> > +                                       MSR_IA32_PKRS,
> > +                                       MSR_TYPE_R | MSR_TYPE_W);
> 
> What if L1 intercepts only *reads* of MSR_IA32_PKRS?

nested_vmx_disable_intercept_for_msr() handles merging L1's desires, the
(MSR_TYPE_R | MSR_TYPE_W) param is effectively L0's desire for L2.

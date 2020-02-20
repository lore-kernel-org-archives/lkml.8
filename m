Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AAFC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D90208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgBTRUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:20:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:11467 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgBTRUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:20:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 09:20:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="236307882"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2020 09:20:38 -0800
Date:   Thu, 20 Feb 2020 09:20:38 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linmiaohe <linmiaohe@huawei.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: apic: avoid calculating pending eoi from an
 uninitialized val
Message-ID: <20200220172038.GB3972@linux.intel.com>
References: <1582213006-488-1-git-send-email-linmiaohe@huawei.com>
 <8736b56wxe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736b56wxe.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:33:17PM +0100, Vitaly Kuznetsov wrote:
> linmiaohe <linmiaohe@huawei.com> writes:
> 
> > From: Miaohe Lin <linmiaohe@huawei.com>
> >
> > When get user eoi value failed, var val would be uninitialized and result
> > in calculating pending eoi from an uninitialized val. Initialize var val
> > to 0 to fix this case.
> 
> Let me try to suggest an alternative wording,
> 
> "When pv_eoi_get_user() fails, 'val' may remain uninitialized and the
> return value of pv_eoi_get_pending() becomes random. Fix the issue by
> initializing the variable."
> 
> >
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  arch/x86/kvm/lapic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 4f14ec7525f6..7e77e94f3176 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -626,7 +626,7 @@ static inline bool pv_eoi_enabled(struct kvm_vcpu *vcpu)
> >  
> >  static bool pv_eoi_get_pending(struct kvm_vcpu *vcpu)
> >  {
> > -	u8 val;
> > +	u8 val = 0;

Rather than initialize @val, I'd prefer to explicitly handle the error,
similar to pv_eoi_clr_pending() and pv_eoi_set_pending(), e.g.

	u8 val;

	if (pv_eoi_get_user(vcpu, &val) < 0) {
		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
		return false;
	}
	return val & 0x1;

> >  	if (pv_eoi_get_user(vcpu, &val) < 0)
> >  		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
> >  			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> But why compilers don't complain?

Clang might?

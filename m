Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C09C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB262206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD0Rcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:32:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:60294 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgD0Rcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:32:42 -0400
IronPort-SDR: 0l1W9mYfL7ySDTyATFd6DWVXjRM9f+xNa06xaPsGpVk4TU4nmmK4rnB8I2v2zbtFajEYiMPQDs
 xW+s6NV+t8KQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:32:42 -0700
IronPort-SDR: 1xMMgJom7B473tblxJSdTr8wBNBbcUi2UQDDSlm0UV6m+UX04XA8NI7Fnc9MCTwGZbr7r1KY9Q
 SdwfDna1VJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="404381107"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 10:32:42 -0700
Date:   Mon, 27 Apr 2020 10:32:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Use accessor to read vmcs.INTR_INFO when
 handling exception
Message-ID: <20200427173241.GJ14870@linux.intel.com>
References: <20200427171837.22613-1-sean.j.christopherson@intel.com>
 <8123dc4b-a449-a92c-85a1-c255fa2bbbca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8123dc4b-a449-a92c-85a1-c255fa2bbbca@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 07:28:02PM +0200, Paolo Bonzini wrote:
> On 27/04/20 19:18, Sean Christopherson wrote:
> > Use vmx_get_intr_info() when grabbing the cached vmcs.INTR_INFO in
> > handle_exception_nmi() to ensure the cache isn't stale.  Bypassing the
> > caching accessor doesn't cause any known issues as the cache is always
> > refreshed by handle_exception_nmi_irqoff(), but the whole point of
> > adding the proper caching mechanism was to avoid such dependencies.
> > 
> > Fixes: 8791585837f6 ("KVM: VMX: Cache vmcs.EXIT_INTR_INFO using arch avail_reg flags")
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 3ab6ca6062ce..7bddcb24f6f3 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -4677,7 +4677,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
> >  	u32 vect_info;
> >  
> >  	vect_info = vmx->idt_vectoring_info;
> > -	intr_info = vmx->exit_intr_info;
> > +	intr_info = vmx_get_intr_info(vcpu);
> >  
> >  	if (is_machine_check(intr_info) || is_nmi(intr_info))
> >  		return 1; /* handled by handle_exception_nmi_irqoff() */
> > 
> 
> Hasn't this been applied already?

No, I missed this case in the original patch, and the other fix was for
incorrect sizing of an exit_qual variable.

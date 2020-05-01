Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E02EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA78206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgEAOMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:12:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:42374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgEAOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:12:00 -0400
IronPort-SDR: 7ak20+LFPjtInjHjoJcmymWKJLLS+kdVN7UR7UsBUeT6igxfqMVFF2JDvXv085hs0EOyeRSJY7
 Hn4uz74Fq9kA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 07:12:00 -0700
IronPort-SDR: YfhOjwW3GA/XOJajdFbOtW1gpR+Ya8ypFpVT5wxq9f//dPzLOLk8a4rEO2PthVyP3bCFFbkmNf
 w4dFnmBlv73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="433322782"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2020 07:11:59 -0700
Date:   Fri, 1 May 2020 07:11:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
Subject: Re: [PATCH v4 1/7] KVM: VMX: Introduce generic fastpath handler
Message-ID: <20200501141159.GC3798@linux.intel.com>
References: <1588055009-12677-1-git-send-email-wanpengli@tencent.com>
 <1588055009-12677-2-git-send-email-wanpengli@tencent.com>
 <87ees5f6gh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ees5f6gh.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:28:46PM +0200, Vitaly Kuznetsov wrote:
> Wanpeng Li <kernellwp@gmail.com> writes:
> 
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Introduce generic fastpath handler to handle MSR fastpath, VMX-preemption
> > timer fastpath etc, move it after vmx_complete_interrupts() in order that
> > later patch can catch the case vmexit occurred while another event was
> > being delivered to guest. There is no obversed performance difference for
> > IPI fastpath testing after this move.
> >
> > Tested-by: Haiwei Li <lihaiwei@tencent.com>
> > Cc: Haiwei Li <lihaiwei@tencent.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 3ab6ca6..9b5adb4 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6583,6 +6583,20 @@ void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
> >  	}
> >  }
> >  
> > +static enum exit_fastpath_completion vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
> > +{
> > +	if (!is_guest_mode(vcpu)) {
> 
> Nitpick: do we actually expect to have any fastpath handlers anytime
> soon? If not, we could've written this as
> 
> 	if (is_guest_mode(vcpu))
> 		return EXIT_FASTPATH_NONE;
> 
> and save on identation)

Agreed.  An alternative approach would be to do the check in the caller, e.g.

	if (is_guest_mode(vcpu))
		return EXIT_FASTPATH_NONE;

	return vmx_exit_handlers_fastpath(vcpu);

I don't have a strong preference either way.

> > +		switch (to_vmx(vcpu)->exit_reason) {
> > +		case EXIT_REASON_MSR_WRITE:
> > +			return handle_fastpath_set_msr_irqoff(vcpu);
> > +		default:
> > +			return EXIT_FASTPATH_NONE;
> > +		}
> > +	}
> > +
> > +	return EXIT_FASTPATH_NONE;
> > +}
> > +
> >  bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
> >  
> >  static enum exit_fastpath_completion vmx_vcpu_run(struct kvm_vcpu *vcpu)
> > @@ -6757,17 +6771,14 @@ static enum exit_fastpath_completion vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >  	if (unlikely(vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
> >  		return EXIT_FASTPATH_NONE;
> >  
> > -	if (!is_guest_mode(vcpu) && vmx->exit_reason == EXIT_REASON_MSR_WRITE)
> > -		exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
> > -	else
> > -		exit_fastpath = EXIT_FASTPATH_NONE;
> > -
> >  	vmx->loaded_vmcs->launched = 1;
> >  	vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
> >  
> >  	vmx_recover_nmi_blocking(vmx);
> >  	vmx_complete_interrupts(vmx);
> >  
> > +	exit_fastpath = vmx_exit_handlers_fastpath(vcpu);

No need for capturing the result in a local variable, just return the function
call.

> > +
> >  	return exit_fastpath;
> >  }
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> -- 
> Vitaly
> 
